# This is a makefile for GNU make.
# This makefile builds the library NetCDF95.

# 1. Source files

makefile_dir = .
VPATH = ${makefile_dir}
sources := $(shell cat ${VPATH}/file_list)

# 2. Objects and libraries

objects := $(sources:.f=.o)
lib_dyn = libnetcdf95.so
lib_stat = libnetcdf95.a

# 3. Compiler-dependent part

include ${general_compiler_options_dir}/settings.mk

# 4. Rules

all: ${lib_stat} log
##${lib_dyn}

${lib_dyn}: ${objects}
	$(FC) $(LDFLAGS) ${ldflags_lib_dyn} $^ -o $@

${lib_stat}: ${lib_stat}(${objects})

depend ${VPATH}/depend.mk:
	makedepf90 -free -Wmissing -Wconfused -I${VPATH} -nosrc $(addprefix -u , netcdf typesizes) ${sources} >${VPATH}/depend.mk

clean:
	rm -f ${lib_dyn} ${lib_stat} ${objects} log

ifneq ($(MAKECMDGOALS), clobber)
include ${VPATH}/depend.mk
endif
