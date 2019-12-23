set xzeroaxis
set xrange[*:*]
set yrange[*:*]

set xlabel "MC Iteration"
set ylabel "Energy/N"

set term png
set output "SIM-L-060-energy-EVO.png"

plot \
"SIM-L-060-TEMP-1500.evo" u ($1):($2/3600) w l t "T=1.5K", \
"SIM-L-060-TEMP-2000.evo" u ($1):($2/3600) w l t "T=2.0K", \
"SIM-L-060-TEMP-2500.evo" u ($1):($2/3600) w l t "T=2.5K", \
"SIM-L-060-TEMP-3000.evo" u ($1):($2/3600) w l t "T=3.0K", \
"SIM-L-060-TEMP-3500.evo" u ($1):($2/3600) w l t "T=3.5K", \
"SIM-L-060-TEMP-4000.evo" u ($1):($2/3600) w l t "T=4.0K", \
"SIM-L-060-TEMP-4500.evo" u ($1):($2/3600) w l t "T=4.5K"

set term wxt
replot
pause -1 "Press ENTER"

set xzeroaxis
set xrange[*:*]
set yrange[*:*]

set ylabel "Magnetization/N"

set term png
set output "SIM-L-060-magnetiz-EVO.png"

plot \
"SIM-L-060-TEMP-1500.evo" u ($1):($3/3600) w l t "T=1.5K", \
"SIM-L-060-TEMP-2000.evo" u ($1):($3/3600) w l t "T=2.0K", \
"SIM-L-060-TEMP-2500.evo" u ($1):($3/3600) w l t "T=2.5K", \
"SIM-L-060-TEMP-3000.evo" u ($1):($3/3600) w l t "T=3.0K", \
"SIM-L-060-TEMP-3500.evo" u ($1):($3/3600) w l t "T=3.5K", \
"SIM-L-060-TEMP-4000.evo" u ($1):($3/3600) w l t "T=4.0K", \
"SIM-L-060-TEMP-4500.evo" u ($1):($3/3600) w l t "T=4.5K"

set term wxt
replot
pause -1 "Press ENTER"
