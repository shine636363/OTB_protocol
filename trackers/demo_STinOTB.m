function [ST_rest_bbg, ST_rest_org] = demo_STinOTB(seq, net)
% DEMO_STINOTB
%
% Interface with OTB protocol
% To speed up process, the protocol should provide pre-loaded net.
%
% Jingjing Xiao & Qiang Lan & Linbo Qiao, 2016. 
% 
% test

warning off

command_display = 0;
[ST_rest_bbg, ST_rest_org] = ST_run(seq.s_frames, seq.init_rect, net, command_display);
