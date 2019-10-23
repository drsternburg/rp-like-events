
function rple_assessClassiAccuracy(cnt,mrk)

global opt

cnt = proc_selectChannels(cnt,opt.clab_select);
fv = proc_segmentation(cnt,mrk,opt.fv_window);
fv = proc_baseline(fv,opt.baseln_len,opt.baseln_pos);
fv = proc_jumpingMeans(fv,opt.ival_fv);
fv = proc_flaten(fv);

warning off
loss = crossvalidation(fv,@train_RLDAshrink,'SampleFcn',@sample_leaveOneOut);
warning on

fprintf('Classification accuracy: %2.1f%%\n',100*(1-loss))