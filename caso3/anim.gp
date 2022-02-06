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


data='data.dat'
session = 2

#SESSION
# 1) Animazione gif delle posizioni iniziali in 2D praticamente inutile
# 2) Animazione gif in 3D
# 3) animazione laterale 2D fighissimo
# 4) animazione con energia posizione e energia cinetica (non cambia molto)


if (session==1){
set terminal gif animate delay 10
set output 'posizioni_iniziali.gif'

set xrange [-1100:1100]
set yrange [-1100:1100]

do for [i=0:99] {
  print(i)
  set title sprintf('Iter: %d', i)
  plot data using 3:4 index i
  }
}




if (session==2){
#consiglio usare almeno 50 come t con passi da 0.1

set terminal gif animate delay 10
set output '3dposition.gif'

set xrange [-2000:2000]
set yrange [-2000:2000]
set zrange [0:100]


do for [i=0:99] {
  print(i)
  set title sprintf('Iter: %d', i)
#   splot data using 3:4:5 index i*2  with dots
  splot data using 3:4:5 index i*5 pt 7 ps 0.3 lc rgb "blue" 


  }
}


if (session==3){
#consiglio usare almeno 50 come t con passi da 0.1

set terminal gif animate delay 10
set output 'lateral.gif'

set xrange [-1100:1100]
set yrange [0:50]


do for [i=0:99] {
  print(i)
  set title sprintf('Iter: %d', i)
  plot data using 3:5 index i pt 7 ps 0.3 lc rgb "blue" 

  }
}


if (session==4){

set terminal gif animate delay 10
set output 'boris.gif'

set xrange [-1100:1100]
set yrange [-1100:1100]
set zrange [0:30]

do for [i=0:99] {
  print(i)
  set title sprintf('Iter: %d', i)
  splot data using 3:4:9 index i pt 7 ps 0.3 lc rgb "blue" 
  }
}
