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
# 1) velocitá tempo
# 2) plot posizione in 2d x,y
# 3) plot posizione in 3d x,y,z
# 4) spazio fasi
# 5) Energia tempo


#FILE

file="emfields.dat"
SESSION = 5


if (SESSION==1){
set output 'vdrift.png'
set xlabel "Tempo"
set ylabel "Velocitá"
# set xrange [-3:3]
set yrange [-1.5:3]
set ytics 1
set xtics 10

plot file using 1:5  with lines title 'Vx' , \
file using 1:6  with lines title 'Vy' , \
file using 1:7  with lines title 'Vz'
}


if (SESSION==2){
set output 'posizionedrift.png'
set key off
set xrange [0:70]
set yrange [-2:5]

set xtics 10
set ytics 1

set xlabel "x "
set ylabel "y "
plot file using 2:3 with lines lc rgb "blue"
}


if (SESSION==3){
set output '3dposizionedrift.png'
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
}


if (SESSION==4){
set output 'spaziofasidrift.png'
# set key off
# set xrange [0:70]
# set yrange [-2:5]

set xtics 10
set ytics 1
set size ratio 0.3
set xlabel "x "
set ylabel "y "
plot file using 2:5 with lines lc rgb "blue",\
file using 3:6 with lines lc rgb "red"
}


if (SESSION==5){
set output 'energia.png'
# set key off
set xrange [0:40]
set yrange [0:3]
set grid
set xtics 10
set ytics 2
set size ratio 0.4
set xlabel "t"
set ylabel "E"
plot file using 1:8 with lines lc rgb "blue" title "Energy"
}
