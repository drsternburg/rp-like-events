
%% data sets
subjs_1 = {'VPtab','VPtae','VPtaf','VPtag','VPtah','VPtai','VPtaj',...
           'VPtak','VPtal','VPtam','VPtan','VPtao','VPtap','VPtaq',...
           'VPtar','VPtas','VPtat','VPtau','VPtaw','VPtax','VPtay',...
           'VPtaz','VPtba'};
subjs_2 = {'VPfah','VPfai','VPfaj','VPfak','VPfal','VPfam','VPfan',...
           'VPfao','VPfap','VPfaq','VPfar','VPfas','VPfat','VPfau',...
           'VPfav','VPfaw','VPfax','VPfay','VPfaz','VPfba','VPfbb',...
           'VPfbc','VPfbd','VPfbe','VPfbf','VPfbg','VPfbh','VPfbi',...
           'VPfbj','VPfbk','VPfbl','VPfbm','VPfbn','VPfbo','VPfbp',...
           'VPfbq','VPfbr','VPfbs','VPfbt','VPfbu','VPfbv','VPfbw',...
           'VPfbx','VPfby','VPfbz'};
subjs_all = cat(2,subjs_1,subjs_2);
Ns = length(subjs_all);

%% classifier parameters
global opt
opt.clab_load = {'F3-4','FC5-6','C5-6','CP5-6','P3-4'};
opt.clab_base = {'F1','Fz','F2',...
                 'FC3','FC2','FC1','FC4',...
                 'C3','C1','Cz','C2','C4',...
                 'CP3','CP1','CPz','CP2','CP4',...
                 'P1','Pz','P2'};
opt.ival_baseln = [-1500 -1400];
opt.baseln_len = 100;
opt.baseln_pos = 'beginning';
opt.ival_fv = [-1500 -1400;
               -1400 -1300;
               -1300 -1200;
               -1200 -1100;
               -1100 -1000;
               -1000  -900;
               -900   -800;
               -800   -700;
               -700   -600;
               -600   -500;
               -500   -400;
               -400   -300;
               -300   -200;
               -200   -100;
               -100      0];
opt.fv_window = [opt.ival_fv(1) opt.ival_fv(end)];
opt.ival_amp = [-200 0];
















