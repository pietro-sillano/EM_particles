EMFIELDS_OBJ = convergence.o  ode_solvers.o

CXX = g++
CFLAGS = -c
SRC = $(HOME)/Scrivania/ALGORITMI/lib
VPATH = ./ :$(SRC)
INCLUDE_DIRS = -I. -I$(SRC)
LDFLAGS = -lm



convergence:	$(EMFIELDS_OBJ)
		$(CXX) $(EMFIELDS_OBJ) $(LDFLAGS) -o $@
	
all:    $(EMFIELDS_OBJ)
	$(CXX) $(EMFIELDS_OBJ) $(LDFLAGS) -o $@
	@./all
	@gnuplot case1.gp

plot: 
	@./all
	@gnuplot case1.gp
	
%.o:	%.cpp
	$(CXX) $(CFLAGS) $(INCLUDE_DIRS) $<
	
clean:
	@rm -f *.o
	@rm -f *.dat
	@echo make clean: done
