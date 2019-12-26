set term pngcairo enhanced font 'verdana,10'

file = "tc2.txt"
load "fits2.txt"

labels = "Tc (energy), Tc (heat cap.), Tc (magnetiz.), Tc (suscept.)"
colors = "1 2 3 4"

############################################################################1
set output "lt.png"

set xzeroaxis
set xrange[0:*]
set yrange[*:*]
set xlabel "1/L"
set key top left
set ylabel "Tc"

plot for[j=1:4] file i j-1 u (1/$2):3 w p pt 1 lc word(colors,j) ps 1 t word(labels,j), \
fe(x) w l lc word(colors,1) t "", \
fc(x) w l lc word(colors,2) t "", \
fm(x) w l lc word(colors,3) t "", \
fx(x) w l lc word(colors,4) t ""

set terminal wxt
replot
pause -1 "Press ENTER"