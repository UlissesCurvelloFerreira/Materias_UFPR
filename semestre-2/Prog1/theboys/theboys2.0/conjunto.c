#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "conjunto.h"

/* Cria um conjunto vazio e preenche seu compo tamanho. */
struct conjunto *cria_cjt(int max)
{
    struct conjunto *c;

    if (!(c = malloc(sizeof(struct conjunto))))
        return NULL;

    c->max = max;
    c->card = 0;
    c->ptr = 0;

    /* Aloca memória para o vetor de inteiros dado seu tamanho máximo. */
    if (!(c->v = malloc(max * sizeof(int))))
    {
        free(c);
        return NULL;
    }
    return c;
}

/* Libera elementos do conjunto. */
struct conjunto *destroi_cjt(struct conjunto *c)
{
    if (c)
    {
        free(c->v);
        free(c);
    }
    return NULL;
}

/* Dada a cardinalidade, verifica se é vazia ou não. */
int vazio_cjt(struct conjunto *c)
{
    if (c->card == 0)
        return 1;
    return 0;
}

/* Retorna a quantidade de elementos no conjunto. */
int cardinalidade_cjt(struct conjunto *c)
{
    return c->card;
}

/* Insere elemento no conjunto. */
int insere_cjt(struct conjunto *c, int elemento)
{
    if (c->card >= c->max)
        return 0;

    /* Verifica se o elemento ja esta conjunto. */
    for (int i = 0; i < c->card; i++)
        if (c->v[i] == elemento)
            return 1;

    c->v[c->card++] = elemento;
    return 1;
}

/* Remove um elemento caso exista. */
int retira_cjt(struct conjunto *c, int elemento)
{
    for (int i = 0; i < c->card; i++)
        if (c->v[i] == elemento)
        {
            /* Desloca os elementos dado o que foi removido. */
            for (int j = i; j < c->card - 1; j++)
                c->v[j] = c->v[j + 1];

            c->card--;
            return 1;
        }
    return 0;
}

/* Verifica se o elemento pertence a determinado conjunto. */
int pertence_cjt(struct conjunto *c, int elemento)
{
    for (int i = 0; i < c->card; i++)
        if (c->v[i] == elemento)
            return 1;

    return 0;
}

/* Verifica se um conjunto estaá contido em outro. */
int contido_cjt(struct conjunto *c1, struct conjunto *c2)
{
    for (int i = 0; i < c1->card; i++)
        if (!pertence_cjt(c2, c1->v[i]))
            return 0;

    return 1;
}

/* Verifica se dois conjuntos são iguais. */
int sao_iguais_cjt(struct conjunto *c1, struct conjunto *c2)
{
    /* Se tem tamanhos diferentes não podem ser iguais. */
    if (c1->card != c2->card)
        return 0;

    for (int i = 0; i < c1->card; i++)
        if (!pertence_cjt(c2, c1->v[i]))
            return 0;

    return 1;
}

/* Cria um terceiro conjunto que é a diferença entre outros dois. */
struct conjunto *diferenca_cjt(struct conjunto *c1, struct conjunto *c2)
{
    struct conjunto *diff;
    diff = cria_cjt(c1->max);

    for (int i = 0; i < c1->card; i++)
        if (!pertence_cjt(c2, c1->v[i]))
            insere_cjt(diff, c1->v[i]);

    return diff;
}

/* Cria um terceiro conjunto que é a intercessão entre outros dois.*/
struct conjunto *interseccao_cjt(struct conjunto *c1, struct conjunto *c2)
{
    struct conjunto *inter;
    inter = cria_cjt(c1->max);

    for (int i = 0; i < c1->card; i++)
        if (pertence_cjt(c2, c1->v[i]))
            insere_cjt(inter, c1->v[i]);

    return inter;
}

/* Cria um conjunto que é a união de outros dois. */
struct conjunto *uniao_cjt(struct conjunto *c1, struct conjunto *c2)
{
    struct conjunto *uni;
    uni = cria_cjt(c1->max);

    for (int i = 0; i < c1->card; i++)
        insere_cjt(uni, c1->v[i]);

    for (int i = 0; i < c2->card; i++)
        insere_cjt(uni, c2->v[i]);

    return uni;
}

/* Retorma uma copia do conjunto. */
struct conjunto *copia_cjt(struct conjunto *c)
{
    struct conjunto *copia;
    copia = cria_cjt(c->max);

    for (int i = 0; i < c->card; i++)
        insere_cjt(copia, c->v[i]);

    return copia;
}












/* Retorna um subconunto do conjunto passado como parâmetro. */
struct conjunto *cria_subcjt_cjt(struct conjunto *c, int n)
{
    struct conjunto *sub;
    int *indices;
    
    // Retornar este conjunto.
    sub = cria_cjt(c->max);

    if (n >= c->max)
        n = c->max-1;

    indices = malloc(c->card * sizeof(int));

    for (int i = 0; i < c->card; i++)
        indices[i] = i;

    for (int i = 0; i < n; i++)
    {
        int idx = rand() % (c->card - i);
        insere_cjt(sub, c->v[indices[idx]]);
        indices[idx] = indices[c->card - i - 1];
    }
    free(indices);

    return sub;
}




















/* Criei uma função com o objetivo de ordenar o conjunto, e ela é chamada no momento da impressão. */
/* Usei o Bubble sort, pois o vetor n é grande tem somente 8 possições. */
void ordena_cjt(struct conjunto *c)
{
    int i, j, n;
    n = c->card;
    ;

    for (i = 0; i < n - 1; i++)
        for (j = 0; j < n - i - 1; j++)
            if (c->v[j] > c->v[j + 1])
            {
                int temp = c->v[j];
                c->v[j] = c->v[j + 1];
                c->v[j + 1] = temp;
            }
}


/* Imprime um conjunto ordenado. */
/* Alterei para imprimir como as []. */
void imprime_cjt(struct conjunto *c)
{
    if (!(c) || !(c->card))
    {
        printf("[ ]\n");
        return;
    }

    ordena_cjt(c);

    /* Depois de ordenado imprime o conjunto. */
    printf("[ ");
    for (int i = 0; i < c->card; i++)
    {
        printf("%d", c->v[i]);
        if (i < c->card - 1)
            printf(" ");
    }
    printf(" ]\n");

    return;
}

/* Inicializa a variável que sera incrementada. */
void inicia_iterador_cjt(struct conjunto *c)
{
    c->ptr = 0;
}

/* Incrementa a variável. */
int incrementa_iterador_cjt(struct conjunto *c, int *ret_iterador)
{
    if (c->ptr < c->card)
    {
        *ret_iterador = c->v[c->ptr];
        c->ptr++;
        return 1;
    }
    return 0;
}

/* Remove um elemenoto do conjunto. */
int retira_um_elemento_cjt(struct conjunto *c)
{
    if (c->card > 0)
    {
        int elemento = c->v[c->card - 1];
        retira_cjt(c, elemento);
        return elemento;
    }
    return 0; // Conjunto vazio
}
