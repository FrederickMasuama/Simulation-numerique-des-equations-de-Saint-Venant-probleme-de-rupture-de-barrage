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
$(OBJ)/mod_solveur_muscl.o \
$(OBJ)/mod_sortie.o \
$(OBJ)/main.o

.PHONY: all clean run plot gif gifs

#==================================================
# CIBLE PRINCIPALE
#==================================================

all: plot


#==================================================
# EDITION DES LIENS
#==================================================

$(EXEC): $(OBJS)
	$(COMPILATEUR) $(OPTC) $^ -o $@


#==================================================
# COMPILATION DES FICHIERS FORTRAN
#==================================================

$(OBJ)/%.o: $(SRC)/%.f90
	$(COMPILATEUR) $(OPTC) -J$(OBJ) -I$(OBJ) -c $< -o $@


#==================================================
# DEPENDANCES DES MODULES
#==================================================

$(OBJ)/mod_initialisations.o: \
$(OBJ)/mod_parametres.o

$(OBJ)/mod_flux.o: \
$(OBJ)/mod_parametres.o

$(OBJ)/mod_solveur.o: \
$(OBJ)/mod_flux.o \
$(OBJ)/mod_parametres.o

$(OBJ)/mod_solveur_muscl.o: \
$(OBJ)/mod_parametres.o \
$(OBJ)/mod_flux.o

$(OBJ)/mod_sortie.o: \
$(OBJ)/mod_parametres.o

$(OBJ)/main.o: \
$(OBJ)/mod_parametres.o \
$(OBJ)/mod_initialisations.o \
$(OBJ)/mod_flux.o \
$(OBJ)/mod_solveur.o \
$(OBJ)/mod_solveur_muscl.o \
$(OBJ)/mod_sortie.o


#==================================================
# NETTOYAGE DES FICHIERS COMPILÉS
#==================================================

clean:
	rm -f $(OBJ)/*.o $(OBJ)/*.mod $(EXEC)


#==================================================
# EXECUTION DU PROGRAMME
#==================================================

run: $(EXEC)
	cd $(DATA) && ../$(EXEC)


#==================================================
# TRACAGE DES RESULTATS FINAUX
#==================================================

plot: run
	cd $(SCRIPTS) && gnuplot plot.gnu


# GENERATION DES DEUX GIF

gifs: $(EXEC)
	cd $(DATA) && rm -f frame_*.dat nb_frames*.dat
	cd $(DATA) && ../$(EXEC)
	cd $(SCRIPTS) && gnuplot animation_lf.gnu
	cd $(SCRIPTS) && gnuplot animation_muscl.gnu

# COMPATIBILITE AVEC L'ANCIENNE CIBLE

gif: gifs
