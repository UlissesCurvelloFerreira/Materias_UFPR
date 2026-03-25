#include "eventos.h"

////????? Apagar o include boolean

int aleat(int min, int max)
{
    return (rand() % (max - min + 1)) + min;
}


void cria_herois(struct mundo_t *m)
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


void destroi_heroi(struct mundo_t *m)
{
    for (int i = 0; i < N_HEROIS; i++)
        m->herois[i].habilidade = destroi_cjt(m->herois[i].habilidade);
}


void cria_bases(struct mundo_t *m)
{
    int i;

    for (i = 0; i < N_BASES; i++)
    {
        m->bases[i].id_base = i;
        m->bases[i].lotacao = aleat(3, 10);
        m->bases[i].local.x = aleat(0, TAMANHO_MUNDO - 1);
        m->bases[i].local.y = aleat(0, TAMANHO_MUNDO - 1);
        m->bases[i].presente = cria_cjt(N_HEROIS - 1);
        m->bases[i].espera = fila_cria();
    }
}


void destroi_bases(struct mundo_t *m)
{
    for (int i = 0; i < N_BASES; i++)
    {
        fila_destroi(&m->bases[i].espera);
        m->bases[i].presente = destroi_cjt(m->bases[i].presente);
    }
}


void cria_missao(struct mundo_t *m)
{
    for (int i = 0; i < N_MISSOES; i++)
    {
        m->missoes[i].id = i;
        m->missoes[i].tentativas = 0;
        m->missoes[i].realizada = 0;
        m->missoes[i].local.x = aleat(0, TAMANHO_MUNDO - 1);
        m->missoes[i].local.y = aleat(0, TAMANHO_MUNDO - 1);
        m->missoes[i].habilidade = cria_subcjt_cjt(m->habilidades, aleat(6, 10));
    }
}

void destroi_missoes(struct mundo_t *m)
{
    for (int i = 0; i < N_MISSOES; i++)
        if (m->missoes[i].habilidade)
            destroi_cjt(m->missoes[i].habilidade);
}

struct mundo_t *inicia_mundo()
{
    struct mundo_t *m;

    if (!(m = malloc(sizeof(struct mundo_t))))
        return NULL;

    m->tempo = 0;                             
    m->n_herois = N_HEROIS;                   
    m->n_bases = N_BASES;                     
    m->n_missoes = N_MISSOES;                 
    m->n_habilidades = N_HABILIDADES;         
    m->tam_mundo = TAMANHO_MUNDO;             
    m->fim_mundo = T_FIM_DO_MUNDO;            
    m->habilidades = cria_cjt(N_HABILIDADES); 
    m->lef = cria_lef();                      

    /* Preenche o conjunto de habilidades do mundo_t. */ 
    for (int i = 0; i < N_HABILIDADES; i++)
        insere_cjt(m->habilidades, i);

    cria_herois(m);
    cria_bases(m);
    cria_missao(m);

    return m;
}


void destroi_mundo(struct mundo_t *m)
{
    destroi_heroi(m);
    destroi_bases(m);
    destroi_missoes(m);

    m->habilidades = destroi_cjt(m->habilidades);
    m->lef = destroi_lef(m->lef);

    free(m);
}


//=============================== Funções auxiliares ===============================

/* A função calcula_distancia calcula a distância entre duas coordenadas (x, y),
 * utilizando o teorema de Pitágoras. Retorna a distância calculada como um valor.
 */
int calcula_distancia(struct local_t loc, struct local_t next_loc)
{
    int distancia;

    int x = (next_loc.x - loc.x) * (next_loc.x - loc.x);
    int y = (next_loc.y - loc.y) * (next_loc.y - loc.y);

    distancia = sqrt(x + y);

    return distancia;
}

/* A função uniao_habilidades calcula a união das habilidades dos 
 *heróis presentes em uma base no mundo.
*/
struct conjunto *uniao_habilidades(struct mundo_t *m, int b_id)
{
    struct conjunto *uniao, *aux;
    int i;

    uniao = cria_cjt(m->n_habilidades-1);

