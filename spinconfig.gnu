defaultL = 60
defaultsymbsize = 1
if (!exists("L")){L = defaultL}
if (!exists("symbsize")){symbsize = defaultsymbsize}
if (!exists("ind")){ind = 0}
#if (!exists("filename")){
#filename="*.conf"
#print "Looping over .conf files"}
#list = system("dir ".filename)
#do for [file in list]{
set term wxt
set size square
set xrange [0.5:L+0.5]
set yrange [0.5:L+0.5]
plot file index ind using 1:2 w p lt 5 lc 7 ps symbsize t ""
pause -1 "FILE: ".file." - Press [ENTER] to continue"
set term png enhanced font 'verdana,14'
set size square
set output file.".png"
replot
#}
