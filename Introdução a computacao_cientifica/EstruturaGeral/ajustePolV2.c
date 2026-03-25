#include <stdio.h>
#include <stdlib.h>
#include <float.h>
#include <fenv.h>
#include <math.h>
#include <stdint.h>
#include <string.h>

#include "utils.h"

/////////////////////////////////////////////////////////////////////////////////////
//   AJUSTE DE CURVAS - VERSÃO OTIMIZADA V2
/////////////////////////////////////////////////////////////////////////////////////

// Estrutura para armazenar potências pré-computadas
typedef struct {
    double **powers;  // powers[i][j] = x[i]^j
    int max_power;
    long long int num_points;
} PowerCache;

// Função para alocar e inicializar cache de potências
PowerCache* createPowerCache(double *x, long long int p, int max_power) {
    PowerCache *cache = (PowerCache*) malloc(sizeof(PowerCache));
    cache->max_power = max_power;
    cache->num_points = p;
    
    // Alocação contígua para melhor cache locality
    cache->powers = (double**) malloc(sizeof(double*) * p);
    double *data = (double*) malloc(sizeof(double) * p * (max_power + 1));
    
    for (long long int i = 0; i < p; ++i) {
        cache->powers[i] = data + i * (max_power + 1);
        
        // Primeira potência: x^0 = 1
        cache->powers[i][0] = 1.0;
        
        // Potências subsequentes: x^k = x^(k-1) * x
        for (int j = 1; j <= max_power; ++j) {
            cache->powers[i][j] = cache->powers[i][j-1] * x[i];
        }
    }
    
    return cache;
}

void destroyPowerCache(PowerCache *cache) {
    if (cache) {
        if (cache->powers) {
            free(cache->powers[0]); // Libera dados contíguos
            free(cache->powers);    // Libera array de ponteiros
        }
        free(cache);
    }
}

// Montagem otimizada do sistema linear usando cache de potências
void montaSL_otimizada(double **A, double *b, int n, PowerCache *cache, double *y) {
    long long int p = cache->num_points;
    
    // Inicialização eficiente
    for (int i = 0; i < n; ++i) {
        b[i] = 0.0;
        for (int j = 0; j < n; ++j) {
            A[i][j] = 0.0;
        }
    }
    
    // Loop principal: uma passada pelos dados
    for (long long int k = 0; k < p; ++k) {
        double yk = y[k];
        
        // Calcula b[i] = Σ(x[k]^i * y[k])
        for (int i = 0; i < n; ++i) {
            b[i] += cache->powers[k][i] * yk;
        }
        
        // Calcula A[i][j] = Σ(x[k]^(i+j)) explorando simetria
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                double term = cache->powers[k][i + j];
                A[i][j] += term;
                if (i != j) {
                    A[j][i] += term; // Matriz simétrica
                }
            }
        }
    }
}

// Eliminação de Gauss otimizada com pivoteamento parcial
void eliminacaoGauss_otimizada(double **A, double *b, int n) {
    for (int i = 0; i < n; ++i) {
        // Busca do melhor pivô
        int iMax = i;
        double maxVal = fabs(A[i][i]);
        
        for (int k = i + 1; k < n; ++k) {
            double absVal = fabs(A[k][i]);
            if (absVal > maxVal) {
                maxVal = absVal;
                iMax = k;
            }
        }
        
        // Troca de linhas se necessário
        if (iMax != i) {
            double *tmp = A[i];
            A[i] = A[iMax];
            A[iMax] = tmp;
            
            double aux = b[i];
            b[i] = b[iMax];
            b[iMax] = aux;
        }
        
        // Eliminação com loop unrolling
        double pivot = A[i][i];
        for (int k = i + 1; k < n; ++k) {
            double m = A[k][i] / pivot;
            A[k][i] = 0.0;
            
            // Loop unrolling para melhor performance
            int j = i + 1;
            for (; j < n - 3; j += 4) {
                A[k][j] -= A[i][j] * m;
                A[k][j+1] -= A[i][j+1] * m;
                A[k][j+2] -= A[i][j+2] * m;
                A[k][j+3] -= A[i][j+3] * m;
            }
            
            // Elementos restantes
            for (; j < n; ++j) {
                A[k][j] -= A[i][j] * m;
            }
            
            b[k] -= b[i] * m;
        }
    }
}

