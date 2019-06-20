# This is a makefile for GNU make.
# This makefile builds the library NetCDF95.

# 1. Source files

sources := $(shell cat file_list)

# 2. Objects and library

objects := $(sources:.f=.o)
lib = libnetcdf95.a

# 3. Compiler-dependent part

include Compiler_options/${FC}.mk

# 4. Rules

.PHONY: all clean depend
all: ${lib}
${lib}: ${lib}(${objects})

depend depend.mk:
	makedepf90 -free -Wmissing -Wconfused -nosrc $(addprefix -u , netcdf typesizes) ${sources} >depend.mk

clean:
	rm -f ${lib} ${objects}

include depend.mk
