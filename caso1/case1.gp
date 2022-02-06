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


#===========SESSION=================
# 1) Errore energia cinetica totale
# 2) confronto traiettorie
# 3) tempo velocitá
# 4) posizione3d


file="emfields.dat"
SESSION = 3

if (SESSION == 1){
set output 'erroreE.png'
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
}

if (SESSION==2){
set output 'confronto_traiettorie.png'
set xlabel "x "
set ylabel "y "
set xrange [-5:5]
set yrange [-5:5]
set ytics 1


set size ratio -1
plot file using 2:3 index 0 with lines lc rgb "red" title 'RK2',\
file using 2:3 index 1 with lines lc rgb "green" title 'RK4',\
 file using 2:3 index 2 with lines lc rgb "blue" title 'Boris Pusher'

}

if (SESSION==3){
set output 'tempovelocitá.png'
# set key off
set xlabel "t"
set ylabel "v"
set xrange [0:30]
set yrange [-2:2.1]
set ytics 0.5
plot file using 1:5 index 2 with lines lc rgb "blue" title 'V_x',\
file using 1:6 index 2 with lines lc rgb "green" title 'V_y',\
file using 1:7 index 2 with lines lc rgb "red" title 'V_z'

}


if (SESSION==4){
set output '3dposizione.png'
set key off
set xlabel "x "
set ylabel "y "
set zlabel "z"
set view 60,20,1.2
set ticslevel 0
set xtics 0.5
set ytics 0.5
set ztics 0.5



# set xrange [-2:2]
# set yrange [-2:2]
# set zrange [0:2]

splot file using 2:3:4 index 2 with lines lc rgb "blue" 
}
# pause -1
