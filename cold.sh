line=$1
outputDir=$2
echo $line | waybackurls | anew $outputDir/urls.txt;
echo https://$line | gau --threads 5 | anew $outputDir/urls.txt
echo http://$line | gau --threads 5 | anew $outputDir/urls.txt
echo https://$line | katana -d 5 silent | anew $outputDir/urls.txt
echo http://$line | katana -d 5 silent | anew $outputDir/urls.txt
echo https://$line | hakrawler | anew $outputDir/urls.txt
echo http://$line | hakrawler | anew $outputDir/urls.txt
cat $outputDir/urls.txt| sed '$!N; /^\(.*\)\n\1$/!P; D'| grep -P '\.php|\.asp|\.js|\.jsp' | anew $outputDir/endpoints.txt
cat $outputDir/urls.txt| grep -Po '(?:\?|\&)(?<key>[\w]+)(?:\=|\&?)(?<value>[\w+,.-]*)' | tr -d '?' | tr -d '&' | sort -u | uniq | anew $outputDir/parameters.txt