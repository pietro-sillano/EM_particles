reset
set term qt 

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



#=====SESSION=========
# 1) in 2D
# 2) in 3D non si capisce un cazzo
# 3) solo le linee di campo

session = 3



data='field.dat'
if (session==1){
set output 'vector_field2d.png'
set xrange [-1000:1000]
set yrange [-1000:1000]
plot data using 1:2:4:5 with vectors 
pause -1
}

if (session==2){
set output 'vector_field3d.png'
set xrange [-1000:1000]
set yrange [-1000:1000]
splot data using 1:2:3:4:5:6 with vectors lc rgb 'blue'
pause -1
}

if (session==3){
set output 'field_line.png'
# set xrange [-1000:1000]
# set yrange [-1000:1000]

reset
set contour
unset surface
set view map
set contour base
set cntrparam level 30
set autoscale fix
set dgrid3d

# -- Plot --
splot data u 1:2:7 with lines lw 2 notitle
pause -1
}

