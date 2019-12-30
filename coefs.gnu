critt = "tc.txt"
coefs = "coefs.txt"

load "fits.txt"
load "fits2.txt"

labelst = "T_c^{ener} T_c^{h.cap} T_c^{magn} T_c^{susc}"
labelsnu = "Energy H.cap. Magnet. Suscep."
colors = "1 2 3 4"

set encoding utf8

############################################################################1
set term pngcairo enhanced font 'verdana,14'
set output "coefs-tc.png"

set xzeroaxis
set xrange[0:0.07]
set yrange[*:*]
set xtics 0.01
set ytics 0.02
set mxtics 5
set mytics 4
set xlabel "1/L"
set key top left
set ylabel "T_c"

#change to j=1:4 to include energy, then add fe
#fe(x) w l lc word(colors,1) t "", \

plot for[j=2:4] critt i j-1 u (1/$2):3 w p pt 1 lc word(colors,j) ps 1 t word(labelst,j), \
fc(x) w l lc word(colors,2) t "", \
fm(x) w l lc word(colors,3) t "", \
fx(x) w l lc word(colors,4) t ""

set term wxt
replot
pause -1 "Press ENTER"

############################################################################2
set term pngcairo enhanced font 'verdana,14'
set output "coefs-nu.png"

set xzeroaxis
set xrange[2.5:5]
set yrange[*:*]
set xtics 0.5
set ytics 0.5
set mxtics 5
set mytics 5
set xlabel "log L"
set key top right
set ylabel "log (T_{cL}-T_c)"

#change to j=1:4 to include energy, then add nue
#nue(x) w l lc 1 t "",\

plot for[j=2:4] coefs i j-1 u (log($1)):(log($2-tcm)) w p pt 1 lc word(colors,j) ps 1 t word(labelsnu,j), \
nuc(x) w l lc 2 t "",\
num(x) w l lc 3 t "",\
nukhi(x) w l lc 4 t ""

set term wxt
replot
pause -1 "Press ENTER"

############################################################################3
set term pngcairo enhanced font 'verdana,14'
set output "coefs-gammanu.png"

set xzeroaxis
set xrange[2.5:5]
set yrange[*:*]
set ytics 1
set mytics 5
set xlabel "log L"
set key top right
set ylabel "log χ"

plot coefs i 4 u 4:5 w p pt 1 lc 1 ps 1 t "",\
gammanu(x) w l lc 1 t ""
set term wxt
replot
pause -1 "Press ENTER"

############################################################################4
set term pngcairo enhanced font 'verdana,14'
set output "coefs-betanu.png"

set xzeroaxis
set xrange[2.5:5]
set yrange[*:*]
set ytics 0.1
set mytics 5
set xlabel "log L"
set key top right
set ylabel "log m"

plot coefs i 5 u 4:5 w p pt 1 lc 1 ps 1 t "",\
betanu(x) w l lc 1 t ""
set term wxt
replot
pause -1 "Press ENTER"

############################################################################5
set term pngcairo enhanced font 'verdana,14'
set output "coefs-alphanu.png"

set xzeroaxis
set xrange[2.5:5]
set yrange[*:*]
set ytics 0.1
set mytics 5
set xlabel "log L"
set key top right
set ylabel "log c_V"

plot coefs i 6 u 4:5 w p pt 1 lc 1 ps 1 t "",\
alphanu(x) w l lc 1 t ""

set term wxt
replot
pause -1 "Press ENTER"