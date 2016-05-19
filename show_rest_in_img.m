function show_rest_in_img()

addpath(genpath('./util/'));
addpath(genpath('../results/results_TRE/'));
addpath(genpath('../dataset/OTB/'));

seqs     = configSeqs;
tracker1 = 'SemanticTracking';
tracker2 = 'Baseline';
tracler3 = 'NetC';

for idxSeq=1:length(seqs)
    s = seqs{idxSeq};    
    s.len = s.endFrame - s.startFrame + 1;
    s.s_frames = cell(s.len,1);
    nz	= strcat('%0',num2str(s.nz),'d'); %number of zeros in the name of image    
    
    % ground truth
    rect_anno = dlmread(['./anno/' s.name '.txt']);
    
    % tracker 1
    tracker_name = strcat(s.name,'_',tracker1,'.mat');
    load(tracker_name)
    rest1 = results;
    
    % tracker 2
    tracker_name = strcat(s.name,'_',tracker2,'.mat');
    load(tracker_name)
    rest2 = results;
    
    tracker_name = strcat(s.name,'_',tracler3,'.mat');
    load(tracker_name)
    rest3 = results;
    
    % load image names
    for i=1:s.len
        image_no = s.startFrame + (i-1);
        id = sprintf(nz,image_no);
        s.s_frames{i} = strcat(s.path,id,'.',s.ext);
    end        
    
    % display images
    for id_f = 1: s.len
        fprintf('%d - %s frame: %d/%d\n', idxSeq, s.name, id_f, s.len);
        img = imread(s.s_frames{id_f});
        imshow(uint8(img))
        rectangle('Position',rest1{1}.res(id_f,:), 'LineWidth',5,'EdgeColor','r')   
        rectangle('Position',rest2{1}.res(id_f,:), 'LineWidth',5,'EdgeColor','y')   
        rectangle('Position',rest3{1}.res(id_f,:), 'LineWidth',5,'EdgeColor','m')    
%         rectangle('Position',rect_anno(id_f,:), 'LineWidth',5,'EdgeColor','b')   
        text(20,20, ['Frame: ', num2str(id_f)],'fontsize' ,30,'fontweight' ,'bold' ,'color' ,'g' )
        pause(0.001)
    end    
    pause
    clear results
end
