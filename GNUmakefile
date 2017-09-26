# This is a makefile for GNU make.
# This makefile builds the library NetCDF95.

# 1. Source files

makefile_dir = .
VPATH = ${makefile_dir}/Sources
sources := $(shell cat ${makefile_dir}/file_list)

# 2. Objects and libraries

objects := $(sources:.f=.o)
lib_dyn = libnetcdf95.so
lib_stat = libnetcdf95.a

# 3. Compiler-dependent part

mode = debug
include ${general_compiler_options_dir}/${FC}_${mode}.mk

# 4. Rules

SHELL = bash
.DELETE_ON_ERROR:
.PHONY: all clean clobber depend
all: ${lib_stat} log
##${lib_dyn}

${lib_dyn}: ${objects}
	$(FC) $(LDFLAGS) $(ldflags_lib_dyn) $^ -o $@

${lib_stat}: ${lib_stat}(${objects})

depend ${makefile_dir}/depend.mk:
	makedepf90 -free -Wmissing -Wconfused -I${VPATH} -nosrc $(addprefix -u , netcdf typesizes) ${sources} >${makefile_dir}/depend.mk

TAGS: ${sources}
	ctags -e --language-force=fortran $^

clean:
	rm -f ${lib_dyn} ${lib_stat} ${objects} log

clobber: clean
	rm -f *.mod ${makefile_dir}/depend.mk TAGS

log:
	hostname >$@
	${FC} ${version_flag} >>$@ 2>&1
	echo -e "\nFC = ${FC}\n\nFFLAGS = ${FFLAGS}\n\nLDFLAGS = ${LDFLAGS}" >>$@

ifneq ($(MAKECMDGOALS), clobber)
include ${makefile_dir}/depend.mk
endif
