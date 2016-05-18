function res_in_img()

addpath(genpath('./util/'));
addpath(genpath('../results/results_TRE/'));
addpath(genpath('../dataset/OTB/'));

seqs=configSeqs;
tracker = 'SemanticTracking';

for idxSeq=1:length(seqs)
    s = seqs{idxSeq};    
    s.len = s.endFrame - s.startFrame + 1;
    s.s_frames = cell(s.len,1);
    nz	= strcat('%0',num2str(s.nz),'d'); %number of zeros in the name of image    
    
    rest_name = strcat(s.name,'_',tracker,'.mat');
    load(rest_name)
    
    for i=1:s.len
        image_no = s.startFrame + (i-1);
        id = sprintf(nz,image_no);
        s.s_frames{i} = strcat(s.path,id,'.',s.ext);
    end        
    for id_f = 1: s.len
        fprintf('%d - %s frame: %d/%d\n', idxSeq, s.name, id_f, s.len);
        img = imread(s.s_frames{id_f});
        imshow(uint8(img))
        rectangle('Position',results{1}.res(id_f,:), 'LineWidth',5,'EdgeColor','r')   
        text(25,25, num2str(id_f),'fontsize' ,25,'fontweight' ,'bold' ,'color' ,'r' )
        pause(0.01)
    end    
    pause
    clear results
end
