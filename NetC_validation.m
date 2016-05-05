function NetC_validation()
% NetC_validation: to check the accuarcy of classification
warning off

addpath(genpath('../OTB_protocol/'));
addpath(genpath('../dataset/'));
addpath(genpath('../SemanticTracking/'));

seqs    = configSeqs;
seq_num = length(seqs);
save_name = ['./results/results_Ours_OPE/NetC_performance.txt'];

net.shared_layers     = fullfile('../SemanticTracking/models','ST_Shared_trained.mat');
net.NetC_layers       = fullfile('../SemanticTracking/models','ST_NetC_trained.mat');
net.NetT_layers       = fullfile('../SemanticTracking/models','ST_NetT_trained.mat');
[NetS, NetC, ~, opts] = ST_init([], net);

if ~exist(save_name)
    for id_s = 1: seq_num
        disp(['processing: ', num2str(id_s)])
        conf = genConfig('otb',seqs{id_s}.name);    
        img = imread(conf.imgList{1});
        if(size(img,3)==1), img = cat(3,img,img,img); end
        [~, sample_class(id_s)] = ST_classify_net(img, conf.gt(1,:), NetS, NetC, opts);   
    end
    save(['./results/results_Ours_OPE/NetC_performance.txt'], 'sample_class');
end

class_name = { '1 - human', '2 - face', '3 - car',...
               '4 - animal', '5 - ball', '6 - motocross',...
               '7 - doll', '8 - others'};
for id_class  = 1: length(class_name)
    disp(class_name{id_class})
end
gt_class   = importdata('../dataset/OTB/OTB100_class.txt');
gt_seq     = importdata('../dataset/OTB/OTB100_seq.txt');
NetC_class = importdata('./results/results_Ours_OPE/NetC_performance.txt');

res = 0;
for id_s = 1: seq_num
    gt_id = find(strcmp(gt_seq, seqs{id_s}.name));
    if gt_class(gt_id) == NetC_class(id_s)
        res = res+1;
    end    
end
ratio      = sum(res)/seq_num;
disp(['The success ratio of NetC at first frame: ', num2str(ratio)]) % remember to change configSeqs.m

%------------ Display labels in images --------
if 0
    for id_s = 1: seq_num
        conf = genConfig('otb',seqs{id_s}.name);    
        disp(['video ', num2str(id_s), ' : ', conf.seqName])
        img = imread(conf.imgList{1});
        imshow(uint8(img))        
        gt_id = find(gt_seq== seqs{id_s}.name);
        show_class = sprintf('Ground truth: %s , NetC : %s', class_name{gt_class(gt_id)}, class_name{NetC_class(id_s)});
        text(30,30, show_class,'fontsize' ,15,'fontweight' ,'bold' ,'color' ,'r' )
        pause
    end
end



