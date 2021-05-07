# This is a makefile for GNU make.

# 1. Executable file

execut = test_netcdf95

# 2. Compiler-dependent part

FC = gfortran
FFLAGS = -I/usr/include -I..
LDLIBS = -L.. -lnetcdf95 -lnetcdff

# 3. Rules

%: %.f90
	$(LINK.f) $^ $(LOADLIBES) $(LDLIBS) -o $@

.PHONY: all clean
all: ${execut}

clean:
	-rm ${execut}