// Substituição regressiva otimizada
void retrossubs_otimizada(double **A, double *b, double *x, int n) {
    for (int i = n - 1; i >= 0; --i) {
        double sum = 0.0;
        
        // Loop unrolling para o somatório
        int j = i + 1;
        for (; j < n - 3; j += 4) {
            sum += A[i][j] * x[j] + A[i][j+1] * x[j+1] + 
                   A[i][j+2] * x[j+2] + A[i][j+3] * x[j+3];
        }
        
        for (; j < n; ++j) {
            sum += A[i][j] * x[j];
        }
        
        x[i] = (b[i] - sum) / A[i][i];
    }
}

// Avaliação de polinômio usando método de Horner
double horner_eval(double x, int N, double *alpha) {
    double result = alpha[N];
    for (int i = N - 1; i >= 0; --i) {
        result = result * x + alpha[i];
    }
    return result;
}

// Cálculo de resíduos otimizado
void calcular_residuos(double *x, double *y, long long int p, int N, double *alpha, double *residuos) {
    for (long long int i = 0; i < p; ++i) {
        residuos[i] = fabs(y[i] - horner_eval(x[i], N, alpha));
    }
}

int main() {
    int N, n;
    long long int K, p;

    scanf("%d %lld", &N, &K);
    p = K;   // quantidade de pontos
    n = N + 1; // tamanho do SL (grau N + 1)

    // Alocação de memória com tentativa de alinhamento
    double *x, *y;
    
    // Tenta alocação alinhada, se falhar usa malloc padrão
    x = (double*) aligned_alloc(64, sizeof(double) * p);
    y = (double*) aligned_alloc(64, sizeof(double) * p);
    
    if (!x || !y) {
        free(x); free(y);
        x = (double*) malloc(sizeof(double) * p);
        y = (double*) malloc(sizeof(double) * p);
    }

    // Leitura dos dados
    for (long long int i = 0; i < p; ++i) {
        scanf("%lf %lf", &x[i], &y[i]);
    }

    // Alocação da matriz A com memória contígua
    double **A = (double**) malloc(sizeof(double*) * n);
    double *A_data = (double*) malloc(sizeof(double) * n * n);
    
    for (int i = 0; i < n; ++i) {
        A[i] = A_data + i * n;
    }
    
    double *b = (double*) malloc(sizeof(double) * n);
    double *alpha = (double*) malloc(sizeof(double) * n);
    double *residuos = (double*) malloc(sizeof(double) * p);

    // Criar cache de potências
    PowerCache *cache = createPowerCache(x, p, 2 * N);

    // (A) Gera SL otimizado
    double tSL = timestamp();
    montaSL_otimizada(A, b, n, cache, y);
    tSL = timestamp() - tSL;

    // (B) Resolve SL otimizado
    double tEG = timestamp();
    eliminacaoGauss_otimizada(A, b, n);
    retrossubs_otimizada(A, b, alpha, n);
    tEG = timestamp() - tEG;

    // Saída dos coeficientes
    for (int i = 0; i < n; ++i) {
        printf("%1.15e ", alpha[i]);
    }
    puts("");

    // Cálculo e saída dos resíduos
    calcular_residuos(x, y, p, N, alpha, residuos);
    for (long long int i = 0; i < p; ++i) {
        printf("%1.15e ", residuos[i]);
    }
    puts("");

    // Saída dos tempos
    printf("%lld %1.10e %1.10e\n", K, tSL, tEG);

    // Liberação de memória
    destroyPowerCache(cache);
    free(x);
    free(y);
    free(A);
    free(A_data);
    free(b);
    free(alpha);
    free(residuos);

    return 0;
}