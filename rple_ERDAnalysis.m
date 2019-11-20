
%subjs_sel = subjs_all(IND_SEL);
%Ns = length(subjs_sel);

clab_base = {'F1','Fz','F2',...
             'FC3','FC2','FC1','FC4',...
             'C3','C1','Cz','C2','C4',...
             'CP3','CP1','CPz','CP2','CP4',...
             'P1','Pz','P2'};

bands = [8 10 ; 11 14 ; 15 19 ; 20 27];
opt.erd_window = [-500 0];

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
cout = cell(Ns,1);
for ii = 1:Ns
    
    [mrk,cnt,mnt] = rple_loadData(subjs_all{ii});
    cnt = proc_selectChannels(cnt,clab_base);
    cnt = proc_filterbank(cnt,filts_b,filts_a);

    mrk = mrk_selectClasses(mrk,{'trial start','movement onset','trial end'});
    trial_mrk = rple_getTrialMarkers(mrk);
    trial_mrk = trial_mrk(cellfun(@length,trial_mrk)==3);
    mrk = mrk_selectEvents(mrk,[trial_mrk{:}]);
    
    mrk1 = mrk_selectClasses(mrk,{'trial start','movement onset'});
    fv = proc_segmentation(cnt,mrk1,opt.erd_window);
    [loss(ii),~,coutxv_] = crossvalidation(fv,@train_RLDAshrink,'Proc',proc,'SampleFcn',@sample_leaveOneOut);
    coutxv{ii,1} = coutxv_(logical(fv.y(1,:)));
    coutxv{ii,2} = coutxv_(logical(fv.y(2,:)));
    
    cout{ii} = proc_slidingClassificationERD(cnt,mrk,proc);
                    
end





