set xzeroaxis
set xrange[*:*]
set yrange[*:*]

set xlabel "MC Iteration"
set ylabel "Energy/N"

set term png
set output "energy_evolution.png"

plot \
"SIM-L-030-TEMP-1500-MCTOT-10K-01.evo" u ($1):($2/900) w l t "T=1.5K", \
"SIM-L-030-TEMP-1800-MCTOT-10K-01.evo" u ($1):($2/900) w l t "T=1.8K", \
"SIM-L-030-TEMP-2500-MCTOT-10K-01.evo" u ($1):($2/900) w l t "T=2.5K", \
"SIM-L-030-TEMP-3500-MCTOT-10K-01.evo" u ($1):($2/900) w l t "T=3.5K", \
"SIM-L-030-TEMP-4500-MCTOT-10K-01.evo" u ($1):($2/900) w l t "T=4.5K"

set term wxt
replot
pause -1 "Press ENTER"

set xzeroaxis
set xrange[*:*]
set yrange[*:*]

set ylabel "Magnetization/N"

set term png
set output "magnetization_evolution.png"

plot \
"SIM-L-030-TEMP-1500-MCTOT-10K-01.evo" u ($1):($4/900) w l t "T=1.5K", \
"SIM-L-030-TEMP-1800-MCTOT-10K-01.evo" u ($1):($4/900) w l t "T=1.8K", \
"SIM-L-030-TEMP-2500-MCTOT-10K-01.evo" u ($1):($4/900) w l t "T=2.5K", \
"SIM-L-030-TEMP-3500-MCTOT-10K-01.evo" u ($1):($4/900) w l t "T=3.5K", \
"SIM-L-030-TEMP-4500-MCTOT-10K-01.evo" u ($1):($4/900) w l t "T=4.5K"

set term wxt
replot
pause -1 "Press ENTER"
