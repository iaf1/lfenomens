file = "MC-TOT.res"

set xzeroaxis
set xrange[*:*]
set yrange[*:*]
set xlabel "Reduced temperature T"
set key top left

displ(x) = ($0 == 0) ? (x0=x,1/0) : (dx=x-x0,x0=x,x-dx/2)
der(x,y) = ($0 == 0) ? (x1=x,y1=y,1/0) : (x2=x1,x1=x,y2=y1,y1=y,(y1-y2)/(x1-x2))

labels = "L=15 L=30 L=45 L=60 L=75 L=120"
colors = "1 2 3 4 5 6"

############################################################################
set ylabel "Energy per particle"

set term png
set output "plot-e.png"

plot for[j=1:words(labels)] file i j-1 u 2:(($4)/$1**2) w p pt 1 lc word(colors,j) ps 0.7 t word(labels,j)

set term wxt
replot
pause -1 "Press ENTER"

############################################################################
set ylabel "Heat capacity at ct. V per part. (in k units)"

set term png
set output "plot-cv.png"

plot for[j=1:words(labels)] file i j-1 u 2:(($5-$4**2)/($2**2*$1**2)) w p pt 1 lc word(colors,j) ps 0.7 t word(labels,j)

set term wxt
replot
pause -1 "Press ENTER"

############################################################################
set ylabel "Magnetization per particle"

set term png
set output "plot-m.png"

#plot \
#file u ($2):($8/$1**2) t"<|m|>", \
#file u ($2):($9**(1./2.)/$1**2) t"sqrt(<m²>)"

plot for[j=1:words(labels)] file i j-1 u 2:($8/$1**2) w p pt 1 lc word(colors,j) ps 0.7 t word(labels,j)

set term wxt
replot
pause -1 "Press ENTER"

############################################################################
set ylabel "Susceptibility per particle"

set term png
set output "plot-x.png"

plot for[j=1:words(labels)] file i j-1 u 2:(($9-$8**2)/($2*$1**2)) w p pt 1 lc word(colors,j) ps 0.7 t word(labels,j)

set term wxt
replot
pause -1 "Press ENTER"
