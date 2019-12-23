file = "MC-TOT.res"

set xzeroaxis
set xrange[1.5:3.5]
set yrange[*:*]
set xlabel "Reduced temperature T"

# derivative functions.  Return 1/0 for first point, otherwise delta y or (delta y)/(delta x)
#d(y) = ($0 == 0) ? (y1 = y, 1/0) : (y2 = y1, y1 = y, y1-y2)
#d(y) = ($0 == 0) ? (x1 = x, y1 = y, 1/0) : (dx=$2-x1, x1=$2, $2-dx/2)
displ(x) = ($0 == 0) ? (x0=x,1/0) : (dx=x-x0,x0=x,x-dx/2)
der(x,y) = ($0 == 0) ? (x1=x,y1=y,1/0) : (x2=x1,x1=x,y2=y1,y1=y,(y1-y2)/(x1-x2))

set ylabel "Heat capacity at ct. V per part. (in k units)"

set term png
set output "plot-cv.png"

plot \
file i 0 u ($2):(($5-$4**2)/($2**2*$1**2)) t"L=15", \
file i 1 u ($2):(($5-$4**2)/($2**2*$1**2)) t"L=30", \
file i 2 u ($2):(($5-$4**2)/($2**2*$1**2)) t"L=45", \
file i 3 u ($2):(($5-$4**2)/($2**2*$1**2)) t"L=60"

set term wxt
replot
pause -1 "Press ENTER"