    i = 0;    
    /* Passa pelos heróis. */
    for (i = 0; i < m->n_herois; i++)
    {
        /* Verifica se o heróis esta na base. */ 
        if (pertence_cjt(m->bases[b_id].presente, i))
        {
            aux = uniao;
            uniao = uniao_cjt(uniao, m->herois[i].habilidade);
            destroi_cjt(aux);
        }
    }
    return uniao;
}

/* A função troca realiza a troca de elementos em dois vetores e seus respectivos índices.
 * Troca os elementos nas posições 'a' e 'b' nos vetores especificados.
 */
void troca(int vetor[], int vetor_id[], int a, int b)
{
    int aux, aux_id;

    aux = vetor[a];              
    vetor[a] = vetor[b];         
    vetor[b] = aux;             

    aux_id = vetor_id[a];
    vetor_id[a] = vetor_id[b];
    vetor_id[b] = aux_id;
}

//==================================================================================================================================

/*====> TESTAR PONTEIROS <====*/
/*====> QUEBRAR LINHA NO PRINT DOS EVENTOS <====*/


void evento_chega(struct mundo_t *m, int tempo, int h, int b)
{
    struct evento_t *ev;
    bool espera;

    m->herois[h].id_baseh = b;

    espera = 0;
    // Se há vagas em B e a fila de espera está vazia:
    if ((cardinalidade_cjt(m->bases[b].presente) < m->bases[b].lotacao) && fila_vazia(m->bases[b].espera))
        espera = true;
    // (paciência de H) > (10 * tamanho da fila em B)
    else
        espera = (m->herois[h].paciencia) > (10 * fila_tamanho(m->bases[b].espera));

    // Tem que atender o if e o else if ??

    // Chama outros eventos:
    if (espera)
    {
        // como fazer isso
        if (!(ev = cria_evento(tempo, E_ESPERA, h, b))) // espera
            printf("ERRO EVENTO CHEGA");
        printf("%6d: CHEGA  HEROI %2d BASE %d (%2d/%2d) ESPERA\n", tempo, h, b,
               cardinalidade_cjt(m->bases[b].presente), m->bases[b].lotacao);
    }
    else
    {
        if (!(ev = cria_evento(tempo, E_DESISTE, h, b))) // desiste
            printf("ERRO: EVENTO CHEGADA NÃO ALOCADO");
        printf("%6d: CHEGA  HEROI %2d BASE %d (%2d/%2d) DESISTE\n", tempo, h, b,
               cardinalidade_cjt(m->bases[b].presente), m->bases[b].lotacao);
    }

    insere_lef(m->lef, ev);
}

void evento_espera(struct mundo_t *m, int tempo, int h, int b)
{
    struct evento_t *ev;

    printf("%6d: ESPERA HEROI %2d BASE %d (%2d)", tempo, h, b, fila_tamanho(m->bases[b].espera));

    // Coloca o herói na fila de espera
    enqueue(m->bases[b].espera, h);
    printf("FILA: ");
    fila_imprime(m->bases[b].espera);

    if (!(ev = cria_evento(tempo, E_AVISA, h, b)))
        printf("ERRO: EVENTO AVISA NÃO ALOCADO\n");
    insere_lef(m->lef, ev);
}

void evento_desiste(struct mundo_t *m, int tempo, int h, int b)
{
    struct evento_t *ev;
    int destino;

    printf("%6d: DESISTE HEROI %2d BASE %d\n", tempo, h, b);

    // testar ponteiro
    destino = aleat(0, N_BASES - 1);

    if (!(ev = cria_evento(tempo, E_VIAJA, h, destino)))
        printf("ERRO: EVENTO DESISTE/VIAJAs NÃO ALOCADOa\n");
    insere_lef(m->lef, ev);
}

