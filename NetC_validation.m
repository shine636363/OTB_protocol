function NetC_validation()
% NetC_validation: to check the accuarcy of classification
warning off

addpath(genpath('../OTB_protocol/'));
addpath(genpath('../dataset/'));
addpath(genpath('../SemanticTracking/'));

seqs    = configSeqs;
seq_num = length(seqs);

net.shared_layers     = fullfile('../SemanticTracking/models','ST_Shared_trained.mat');
net.NetC_layers       = fullfile('../SemanticTracking/models','ST_NetC_trained.mat');
net.NetT_layers       = fullfile('../SemanticTracking/models','ST_NetT_trained.mat');
[NetS, NetC, ~, opts] = ST_init([], net);
for id_s = 1: seq_num
    disp(['processing: ', num2str(id_s)])
    conf = genConfig('otb',seqs{id_s}.name);    
    img = imread(conf.imgList{1});
    if(size(img,3)==1), img = cat(3,img,img,img); end
    [~, sample_class(id_s)] = ST_classify_net(img, conf.gt(1,:), NetS, NetC, opts);   
end
save(['./results/results_Ours_OPE/NetC_performance.txt'], 'sample_class');

class_name = { '1 - human', '2 - face', '3 - car',...
               '4 - animal', '5 - ball', '6 - motocross',...
               '7 - doll', '8 - others'};
for id_class  = 1: length(class_name)
    disp(class_name{id_class})
end
gt_class   = importdata('./results/results_Ours_OPE/NetC_performance.txt');
NetC_class = importdata('../dataset/OTB/OTB100_class.txt');
res        = (gt_class == NetC_class');
ratio      = sum(res)/seq_num;
disp(['The success ratio of NetC at first frame: ', num2str(ratio)])



