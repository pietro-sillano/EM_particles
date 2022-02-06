EMFIELDS_OBJ = borismod.o  ode_solvers.o

CXX = g++
CFLAGS = -c
SRC = $(HOME)/Scrivania/ALGORITMI/lib
VPATH = ./ :$(SRC)
INCLUDE_DIRS = -I. -I$(SRC)
LDFLAGS = -lm

case3:	$(EMFIELDS_OBJ)
	$(CXX) $(EMFIELDS_OBJ) $(LDFLAGS) -o $@
	

		
all:    $(EMFIELDS_OBJ)
	$(CXX) $(EMFIELDS_OBJ) $(LDFLAGS) -o $@
	@./all
	@gnuplot field.gp
	
plot: 
	@./all
	@gnuplot field.gp


	
%.o:	%.cpp
	$(CXX) $(CFLAGS) $(INCLUDE_DIRS) $<
	
clean:
	@rm -f *.o
	@rm -f *.dat
	@echo make clean: done
