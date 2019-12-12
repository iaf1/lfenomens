defaultfile = "MC-L-030-TEMP-1500-4500-0010.res"
if (!exists("file")){file = defaultfile}

set xzeroaxis
set xrange[*:*]
set yrange[*:*]
set xlabel "Reduced temperature T"

############################################################################
set ylabel "Energy per particle"

set term png
set output file."_e.png"

plot \
file u ($2):(($4)/$2**2) t""

set term wxt
replot
pause -1 "Press ENTER"

############################################################################
set ylabel "Magnetization per particle"

set term png
set output file."_m.png" 

plot \
file u ($2):($8) t"<|m|>", \
file u ($2):($9**(1./2.)) t"sqrt(<m²>)"

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

plot \
file u ($2):(($5-$4**2)/($2**2*$1**2)) t""

set term wxt
replot
pause -1 "Press ENTER"

############################################################################
set ylabel "Susceptibility"

set term png
set output file."_x.png"

plot \
file u ($2):(($9-$8**2)/$2**2) t""

set term wxt
replot
pause -1 "Press ENTER"

############################################################################
set ylabel "Susceptibility per particle"

set term png
set output file."_xn.png"

plot \
file u ($2):(($9-$8**2)/$2**2*$1**2) t""

set term wxt
replot
pause -1 "Press ENTER"
