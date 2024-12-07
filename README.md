# GMTED2010 global elevation data in NetCDF format

Global Multi-resolution Terrain Elevation Data (GMTED2010) are [available here](netcdf) in NetCDF4 format. USGS [distributes](https://topotools.cr.usgs.gov/gmted_viewer/gmted2010_global_grids.php) GMTED2010 in ESRI ArcGrid format. The NetCDF4 files here were converted from the source using a script in this repository. GMTED2010 replaces the older GTOPO30 elevation dataset.

See the [USGS GMTED2010 webpage](https://www.usgs.gov/coastal-changes-and-impacts/gmted2010) for a description of the dataset. 

# EGM96, EGM2008 geoid data in NetCDF format

Earth Gravitational Model (EGM) global geoid heights are [available here](netcdf) in NetCDF4 format. Versions EGM96 and EGM2008 are provided at several resolutions, including a grid that matches GMTED2010. Earth's surface elvation above the WGS84 ellipsoid is computed by adding GMTED2010 and EGM96 heights.

EGM source data are originally from [NGA](https://earth-info.nga.mil/#wgs84-data) and computed here from GeoTiff files provided by [Agisoft](https://www.agisoft.com/downloads/geoids/). 

# Data Access

See [netcdf](netcdf) folder or links to individual files below.

## GMTED2010

### 30 arc-second resolution
 - [mean](https://github.com/cdholmes/GMTED2010-netcdf/raw/main/netcdf/GMTED2010_mean_30arcsec.nc4?download=)
 - [maximum](https://github.com/cdholmes/GMTED2010-netcdf/raw/main/netcdf/GMTED2010_maximum_30arcsec.nc4?download=)
 - [minimum](https://github.com/cdholmes/GMTED2010-netcdf/raw/main/netcdf/GMTED2010_minimum_30arcsec.nc4?download=)
 - [median](https://github.com/cdholmes/GMTED2010-netcdf/raw/main/netcdf/GMTED2010_median_30arcsec.nc4?download=)
 - [standard deviation](https://github.com/cdholmes/GMTED2010-netcdf/raw/main/netcdf/GMTED2010_stdev_30arcsec.nc4?download=)
 - [breakline](https://github.com/cdholmes/GMTED2010-netcdf/raw/main/netcdf/GMTED2010_breakline_30arcsec.nc4?download=)
 - [systematic subsample](https://github.com/cdholmes/GMTED2010-netcdf/raw/main/netcdf/GMTED2010_subsample_30arcsec.nc4?download=)
 
### 15 arc-second resolution
 - [mean](https://github.com/cdholmes/GMTED2010-netcdf/raw/main/netcdf/GMTED2010_mean_15arcsec.nc4?download=)
 - Convert other variables with `gmted2nc -r 15 -v <varname>`

### 7.5 arc-second resolution
 - [mean](https://github.com/cdholmes/GMTED2010-netcdf/raw/main/netcdf/GMTED2010_mean_7p5arcsec.nc4?download=)
 - Convert other variables with `gmted2nc -r 75 -v <varname>`


## EGM Geoid

### EGM96
 - [15 arc-minutes](netcdf/EGM96_15arcmin.nc4)
 - [30 arc-seconds](netcdf/EGM96_30arcsec.nc4) (same grid as GMTED2010_mean_30arcsec.nc4 )
 - Other resolutions can be produced by `egm2nc`

### EGM2008
 - [2.5 arc-minutes](netcdf/EGM2008_2p5arcmin.nc4)
 - Other resolutions can be produced by `egm2nc`
