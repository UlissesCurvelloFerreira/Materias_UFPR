/*
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

// na main();




    printf("\nHabilidades existentes no mundo:\n");
    imprime_cjt(mundo->habilidades);

    printf("\nPropriedades dos Heróis:\n");
    imprime_herois_mundo(mundo);

    printf("\nPropriedades das Bases:\n");
    imprime_bases_mundo(mundo);

    printf("\nPropriedades das Missões:\n");
    imprime_missoes_mundo(mundo);







*/