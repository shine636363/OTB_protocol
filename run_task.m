
system('git rm -rf  ./tmp');
system('git pull');
cd ../SemanticTracking
system('git pull');
cd ../OTB_protocol

system('git add  run_task.m');
system('git commit -m "code update"');
system('git push');

pmain_running


system('git pull');
system('git add  ./results');
system('git commit -m "resutlts-9th"');
system('git push');

