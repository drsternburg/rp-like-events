
function rple_visualizeCout(C)

fig_init(15,15);
hold on
clrs = lines;

t_all = cellfun(@(f)f.t,C,'UniformOutput',false);
t_all = [t_all{:}];
T = [prctile(t_all,5) prctile(t_all,99)];

t = T(1):10:T(2);
Nt = length(C);
Cm = nan(Nt,length(t));
for jj = 1:Nt
    Cm(jj,:) = interp1(C{jj}.t,C{jj}.x,t,'linear',NaN);
    plot(C{jj}.t,C{jj}.x,'color',clrs(1,:))
end
plot(t,nanmean(Cm),'color',clrs(2,:),'linewidth',2)
plot([0 0],ylim,'k--')
plot(T,[0 0],'k--')
grid on
xlabel('time w.r.t. movement onset (msec)')
ylabel('Classifier output (a.u.)')
set(gca,'xlim',T)


