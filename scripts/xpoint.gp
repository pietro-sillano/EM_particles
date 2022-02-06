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


set print "-"


data='../data/xpoint.dat'



#SESSION
# 1) grafico per Latex: posizioni3d dopo tot evoluzioni
# 2) grafico per energia delle particelle




reset
set terminal pngcairo size wpx,hpx fontscale ptscale linewidth ptscale pointscale ptscale
set key off
set view 70,20,1.3
set ticslevel 0
set xrange [-1100:1100]
set yrange [-1100:1100]
set zrange [0:60]
set xtics 10000
set ytics 10000
set ztics 20
unset tics
unset border
do for [i=0:200:20] {
  set output '../plot/img/distrib_'.i.'.png'
  splot data using 3:4:9 index i pt 7 ps 0.1 lc rgb "blue"
  }




reset
set terminal pngcairo size wpx,hpx fontscale ptscale linewidth ptscale pointscale ptscale
set key off
set xrange [-1100:1100]
set yrange [0:70]
set xlabel "x"
set ylabel "E"
set cbrange [0:50]
do for [i=0:200:20] {
  set output '../plot/img/energy_'.i.'.png'
  plot data using 3:5:9 index i with points palette pt 7 ps 0.3
  }

