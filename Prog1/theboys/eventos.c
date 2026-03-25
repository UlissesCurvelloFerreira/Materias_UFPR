
#include <stdlib.h>
#include <stdio.h>
#include <math.h> // usar para distância euclidiana
#include "conjunto.h"
#include "fila.h"
#include "lef.h"
#include "eventos.h"


/* Gera númeor aleatórios entre min e max. */
int aleat(int min, int max)
{
    return (rand() % (max - min + 1)) + min;
}

/*================================================================================*/
/* */
void cria_herois(struct Mundo *m)
{
    int i;

    for (i = 0; i < N_HEROIS; i++)
    {
        m->herois[i].id = i;
        m->herois[i].experiencia = 0;
        m->herois[i].paciencia = aleat(1, 1); // Alterar parâmetros
        m->herois[i].velocidade = aleat(1, 1);
        m->herois[i].habilidade = cria_subcjt_cjt(m->habilidades, 3);
    }
}

/* Destrói um herói presente no mundo por fez. */
struct Heroi destroiHeroi(struct Heroi heroi)
{
    heroi.habilidade = destroi_cjt(heroi.habilidade);
    return heroi;
}

/*================================================================================*/
/* Incrementa experiência dos herós que cumpriram uma missão. */
void incrementaExperiencia();

/* Função auxiliar usada para retornar um herói. */
void retornaHeroi();

/*================================================================================*/

/* Laço para inicalizar as bases. */
void cria_bases(struct Mundo *m)
{
    int i;

    for (i = 0; i < N_BASES; i++)
    {
        m->bases[i].lotacao = aleat(1, 1);
        m->bases[i].local.x = aleat(1, 1);
        m->bases[i].local.y = aleat(1, 1);
        m->bases[i].espera = fila_cria();
        m->bases[i].presente = cria_cjt(m->bases[i].lotacao);
        m->bases[i].idBase = i;
    }
}

/* Destrói as bases do mundo. */
struct Base destroiBases(struct Base b)
{
    fila_destroi(&b.espera);
    destroi_cjt(b.presente);

    return b;
}

/*================================================================================*/
/* Retorna a habilidade dos heróois presentes na bese.*/
void habilidadeBase();

/* Função auxiliar usada para retornar uma base. */
void retornaBase();
/*================================================================================*/

struct Missao *cria_missao(int id)
{
    struct Missao *m;
    int tam = aleat(6, 10);

    if (!(m = malloc(sizeof(struct Missao))))
        return NULL;

    m->id = id;
    m->local.x = aleat(0, TAMANHO_MUNDO - 1);
    m->local.y = aleat(0, TAMANHO_MUNDO - 1);
    m->habilidade = cria_cjt(tam);

    while (cardinalidade_cjt(m->habilidade) < tam)
        insere_cjt(m->habilidade, aleat(0, N_HABILIDADES));

    return m;
}

void todas_missoes(struct Mundo *m)
{
    for (int i = 0; i < N_MISSOES; i++)
        m->missoes[i] = cria_missao(i);
}

/*================================================================================*/
/* Cria o mundo como os parâmetros. */
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
    // criar missoes

    /* Preenche o conjunto de habilidades do mundo.*/
    for (int i = 0; i < N_HABILIDADES; i++)
        insere_cjt(m->habilidades, i);

    /* cria uma lef. */
    m->lef = cria_lef();

    return m;
}

/* Destrói o mundo como os parâmetros. */
struct Mundo *destroiMundo(struct Mundo *m)
{
    int i;

    /* Liberar a memória dos heróis. */
    for (i = 0; i < N_HEROIS; i++)
        destroiHeroi(m->herois[i]);

    /* Liberar a memória das bases. */
    for (i = 0; i < N_BASES; i++)
        destroiBases(m->bases[i]);

    /* Destrói o mundo.*/
    m->habilidades = destroi_cjt(m->habilidades);
    free(m);

    return m;
}
/*==================================================================================*/





























/*==========================================EVENTOS========================================*/

