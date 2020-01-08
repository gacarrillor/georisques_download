#!/bin/bash

# Script to merge 'Plans de Prévention de Risques (PPR)' data for all French departments from Géorisques into a single
# GeoPackage database file.
# Data available at: https://www.georisques.gouv.fr/dossiers/telechargement
# You should set:
#  + The folder where the uncompressed data is located (edit line 10).
#  + The path to the new GPKG file (edit line 13).

directory="/tmp/donnees"
cd $directory

gpkg="/tmp/donnees.gpkg"
b_gpkg_exists=false

for shp_path in $(find -type f -name '*.shp')  # recursive search
do
  shp=$(basename "$shp_path")
  len=${#shp}
  name=${shp:0:len-8}  # Remove suffix and extension
  echo $name
  if $b_gpkg_exists ; then
     echo "...Appending $shp..."
     ogr2ogr -f GPKG -update -append $gpkg $shp_path -nln $name
  else
     echo "Creating $shp..."
     ogr2ogr -f GPKG $gpkg $shp_path -nln $name
     b_gpkg_exists=true
  fi
done
