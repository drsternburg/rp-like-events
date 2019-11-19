
%subjs_sel = subjs_all(IND_SEL);
%Ns = length(subjs_sel);

clab_base = {'F1','Fz','F2',...
             'FC3','FC2','FC1','FC4',...
             'C3','C1','Cz','C2','C4',...
             'CP3','CP1','CPz','CP2','CP4',...
             'P1','Pz','P2'};

bands = [8 10 ; 11 14 ; 15 19 ; 20 27];
fvtr_ival = [-500 0];

[filts_b,filts_a] = butters(5,bands/100*2);
proc = struct('memo','W');
proc.train= {{'W',@proc_multiBandSpatialFilter,{@proc_csp,...
              'ScoreFcn',{@score_eigenvalues},'SelectFcn',{@select_directorsCut}}}
             {@proc_variance}
             {@proc_logarithm}};
proc.apply= {{@proc_multiBandLinearDerivation,'$W'}
             {@proc_variance}
             {@proc_logarithm}};

%%
loss = zeros(Ns,1);
coutxv = cell(Ns,2);
for ii = 1:Ns
    
    [mrk,cnt,mnt] = tl_proc_loadData(subjs_sel{ii});
    trial = tl_mrk_analyzeTrials(mrk,1);
    cnt = proc_selectChannels(cnt,clab_base);
    cnt = proc_filterbank(cnt,filts_b,filts_a);
    
    ind = trial.phase1 & trial.emg_onset;
    
    mrk1 = tl_mrk_selectTrials(mrk,ind);
    mrk1 = mrk_selectClasses(mrk1,{'start phase1','EMG onset'});
    
    fv = proc_segmentation(cnt,mrk1,fvtr_ival);
    [loss(ii),~,coutxv_] = crossvalidation(fv,@train_RLDAshrink,'Proc',proc,'SampleFcn',@sample_leaveOneOut);
    coutxv{ii,1} = coutxv_(logical(fv.y(1,:)));
    coutxv{ii,2} = coutxv_(logical(fv.y(2,:)));
    [fv,W] = xvalutil_proc(fv,proc.train);
    fv = proc_flaten(fv);
    C = train_RLDAshrink(fv.x,fv.y);
    
    %fv = xvalutil_proc(fv,proc.apply,W);
    %fv = proc_flaten(fv);
    %cout_erd = apply_separatingHyperplane(C,fv.x);
                    
end





