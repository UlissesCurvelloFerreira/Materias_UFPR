#include <stdio.h>
#include <stdlib.h>
#include <float.h>
#include <fenv.h>
#include <math.h>
#include <stdint.h>

#include "utils.h"

/////////////////////////////////////////////////////////////////////////////////////
//   AJUSTE DE CURVAS - VERSÃO OTIMIZADA
/////////////////////////////////////////////////////////////////////////////////////

// Otimização 1: Pré-computação de potências usando programação dinâmica
void precomputePowers(double *x, long long int p, int maxPower, double **xPowers) {
    // Inicializa x^0 = 1 para todos os pontos
    for (long long int i = 0; i < p; ++i) {
        xPowers[i][0] = 1.0;
    }
    
    // Calcula potências incrementalmente: x^k = x^(k-1) * x
    for (int pow = 1; pow <= maxPower; ++pow) {
        for (long long int i = 0; i < p; ++i) {
            xPowers[i][pow] = xPowers[i][pow-1] * x[i];
        }
    }
}

// Otimização 2: Montagem do sistema linear com loop unrolling e cache optimization
void montaSL_otimizada(double **A, double *b, int n, long long int p, double **xPowers, double *y) {
    // Inicialização mais eficiente usando memset seria ideal, mas usando loops otimizados
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            A[i][j] = 0.0;
        }
        b[i] = 0.0;
    }
    
    // Loop principal otimizado: uma passada pelos dados para calcular A e b simultaneamente
    for (long long int k = 0; k < p; ++k) {
        // Calcula b[i] = Σ(x[k]^i * y[k]) em uma passada
        double yk = y[k];
        for (int i = 0; i < n; ++i) {
            b[i] += xPowers[k][i] * yk;
        }
        
        // Calcula A[i][j] = Σ(x[k]^(i+j)) usando simetria da matriz
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {  // Aproveita simetria: A[i][j] = A[j][i]
                double term = xPowers[k][i + j];
                A[i][j] += term;
                if (i != j) {
                    A[j][i] += term;  // Explorar simetria
                }
            }
        }
    }
}

// Otimização 3: Eliminação de Gauss com pivoteamento parcial otimizado
void eliminacaoGauss_otimizada(double **A, double *b, int n) {
    for (int i = 0; i < n; ++i) {
        // Busca do pivô otimizada
        int iMax = i;
        double maxVal = fabs(A[i][i]);
        for (int k = i + 1; k < n; ++k) {
            double absVal = fabs(A[k][i]);
            if (absVal > maxVal) {
                maxVal = absVal;
                iMax = k;
            }
        }
        
        // Troca de linhas apenas se necessário
        if (iMax != i) {
            double *tmp = A[i];
            A[i] = A[iMax];
            A[iMax] = tmp;
            
            double aux = b[i];
            b[i] = b[iMax];
            b[iMax] = aux;
        }
        
        // Eliminação com otimização de divisão
        double pivot = A[i][i];
        for (int k = i + 1; k < n; ++k) {
            double m = A[k][i] / pivot;
            A[k][i] = 0.0;
            
            // Loop unrolling manual para pequenos valores de n
            int j = i + 1;
            for (; j < n - 3; j += 4) {  // Unroll por 4
                A[k][j] -= A[i][j] * m;
                A[k][j+1] -= A[i][j+1] * m;
                A[k][j+2] -= A[i][j+2] * m;
                A[k][j+3] -= A[i][j+3] * m;
            }
            for (; j < n; ++j) {  // Resto do loop
                A[k][j] -= A[i][j] * m;
            }
            
            b[k] -= b[i] * m;
        }
    }
}

