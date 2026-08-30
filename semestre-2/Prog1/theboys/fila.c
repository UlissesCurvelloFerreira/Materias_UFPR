#include <stdio.h>
#include <stdlib.h>
#include "fila.h"

/* Cria uma nova fila. */
struct fila *fila_cria ()
{
    struct fila *nova_fila;
    if (!(nova_fila = malloc(sizeof(struct fila))))
        return 0;
    
    nova_fila->ini = NULL;
    nova_fila->fim = NULL;
    nova_fila->tamanho = 0;

    return nova_fila;
}

/* Desaloca toda a memória da fila e faz a fila receber NULL. */
void fila_destroi (struct fila **fila)
{
    struct nodo *auxiliar;

    while ((*fila)->ini)
    {
        auxiliar = (*fila)->ini;
        (*fila)->ini = auxiliar->prox;
        free (auxiliar);
    }

    /* Segundo free */
    auxiliar = NULL;
    free(*fila);
    *fila = NULL;
}

/* Insere na lista segundo a política FIFO. */
int enqueue (struct fila *fila, int dado)
{
    struct nodo *novo;

    if (!(novo = malloc(sizeof(struct nodo))))
        return 0;

    novo->chave = dado;
    novo->prox = NULL;

    if (fila_vazia(fila))
        fila->ini = novo;
    else
        fila->fim->prox = novo;
   
    fila->fim = novo;
    fila->tamanho ++;

    return 1;
}

/* Remove o dado da lista segundo a política FIFO. */
int dequeue (struct fila *fila, int *dado)
{
    struct nodo *auxiliar;

    if(fila_vazia(fila))
        return 0;
    
    auxiliar = fila->ini;
    fila->ini = auxiliar->prox;
    *dado = auxiliar->chave;
    
    fila->tamanho--;
    free(auxiliar);

    return 1;
}
 
/* Retorna o tamanho da fila. */
int fila_tamanho (struct fila *fila)
{
    return fila->tamanho;
}

/* Verifica se a fila está vazia. */
int fila_vazia (struct fila *fila)
{
    if (!fila->tamanho) 
        return 1;
    return 0;
}


/* Funçaõ criada no dia: 29/10/ 2023 */

void fila_imprime(struct fila *fila) {
    struct nodo *atual = fila->ini;

    printf("[ ");
    while (atual != NULL) {
        printf("%d ", atual->chave);
        atual = atual->prox;
    }
    printf("]\n");
}