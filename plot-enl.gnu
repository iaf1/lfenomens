#set terminal wxt
set terminal png

file = "MC-TOT.res"

displ(x) = ($0 == 0) ? (x0=x,1/0) : (dx=x-x0,x0=x,x-dx/2)
der(x,y) = ($0 == 0) ? (x1=x,y1=y,1/0) : (x2=x1,x1=x,y2=y1,y1=y,(y1-y2)/(x1-x2))

labels = "L=15 L=30 L=45 L=60 L=75 L=120"
colors = "1 2 3 4 5 6"

############################################################################1
set output "plot-e.png"

set xzeroaxis
set xrange[1.5:3.5]
set yrange[*:*]
set xlabel "Reduced temperature T"
set key top left
set ylabel "Energy per particle"

set xtics 0.2
set ytics 0.2
set mxtics 4
set mytics 4

set multiplot
# === large plot ===
plot for[j=1:words(labels)] file i j-1 u 2:(($4)/$1**2) w p pt 1 lc word(colors,j) ps 0.7 t word(labels,j)

# === small plot ===
set origin 0.55,0.15
set size 0.4,0.55
set xrange [2.25:2.4]
set yrange [-1.5:-1.2]
unset xlabel
unset ylabel
unset key
set tics scale 0.5 front
set xtics 0.05 offset 0,0.5
set ytics 0.1 offset 0.5,0
plot for[j=1:words(labels)] file i j-1 u 2:(($4)/$1**2) w p pt 1 lc word(colors,j) ps 0.7 t word(labels,j)

unset multiplot

pause -1 "Press ENTER"
reset
############################################################################2
set output "plot-cv.png"

set xzeroaxis
set xrange[1.5:3.5]
set yrange[*:*]
set xlabel "Reduced temperature T"
set key top left
set ylabel "Heat capacity at const. vol. per part."

set xtics 0.2
set ytics 0.5
set mxtics 4
set mytics 5

set multiplot
# === large plot ===
plot for[j=1:words(labels)] file i j-1 u 2:(($5-$4**2)/($2**2*$1**2)) w p pt 1 lc word(colors,j) ps 0.7 t word(labels,j)

# === small plot ===
set origin 0.55,0.35
set size 0.4,0.6
set xrange [2.15:2.45]
set yrange [1.2:2.6]
unset xlabel
unset ylabel
unset key
set tics scale 0.5 front
set xtics 0.1 offset 0,0.5
set ytics 0.2 offset 0.5,0
plot for[j=1:words(labels)] file i j-1 u 2:(($5-$4**2)/($2**2*$1**2)) w p pt 1 lc word(colors,j) ps 0.7 t word(labels,j)

unset multiplot

pause -1 "Press ENTER"
reset
############################################################################3
set output "plot-m.png"

set xzeroaxis
set xrange[1.5:3.5]
set yrange[*:*]
set xlabel "Reduced temperature T"
set key bottom left
set ylabel "Magnetization per part."

set xtics 0.2
set ytics 0.2
set mxtics 4
set mytics 4

set multiplot
# === large plot ===
plot for[j=1:words(labels)] file i j-1 u 2:($8/$1**2) w p pt 1 lc word(colors,j) ps 0.7 t word(labels,j)

# === small plot ===
set origin 0.55,0.45
set size 0.4,0.5
set xrange [2.2:2.4]
set yrange [0:0.8]
unset xlabel
unset ylabel
unset key
set tics scale 0.5 front
set xtics 0.1 offset 0,0.5
set ytics 0.2 offset 0.5,0
plot for[j=1:words(labels)] file i j-1 u 2:($8/$1**2) w p pt 1 lc word(colors,j) ps 0.7 t word(labels,j)

unset multiplot

pause -1 "Press ENTER"
reset
############################################################################4
set output "plot-x.png"

set xzeroaxis
set xrange[1.5:3.5]
set yrange[0:250]
set xlabel "Reduced temperature T"
set key top left
set ylabel "Susceptibility per part."

set xtics 0.2
set ytics 50
set mxtics 4
set mytics 5

set multiplot
# === large plot ===
plot for[j=1:words(labels)] file i j-1 u 2:(($9-$8**2)/($2*$1**2)) w p pt 1 lc word(colors,j) ps 0.7 t word(labels,j)

# === small plot ===
set origin 0.55,0.15
set size 0.4,0.75
set xrange [2.2:2.5]
set yrange [0:230]
unset xlabel
unset ylabel
unset key
set tics scale 0.5 front
set xtics 0.1 offset 0,0.5
set ytics 50 offset 0.5,0
plot for[j=1:words(labels)] file i j-1 u 2:(($9-$8**2)/($2*$1**2)) w p pt 1 lc word(colors,j) ps 0.7 t word(labels,j)

unset multiplot

pause -1 "REMEMBER TO SET TERM PNG!!!"
reset
