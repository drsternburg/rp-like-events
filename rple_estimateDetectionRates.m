
function rple_estimateDetectionRates(C,beta)

%% define possible threshold range
x_all = cellfun(@(f)getfield(f,'x'),C,'UniformOutput',false);
x_all = [x_all{:}];
thresh = linspace(0,prctile(x_all,99.5),100);

%%
Nth = length(thresh);
Nt = length(C);
T = inf(Nt,Nth);
for jj = 1:Nt
    tind = C{jj}.t<=0;
    x = C{jj}.x(tind);
    t = C{jj}.t(tind);
    for kk = 1:Nth
        ind = find(diff(sign(x-thresh(kk)))==2,1);
        if not(isempty(ind))
            T(jj,kk) = t(ind);
        end
    end
end

%%
edges = [-Inf -500 0 Inf];
R = zeros(Nth,length(edges)-1);
for kk = 1:Nth
    R(kk,:) = histcounts(T(:,kk),edges,'normalization','probability');
end
F = fScore(R(:,1),R(:,2),R(:,3),beta);
F = smooth(F,10);
[~,ind_maxF] = max(F);

%%
fig_init(15,15);
hold on
clrs = lines(7);
for jj = 1:size(R,2)
    plot(thresh,R(:,jj),'color',clrs(jj,:),'linewidth',1.5)
end
plot(thresh,F,'color',clrs(jj+1,:),'linewidth',1.5)
plot([1 1]*thresh(ind_maxF),ylim,'color',clrs(jj+2,:))
axis tight
box on
lh = legend(sprintf('FA rate: %2.1f%%',R(ind_maxF,1)*100),...
            sprintf('HIT rate: %2.1f%%\n',R(ind_maxF,2)*100),...
            sprintf('MISS rate: %2.1f%%\n',R(ind_maxF,3)*100),...
            sprintf('Smoothed F-score: %9.3f\n',F(ind_maxF)),...
            'location','west');
set(lh,'box','off')
xlabel('Threshold')
title(sprintf('HIT interval: [%d %d]ms, F-score: %0.3f',edges(2),edges(3),F(ind_maxF)))

