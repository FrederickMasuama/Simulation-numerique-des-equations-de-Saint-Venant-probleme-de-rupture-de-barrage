set terminal pngcairo enhanced
set output "../resultats/advection1D_VF.png"

set title "Équation d'Advection 1D - VF avec flux de Lax-Friedrichs"
set xlabel "x"
set ylabel "u(x,t)"

set xrange [-3:8]
set yrange [-0.1:1.5]

set xtics 1
set ytics 0.1
set grid

plot \
    ((x >= -1 && x <= 1) ? 1 : 0) \
        with lines lw 2 title "Condition initiale", \
    "../data/solution.dat" using 1:2 \
        with lines lw 2 title "Solution finale"

set output