void evento_avisa(struct mundo_t *m, int tempo, int h, int b)
{
    struct evento_t *ev;

    printf("%6d: AVISA  PORTEIRO BASE %d (%2d/%2d) FILA ", tempo, b, cardinalidade_cjt(m->bases[b].presente), m->bases[b].lotacao);
    fila_imprime(m->bases[b].espera);

    // Aqui tem que ser negado!
    while ((cardinalidade_cjt(m->bases[b].presente) < m->bases[b].lotacao) && !fila_vazia(m->bases[b].espera))
    {
        // retira o heroi da fila como a política fifo
        dequeue(m->bases[b].espera, &h);
        // coloca o heroi da lista de espera na base;
        // insere_cjt(m->bases[b].presente, dado);
        printf("%6d: AVISA  PORTEIRO BASE %d ADMITE %2d \n", tempo, b, h);

        if (!(ev = cria_evento(tempo, E_ENTRA, h, b)))
            printf("ERRO: EVENTO AVISA NÃO ALOCADO\n");
        insere_lef(m->lef, ev);
    }
}

void evento_entra(struct mundo_t *m, int tempo, int h, int b)
{
    struct evento_t *ev;
    int tpb; // tempo de permanência na base

    // Adiciona heroi nos presentes da base b
    insere_cjt(m->bases[b].presente, h);

    tpb = 15 + m->herois[h].paciencia * aleat(1, 20); // ???

    printf("%6d: ENTRA  HEROI %2d BASE %d (%2d/%2d) SAI %d\n", tempo, h, b, cardinalidade_cjt(m->bases[b].presente), m->bases[b].lotacao, tempo + tpb);

    if (!(ev = cria_evento(tempo + tpb, E_SAI, h, b)))
        printf("ERRO: EVENTO ENTAR NÃO ALOCADO\n");
    insere_lef(m->lef, ev);
}

void evento_sai(struct mundo_t *m, int tempo, int h, int b)
{
    struct evento_t *ev;
    int destino;

    printf("%6d: SAI    HEROI %2d BASE %.d (%2d/%2d)\n", tempo, h, b, cardinalidade_cjt(m->bases[b].presente), m->bases[b].lotacao);

    retira_cjt(m->bases[b].presente, h);

    // Calcula o destino do herói e o retira da base
    destino = aleat(0, N_BASES - 1);

    // Destino para onde o herói irá
    if (!(ev = cria_evento(tempo, E_VIAJA, h, destino)))
        printf("ERRO: EVENTO SAI/VIAJA NÃO ALOCADO\n");
    insere_lef(m->lef, ev);

    // Avisa  abase que o herói esta
    if (!(ev = cria_evento(tempo, E_AVISA, h, b)))
        printf("ERRO: EVENTO SAI/AVISA NÃO ALOCADO\n");
    insere_lef(m->lef, ev);
}

void evento_viaja(struct mundo_t *m, int tempo, int h, int b)
{
    struct evento_t *ev;
    int distancia, duracao;
    int id_origem;

    // m->tempo = tempo;
    id_origem = m->herois[h].id_baseh;

    // Calcula o tempo que a viajem levaar
    distancia = calcula_distancia(m->bases[id_origem].local, m->bases[b].local);
    duracao = distancia / m->herois[h].velocidade;

    printf("%6d: VIAJA  HEROI %2d BASE %d BASE %d DIST %d VEL %d CHEGA %d\n", tempo, h, id_origem, b, distancia, m->herois[h].velocidade, tempo + duracao);

    if (!(ev = cria_evento(tempo + duracao, E_CHEGA, h, b)))
        printf("ERRO: EVENTO VIAJA/CHEGA NÃO ALOCADO\n");
    insere_lef(m->lef, ev);
}