// Otimização 4: Substituição regressiva otimizada
void retrossubs_otimizada(double **A, double *b, double *x, int n) {
    for (int i = n - 1; i >= 0; --i) {
        double sum = 0.0;
        
        // Loop unrolling para somatório
        int j = i + 1;
        for (; j < n - 3; j += 4) {  // Unroll por 4
            sum += A[i][j] * x[j] + A[i][j+1] * x[j+1] + 
                   A[i][j+2] * x[j+2] + A[i][j+3] * x[j+3];
        }
        for (; j < n; ++j) {  // Resto do loop
            sum += A[i][j] * x[j];
        }
        
        x[i] = (b[i] - sum) / A[i][i];
    }
}

// Otimização 5: Avaliação do polinômio usando método de Horner
double P_horner(double x, int N, double *alpha) {
    if (N < 0) return 0.0;
    
    double result = alpha[N];
    for (int i = N - 1; i >= 0; --i) {
        result = result * x + alpha[i];
    }
    return result;
}

// Otimização 6: Cálculo de resíduos vetorizado
void calcularResiduos(double *x, double *y, long long int p, int N, double *alpha, double *residuos) {
    for (long long int i = 0; i < p; ++i) {
        residuos[i] = fabs(y[i] - P_horner(x[i], N, alpha));
    }
}

int main() {
    int N, n;
    long long int K, p;

    scanf("%d %lld", &N, &K);
    p = K;   // quantidade de pontos
    n = N + 1; // tamanho do SL (grau N + 1)

    // Alocação de memória otimizada com alinhamento
    double *x = (double *) aligned_alloc(32, sizeof(double) * p);
    double *y = (double *) aligned_alloc(32, sizeof(double) * p);
    
    if (!x || !y) {
        // Fallback para malloc se aligned_alloc falhar
        free(x); free(y);
        x = (double *) malloc(sizeof(double) * p);
        y = (double *) malloc(sizeof(double) * p);
    }

    // Leitura otimizada dos dados
    for (long long int i = 0; i < p; ++i) {
        scanf("%lf %lf", &x[i], &y[i]);
    }

    // Alocação da matriz A com melhor localidade de cache
    double **A = (double **) malloc(sizeof(double *) * n);
    double *A_data = (double *) aligned_alloc(32, sizeof(double) * n * n);
    if (!A_data) {
        A_data = (double *) malloc(sizeof(double) * n * n);
    }
    
    for (int i = 0; i < n; ++i) {
        A[i] = A_data + i * n;  // Memória contígua
    }
    
    double *b = (double *) malloc(sizeof(double) * n);
    double *alpha = (double *) malloc(sizeof(double) * n);
    double *residuos = (double *) malloc(sizeof(double) * p);

    // Pré-computação de potências
    double **xPowers = (double **) malloc(sizeof(double *) * p);
    double *xPowers_data = (double *) malloc(sizeof(double) * p * (2 * N + 1));
    for (long long int i = 0; i < p; ++i) {
        xPowers[i] = xPowers_data + i * (2 * N + 1);
    }

    // (A) Gera SL com otimizações
    double tSL = timestamp();
    precomputePowers(x, p, 2 * N, xPowers);
    montaSL_otimizada(A, b, n, p, xPowers, y);
    tSL = timestamp() - tSL;

    // (B) Resolve SL com otimizações
    double tEG = timestamp();
    eliminacaoGauss_otimizada(A, b, n); 
    retrossubs_otimizada(A, b, alpha, n); 
    tEG = timestamp() - tEG;

    // Imprime coeficientes
    for (int i = 0; i < n; ++i) {
        printf("%1.15e ", alpha[i]);
    }
    puts("");

    // Calcula e imprime resíduos otimizadamente
    calcularResiduos(x, y, p, N, alpha, residuos);
    for (long long int i = 0; i < p; ++i) {
        printf("%1.15e ", residuos[i]);
    }
    puts("");

    // Imprime os tempos
    printf("%lld %1.10e %1.10e\n", K, tSL, tEG);

    // Liberação de memória
    free(x);
    free(y);
    free(A);
    free(A_data);
    free(b);
    free(alpha);
    free(residuos);
    free(xPowers);
    free(xPowers_data);

    return 0;
}