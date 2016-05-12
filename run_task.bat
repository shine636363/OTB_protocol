git pull
cd ../SemanticTracking
git pull
cd ../OTB_protocol

matlab -nodisplay -nosplash -nodesktop -r "main_running;exit;"
git rm -rf ./tmp

git add -A
git commit -m "resutlts-20160513"
git push

