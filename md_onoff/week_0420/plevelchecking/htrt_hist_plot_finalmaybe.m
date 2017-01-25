%maybe the last htrt histogram plot to crack this...


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

load('/project/rg312/mat_files/heat_rates_best.mat','htrt_000')
htrt_000_ll = squeeze(cube2latlon(xc,yc,htrt_000(:,:,10,1:719),xi,yi)).*86400;
htrt_000_ll_tav = repmat(mean(htrt_000_ll,3),[1 1 719]);
htrt_ed_000_ll = htrt_000_ll - htrt_000_ll_tav;
clear('htrt_000')

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_000')
t_000_ll = squeeze(cube2latlon(xc,yc,t_000(:,:,10,1:719),xi,yi));
t_000_ll_tav = repmat(mean(t_000_ll,3),[1 1 719]);
t_ed_000_ll = t_000_ll - t_000_ll_tav;
clear('t_000')

load('/project/rg312/mat_files/heat_rates_best.mat','htrt_100')
htrt_100_ll = squeeze(cube2latlon(xc,yc,htrt_100(:,:,10,1:719),xi,yi)).*86400;
htrt_100_ll_tav = repmat(mean(htrt_100_ll,3),[1 1 719]);
htrt_ed_100_ll = htrt_100_ll - htrt_100_ll_tav;
clear('htrt_100')

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_100')
t_100_ll = squeeze(cube2latlon(xc,yc,t_100(:,:,10,1:719),xi,yi));
t_100_ll_tav = repmat(mean(t_100_ll,3),[1 1 719]);
t_ed_100_ll = t_100_ll - t_100_ll_tav;
clear('t_100')


t_mask_7_pos_000 = +(t_ed_000_ll > 6 & t_ed_000_ll <= 7);
t_mask_7_neg_000 = +(t_ed_000_ll >= -7 & t_ed_000_ll < -6);

htrt_ed_000_7_pos = htrt_ed_000_ll.*t_mask_7_pos_000;
htrt_ed_000_7_pos(htrt_ed_000_7_pos == 0) =[];
htrt_ed_000_7_neg = htrt_ed_000_ll.*t_mask_7_neg_000;
htrt_ed_000_7_neg(htrt_ed_000_7_neg == 0) =[];

t_mask_7_pos_100 = +(t_ed_100_ll > 6 & t_ed_100_ll <= 7);
t_mask_7_neg_100 = +(t_ed_100_ll >= -7 & t_ed_100_ll < -6);

htrt_ed_100_7_pos = htrt_ed_100_ll.*t_mask_7_pos_100;
htrt_ed_100_7_pos(htrt_ed_100_7_pos == 0) =[];
htrt_ed_100_7_neg = htrt_ed_100_ll.*t_mask_7_neg_100;
htrt_ed_100_7_neg(htrt_ed_100_7_neg == 0) =[];


t_mask_4_pos_000 = +(t_ed_000_ll > 3 & t_ed_000_ll <= 4);
t_mask_4_neg_000 = +(t_ed_000_ll >= -4 & t_ed_000_ll < -3);

htrt_ed_000_4_pos = htrt_ed_000_ll.*t_mask_4_pos_000;
htrt_ed_000_4_pos(htrt_ed_000_4_pos == 0) =[];
htrt_ed_000_4_neg = htrt_ed_000_ll.*t_mask_4_neg_000;
htrt_ed_000_4_neg(htrt_ed_000_4_neg == 0) =[];

t_mask_4_pos_100 = +(t_ed_100_ll > 3 & t_ed_100_ll <= 4);
t_mask_4_neg_100 = +(t_ed_100_ll >= -4 & t_ed_100_ll < -3);

htrt_ed_100_4_pos = htrt_ed_100_ll.*t_mask_4_pos_100;
htrt_ed_100_4_pos(htrt_ed_100_4_pos == 0) =[];
htrt_ed_100_4_neg = htrt_ed_100_ll.*t_mask_4_neg_100;
htrt_ed_100_4_neg(htrt_ed_100_4_neg == 0) =[];


t_mask_3_pos_000 = +(t_ed_000_ll > 2 & t_ed_000_ll <= 3);
t_mask_3_neg_000 = +(t_ed_000_ll >= -3 & t_ed_000_ll < -2);

htrt_ed_000_3_pos = htrt_ed_000_ll.*t_mask_3_pos_000;
htrt_ed_000_3_pos(htrt_ed_000_3_pos == 0) =[];
htrt_ed_000_3_neg = htrt_ed_000_ll.*t_mask_3_neg_000;
htrt_ed_000_3_neg(htrt_ed_000_3_neg == 0) =[];

t_mask_3_pos_100 = +(t_ed_100_ll > 2 & t_ed_100_ll <= 3);
t_mask_3_neg_100 = +(t_ed_100_ll >= -3 & t_ed_100_ll < -2);

