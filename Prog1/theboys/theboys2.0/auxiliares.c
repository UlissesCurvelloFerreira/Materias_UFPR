  
  
  /* Chamada para as funções teste, funções que verificam se tudoo esta bem inicializada. */
  // printf("\nHabilidades existentes no mundo:\n");
  // imprime_cjt(mundo->habilidades);

  //printf("\nPropriedades dos Heróis:\n");
  //imprime_herois_mundo(mundo);

  // printf("\nPropriedades das Bases:\n");
  // imprime_bases_mundo(mundo);

  //printf("\nPropriedades das Missões:\n");
  //imprime_missoes_mundo(mundo);

  // evento_chega(mundo, 0, 0, 0);



//============================================================================================//
/*
void imprime_herois_mundo(struct mundo_t *m)
{
    if (m)
    {
        for (int i = 0; i < m->n_herois; i++)
        {
            struct heroi_t heroi = m->herois[i];

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

void imprime_bases_mundo(struct mundo_t *m)
{

    for (int i = 0; i < m->n_bases; i++)
    {
        struct base_t base = m->bases[i];

        printf("Base %d:\n", base.id_base);
        printf("Lotação: %d\n", base.lotacao);
        printf("Localização: (%d, %d)\n", base.local.x, base.local.y);
        printf("Heróis Presentes na Base:\n");
        imprime_cjt(base.presente);

        printf("Heróis na Fila de Espera:\n");
        fila_imprime(base.espera);
        printf("\n");
    }
}

void imprime_missoes_mundo(struct mundo_t *m)
{
    for (int i = 0; i < N_MISSOES; i++)
    {
        struct missao_t *missoes = m->missoes;

        printf("Missão %d:\n", missoes[i].id);
        printf("Tentativas: %d\n", m->missoes[i].tentativas);
        printf("Localização da Missão: (%d, %d)\n", missoes[i].local.x, missoes[i].local.y);
        printf("Habilidades Necessárias:\n");
        imprime_cjt(missoes[i].habilidade);
        printf("\n");
    }
}
*/

//============================================================================================//



//============================================================================================//
/* Funçaõ usada no imprime conjunto, mas acho que não é necessario*/
/* Mudei para o quickSort para ficar mais eficiente, dado que ja usei em um outro tp pequeno. */
/* Troca os posições. */
void swap(int *a, int *b)
{
    int t = *a;
    *a = *b;
    *b = t;
}

/* Particiona o vetor a ser ordenado. */
int partition(int v[], int a, int b)
{
    int x = v[b];
    int i = (a - 1);

    for (int j = a; j <= b - 1; j++)
    {
        if (v[j] <= x)
        {
            i++;
            swap(&v[i], &v[j]);
        }
    }
    swap(&v[i + 1], &v[b]);
    return (i + 1);
}

/* Responsaver por ordenar o vetor. */
void quickSort(int v[], int a, int b)
{
    if (a < b)
    {
        int p = partition(v, a, b);
        quickSort(v, a, p - 1);
        quickSort(v, p + 1, b);
    }
}

/* Se usar chamar no lugar do imprime conjunto. */
//quickSort(c->v, 0, c->card - 1);

//============================================================================================//
  