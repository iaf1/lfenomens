file = "MC-TOT.res"

set xzeroaxis
set xrange[*:3.5]
set yrange[*:*]
set xlabel "Reduced temperature T"


set ylabel "Susceptibility per particle"

set term png
set output "plot-x.png"

plot \
file u ($2):(($9-$8**2)/($2*$1**2)) t""
plot \
file i 0 u ($2):(($9-$8**2)/($2*$1**2)) t"L=15", \
file i 1 u ($2):(($9-$8**2)/($2*$1**2)) t"L=30", \
file i 2 u ($2):(($9-$8**2)/($2*$1**2)) t"L=45", \
file i 3 u ($2):(($9-$8**2)/($2*$1**2)) t"L=60"

set term wxt
replot
pause -1 "Press ENTER"
