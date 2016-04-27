function results = demo_STinOTB(seq, net)
% DEMO_STINOTB
%
% Interface with OTB protocol
% To speed up process, the protocol should provide pre-loaded net.
%
% Jingjing Xiao & Qiang Lan & Linbo Qiao, 2016. 
% 

warning off

results = ST_run(seq.s_frames, seq.init_rect, net);