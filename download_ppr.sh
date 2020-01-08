#!/bin/bash

# Script to download 'Plans de Prévention de Risques (PPR)' data for all French departments from Géorisques.
# Data available at: https://www.georisques.gouv.fr/dossiers/telechargement
# The script downloads and unzips data for all departments into a given folder.
# The follow-up script convert_ppr_to_gpkg.sh gets all the data files and stores them into a GPKG database.

directory="/tmp/donnees"
mkdir $directory
cd $directory

download_and_unzip_ppr(){
   dept=$1
   echo "Downloading $dept..."
   wget http://files.georisques.fr/ppr/pprx_$dept.zip
   unzip -o pprx_$dept.zip
}

for i in $(seq -f "%02g" 1 99)
do
  download_and_unzip_ppr $i
done

for i in {971..976}
do
  download_and_unzip_ppr $i
done

download_and_unzip_ppr "2A"
download_and_unzip_ppr "2B"

