COMPILATEUR = gfortran
OPTC = -Wall -O2

SRC = source
OBJ = obj
BIN = bin
DATA = data
SCRIPTS = scripts

EXEC = $(BIN)/advection_exe

OBJS = \
$(OBJ)/mod_parametres.o \
$(OBJ)/mod_initialisations.o \

.PHONY: all clean run plot

all : plot

$(EXEC): $(OBJS)
	$(COMPILATEUR) $(OPTC) $^ -o $@

$(OBJ)/%.o: $(SRC)/%.f90
	$(COMPILATEUR) $(OPTC) -J$(OBJ) -c $< -o $@

#dépendances des modules
$(OBJ)/mod_initialisations.o: \
$(OBJ)/mod_parametres.o \


clean :
	rm -f $(OBJ)/*.mod $(EXEC)

run : $(EXEC)
	cd$(DATA) && ../$  #permet de retrouver le parametres.nml sans modifier le code source

plot: run
	cd $(SCRIPTS) && gnuplot plot.gnu


