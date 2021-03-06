set xzeroaxis
set xrange[0:5000]
set yrange[*:*]
set xtics 1000
set ytics 0.2
set mxtics 10
set mytics 4

set xlabel "MC Iteration"
set ylabel "Energy/N"
set key top right horizontal

set term pngcairo enhanced font 'verdana,12'
set output "SIM-L-060-energy-EVO.png"

plot \
"SIM-L-060-TEMP-1500.evo" u ($1):($2/3600) w l t "T=1.5", \
"SIM-L-060-TEMP-2000.evo" u ($1):($2/3600) w l t "T=2.0", \
"SIM-L-060-TEMP-2500.evo" u ($1):($2/3600) w l t "T=2.5", \
"SIM-L-060-TEMP-3000.evo" u ($1):($2/3600) w l t "T=3.0", \
"SIM-L-060-TEMP-3500.evo" u ($1):($2/3600) w l t "T=3.5", \
"SIM-L-060-TEMP-4000.evo" u ($1):($2/3600) w l t "T=4.0", \
"SIM-L-060-TEMP-4500.evo" u ($1):($2/3600) w l t "T=4.5"

set term wxt
replot
pause -1 "Press ENTER"

set xzeroaxis
set xrange[0:5000]
set yrange[*:*]

set ylabel "Magnetization/N"

set term pngcairo enhanced font 'verdana,12'
set output "SIM-L-060-magnetiz-EVO.png"
set key top right vertical

plot \
"SIM-L-060-TEMP-1500.evo" u ($1):($3/3600) w l t "T=1.5 ", \
"SIM-L-060-TEMP-2000.evo" u ($1):($3/3600) w l t "T=2.0 ", \
"SIM-L-060-TEMP-2500.evo" u ($1):($3/3600) w l t "T=2.5 ", \
"SIM-L-060-TEMP-3000.evo" u ($1):($3/3600) w l t "T=3.0 ", \
"SIM-L-060-TEMP-3500.evo" u ($1):($3/3600) w l t "T=3.5 ", \
"SIM-L-060-TEMP-4000.evo" u ($1):($3/3600) w l t "T=4.0 ", \
"SIM-L-060-TEMP-4500.evo" u ($1):($3/3600) w l t "T=4.5 "

set term wxt
replot
pause -1 "Press ENTER"
