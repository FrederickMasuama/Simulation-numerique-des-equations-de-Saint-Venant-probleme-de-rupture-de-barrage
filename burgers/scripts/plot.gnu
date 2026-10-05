set terminal pngcairo enhanced

# =========================
# Condition initiale
# =========================

set output "../resultats/condition_initiale.png"

set title "Équation de Burgers - Condition initiale"
set xlabel "x"
set ylabel "u(x,0)"

set xrange [-5:5]
set yrange [-0.1:5.0]

set xtics 1
set ytics 0.1
set grid

plot "../data/solution_initiale.dat" using 1:2 \
     with lines lw 2 title "u(x,0)"

set output


# =========================
# Solution finale
# =========================

set output "../resultats/burgers_finale.png"

set title "Équation de Burgers - Solution finale"
set xlabel "x"
set ylabel "u(x,t_f)"

set xrange [-5:5]
set yrange [-0.1:5.0]

set xtics 1
set ytics 0.1
set grid

plot "../data/solution.dat" using 1:2 \
     with lines lw 2 title "u(x,t_f)"

set output
