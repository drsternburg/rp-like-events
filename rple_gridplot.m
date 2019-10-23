
function H = rple_gridplot(epo,rsq,mnt,clab_selected)

fig_init(25,20);
H = grid_plot(epo,mnt,'PlotStat','sem','ShrinkAxes',[.85 .85]);
if not(isempty(rsq))
    grid_addBars(rsq,'HScale',H.scale,'Height',1/7);
end
set(H.leg,'pos',[.42 .6 .15 .05])
if nargin>3
    for jj = 1:length(H.chan)
        if any(strcmp(H.chan(jj).ax_title.String,clab_selected))
            set(H.chan(jj).ax_title,'FontWeight','bold')
        end
    end
end