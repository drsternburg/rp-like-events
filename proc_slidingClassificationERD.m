
function cout = proc_slidingClassificationERD(cnt,mrk,proc,C)

global opt

n_trial = sum(mrk.y(1,:));
i_trial = reshape(1:length(mrk.time),3,n_trial);

%%
cout = cell(1,n_trial);
h = waitbar(0,'Computing sliding classifier output...');
for ii = 1:n_trial
    
    if not(exist('C','var'))
        %% train
        mrk_train = mrk_selectEvents(mrk,'not',i_trial(:,ii));
        mrk_train = mrk_selectClasses(mrk_train,'trial start','movement onset');
        fv = proc_segmentation(cnt,mrk_train,opt.erd_window);
        [fv,W] = xvalutil_proc(fv,proc.train);
        fv = proc_flaten(fv);
        C = train_RLDAshrink(fv.x,fv.y);
    end
    
    %% apply
    mrk_apply = mrk_selectEvents(mrk,i_trial(:,ii));
    t_ts = mrk_apply.time(1);
    t_eo = mrk_apply.time(2);
    t_te = mrk_apply.time(3);
    ival = [t_ts t_te]-t_eo;
    
    mrk_eo = mrk_selectEvents(mrk_apply,2);
    epo = proc_segmentation(cnt,mrk_eo,ival);
    cout{ii} = proc_applySlidingClassifierERD(epo,C,W,proc);
    
    %%
    waitbar(ii/n_trial,h);
    
end
close(h)
