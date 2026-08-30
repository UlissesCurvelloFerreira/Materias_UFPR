#include <stdio.h>
#include <stdlib.h>
#include "lef.h"


/* Cria um novo evento e preenche seus campos. */
struct evento_t *cria_evento(int tempo, int tipo, int dado1, int dado2) 
{
    struct evento_t *evento;
    
    if (!(evento = malloc(sizeof(struct evento_t))))
        return NULL;

    evento->tempo = tempo;
    evento->tipo = tipo;
    evento->dado1 = dado1;
    evento->dado2 = dado2;
    return evento;
}

/* Libera memória de um evento. */
struct evento_t *destroi_evento(struct evento_t *e)
{
    free(e);
    return NULL;
}

/* Crie a estrutura 'lef' de forma que a primeira posição seja NULL. */
struct lef_t *cria_lef() 
{
    struct lef_t *lef;

    if (!(lef = malloc(sizeof(struct lef_t))))
        return NULL;

    lef->primeiro = NULL;
    return lef;
}

/* Libera a memória alocada por lef. */
struct lef_t *destroi_lef(struct lef_t *l) 
{
    struct nodo_lef_t *temp; /* Destrói esta variável. */

    while (l->primeiro) 
    {
        temp = l->primeiro;
        l->primeiro = l->primeiro->prox;
        destroi_evento(temp->evento);
        free(temp);
    }
    free(l);
    return NULL;
}

/* Insere um novo evento na lef. */
int insere_lef(struct lef_t *l, struct evento_t *e) 
{
    /* Primeiro aloco memória para o novo nó da lef. */
    struct nodo_lef_t *novo, *atual;

    if (!(novo = malloc(sizeof(struct nodo_lef_t)))) 
        return 0; 

    novo->evento = e;

    /* 1º caso: se não há nenhum nó na estrutura ou se o novo nó tem tempo menor, 
     * ele deve ser colocado como o primeiro. */
    if (!l->primeiro || e->tempo < l->primeiro->evento->tempo) 
    {
        novo->prox = l->primeiro;
        l->primeiro = novo;
    }
    else /* 2º caso: se o tempo é maior que o tempo do primeiro. */
    {
        atual = l->primeiro; 
        /* Acha a posição a ser inserida. */
        while (atual->prox && e->tempo >= atual->prox->evento->tempo) 
            atual = atual->prox;
            
        novo->prox = atual->prox;
        atual->prox = novo;
    }
    return 1; 
}

/* Retira o primeiro evento da lef. */
struct evento_t *retira_lef(struct lef_t *l) 
{
    if (vazia_lef(l)) 
        return NULL;

    struct nodo_lef_t *temp;
    struct evento_t *evento;

    /* Guarda o evento para ser retornado. */
    temp = l->primeiro;
    l->primeiro = l->primeiro->prox;
    evento = temp->evento;
    free(temp);
    return evento;
}

/* Verifica se a estrutura 'lef' esta vazia. */
int vazia_lef(struct lef_t *l) 
{
    if (l->primeiro == NULL)
        return 1;
    return 0;
}

/* Imprime a lef no padrão apresentado. */
void imprime_lef(struct lef_t *l) 
{
    struct nodo_lef_t *atual;
    int total;

    atual = l->primeiro;
    total = 0;

    /* Para quando chegar no fim da lef. */
    printf("LEF:\n");
    while (atual) 
    {
        total++;
        printf("  tempo %d", atual->evento->tempo);
        printf(" tipo %d", atual->evento->tipo);
        printf(" d1 %d", atual->evento->dado1);
        printf(" d2 %d\n", atual->evento->dado2);
        atual = atual->prox;
    }
    printf("  Total %d eventos\n", total);
}