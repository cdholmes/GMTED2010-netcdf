#!/bin/bash

# Parse command options
show_usage () {
  echo "Usage: $0 -O -g '<regions>' -r '<resolutions>' -v '<variables>'"
  echo "  <regions> values may be: all NorthAmerica SouthAmerica Europe Africa Asia Australia Antarctica."
  echo "              Use quotes if two or more regions are specified"
  echo "  <variables> values may be: all mean maximum minimum median stdev breakline subsample."
  echo "              Use quotes if two or more variables are specified"
  echo "  <resolutions> values may be: all, 30arcsec 15arcsec 7p5arcsec. Use quotes if two or more resolutions are specified"
  echo "  -O overwrites output files, if any exist"
  echo "  -h show help message"
  echo "  Subdivides GMTED2010 data into geographic regions."
}
overwrite=false
OPTSTRING=":hOg:r:v:"
while getopts ${OPTSTRING} opt; do
  case ${opt} in
    g) region_list=${OPTARG};;
    r) resolution_list=${OPTARG};;
    v) variable_list=${OPTARG};;
    O) overwrite=true;;
    h)
      show_usage
      exit 1
      ;;
    :)
      echo "Option -${OPTARG} requires an argument."
      show_usage
      exit 1
      ;;
    ?)
      echo "Invalid option: -${OPTARG}."
      show_usage
      exit 1
      ;;
  esac
done
if [ $OPTIND -eq 1 ]; then 
  echo "Missing required arguments"
  show_usage
  exit 1 
fi

# Default argument values
if [ -z "${region_list}" ] || [ "${region_list}" == "all" ]; then
  region_list="NorthAmerica SouthAmerica Europe Africa Asia Australia Antarctica"
  # region_list="NorthAmerica"
fi
if [ -z "${resolution_list}" ] || [ "${resolution_list}" == "all"  ]; then
  resolution_list="30arcsec 15arcsec 7p5arcsec"
  # resolution="30arcsec"
fi
if [ -z "${variable_list}" ] || [ "${variable_list}" == "all" ]; then
  variable_list="mean maximum minimum median stdev breakline subsample"
  # variable="mean"
fi

# Loop over resolutions and regions
for resolution in ${resolution_list}; do
for region in ${region_list}; do

    # Set latitude, longitude range for each region
    case ${region} in 
    NorthAmerica)
        latrange='13.,-21.'
        lonrange='-169.,-70.'
        ;;
    SouthAmerica)
        latrange='-57.,13.'
        lonrange='-82.,-34.'
        ;;        
    Europe)
        latrange='34.,72.'
        lonrange='-12.,50.'
        ;;        
    Africa)
        latrange='-35.,38.'
        lonrange='-18.,52.'
        ;;        
    Asia)
        latrange='5.,78.'
        lonrange='32.,-169.'
        ;;        
    Australia)
        latrange='-44.,8.'
        lonrange='94.,159.'
        ;;   
    Antarctica)
        # GMTED2010 doesn't have finer resolution over Antarctica
        if [[ "${resolution}" != "30arcsec" ]]; then continue; fi
        latrange='-90.,-60.'
        lonrange='-180.,180.'
        ;;   
    *)
        echo "Region not defined ${region}"
        continue
        ;;
    esac

    # echo ${region} ${lonrange} ${latrange}

    # Create directory for regional files
    region_dir="../netcdf/GMTED2010_${region}_${resolution}"
    mkdir -p ${region_dir}


    for variable in ${variable_list}; do
        echo "${region} ${resolution} ${variable}"

        # Set input and output filenames
        infile="../netcdf/GMTED2010_${variable}_${resolution}.nc4"
        outfile="${region_dir}/GMTED2010_${region}_${variable}_${resolution}.nc4"

        # Error if input file doesn't exist
        if [ ! -f ${infile} ]; then
            echo "Input file does not exist. Skipping. ${infile}"
            continue
        fi

        # Write the file if it doesn't already exist, or if user specified to overwrite
        if [ "${overwrite}" = true ] || [ ! -f ${outfile} ]; then
            ncks -O -d lat,${latrange} -d lon,${lonrange} ${infile} ${outfile}
        else
            echo "Output file exists. Use -O to overwrite. Skpping. ${outfile}"
        fi
    done

done
done
