#include <stdlib.h>
#include <string.h>

#include <netcdf.h>

int nc_get_att_1_string(int ncid, int varid, const char *name, char *values,
			size_t *att_len, size_t size_values)
{
  int stat;
  size_t n_strings; /* number of strings in the attribute */
  stat = nc_inq_attlen(ncid, varid, name, &n_strings);

  if (stat == NC_NOERR)
    {
      char **string_attr = (char**)malloc(n_strings * sizeof(char*));

      if (string_attr != NULL)
	{
	  memset(string_attr, 0, n_strings * sizeof(char*));
	  stat = nc_get_att_string(ncid, varid, name, string_attr);

	  if (stat == NC_NOERR)
	    {
	      if (size_values > strlen(string_attr[0]))
		{
		  *att_len = strlcpy(values, string_attr[0], size_values);
		  stat = nc_free_string(n_strings, string_attr);
		}
	      else
		{
		  stat = NC_ESTS;
		  nc_free_string(n_strings, string_attr);
		}
	    }
	  else
	    {
	      nc_free_string(n_strings, string_attr);
	    }

	  free(string_attr);
	}
      else
	{
	  stat = NC_ENOMEM;
	}
    }

  return(stat);
}