htrt_ed_100_3_pos = htrt_ed_100_ll.*t_mask_3_pos_100;
htrt_ed_100_3_pos(htrt_ed_100_3_pos == 0) =[];
htrt_ed_100_3_neg = htrt_ed_100_ll.*t_mask_3_neg_100;
htrt_ed_100_3_neg(htrt_ed_100_3_neg == 0) =[];


for i=1:90
%include lat weighting too
i
xbins = -45:0.2:45;

htrt_ed_000_counts = hist(reshape(htrt_ed_000_ll,[numel(htrt_ed_000_ll),1]),xbins);
htrt_ed_000_counts_cos(i,:) = htrt_ed_000_counts.*cos(yi(i).*pi./180);

htrt_ed_000_7_pos_counts = hist(reshape(htrt_ed_000_7_pos,[numel(htrt_ed_000_7_pos),1]),xbins);
htrt_ed_000_7_pos_counts_cos(i,:) = htrt_ed_000_7_pos_counts.*cos(yi(i).*pi./180);

htrt_ed_000_7_neg_counts = hist(reshape(htrt_ed_000_7_neg,[numel(htrt_ed_000_7_neg),1]),xbins);
htrt_ed_000_7_neg_counts_cos(i,:) = htrt_ed_000_7_neg_counts.*cos(yi(i).*pi./180);

htrt_ed_000_4_pos_counts = hist(reshape(htrt_ed_000_4_pos,[numel(htrt_ed_000_4_pos),1]),xbins);
htrt_ed_000_4_pos_counts_cos(i,:) = htrt_ed_000_4_pos_counts.*cos(yi(i).*pi./180);

htrt_ed_000_4_neg_counts = hist(reshape(htrt_ed_000_4_neg,[numel(htrt_ed_000_4_neg),1]),xbins);
htrt_ed_000_4_neg_counts_cos(i,:) = htrt_ed_000_4_neg_counts.*cos(yi(i).*pi./180);

htrt_ed_000_3_pos_counts = hist(reshape(htrt_ed_000_3_pos,[numel(htrt_ed_000_3_pos),1]),xbins);
htrt_ed_000_3_pos_counts_cos(i,:) = htrt_ed_000_3_pos_counts.*cos(yi(i).*pi./180);

htrt_ed_000_3_neg_counts = hist(reshape(htrt_ed_000_3_neg,[numel(htrt_ed_000_3_neg),1]),xbins);
htrt_ed_000_3_neg_counts_cos(i,:) = htrt_ed_000_3_neg_counts.*cos(yi(i).*pi./180);


htrt_ed_100_counts = hist(reshape(htrt_ed_100_ll,[numel(htrt_ed_100_ll),1]),xbins);
htrt_ed_100_counts_cos(i,:) = htrt_ed_100_counts.*cos(yi(i).*pi./180);

htrt_ed_100_7_pos_counts = hist(reshape(htrt_ed_100_7_pos,[numel(htrt_ed_100_7_pos),1]),xbins);
htrt_ed_100_7_pos_counts_cos(i,:) = htrt_ed_100_7_pos_counts.*cos(yi(i).*pi./180);

htrt_ed_100_7_neg_counts = hist(reshape(htrt_ed_100_7_neg,[numel(htrt_ed_100_7_neg),1]),xbins);
htrt_ed_100_7_neg_counts_cos(i,:) = htrt_ed_100_7_neg_counts.*cos(yi(i).*pi./180);

htrt_ed_100_4_pos_counts = hist(reshape(htrt_ed_100_4_pos,[numel(htrt_ed_100_4_pos),1]),xbins);
htrt_ed_100_4_pos_counts_cos(i,:) = htrt_ed_100_4_pos_counts.*cos(yi(i).*pi./180);

htrt_ed_100_4_neg_counts = hist(reshape(htrt_ed_100_4_neg,[numel(htrt_ed_100_4_neg),1]),xbins);
htrt_ed_100_4_neg_counts_cos(i,:) = htrt_ed_100_4_neg_counts.*cos(yi(i).*pi./180);

htrt_ed_100_3_pos_counts = hist(reshape(htrt_ed_100_3_pos,[numel(htrt_ed_100_3_pos),1]),xbins);
htrt_ed_100_3_pos_counts_cos(i,:) = htrt_ed_100_3_pos_counts.*cos(yi(i).*pi./180);

htrt_ed_100_3_neg_counts = hist(reshape(htrt_ed_100_3_neg,[numel(htrt_ed_100_3_neg),1]),xbins);
htrt_ed_100_3_neg_counts_cos(i,:) = htrt_ed_100_3_neg_counts.*cos(yi(i).*pi./180);

end


