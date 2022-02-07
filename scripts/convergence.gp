reset
#  set term pngcairo size 2048,1536
dpi = 300 ## dpi (variable)
width = 160 ## mm (variable)
height = 120 ## mm (variable)

in2mm = 25.4 # mm (fixed)
pt2mm = 0.3528 # mm (fixed)
mm2px = dpi/in2mm
ptscale = pt2mm*mm2px
round(x) = x - floor(x) < 0.5 ? floor(x) : ceil(x)
wpx = round(width * mm2px)
hpx = round(height * mm2px)

set terminal pngcairo size wpx,hpx fontscale ptscale linewidth ptscale pointscale ptscale

#===========SESSION=================
# 1) Convergenza

file="../data/convergence.dat"

set output '../plot/convergence.png'
set xlabel "dt"
set ylabel "Errore"
# set yrange [1e-17:100]
set key bottom right
set grid

set logscale x
set logscale y
set xtics 10
set ytics 10000


 
plot file using 1:2 index 0 with lp lc rgb "red" title 'RK2',\
file using 1:2 index 1 with lp lc rgb "green" title 'RK4',\
file using 1:2 index 2 with lp lc rgb "blue" title 'Boris Pusher',\




