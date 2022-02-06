mkdir -p ../plot/img

echo "Plotting gyration_particle.gp"
gnuplot gyration_particle.gp

echo "Plotting ExBdrift.gp"
gnuplot ExBdrift.gp

echo "Plotting convergence.gp"
gnuplot convergence.gp

echo "Plotting xpoint.gp"
gnuplot xpoint.gp

echo "Plotting gif_maker.gp"
gnuplot gif_maker.gp

