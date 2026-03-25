#include <stdlib.h>
#include <stdio.h>
#include <math.h> // usar para distância euclidiana
#include "fila.h"
#include "conjunto.h"
#include "lef.h"

#define T_FIM_DO_MUNDO 525600
#define TAMANHO_MUNDO 20000
#define N_HABILIDADES 10
#define N_HEROIS (N_HABILIDADES * 5)
#define N_BASES (N_HEROIS / 6)
#define N_MISSOES (T_FIM_DO_MUNDO / 100)

/* Para os eventos */
#define E_CHEGA 1
#define E_ESPERA 2
#define E_DESISTE 3
#define E_AVISA 4
#define E_ENTRA 5
#define E_SAI 6
#define E_VIAJA 7
#define E_MISSAO 8
#define E_Fim 9



/* Struct auxiliar para local. */
struct Local
{
    int x;
    int y;
};

struct Heroi
{
    int id;
    int idBaseh;
    int paciencia;
    int velocidade;
    int experiencia;
    struct conjunto *habilidade;
};

struct Base
{
    int idBase;
    int lotacao;
    struct Local local;
    struct fila *espera;
    struct conjunto *presente;
};

struct Missao
{
    int id;
    struct Local local;
    struct conjunto *habilidade; // Acho que é um número aleatório;
};

struct Mundo
{
    int fimMundo;
    int tMundo;
    int nBases;
    int nHeoris;
    int nMissoes;
    int nHabilidades;
    struct lef_t *lef;
    struct Missao *missoes;
    struct conjunto *habilidades;
    struct Heroi herois[N_HEROIS];
    struct Base bases[N_BASES];
};


int aleat(int min, int max)
{
    return (rand() % (max - min + 1)) + min;
}

void cria_herois(struct Mundo *m)
{
    int i;

    for (i = 0; i < N_HEROIS; i++)
    {
        m->herois[i].id = i;
        m->herois[i].experiencia = 0;
        m->herois[i].paciencia = aleat(0, 100);
        m->herois[i].velocidade = aleat(50, 5000);
        m->herois[i].habilidade = cria_subcjt_cjt(m->habilidades, aleat(1, 3));
    }
}

void destroiHeroi(struct Mundo *m)
{
    for (int i = 0; i < N_HEROIS; i++) 
        m->herois[i].habilidade = destroi_cjt(m->herois[i].habilidade);
}


void cria_bases(struct Mundo *m)
{
    int i;

    for (i = 0; i < N_BASES; i++)
    {
        m->bases[i].idBase = i;
        m->bases[i].lotacao = aleat(3, 10);
        m->bases[i].local.x = aleat(0, TAMANHO_MUNDO-1);
        m->bases[i].local.y = aleat(0, TAMANHO_MUNDO-1);
        m->bases[i].presente = cria_cjt(m->bases[i].lotacao);
        m->bases[i].espera = fila_cria();
    }
}

void destroiBases(struct Mundo *m)
{
    for (int i = 0; i < N_BASES; i++)
    {
        fila_destroi(&m->bases[i].espera);
        m->bases[i].presente = destroi_cjt(m->bases[i].presente);
    }
}

void cria_missao(struct Mundo *m)
{
    int tam;

    if (!(m->missoes = malloc(sizeof(struct Missao) * N_MISSOES)))
        return;

    for (int i = 0; i < N_MISSOES; i++)
    {
        tam = aleat(6, 10);
        m->missoes[i].id = i;
        m->missoes[i].local.x = aleat(0, TAMANHO_MUNDO - 1);
        m->missoes[i].local.y = aleat(0, TAMANHO_MUNDO - 1);
        m->missoes[i].habilidade = cria_subcjt_cjt(m->habilidades, tam);
    }
}

void destroi_missoes(struct Mundo *m)
{
    for (int i = 0; i < N_MISSOES; i++) 
        if (m->missoes[i].habilidade) 
            m->missoes[i].habilidade = destroi_cjt(m->missoes[i].habilidade);
    
    free(m->missoes);
}


struct Mundo *iniciaMundo()
{
    struct Mundo *m;

    if (!(m = malloc(sizeof(struct Mundo))))
        return NULL;

    m->nHeoris = N_HEROIS;
    m->nBases = N_BASES;
    m->nMissoes = N_MISSOES;
    m->nHabilidades = N_HABILIDADES;
    m->tMundo = TAMANHO_MUNDO;
    m->fimMundo = T_FIM_DO_MUNDO;
    m->habilidades = cria_cjt(N_HABILIDADES);
    m->lef = cria_lef();
   
    // Preenche o conjunto de habilidades do mundo.
    for (int i = 0; i < N_HABILIDADES; i++)
        insere_cjt(m->habilidades, i);

    cria_herois(m);
    cria_bases(m);
    cria_missao(m);

    return m;
}

void destroiMundo(struct Mundo *m)
{
    destroiHeroi(m);
    destroiBases(m);
    destroi_missoes(m);

    m->habilidades = destroi_cjt(m->habilidades);
    m->lef = destroi_lef(m->lef);

    free(m);
}



void imprime_herois_mundo(struct Mundo *m)
{
    if (m)
    {

        for (int i = 0; i < m->nHeoris; i++)
        {
            struct Heroi heroi = m->herois[i];

            printf("Herói %d:\n", heroi.id);
            printf("Paciência: %d\n", heroi.paciencia);
            printf("Velocidade: %d\n", heroi.velocidade);
            printf("Experiência: %d\n", heroi.experiencia);
            printf("Habilidades do Herói:\n");
            imprime_cjt(heroi.habilidade);
            printf("\n");
        }
    }
}

// Função para imprimir as propriedades das bases
void imprime_bases_mundo(struct Mundo *m)
{

    for (int i = 0; i < m->nBases; i++)
    {
        struct Base base = m->bases[i];

        printf("Base %d:\n", base.idBase);
        printf("Lotação: %d\n", base.lotacao);
        printf("Localização: (%d, %d)\n", base.local.x, base.local.y);
        printf("Heróis Presentes na Base:\n");
        imprime_cjt(base.presente);

        printf("Heróis na Fila de Espera:\n");
        fila_imprime(base.espera);
        printf("\n");
    }
}

// Função para imprimir as propriedades das missões

void imprime_missoes_mundo(struct Mundo *m)
{

    for (int i = 0; i < N_MISSOES; i++)
    {
        struct Missao *missoes = m->missoes;

        printf("Missão %d:\n", missoes[i].id);
        printf("Localização da Missão: (%d, %d)\n", missoes[i].local.x, missoes[i].local.y);
        printf("Habilidades Necessárias:\n");
        imprime_cjt(missoes[i].habilidade);
        printf("\n");
    }
}



int main()
{
    struct Mundo *mundo;
    srand(0);
    
    mundo = iniciaMundo();

    printf("\nHabilidades existentes no mundo:\n");
    imprime_cjt(mundo->habilidades);

    printf("\nPropriedades dos Heróis:\n");
    imprime_herois_mundo(mundo);

    printf("\nPropriedades das Bases:\n");
    imprime_bases_mundo(mundo);

    printf("\nPropriedades das Missões:\n");
    imprime_missoes_mundo(mundo);

    destroiMundo(mundo);

    return 0;
}