htrt_hist_000 = sum(htrt_ed_000_counts_cos,1)./sum(sum(htrt_ed_000_counts_cos));
htrt_hist_100 = sum(htrt_ed_100_counts_cos,1)./sum(sum(htrt_ed_100_counts_cos));

htrt_hist_000_7_pos = sum(htrt_ed_000_7_pos_counts_cos,1)./sum(sum(htrt_ed_000_7_pos_counts_cos));
t_prob_000_7_pos = sum(sum(htrt_ed_000_7_pos_counts_cos))./sum(sum(htrt_ed_000_counts_cos));
htrt_hist_000_4_pos = sum(htrt_ed_000_4_pos_counts_cos,1)./sum(sum(htrt_ed_000_4_pos_counts_cos));
t_prob_000_4_pos = sum(sum(htrt_ed_000_4_pos_counts_cos))./sum(sum(htrt_ed_000_counts_cos));
htrt_hist_000_3_pos = sum(htrt_ed_000_3_pos_counts_cos,1)./sum(sum(htrt_ed_000_3_pos_counts_cos));
t_prob_000_3_pos = sum(sum(htrt_ed_000_3_pos_counts_cos))./sum(sum(htrt_ed_000_counts_cos));

htrt_hist_000_7_neg = sum(htrt_ed_000_7_neg_counts_cos,1)./sum(sum(htrt_ed_000_7_neg_counts_cos));
t_prob_000_7_neg = sum(sum(htrt_ed_000_7_neg_counts_cos))./sum(sum(htrt_ed_000_counts_cos));
htrt_hist_000_4_neg = sum(htrt_ed_000_4_neg_counts_cos,1)./sum(sum(htrt_ed_000_4_neg_counts_cos));
t_prob_000_4_neg = sum(sum(htrt_ed_000_4_neg_counts_cos))./sum(sum(htrt_ed_000_counts_cos));
htrt_hist_000_3_neg = sum(htrt_ed_000_3_neg_counts_cos,1)./sum(sum(htrt_ed_000_3_neg_counts_cos));
t_prob_000_3_neg = sum(sum(htrt_ed_000_3_neg_counts_cos))./sum(sum(htrt_ed_000_counts_cos));


htrt_hist_100_7_pos = sum(htrt_ed_100_7_pos_counts_cos,1)./sum(sum(htrt_ed_100_7_pos_counts_cos));
t_prob_100_7_pos = sum(sum(htrt_ed_100_7_pos_counts_cos))./sum(sum(htrt_ed_100_counts_cos));
htrt_hist_100_4_pos = sum(htrt_ed_100_4_pos_counts_cos,1)./sum(sum(htrt_ed_100_4_pos_counts_cos));
t_prob_100_4_pos = sum(sum(htrt_ed_100_4_pos_counts_cos))./sum(sum(htrt_ed_100_counts_cos));
htrt_hist_100_3_pos = sum(htrt_ed_100_3_pos_counts_cos,1)./sum(sum(htrt_ed_100_3_pos_counts_cos));
t_prob_100_3_pos = sum(sum(htrt_ed_100_3_pos_counts_cos))./sum(sum(htrt_ed_100_counts_cos));

htrt_hist_100_7_neg = sum(htrt_ed_100_7_neg_counts_cos,1)./sum(sum(htrt_ed_100_7_neg_counts_cos));
t_prob_100_7_neg = sum(sum(htrt_ed_100_7_neg_counts_cos))./sum(sum(htrt_ed_100_counts_cos));
htrt_hist_100_4_neg = sum(htrt_ed_100_4_neg_counts_cos,1)./sum(sum(htrt_ed_100_4_neg_counts_cos));
t_prob_100_4_neg = sum(sum(htrt_ed_100_4_neg_counts_cos))./sum(sum(htrt_ed_100_counts_cos));
htrt_hist_100_3_neg = sum(htrt_ed_100_3_neg_counts_cos,1)./sum(sum(htrt_ed_100_3_neg_counts_cos));
t_prob_100_3_neg = sum(sum(htrt_ed_100_3_neg_counts_cos))./sum(sum(htrt_ed_100_counts_cos));



figure
h_000=bar(xbins,htrt_hist_000,'r');
alpha(get(h_000,'children'),.5);
set(h_000,'EdgeColor','none')
ylim([0 0.35])
xlim([-10 10])
set(gca,'FontSize',15);
xlabel('Diabatic heating, K/day')
ylabel('Probability')
title('PDF of diabatic heating in the dry model')
print('-dpng','htrt_hist_plot_dry_l10.png')

figure
h_100=bar(xbins,htrt_hist_100);
alpha(get(h_100,'children'),.25);
ylim([0 0.35])
xlim([-10 10])
set(gca,'FontSize',15);
xlabel('Diabatic heating, K/day')
ylabel('Probability')
title('PDF of diabatic heating in the wet model')
print('-dpng','htrt_hist_plot_wet_l10.png')


