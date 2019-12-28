defaultfile = "MC-L-030-TEMP-1500-4500-0010.res"
#defaultfile = MC-L-060-TEMP-1500-4100-0010-UNION.res
defaultdT = 0.1/0.2
if (!exists("file")){file = defaultfile}
if (!exists("dT")){dT = defaultdT}
if (!exists("outputname")){outputname = file}

set xzeroaxis
set xrange[*:*]
set yrange[*:*]
set xlabel "Reduced temperature T"
set xtics 0.5
set mxtics 5

# derivative functions.  Return 1/0 for first point, otherwise delta y or (delta y)/(delta x)
#d(y) = ($0 == 0) ? (y1 = y, 1/0) : (y2 = y1, y1 = y, y1-y2)
#d(y) = ($0 == 0) ? (x1 = x, y1 = y, 1/0) : (dx=$2-x1, x1=$2, $2-dx/2)
displ(x) = ($0 == 0) ? (x0=x,1/0) : (dx=x-x0,x0=x,x-dx/2)
der(x,y) = ($0 == 0) ? (x1=x,y1=y,1/0) : (x2=x1,x1=x,y2=y1,y1=y,(y1-y2)/(x1-x2))

############################################################################
set ylabel "Energy/N"

set terminal pngcairo enhanced font 'verdana,12'
set output outputname."_e.png"
set key top left
set ytics 0.2
set mytics 4

plot \
file u ($2):(($4)/$1**2):(sqrt($6/40000)/$1**2) w yerrorbars t "<e>"

set term wxt
replot
pause -1 "Press ENTER"

############################################################################
set ylabel "Magnetization/N"
    
set terminal pngcairo enhanced font 'verdana,12'
set output outputname."_m.png"
set key top right
set ytics 0.1
set mytics 5

plot \
file u ($2):($8/$1**2):(sqrt($10/40000)/$1**2) w yerrorbars lt 1 lc 1 t"<|m|>", \
file u ($2):($9**(1./2.)/$1**2):(sqrt($10/40000)/$1**2) w yerrorbars lt 1 lc 2 t"sqrt(<m²>)"

set term wxt
replot
pause -1 "Press ENTER"
    
############################################################################
set ylabel "Heat capacity at ct. V"

set terminal pngcairo enhanced font 'verdana,12'
set output outputname."_cv.png"
set ytics 200
unset mytics

plot \
file u ($2):(($5-$4**2)/$2**2) t""

set term wxt
replot
pause -1 "Press ENTER"

############################################################################
set ylabel "Heat capacity at ct. V per particle"

set terminal pngcairo enhanced font 'verdana,12'
set output outputname."_cvn.png"
set ytics 0.2
set mytics 4

plot \
file u ($2):(($5-$4**2)/($2**2*$1**2)) t"c_V", \
file u (displ($2)):(der($2,$4/$1**2)) w l lt 1 lc 3 t"d<e>/dT"
#file u (dx=$2-x0,x0=$2,$2-dx/2):(dy=($4/$1**2)-y0,y0=($4/$1**2),dy/dx) w l lt 1 lc 3 t"d<e>/dT"



set term wxt
replot
pause -1 "Press ENTER"

############################################################################
set ylabel "Susceptibility"

set terminal pngcairo enhanced font 'verdana,12'
set output outputname."_x.png"
set ytics 2000
unset mytics

plot \
file u ($2):(($9-$8**2)/$2) t""

set term wxt
replot
pause -1 "Press ENTER"

############################################################################
set ylabel "Susceptibility per particle"

set terminal pngcairo enhanced font 'verdana,12'
set output outputname."_xn.png"
set ytics 2
set mytics 4

plot \
file u ($2):(($9-$8**2)/($2*$1**2)) t""

set term wxt
replot
pause -1 "Press ENTER"