void evento_missao(struct mundo_t *m, int tempo, int m_id)
{
    struct evento_t *ev;
    struct conjunto *uniao;
    int base_id[m->n_bases], base_distancia[m->n_bases];
    int i, j, exit, min, base_cumpre;

    printf("%6d: MISSAO %d HAB REQ: ", tempo, m_id);
    imprime_cjt(m->missoes[m_id].habilidade);

    m->missoes[m_id].tentativas++; // Colocar no mundo pds

    // calcula distancia de cada base e coloca em um vetor.
    //calcula a distância de cada base ao local da missão M.
    for (i = 0; i < m->n_bases; i++)
    {
        base_distancia[i] = calcula_distancia(m->bases[i].local, m->missoes[m_id].local);
        base_id[i] = i;        
    }

    // ordena vetor distância
    for (i = 0; i < m->n_bases - 1; i++)
    {
        min = i;
        for (j = i + 1; j < m->n_bases; j++)
            if (base_distancia[j] < base_distancia[min])
                min = j;
        troca(base_distancia, base_id, i, min);
    }

    // imprime a união das habilidades da mais próxima até a mais distante. 
    for(i = 0; i < m->n_bases; i++)
    {
        uniao = uniao_habilidades(m, base_id[i]);
        printf("%6d: MISSAO %d HAB BASE %d: ", tempo, m_id, base_id[i]);
        
        imprime_cjt(uniao);
        destroi_cjt(uniao);
    }

    i = 0;
    exit = 0;

    while (i < m->n_bases && exit == 0)
    {
        uniao = uniao_habilidades(m, base_id[i]);
        if(contido_cjt(m->missoes[m_id].habilidade, uniao))
        {
            exit = 1;
            base_cumpre = m->bases[base_id[i]].id_base;
            // printf("%dUNIAO BASE\n", i);
            // imprime_cjt(uniao);
        }
        destroi_cjt(uniao);
        i++;
    }


    if(exit == 1)
    {
        m->missoes[m_id].realizada = 1;
        printf("%6d: MISSAO %d CUMPRIDA BASE %d HEROIS: ", tempo, m_id, base_cumpre);
        imprime_cjt(m->bases[base_cumpre].presente);

        for (i = 0; i < m->n_herois; i++)
        {
            if(pertence_cjt(m->bases[base_cumpre].presente, i))
            {
                m->herois[i].experiencia ++;
            }
        }
    }
    
    // Adiar a missão em 24 h.
    else
    {
        m->n_miss_impos++;
        if (!(ev = cria_evento(tempo + (24 * 60), E_MISSAO, m_id, 0)))
            printf("ERRO: MISSÃO N ALOCOU EVENTO IMPOSSÍVEL\n");
        insere_lef(m->lef, ev);

        printf("%d: MISSAO %d IMPOSSIVEL\n", tempo, m_id);
    }
}


void evento_fim(struct mundo_t *m)
{
    int m_compridas, tentativas, i;
    m_compridas = 0;
    tentativas = 0;

    printf("%d: FIM\n", m->tempo);

    // Dados dos heróis.
    for (i = 0; i < m->n_herois; i++)
    {
        printf("HEROI %2d PAC  %3d", i, m->herois[i].paciencia);
        printf(" VEL %4d EXP %4d HABS ", m->herois[i].velocidade, m->herois[i].experiencia);
        imprime_cjt(m->herois[i].habilidade);
    }

    // Pega os dados das missôes para formar a saída.
    for (i = 0; i < m->n_missoes; i++)
    {
        tentativas = m->missoes[i].tentativas + tentativas;
        m_compridas += m->missoes[i].realizada;
    }

    // IMprime as estatísticas da simulação, usa um comando casting para mudar de int para float.
    printf("%d MISSOES CUMPRIDAS\n", m_compridas);
    printf("%d/%d MISSOES CUMPRIDAS (%.2f%%), MEDIA %.2f TENTATIVAS/MISSAO\n", m_compridas, m->n_missoes,
           (float)m_compridas / m->n_missoes * 100, (float)tentativas / m->n_missoes);
}

void evento_inicia(struct mundo_t *m)
{
    struct evento_t *ev;
    int base, tempo;

    for (int i = 0; i < m->n_herois; i++)
    {
        base = aleat(0, m->n_bases - 1);
        tempo = aleat(0, 4320); // 4320 = 60*24*3 = 3 dias

        if (!(ev = cria_evento(tempo, E_CHEGA, i, base)))
            printf("ERRO: INICIA HEROIS\n");

        insere_lef(m->lef, ev);
    }

    for (int i = 0; i < m->n_missoes; i++)
    {
        tempo = aleat(0, T_FIM_DO_MUNDO - 1);

        if (!(ev = cria_evento(tempo, E_MISSAO, i, 0)))
            printf("ERRO: INICIA MISSOES\n");

        insere_lef(m->lef, ev);
    }

    if (!(ev = cria_evento(T_FIM_DO_MUNDO, E_FIM, 0, 0)))
        printf("ERRO: ALOCAR MISSOES\n");
    insere_lef(m->lef, ev);
}