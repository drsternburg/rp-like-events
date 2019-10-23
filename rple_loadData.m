
function [mrk,cnt,mnt] = rple_loadData(subj_code)

global BTB opt

phase_name = 'Phase1';
if strcmp(subj_code(3),'t')
    session_name = 'TrafficLight';
else
    session_name = 'ReadinessFeedback';
end

ds_list = dir(BTB.MatDir);
ds_idx = strncmp(subj_code,{ds_list.name},5);
ds_name = ds_list(ds_idx).name;

filename_eeg = sprintf('%s_%s_%s',session_name,phase_name,subj_code);
filename_eeg = fullfile(ds_name,filename_eeg);
filename_mrk = sprintf('%s%s_mrk.mat',BTB.MatDir,filename_eeg);

fprintf('Loading data set %s, %s...\n',ds_name,phase_name)

if nargout>1 || not(exist(filename_mrk,'file'))
    [cnt,mrk,mnt] = file_loadMatlab(filename_eeg);
end
if exist(filename_mrk,'file')
    load(filename_mrk)
end

cnt = proc_selectChannels(cnt,opt.clab_load);
mnt = mnt_restrictMontage(mnt,cnt);
mnt.scale_box = [];
mnt = mnt_scalpToGrid(mnt);

switch session_name
    case 'TrafficLight'
        ci = strcmp(mrk.className,'start phase1');
        mrk.className{ci} = 'trial start';
        ci = strcmp(mrk.className,'EMG onset');
        mrk.className{ci} = 'movement onset';
end