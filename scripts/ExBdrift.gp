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
# set term qt 

#SESSION
# 1) plot posizione in 3d x,y,z
# 2) Energia tempo



file="../data/ExBdrift.dat"


reset
set output '../plot/ExBdrift_3d_position.png'
set key off
set xlabel "x "
set ylabel "y "
set zlabel "z"
set view 60,20,1      
set xtics 10
set ytics 1
set ztics 1
set ticslevel 0
set xrange [0:20]
set yrange [-1:2]
set zrange [0:2]
splot file using 2:3:4 with lines lc rgb "blue" 



reset
set output '../plot/ExBdrift_energy.png'
set xrange [0:40]
set yrange [0:3]
set grid
set xtics 10
set ytics 2
set size ratio 0.4
set xlabel "t"
set ylabel "E"
plot file using 1:8 with lines lc rgb "blue" title "Energy"

