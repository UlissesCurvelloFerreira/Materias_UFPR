# makefile The Boys
# Carlos Maziero - DINF/UFPR, 10/2023

CC      = gcc
CFLAGS  = -Wall -Wextra -g -std=c99 -pedantic
LDLIBS  = -lm
MAIN    = theboys
ENTREGA = $(MAIN)-entrega

# programa principal
$(MAIN): $(MAIN).o lef.o fila.o conjunto.o eventos.o
$(MAIN).o: $(MAIN).c lef.c fila.c conjunto.c eventos.c

# TADs
lef.o: lef.c lef.h
fila.o: fila.c fila.h
conjunto.o: conjunto.c conjunto.h
eventos.o: eventos.c eventos.h

# Teste da LEF
testa-lef: testa-lef.o lef.o
testa-lef.o: testa-lef.c lef.h

clean:
	rm -f *.o *~ $(MAIN) $(ENTREGA).tgz

entrega: clean
	mkdir $(ENTREGA)
	cp *.c *.h makefile $(ENTREGA)
	rm -f $(ENTREGA)/testa*
	chmod 600 $(ENTREGA)/*
	tar czvf $(ENTREGA).tgz $(ENTREGA)
	rm -rf $(ENTREGA)
	@echo "Arquivo $(ENTREGA).tgz criado para entrega"
