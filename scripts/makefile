gyration_particle_OBJ = gyration_particle.o  ode_solvers.o
ExBdrift_OBJ = ExBdrift.o  ode_solvers.o
convergence_OBJ = convergence.o  ode_solvers.o
xpoint_OBJ = xpoint.o  ode_solvers.o


CXX = g++
CFLAGS = -c
SRC = ../src

VPATH = ./ :$(SRC)
INCLUDE_DIRS = -I. -I$(SRC)
LDFLAGS = -lm


gyration_particle:	$(gyration_particle_OBJ)
			$(CXX) $(gyration_particle_OBJ) $(LDFLAGS) -o $@
			
ExBdrift:		$(ExBdrift_OBJ)
			$(CXX) $(ExBdrift_OBJ) $(LDFLAGS) -o $@
			
convergence:		$(convergence_OBJ)
			$(CXX) $(convergence_OBJ) $(LDFLAGS) -o $@

xpoint:			$(xpoint_OBJ)
			$(CXX) $(xpoint_OBJ) $(LDFLAGS) -o $@

	
%.o:	%.cpp
	$(CXX) $(CFLAGS) $(INCLUDE_DIRS) $<
	
clean:
	@rm -f *.o
	@rm -f *.dat
	@echo make clean: done
