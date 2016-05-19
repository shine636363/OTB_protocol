function rename_tracker()
clear;clc;

old_path = './rename_baseline/';
new_path = 'rename_baseline';
Org_name  = 'NetC';
New_name  = 'Baseline';
seqs      = configSeqs;

for ids = 1:length(seqs)
    s = seqs{ids};
    load([old_path, s.name '_' Org_name '.mat'])
    save([new_path, s.name '_' New_name '.mat'], 'results');
end