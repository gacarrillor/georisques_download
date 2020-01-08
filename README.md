# Géorisques data download and merge
Scripts to download and merge French data from Géorisques (https://www.georisques.gouv.fr)


Scripts:

1. a. [download_ppr.sh](https://github.com/gacarrillor/georisques_download/blob/master/download_ppr.sh)

    Script to download 'Plans de Prévention de Risques (PPR)' data for all French departments from Géorisques.
    Data available at: https://www.georisques.gouv.fr/dossiers/telechargement
    The script downloads and uncompresses data for all departments into a given folder.

    NOTE: The follow-up script [convert_ppr_to_gpkg.sh](https://github.com/gacarrillor/georisques_download/blob/master/convert_ppr_to_gpkg.sh) gets all the data files and stores them into a GPKG database.

1. b. [convert_ppr_to_gpkg.sh](https://github.com/gacarrillor/georisques_download/blob/master/convert_ppr_to_gpkg.sh)

   Script to merge 'Plans de Prévention de Risques (PPR)' data for all French departments from Géorisques into a single
   GeoPackage database file.
   Data available at: https://www.georisques.gouv.fr/dossiers/telechargement
   For running the script you should set:
    + The folder where the uncompressed data is located (edit line 10).
    + The path to the new GPKG file (edit line 13).

2. [download_csvs.sh](https://github.com/gacarrillor/georisques_download/blob/master/download_csvs.sh)

   Script to download CSV data per department from the French website Géorisques (https://www.georisques.gouv.fr/dossiers/basias/donnees#/), merging all departments into a single CSV (merged.csv).

