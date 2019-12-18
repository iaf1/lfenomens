defaultfile = "MC-L-030-TEMP-1500-4500-0010.res"
defaultdT = 0.1/0.2
if (!exists("file")){file = defaultfile}
if (!exists("dT")){dT = defaultdT}

set xzeroaxis
set xrange[*:*]
set yrange[*:*]
set xlabel "Reduced temperature T"

# derivative functions.  Return 1/0 for first point, otherwise delta y or (delta y)/(delta x)
#d(y) = ($0 == 0) ? (y1 = y, 1/0) : (y2 = y1, y1 = y, y1-y2)
#d(y) = ($0 == 0) ? (x1 = x, y1 = y, 1/0) : (dx=$2-x1, x1=$2, $2-dx/2)

############################################################################
set ylabel "Energy per particle"

set term png
set output file."_e.png"

plot \
file u ($2):(($4)/$1**2) t""

set term wxt
replot
pause -1 "Press ENTER"

############################################################################
set ylabel "Magnetization per particle"

set term png
set output file."_m.png" 

plot \
file u ($2):($8/$1**2) t"<|m|>", \
file u ($2):($9**(1./2.)/$1**2) t"sqrt(<m²>)"

set term wxt
replot
pause -1 "Press ENTER"
    
############################################################################
set ylabel "Heat capacity at ct. V (in k units)"

set term png
set output file."_cv.png"

plot \
file u ($2):(($5-$4**2)/$2**2) t""

set term wxt
replot
pause -1 "Press ENTER"

############################################################################
set ylabel "Heat capacity at ct. V per part. (in k units)"

set term png
set output file."_cvn.png"

x0 = NaN
y0 = NaN
#dx = NaN
#dy = NaN

plot \
file u ($2):(($5-$4**2)/($2**2*$1**2)) t"c_V", \
file u (dx=$2-x0,x0=$2,$2-dx/2):(dy=($4/$1**2)-y0,y0=($4/$1**2),dy/dx) w l lt 1 lc 3 t"d<e>/dT"


set term wxt
replot
pause -1 "Press ENTER"

############################################################################
set ylabel "Susceptibility"

set term png
set output file."_x.png"

plot \
file u ($2):(($9-$8**2)/$2) t""

set term wxt
replot
pause -1 "Press ENTER"

############################################################################
set ylabel "Susceptibility per particle"

set term png
set output file."_xn.png"

plot \
file u ($2):(($9-$8**2)/($2*$1**2)) t""

set term wxt
replot
pause -1 "Press ENTER"
