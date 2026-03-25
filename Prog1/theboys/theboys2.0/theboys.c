#include <stdlib.h>
#include <stdio.h>

#include "eventos.h"

int main()
{
  struct mundo_t *mundo;
  struct evento_t *ev;

  srand(0);

  mundo = inicia_mundo();
  evento_inicia(mundo);


  while (mundo->tempo < T_FIM_DO_MUNDO)
  {

    ev = retira_lef(mundo->lef);

    mundo->tempo = ev->tempo; // dps
    
    
    switch (ev->tipo)
    {
    case E_CHEGA:
      evento_chega(mundo, ev->tempo, ev->dado1, ev->dado2);
      break;

    case E_ESPERA:
      evento_espera(mundo, ev->tempo, ev->dado1, ev->dado2);
      break;

    case E_DESISTE:
      evento_desiste(mundo, ev->tempo, ev->dado1, ev->dado2);
      break;

    case E_AVISA:
      evento_avisa(mundo, ev->tempo, ev->dado1, ev->dado2);
      break;

    case E_ENTRA:
      evento_entra(mundo, ev->tempo, ev->dado1, ev->dado2);
      break;

    case E_SAI:
      evento_sai(mundo, ev->tempo, ev->dado1, ev->dado2);
      break;

    case E_VIAJA:
      evento_viaja(mundo, ev->tempo, ev->dado1, ev->dado2);
      break;
    
    case E_MISSAO:
      evento_missao(mundo, ev->tempo, ev->dado1);
      break;
      
    
    case E_FIM:
      evento_fim(mundo);
      break;

    default:
      break;
    }
    
    destroi_evento(ev);
    
  }

  destroi_mundo(mundo);

  return 0;
}
