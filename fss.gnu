#set terminal wxt
set terminal pngcairo enhanced font 'Verdana,14'
set encoding utf8

file = "MC-TOT.res"

load "fits2.txt"

displ(x) = ($0 == 0) ? (x0=x,1/0) : (dx=x-x0,x0=x,x-dx/2)
der(x,y) = ($0 == 0) ? (x1=x,y1=y,1/0) : (x2=x1,x1=x,y2=y1,y1=y,(y1-y2)/(x1-x2))

labels = "L=15 L=30 L=45 L=60 L=75 L=90 L=120"
colors = "1 2 3 4 5 6 7"

############################################################################1
set output "fss-m.png"

set xzeroaxis
set xrange[-40:80]
set yrange[0:1.8]
set xlabel "L^{1/ν} (T-T_c)/T_c"
set key bottom left opaque
set ylabel "<|m_L|> L^{β/ν}"

set xtics 20
set ytics 0.2
set mxtics 4
set mytics 4

set multiplot
# === large plot ===
plot for[j=1:words(labels)] file i j-1 u ($1**(1/nu)*($2-tc)/tc):(($8/$1**2)*$1**(beta/nu)) w p pt 1 lc word(colors,j) ps 0.7 t word(labels,j)

# === small plot ===
set origin 0.55,0.45
set size 0.4,0.5
set xrange [-5:10]
set yrange [0.2:1.6]
unset xlabel
unset ylabel
unset key
set tics scale 0.5 front
set xtics 5 offset 0,0.5
set ytics 0.2 offset 0.5,0
set mxtics 5
set mytics 4
replot

unset multiplot

pause -1 "Press ENTER"
reset
############################################################################2
set output "fss-x.png"

set xzeroaxis
set xrange[-40:80]
set yrange[0:0.04]
set xlabel "L^{1/ν} (T-T_c)/T_c"
set key top left horizontal opaque
set ylabel "<χ_L> L^{-γ/ν}"

set xtics 20
set ytics 0.005
set mxtics 4
set mytics 5

set multiplot
# === large plot ===
plot for[j=1:words(labels)] file i j-1 u ($1**(1/nu)*($2-tc)/tc):((($9-$8**2)/($2*$1**2))*$1**(-gamma/nu)) w p pt 1 lc word(colors,j) ps 0.7 t word(labels,j)

# === small plot ===
set origin 0.55,0.15
set size 0.4,0.75
set xrange [-5:10]
set yrange [0:0.035]
unset xlabel
unset ylabel
unset key
set tics scale 0.5 front
set xtics 5 offset 0,0.5
set ytics 0.005 offset 0.5,0
set mxtics 5
set mytics 5
replot

unset multiplot

pause -1 "REMEMBER TO SET TERM PNG!!!"
reset
