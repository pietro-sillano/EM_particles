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


set term qt 
set print "-"


data='../data/xpoint.dat'

#SESSION
# 1) 3D positions animation
# 2) Energy animation


set terminal gif animate delay 10
set output '../plot/3dposition.gif'
set xrange [-2000:2000]
set yrange [-2000:2000]
set zrange [0:100]
do for [i=0:99] {
  print(i)
  set title sprintf('Iter: %d', i)
  splot data using 3:4:5 index i*5 pt 7 ps 0.3 lc rgb "blue" 
  }




reset
set terminal gif animate delay 10
set output '../plot/energy.gif'
set key off
set xrange [-1100:1100]
set yrange [0:70]
set xlabel "x"
set ylabel "E"
set cbrange [0:50]
do for [i=0:99] {
  print(i)
  set title sprintf('Iter: %d', i)
  plot data using 3:5:9 index i with points palette pt 7 ps 0.3
  }

