
#ifndef _EVENTOS_T
#define _EVENTOS_T

#include <stdlib.h>
#include <stdio.h>
#include <math.h> 
#include <stdbool.h>

#include "fila.h"
#include "conjunto.h"
#include "lef.h"

#define T_FIM_DO_MUNDO 525600  // 525600
#define TAMANHO_MUNDO 20000
#define N_HABILIDADES 10
#define N_HEROIS (N_HABILIDADES * 5)
#define N_BASES (N_HEROIS / 6)
#define N_MISSOES (T_FIM_DO_MUNDO / 100)

#define T_INICIO 4320 // 4320 = 60*24*3 = 3 dias

/* Defines usados para identificar os eventos. */
#define E_CHEGA 1
#define E_ESPERA 2
#define E_DESISTE 3
#define E_AVISA 4
#define E_ENTRA 5
#define E_SAI 6
#define E_VIAJA 7
#define E_MISSAO 8
#define E_FIM 9

/* Struct auxiliar para local. */
struct local_t
{
    int x;
    int y;
};

struct heroi_t
{
    int id;
    int id_baseh;
    int paciencia;
    int velocidade;
    int experiencia;
    struct conjunto *habilidade;
};

struct base_t
{
    int id_base;
    int lotacao;
    struct local_t local;
    struct fila *espera;
    struct conjunto *presente;
};

struct missao_t
{
    int id;
    
    int realizada;
    int tentativas;
    struct local_t local;
    struct conjunto *habilidade;
};

struct mundo_t
{
    int miss_impos;
    int tempo;
    int fim_mundo;
    int tam_mundo;
    int n_bases;
    int n_herois;
    int n_missoes;
    int n_miss_impos;
    int n_habilidades;
    struct lef_t *lef;
    struct conjunto *habilidades;  
    struct missao_t missoes[N_MISSOES];      
    struct heroi_t herois[N_HEROIS];
    struct base_t bases[N_BASES];
};

/* Responsavel por criar um numero aleatório entre min e max. */
int aleat(int min, int max);


/* Preenche o array de heróis no mundo com valores iniciais.
 * Cada herói recebe um identificador único, e habilidade criada 
 * utilizando uma função auxiliar cria_subcjt_cjt.
 */
void cria_herois(struct mundo_t *m);


/*A função destroi_heroi libera a memória associada às habilidades 
 * de cada herói no mundo.
*/
void destroi_heroi(struct mundo_t *m);


/* A função cria_bases inicializa as bases no mundo, atribuindo a 
 * cada base um identificador único, posição no mundo com coordenadas aleatórias,
 * conjuntos de heróis presentes e uma fila de espera.
 */
void cria_bases(struct mundo_t *m);


/* A função destroi_bases libera a memória associada às estruturas de fila e conjuntos de heróis
 * presentes em cada base no mundo. 
 */
void destroi_bases(struct mundo_t *m);

 
/* Inicializando cada missão com um identificador único, número de tentativas e conclusão zerados,
 * além de uma localização aleatória e um conjunto de habilidades.
 */

void cria_missao(struct mundo_t *m);


/* A função destroi_missoes libera a memória associada às habilidades de cada missão no mundo,
 * utilizando a função auxiliar destroi_cjt.
 */
void destroi_missoes(struct mundo_t *m);


/* Aloca dinamicamente uma estrutura mundo_t e inicializa seus atributos,
 * incluindo tempo, quantidade de heróis, bases, missões, habilidades e o tamanho do mundo.
 * Retorna um ponteiro para a estrutura mundo_t recém-inicializada ou NULL em caso de falha na alocação.
 */
struct mundo_t *inicia_mundo();


/* libera a memória associada aos elementos do mundo, incluindo heróis, bases e missões,
 * Em seguida, libera a memória do conjunto de habilidades e da lista de eventos futuros (LEF),
 * finalmente, desaloca o espaço alocado para a estrutura mundo_t.
 */
void destroi_mundo(struct mundo_t *m);




//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


/* A função evento_chega representa a chegada de um herói a uma base no mundo,
 * gerando eventos de espera ou desistência com base nas condições estabelecidas.
 */
void evento_chega(struct mundo_t *m, int tempo, int h, int b);


/* A função evento_espera representa a ação de um herói esperar em uma fila de uma base no mundo.
 * Adiciona o herói à fila de espera, imprime informações sobre a ação e gera um evento de aviso.
 */
void evento_espera(struct mundo_t *m, int tempo, int h, int b);


/* A função evento_desiste representa a desistência de um herói em relação a uma base no mundo.
 * Imprime informações sobre a ação, gera um evento de viagem para uma base aleatória e o adiciona lef.
 */
void evento_desiste(struct mundo_t *m, int tempo, int h, int b);


/* A função evento_avisa simula um aviso do porteiro de uma base, admitindo heróis da fila de espera
 * enquanto houver vagas disponíveis na base. Imprime informações sobre a ação e gera eventos de entrada
 * para os heróis admitidos, adicionando-os à lef.
 */

void evento_avisa(struct mundo_t *m, int tempo, int h, int b);




/* A função evento_entra simula a entrada de um herói em uma base no mundo,
 * adicionando-o aos heróis presentes na base e gerando um evento de saída após um tempo.
 */
void evento_entra(struct mundo_t *m, int tempo, int h, int b);


/* A função evento_sai simula a saída de um herói de uma base no mundo,
 * removendo-o dos heróis presentes na base. Calcula aleatoriamente o destino do herói
 * e gera eventos de viagem e aviso para a base de origem.
 */
void evento_sai(struct mundo_t *m, int tempo, int h, int b);


/* A função evento_viaja simula a viagem de um herói entre duas bases no mundo,
 * calculando a duração da viagem com base na velocidade do herói. Gera um evento de chegada
 * à base de destino e o adiciona à lef.
 */
void evento_viaja(struct mundo_t *m, int tempo, int h, int b);


/* A função evento_missao simula a realização de uma missão no mundo, considerando a tentativa de cada base em cumprir a missão.
 * Calcula a distância de cada base até o local da missão, ordena as bases por proximidade e imprime a união das habilidades das bases,
 * do mais próximo ao mais distante. Realiza a tentativa de cumprir a missão em cada base, verificando se a união das habilidades da base
 * é suficiente para a missão. Se uma base é apta, a missão é realizada, os heróis envolvidos ganham experiência, 
 * e a base é marcada como cumprindo a missão.
 * Caso contrário, a missão é adiada por 24 horas.
 */
void evento_missao(struct mundo_t *m, int tempo, int m_id);


/* Imprime informações sobre o estado final da simulação, incluindo dados dos heróis,
 *  estatísticas das missões e média de tentativas por missão.
 */
void evento_fim(struct mundo_t *m);


/* A função evento_inicia inicializa a simulação, gerando eventos de chegada de heróis e início de missões.
 * Os heróis são distribuídos aleatoriamente em bases, e as missões são agendadas para começar em tempos aleatórios.
 * Também é gerado um evento de fim da simulação no tempo predefinido.
 */
void evento_inicia(struct mundo_t *m);

#endif