reset
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
# 1) Kinetic Energy Error
# 2) Trajectories
# 3) Velocity over time
# 4) Position in 3d


file="../data/gyration_particle.dat"


set output '../plot/erroreE.png'
set xlabel "Tempo"
set ylabel "Fluttuazione Relativa Energia"
set yrange [1e-17:100]
set key center right
set xtics 200

# set logscale x
set logscale y
set ytics 10000
plot file using 1:8 index 0 with lines lc rgb "red" title 'RK2',\
file using 1:8 index 1 with lines lc rgb "green" title 'RK4',\
file using 1:8 index 2 with lines lc rgb "blue" title 'Boris Pusher'


reset
set output '../plot/confronto_traiettorie.png'
set xlabel "x "
set ylabel "y "
set xrange [-5:5]
set yrange [-5:5]
set ytics 1


set size ratio -1
plot file using 2:3 index 0 with lines lc rgb "red" title 'RK2',\
file using 2:3 index 1 with lines lc rgb "green" title 'RK4',\
 file using 2:3 index 2 with lines lc rgb "blue" title 'Boris Pusher'



reset
set output '../plot/tempovelocitá.png'
# set key off
set xlabel "t"
set ylabel "v"
set xrange [0:30]
set yrange [-2:2.1]
set ytics 0.5
plot file using 1:5 index 2 with lines lc rgb "blue" title 'V_x',\
file using 1:6 index 2 with lines lc rgb "green" title 'V_y',\
file using 1:7 index 2 with lines lc rgb "red" title 'V_z'




reset
set output '../plot/3dposizione.png'
set key off
set xlabel "x "
set ylabel "y "
set zlabel "z"
set view 60,20,1.2
set ticslevel 0
set xtics 0.5
set ytics 0.5
set ztics 0.5
set zrange [0:1]

splot file using 2:3:4 index 2 with lines lc rgb "blue" 

