%t' and v' histograms
%CORRECTED VERSION WITH AREA WEIGHTING DONE RIGHT



rDir='/project/rg312/wv_on_rad_off/run_000_best/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
yi = -89:2:89;
xi = -179:2:179;

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best','vN_000')
vN_000_ll = squeeze(cube2latlon(xc,yc,vN_000(:,:,13,1:719),xi,yi));
vN_000_ll_tav = repmat(mean(vN_000_ll,3),[1 1 719]);
vN_ed_000_ll = vN_000_ll - vN_000_ll_tav;
clear('vN_000')

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_000')
t_000_ll = squeeze(cube2latlon(xc,yc,t_000(:,:,13,1:719),xi,yi));
t_000_ll_tav = repmat(mean(t_000_ll,3),[1 1 719]);
t_ed_000_ll = t_000_ll - t_000_ll_tav;
clear('t_000')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_100')
vN_100_ll = squeeze(cube2latlon(xc,yc,vN_100(:,:,13,1:719),xi,yi));
vN_100_ll_tav = repmat(mean(vN_100_ll,3),[1 1 719]);
vN_ed_100_ll = vN_100_ll - vN_100_ll_tav;
clear('vN_100')

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_100')
t_100_ll = squeeze(cube2latlon(xc,yc,t_100(:,:,13,1:719),xi,yi));
t_100_ll_tav = repmat(mean(t_100_ll,3),[1 1 719]);
t_ed_100_ll = t_100_ll - t_100_ll_tav;
clear('t_100')


xbins_t=-20:0.2:20;
xbins_v=-40:0.4:40;

for i=1:90
%include lat weighting too
i

t_ed_000_counts = hist(reshape(t_ed_000_ll(:,i,:),[numel(t_ed_000_ll(:,i,:)),1]),xbins_t);
t_ed_000_counts_cos(i,:) = t_ed_000_counts.*cos(yi(i).*pi./180);

t_ed_100_counts = hist(reshape(t_ed_100_ll(:,i,:),[numel(t_ed_100_ll(:,i,:)),1]),xbins_t);
t_ed_100_counts_cos(i,:) = t_ed_100_counts.*cos(yi(i).*pi./180);


vN_ed_000_counts = hist(reshape(vN_ed_000_ll(:,i,:),[numel(vN_ed_000_ll(:,i,:)),1]),xbins_v);
vN_ed_000_counts_cos(i,:) = vN_ed_000_counts.*cos(yi(i).*pi./180);

vN_ed_100_counts = hist(reshape(vN_ed_100_ll(:,i,:),[numel(vN_ed_100_ll(:,i,:)),1]),xbins_v);
vN_ed_100_counts_cos(i,:) = vN_ed_100_counts.*cos(yi(i).*pi./180);

end


t_hist_000 = sum(t_ed_000_counts_cos,1)./sum(sum(t_ed_000_counts_cos));
t_hist_100 = sum(t_ed_100_counts_cos,1)./sum(sum(t_ed_100_counts_cos));
vN_hist_000 = sum(vN_ed_000_counts_cos,1)./sum(sum(vN_ed_000_counts_cos));
vN_hist_100 = sum(vN_ed_100_counts_cos,1)./sum(sum(vN_ed_100_counts_cos));



figure
h_000=bar(xbins_t,t_hist_000,'r');
hold on;
h_100=bar(xbins_t,t_hist_100);
alpha(get(h_000,'children'),.5);
alpha(get(h_100,'children'),.25);
set(h_000,'EdgeColor','none')
ylim([0 0.25])
xlim([-10 10])
set(gca,'FontSize',15);
xlabel('T'', K')
ylabel('Probability')
title('PDF of T'' in the dry and wet models')
dryleg = ['Dry'];
wetleg = ['Wet'];
legend(dryleg, wetleg)
print('-dpng','t_hist_plot.png')



figure
h_000=bar(xbins_v,vN_hist_000,'r');
hold on;
h_100=bar(xbins_v,vN_hist_100);
alpha(get(h_000,'children'),.5);
alpha(get(h_100,'children'),.25);
set(h_000,'EdgeColor','none')
%ylim([0 0.25])
xlim([-20 20])
set(gca,'FontSize',15);
xlabel('V'', m/s')
ylabel('Probability')
title('PDF of V'' in the dry and wet models')
dryleg = ['Dry'];
wetleg = ['Wet'];
legend(dryleg, wetleg)
print('-dpng','v_hist_plot.png')





return


