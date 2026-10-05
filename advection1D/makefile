COMPILATEUR = gfortran
OPTC = -Wall -O2

SRC = source
OBJ = obj
BIN = bin
DATA = data
SCRIPTS = scripts
RESULTATS = resultats

EXEC = $(BIN)/advection_exe

OBJS = \
$(OBJ)/main.o \
$(OBJ)/mod_parametres.o \
$(OBJ)/mod_initialisations.o \
$(OBJ)/mod_flux.o \
$(OBJ)/mod_solveur.o \
$(OBJ)/mod_sortie.o 

.PHONY: all clean run plot

all : plot

#=================================================
#édition des liens
$(EXEC): $(OBJS)
	$(COMPILATEUR) $(OPTC) $^ -o $@

#==================================================
#compilation générale des fichiers fortran
$(OBJ)/%.o: $(SRC)/%.f90
	$(COMPILATEUR) $(OPTC) -J$(OBJ) -c $< -o $@

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
clean:
	rm -f $(OBJ)/*.o $(OBJ)/*.mod $(EXEC)

run : $(EXEC)
	cd $(DATA) && ../$(EXEC)  #permet de retrouver le parametres.nml sans modifier le code source

plot: run
	cd $(SCRIPTS) && gnuplot plot.gnu