/* Cria a chegada do herói em uma base.  Add a lef de eventos. 

void evento_chega(struct Mundo *m, int tempo, int h_id, int b_id)
{
    struct evento_t *ev;

    int espera;
    m->herois[h_id].idBaseh = b_id;

    // Se há vagas em B e a fila de espera está vazia: 
    espera = 0;

    if (cardinalidade_cjt(m->bases[b_id].presente) < m->bases[b_id].lotacao && !fila_vazia(m->bases[b_id].espera))
        espera = 1;
    //(paciência de H) > (10 * tamanho da fila em B)
    else if (m->herois[h_id].paciencia > (10 * fila_tamanho(m->bases[b_id].presente)))
        espera = 1;

    //Chama outros eventos: 
    if (espera)
        ev = cria_evento(tempo, E_ESPERA, h_id, b_id); // espera

    else
        ev = cria_evento(tempo, E_DESISTE, h_id, b_id); // desiste

    // Add um evento na lef. 
    insere_lef(m->eventos, ev);
}

// Evento espera add a lef. 
void evento_espera(struct Mundo *m, int tempo, int h_id, int b_id)
{
    struct evento_t *ev;

    enqueue(m->bases[b_id].espera, h_id);

    ev = cria_evento(tempo, E_AVISA, h_id, b_id);
    insere_lef(m->eventos, ev);
}

// Desiste add a lef. 
void evento_desiste(struct Mundo *m, int tempo, int h_id, int b_id)
{
    struct evento_t *ev;
    int destino;

    destino = aleat(0, N_BASES - 1);
    ev = cria_evento(tempo, E_AVISA, h_id, destino);

    insere_lef(m->eventos, ev);
}

void evento_avisa(struct Mundo *m, int tempo, int h_id, int b_id)
{
    struct evento_t *ev;
    int dado;

    while (cardinalidade_cjt(m->bases[b_id].presente) < m->bases[b_id].lotacao && fila_vazia(m->bases[b_id].espera))
    {
        dequeue(m->bases[b_id].espera, dado);
        insere_cjt(m->bases[b_id].presente, dado);
    }

    // verificar a ordem de h_id, b_id)
    ev = cria_evento(tempo, E_ENTRA, h_id, b_id);
    insere_lef(m->eventos, ev);
}

evento_entra(struct Mundo *m, int tempo, int h_id, int b_id)
{
    struct evento_t *ev;
    int tpd;

    tpd = 15 + (m->herois[h_id].paciencia * aleat(1, 20));

    ev = cria_evento(tempo + tpd, E_ENTRA, h_id, b_id);
    insere_lef(m->eventos, ev);
}

// Verificar eventos e if(!ev
evento_sai(struct Mundo *m, int tempo, int h_id, int b_id)
{
    struct evento_t *ev;
    int destino;

    destino = aleat(0, N_BASES - 1);
    retira_cjt(m->bases[b_id].presente, h_id);

    ev = cria_evento(tempo, E_VIAJA, h_id, destino);
    insere_lef(m->eventos, ev);
    ev = cria_evento(tempo, E_AVISA, h_id, b_id);
    insere_lef(m->eventos, ev);
}




//ARRUMAR   
//auxiliar para a distẫncia.
long calcula_distancia(struct Local loc, struct Local next_loc)
{

    long distancia;

    // calculo da distancia
    long x = (next_loc.x - loc.x) * (next_loc.x - loc.x);
    long y = (next_loc.y - loc.y) * (next_loc.y - loc.y);

    distancia = sqrt(x + y);

    return distancia;
}



evento_viaja(struct Mundo *m, int tempo, int h_id, int b_id)
{
    struct evento_t *ev;
    long distancia, duracao;
    int id_origem = m->herois[h_id].idBaseh; 

    distancia = calcula_distancia(m->bases[id_origem].local, m->bases[b_id].local);
    duracao = distancia / m->herois[h_id].velocidade;

    ev = cria_evento(tempo + duracao, E_CHEGA , h_id, b_id);
    insere_lef(m->eventos, ev);

}
*/
/*
evento_missao(struct Mundo *m, int m_id, int tempo)
{
    struct evento_t *ev;
    int b_id, i;
    long distancia, menor_distancia;

    distancia = calcula_distancia(m->bases[0].local, m->bases[m_id].local);

    menor_distancia = distancia;

   
    for (i = 0; i < m->nBases; i++)
    {
        if(distancia  < menor_distancia)
        {
            menor_distancia = distancia;
            b_id = i;

        }
        distancia = calcula_distancia(m->bases[i].local, m->bases[m_id].local);
    }
    

    ev = cria_evento(tempo + duracao, E_CHEGA , h_id, b_id);
    insere_lef(m->eventos, ev);
}


evento_fim()
{


}
*/

/*==========================================FIM_EVENTOS========================================*/