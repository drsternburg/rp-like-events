
function rple_visualizeWaitingTimes(mrk)

fig_init(15,15);

mrk = mrk_selectClasses(mrk,{'trial start','movement onset'});
WT = mrk.time(logical(mrk.y(2,:)))-mrk.time(logical(mrk.y(1,:)));

histogram(WT)
xlabel('Waiting time (msec)')