# ==========================================
# Animation GIF : rupture de barrage - Lax-Friedrichs
# ==========================================

stats "../data/nb_frames_LF.dat" using 1 nooutput
nframes = STATS_max

set terminal gif animate delay 8 loop 0 optimize
set output "../resultats/rupture_barrage_LF.gif"

set title "Saint-Venant - Rupture de barrage - Lax-Friedrichs"
set xlabel "Position x"
set ylabel "Hauteur d'eau h(x,t)"

set xrange [-10:10]
set yrange [0:3]

set xtics 1
set ytics 0.2
set grid
set key top right

do for [i=0:nframes] {
    set title sprintf("Rupture de barrage - Lax-Friedrichs - Image %d/%d", i, nframes)

    fichier = sprintf("../data/frame_LF_%05d.dat", i)

    plot fichier using 1:2 with lines lw 2 title "Hauteur d'eau"
}

set output