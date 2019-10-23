
function rple_inspectData(cnt,mrk,mnt)

global opt

%% plot raw Cz signal
t = 1/cnt.fs:1/cnt.fs:cnt.T/cnt.fs;
figure
plot(t,cnt.x(:,util_chanind(cnt,'Cz')))
xlabel('sec')
ylabel('\muV')

%% plot ERPs
mrk = mrk_selectClasses(mrk,{'trial start','movement onset'});
epo = proc_segmentation(cnt,mrk,opt.fv_window);
epo = proc_baseline(epo,opt.baseln_len,opt.baseln_pos);
rsq = proc_rSquareSigned(epo);
rple_gridplot(epo,rsq,mnt);