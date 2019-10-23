
function rple_selectChannels(cnt,mrk,mnt)

global opt

%% get amplitudes
epo = proc_segmentation(cnt,mrk,opt.fv_window);
epo = proc_baseline(epo,opt.ival_baseln);
rsq = proc_rSquareSigned(epo,'Stats',1);
epo_ = proc_selectChannels(epo,opt.cfy_rp.clab_base);
amp = proc_meanAcrossTime(epo_,opt.ival_amp);

%% channel selection
[~,pval1] = ttest(squeeze(amp.x(1,:,logical(amp.y(2,:))))',0,'tail','left'); % RP amplitudes must be smaller than zero
[~,pval2] = ttest2(squeeze(amp.x(1,:,logical(amp.y(2,:))))',...
    squeeze(amp.x(1,:,logical(amp.y(1,:))))',...
    'tail','left'); % RP amplitudes must be smaller than No-RP amplitudes
opt.clab_select = epo_.clab(pval1<.05&pval2<.05);

%% visualize
rple_gridplot(epo,rsq,mnt,opt.clab_select);