figure
h_000=bar(xbins,htrt_hist_000_3_pos,'r');
hold on;
h_100=bar(xbins,htrt_hist_100_3_pos);
alpha(get(h_000,'children'),.5);
alpha(get(h_100,'children'),.25);
set(h_000,'EdgeColor','none')
ylim([0 0.25])
xlim([-10 10])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with 2<T''<3, K/day')
ylabel('Probability')
title('Diabatic heating associated with positive T'' in the dry and wet models')
dryleg = ['Dry (' num2str(round(10000.*t_prob_000_3_pos)./100) '%)'];
wetleg = ['Wet (' num2str(round(10000.*t_prob_100_3_pos)./100) '%)'];
legend(dryleg, wetleg)
print('-dpng','htrt_hist_pos_plot_l10.png')


figure
h_000=bar(xbins,htrt_hist_000_3_neg,'r');
hold on;
h_100=bar(xbins,htrt_hist_100_3_neg);
alpha(get(h_000,'children'),.5);
alpha(get(h_100,'children'),.25);
set(h_000,'EdgeColor','none')
ylim([0 0.1])
xlim([-10 10])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with -3<T''<-2, K/day')
ylabel('Probability')
title('Diabatic heating associated with negative T'' in the dry and wet models')
dryleg = ['Dry (' num2str(round(10000.*t_prob_000_3_neg)./100) '%)'];
wetleg = ['Wet (' num2str(round(10000.*t_prob_100_3_neg)./100) '%)'];
legend(dryleg, wetleg)
print('-dpng','htrt_hist_neg_plot_l10.png')



figure
h_000=bar(xbins,htrt_hist_000_4_pos,'r');
hold on;
h_100=bar(xbins,htrt_hist_100_4_pos);
alpha(get(h_000,'children'),.5);
alpha(get(h_100,'children'),.25);
set(h_000,'EdgeColor','none')
ylim([0 0.25])
xlim([-10 10])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with 3<T''<4, K/day')
ylabel('Probability')
title('Diabatic heating associated with positive T'' in the dry and wet models')
dryleg = ['Dry (' num2str(round(10000.*t_prob_000_4_pos)./100) '%)'];
wetleg = ['Wet (' num2str(round(10000.*t_prob_100_4_pos)./100) '%)'];
legend(dryleg, wetleg)
print('-dpng','htrt_hist_pos_plot_4_l10.png')


figure
h_000=bar(xbins,htrt_hist_000_4_neg,'r');
hold on;
h_100=bar(xbins,htrt_hist_100_4_neg);
alpha(get(h_000,'children'),.5);
alpha(get(h_100,'children'),.25);
set(h_000,'EdgeColor','none')
ylim([0 0.1])
xlim([-10 10])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with -4<T''<-3, K/day')
ylabel('Probability')
title('Diabatic heating associated with negative T'' in the dry and wet models')
dryleg = ['Dry (' num2str(round(10000.*t_prob_000_4_neg)./100) '%)'];
wetleg = ['Wet (' num2str(round(10000.*t_prob_100_4_neg)./100) '%)'];
legend(dryleg, wetleg)
print('-dpng','htrt_hist_neg_plot_4_l10.png')



figure
h_000=bar(xbins,htrt_hist_000_7_pos,'r');
hold on;
h_100=bar(xbins,htrt_hist_100_7_pos);
alpha(get(h_000,'children'),.5);
alpha(get(h_100,'children'),.25);
set(h_000,'EdgeColor','none')
ylim([0 0.25])
xlim([-10 10])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with 6<T''<7, K/day')
ylabel('Probability')
title('Diabatic heating associated with positive T'' in the dry and wet models')
dryleg = ['Dry (' num2str(round(10000.*t_prob_000_7_pos)./100) '%)'];
wetleg = ['Wet (' num2str(round(10000.*t_prob_100_7_pos)./100) '%)'];
legend(dryleg, wetleg)
print('-dpng','htrt_hist_pos_plot_7_l10.png')


figure
h_000=bar(xbins,htrt_hist_000_7_neg,'r');
hold on;
h_100=bar(xbins,htrt_hist_100_7_neg);
alpha(get(h_000,'children'),.5);
alpha(get(h_100,'children'),.25);
set(h_000,'EdgeColor','none')
ylim([0 0.1])
xlim([-10 10])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with -7<T''<-6, K/day')
ylabel('Probability')
title('Diabatic heating associated with negative T'' in the dry and wet models')
dryleg = ['Dry (' num2str(round(10000.*t_prob_000_7_neg)./100) '%)'];
wetleg = ['Wet (' num2str(round(10000.*t_prob_100_7_neg)./100) '%)'];
legend(dryleg, wetleg)
print('-dpng','htrt_hist_neg_plot_7_l10.png')