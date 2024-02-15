ifeq ($(out), y)
	FLAGS += -D_OUTPUT=1
endif
 
ifeq ($(OMP_CANCELLATION), false)
	OMP_EN="OMP not enabled"
endif

ifeq ($(parflags), y)
	FLAGS += -fopenmp -D_USE_OMP=1
endif
 
serial:
	gcc -c -g utils.c -lm
	gcc -c -g heat2D.c $(FLAGS) -lm
	gcc -g -o heat2D utils.o heat2D.o $(FLAGS) -lm
 
parallel:
	echo $(OMP_EN)
	gcc -c -g utils.c $(FLAGS) -lm
	gcc -c -g heat2D-parallel.c $(FLAGS) -lm
	gcc -g -o heat2D-parallel utils.o heat2D-parallel.o $(FLAGS) -lm

clear:
	rm ./heat-dat-files/Heat*.dat;\