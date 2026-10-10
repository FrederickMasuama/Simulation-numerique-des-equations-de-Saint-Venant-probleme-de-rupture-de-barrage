set terminal pngcairo enhanced

# =========================
# Condition initiale
# =========================

set output "../resultats/condition_initiale.png"

set title "Saint-Venant - Hauteur d'eau initiale"
set xlabel "Position x"
set ylabel "Hauteur d'eau h(x,0)"

set xrange [-10:10]
set yrange [0:3]

set xtics 1
set ytics 0.2
set grid

plot "../data/solution_initiale.dat" using 1:2 \
     with lines lw 2 title "h(x,0)"

set output


# =========================
# Solution finale
# =========================

set output "../resultats/saint_venant_finale.png"

set title "Saint-Venant - Hauteur d'eau finale"
set xlabel "Position x"
set ylabel "Hauteur d'eau h(x,t_f)"

set xrange [-10:10]
set yrange [0:3]

set xtics 1
set ytics 0.2
set grid

plot "../data/solution.dat" using 1:2 \
     with lines lw 2 title "h(x,t_f)"

set output


# =========================
# Vitesse finale
# =========================

set output "../resultats/vitesse_finale.png"

set title "Saint-Venant - Vitesse finale"
set xlabel "Position x"
set ylabel "Vitesse u(x,t_f)"

set xrange [-10:10]
set autoscale y

set xtics 1
set grid

plot "../data/solution.dat" using 1:4 \
     with lines lw 2 title "u(x,t_f)"

set output