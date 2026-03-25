
#include <stdlib.h>
#include <stdio.h>
#include <math.h> // usar para distância euclidiana
#include "conjunto.h"
#include "fila.h"
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
    //
    //
    int nHabilidades;
    struct lef_t *lef;
    struct Missao *missoes;
    struct conjunto *habilidades;
    struct Heroi herois[N_HEROIS];
    struct Base bases[N_BASES];
};







/* Gera númeor aleatórios entre min e max. */
int aleat(int min, int max);


/*================================================================================*/
/* */
void cria_herois(struct Mundo *m);

/* Destrói um herói presente no mundo por fez. */
struct Heroi destroiHeroi(struct Heroi heroi);

/*================================================================================*/
/* Incrementa experiência dos herós que cumpriram uma missão. */
void incrementaExperiencia();

/* Função auxiliar usada para retornar um herói. */
void retornaHeroi();

/*================================================================================*/

/* Laço para inicalizar as bases. */
void cria_bases(struct Mundo *m);


/* Destrói as bases do mundo. */
struct Base destroiBases(struct Base b);


/*================================================================================*/
/* Retorna a habilidade dos heróois presentes na bese.*/
void habilidadeBase();

/* Função auxiliar usada para retornar uma base. */
void retornaBase();
/*================================================================================*/

struct Missao *cria_missao(int id);


void todas_missoes(struct Mundo *m);



/* Cria o mundo como os parâmetros. */
struct Mundo *iniciaMundo();


/* Destrói o mundo como os parâmetros. */
struct Mundo *destroiMundo(struct Mundo *m);






















/*==========================================EVENTOS========================================*/
/*
void evento_chega(struct Mundo *m, int tempo, int h_id, int b_id);

void evento_espera(struct Mundo *m, int tempo, int h_id, int b_id);

void evento_desiste(struct Mundo *m, int tempo, int h_id, int b_id);

void evento_avisa(struct Mundo *m, int tempo, int h_id, int b_id);

evento_entra(struct Mundo *m, int tempo, int h_id, int b_id);

evento_sai(struct Mundo *m, int tempo, int h_id, int b_id);

long calcula_distancia(struct Local loc, struct Local next_loc);

evento_viaja(struct Mundo *m, int tempo, int h_id, int b_id);

evento_missao(struct Mundo *m, int m_id, int tempo);

evento_fim();
*/
