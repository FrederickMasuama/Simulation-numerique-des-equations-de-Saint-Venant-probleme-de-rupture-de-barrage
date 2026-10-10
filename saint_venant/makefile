COMPILATEUR = gfortran
OPTC = -Wall -O2

SRC = source
OBJ = obj
BIN = bin
DATA = data
SCRIPTS = scripts
RESULTATS = resultats

EXEC = $(BIN)/saint_venant_exe

OBJS = \
$(OBJ)/mod_parametres.o \
$(OBJ)/mod_initialisations.o \
$(OBJ)/mod_flux.o \
$(OBJ)/mod_solveur.o \
$(OBJ)/mod_sortie.o \
$(OBJ)/main.o 

.PHONY: all clean run plot gif

#cible principale
all : plot

#=================================================
#édition des liens
$(EXEC): $(OBJS)
	$(COMPILATEUR) $(OPTC) $^ -o $@

#==================================================
#compilation générale des fichiers fortran
$(OBJ)/%.o: $(SRC)/%.f90
	$(COMPILATEUR) $(OPTC) -J$(OBJ) -I$(OBJ) -c $< -o $@

#====================================================
#dépendances des modules
$(OBJ)/mod_initialisations.o: \
$(OBJ)/mod_parametres.o 

$(OBJ)/mod_flux.o: \
$(OBJ)/mod_parametres.o 

$(OBJ)/mod_solveur.o: \
$(OBJ)/mod_flux.o \
$(OBJ)/mod_parametres.o 

$(OBJ)/mod_sortie.o:\
$(OBJ)/mod_parametres.o 

$(OBJ)/main.o: \
$(OBJ)/mod_flux.o \
$(OBJ)/mod_initialisations.o \
$(OBJ)/mod_parametres.o \
$(OBJ)/mod_solveur.o \
$(OBJ)/mod_sortie.o

#===================================================
#Nettoyage
clean:
	rm -f $(OBJ)/*.o $(OBJ)/*.mod $(EXEC)

#execution du programme
run : $(EXEC)
	cd $(DATA) && ../$(EXEC)  #permet de retrouver le parametres.nml sans modifier le code source

#tracage des resultats
plot: run
	cd $(SCRIPTS) && gnuplot plot.gnu


#creation du gif
gif: $(EXEC)
	cd $(DATA) && rm -f frame_*.dat nb_frames.dat && ../$(EXEC)
	cd $(SCRIPTS) && gnuplot animation.gnu

