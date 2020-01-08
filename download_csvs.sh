#!/bin/bash

# Script to download CSV data per department from the French website Géorisques
# (https://www.georisques.gouv.fr/dossiers/basias/donnees#/), merging all departments into a single CSV (merged.csv).

directory="/tmp/csv"
mkdir $directory
cd $directory

download_and_unzip_ppr(){
   dept=$1
   echo "Downloading $dept..."

   # The folowing cURL command can be extracted using Firefox from the Géorisques download page:
   # 1. Go to the Géorisques download page (https://www.georisques.gouv.fr/dossiers/basias/donnees/resultats?dept=01#/)
   # 2. Press F12 on the download page, go to tab Network on the new panel.
   # 3. Click the download button from the page to actually download the file.
   # 4. Right click on the link in the Network panel and go to "Copy > Copy as cURL".
   # 5. Finally paste the whole command replacing line 17. Make sure you add "> $dept.csv" as suffix and that you
   #    replace the "?dept=01&" string by "?dept='$dept'&".
   curl 'https://www.georisques.gouv.fr/webappReport/ws/basias/sitesdetails/detailsites_2020-01-08.csv?dept='$dept'&commune=&activites=&isExport=true&start=0&size=0' -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:67.0) Gecko/20100101 Firefox/67.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Connection: keep-alive' -H 'Referer: https://www.georisques.gouv.fr/dossiers/basias/donnees/resultats?dept=01' -H 'Cookie: _pk_id.82.7893=960ffca97cf6bfbb.1577695519.4.1578473943.1578473440.; TS019a54ed=01ce77d600023982ec591e83dcb69594b415043788c98a8bdaa410011564c8cdc65c60c2f8cb4388b2b882038b194c0e5b438a79be; has_js=1; _pk_ses.82.7893=1' -H 'Upgrade-Insecure-Requests: 1' -H 'Pragma: no-cache' -H 'Cache-Control: no-cache'  > $dept.csv
   if [ "$dept" != "01" ]; then
     echo "Removing header in $dept ..."
     printf "%s\n\n" "$(tail -n +2 $dept.csv)" > $dept.csv
  fi
}

for i in $(seq -f "%02g" 1 99)
do
  download_and_unzip_ppr $i
done
cat * > merged.csv
echo "Done!"
