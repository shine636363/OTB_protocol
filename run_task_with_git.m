system('git pull');
cd ../SemanticTracking
system('git pull');
cd ../OTB_protocol

system('git add  run_task.m');
system('git commit -m "code update"');
system('git push');

main_running


system('git pull');
system('git add  ./results');
system('git commit -m "resutlts-10th"');
system('git push');

