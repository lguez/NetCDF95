/* Extracted from file fortran/nf_lib.c in the library netCDF-Fortran
   v4.5.4. Renamed function nc_inq_numgrps to inq_numgrps. */

#include <stddef.h>     /* for NULL */
#include "netcdf.h"

/**
 * Get the number of groups.
 *
 * @param ncid The ncid of the open file.
 * @param numgrps Pointer that gets the number of groups. Ignored if
 * NULL.
 *
 * @return ::NC_NOERR No error.
 * @return ::NC_ENOMEM Out of memory.
 * @author Richard Weed
 */
extern int
inq_numgrps(int ncid, int *numgrps)
{
    return nc_inq_grps(ncid, numgrps, NULL);
}
