
subj_code = subjs_all{1};

%% load data
[mrk,cnt,mnt] = rple_loadData(subj_code);

%% select trials containing movement onset
mrk = mrk_selectClasses(mrk,{'trial start','movement onset','trial end'});
trial_mrk = rple_getTrialMarkers(mrk);
trial_mrk = trial_mrk(cellfun(@length,trial_mrk)==3);
mrk = mrk_selectEvents(mrk,[trial_mrk{:}]);

%% inspect data
rple_inspectData(cnt,mrk,mnt);

%% visualize waiting times
rple_visualizeWaitingTimes(mrk);

%% select channels
rple_selectChannels(cnt,mrk,mnt);

%% assess classification accuracy
rple_assessClassiAccuracy(cnt,mrk);

%% compute sliding classifier output
Cout = proc_slidingClassification(cnt,mrk);

%% visualize classifier output
rple_visualizeCout(Cout);

%% estimate detection rates
R = rple_estimateDetectionRates(Cout,.5);