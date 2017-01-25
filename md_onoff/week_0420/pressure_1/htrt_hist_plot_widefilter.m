%maybe the last htrt histogram plot to crack this...
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

%load in heat rates and t
load('/project/rg312/mat_files/heat_rates_best.mat','htrt_000')
htrt_000_ll = squeeze(cube2latlon(xc,yc,htrt_000(:,:,1,1:719),xi,yi)).*86400;
htrt_000_ll_tav = repmat(mean(htrt_000_ll,3),[1 1 719]);
htrt_ed_000_ll = htrt_000_ll - htrt_000_ll_tav;
clear('htrt_000')

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_000')
t_000_ll = squeeze(cube2latlon(xc,yc,t_000(:,:,1,1:719),xi,yi));
t_000_ll_tav = repmat(mean(t_000_ll,3),[1 1 719]);
t_ed_000_ll = t_000_ll - t_000_ll_tav;
clear('t_000')

load('/project/rg312/mat_files/heat_rates_best.mat','htrt_100')
htrt_100_ll = squeeze(cube2latlon(xc,yc,htrt_100(:,:,1,1:719),xi,yi)).*86400;
htrt_100_ll_tav = repmat(mean(htrt_100_ll,3),[1 1 719]);
htrt_ed_100_ll = htrt_100_ll - htrt_100_ll_tav;
clear('htrt_100')

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_100')
t_100_ll = squeeze(cube2latlon(xc,yc,t_100(:,:,1,1:719),xi,yi));
t_100_ll_tav = repmat(mean(t_100_ll,3),[1 1 719]);
t_ed_100_ll = t_100_ll - t_100_ll_tav;
clear('t_100')

%create mask so we only look at T' greater than 1, less that -1
t_mask_pos_000 = +(t_ed_000_ll > 1 );
t_mask_neg_000 = +(t_ed_000_ll < -1);

%mask heat rates
htrt_ed_000_pos = htrt_ed_000_ll.*t_mask_pos_000;
htrt_ed_000_neg = htrt_ed_000_ll.*t_mask_neg_000;

t_mask_pos_100 = +(t_ed_100_ll > 1 );
t_mask_neg_100 = +(t_ed_100_ll < -1);

htrt_ed_100_pos = htrt_ed_100_ll.*t_mask_pos_100;
htrt_ed_100_neg = htrt_ed_100_ll.*t_mask_neg_100;


for i=1:90
%include lat weighting too
i
xbins = -45:0.2:45;

%select lat to look at for masked plots, and empty out 0 (i.e. masked) elements
htrt_ed_000_pos_in = htrt_ed_000_pos(:,i,:);
htrt_ed_000_pos_in(htrt_ed_000_pos_in == 0) =[];
htrt_ed_000_neg_in = htrt_ed_000_neg(:,i,:);
htrt_ed_000_neg_in(htrt_ed_000_neg_in == 0) =[];

htrt_ed_100_pos_in = htrt_ed_100_pos(:,i,:);
htrt_ed_100_pos_in(htrt_ed_100_pos_in == 0) =[];
htrt_ed_100_neg_in = htrt_ed_100_neg(:,i,:);
htrt_ed_100_neg_in(htrt_ed_100_neg_in == 0) =[];

%bin data at each latitude and weight bin contribution by area (i.e. cos(lat))
htrt_ed_000_counts = hist(reshape(htrt_ed_000_ll(:,i,:),[numel(htrt_ed_000_ll(:,i,:)),1]),xbins);
htrt_ed_000_counts_cos(i,:) = htrt_ed_000_counts.*cos(yi(i).*pi./180);

htrt_ed_000_pos_counts = hist(reshape(htrt_ed_000_pos_in,[numel(htrt_ed_000_pos_in),1]),xbins);
htrt_ed_000_pos_counts_cos(i,:) = htrt_ed_000_pos_counts.*cos(yi(i).*pi./180);

htrt_ed_000_neg_counts = hist(reshape(htrt_ed_000_neg_in,[numel(htrt_ed_000_neg_in),1]),xbins);
htrt_ed_000_neg_counts_cos(i,:) = htrt_ed_000_neg_counts.*cos(yi(i).*pi./180);


htrt_ed_100_counts = hist(reshape(htrt_ed_100_ll(:,i,:),[numel(htrt_ed_100_ll(:,i,:)),1]),xbins);
htrt_ed_100_counts_cos(i,:) = htrt_ed_100_counts.*cos(yi(i).*pi./180);

htrt_ed_100_pos_counts = hist(reshape(htrt_ed_100_pos_in,[numel(htrt_ed_100_pos_in),1]),xbins);
htrt_ed_100_pos_counts_cos(i,:) = htrt_ed_100_pos_counts.*cos(yi(i).*pi./180);

htrt_ed_100_neg_counts = hist(reshape(htrt_ed_100_neg_in,[numel(htrt_ed_100_neg_in),1]),xbins);
htrt_ed_100_neg_counts_cos(i,:) = htrt_ed_100_neg_counts.*cos(yi(i).*pi./180);


end

%sum up weighted contributions to get total distribution, and divide by sum of hist to get pdf
htrt_hist_000 = sum(htrt_ed_000_counts_cos,1)./sum(sum(htrt_ed_000_counts_cos));
htrt_hist_100 = sum(htrt_ed_100_counts_cos,1)./sum(sum(htrt_ed_100_counts_cos));

%also work out the fraction of the total htrt histogram that each tfiltered part represents
htrt_hist_000_pos = sum(htrt_ed_000_pos_counts_cos,1)./sum(sum(htrt_ed_000_pos_counts_cos));
t_prob_000_pos = sum(sum(htrt_ed_000_pos_counts_cos))./sum(sum(htrt_ed_000_counts_cos));

htrt_hist_000_neg = sum(htrt_ed_000_neg_counts_cos,1)./sum(sum(htrt_ed_000_neg_counts_cos));
t_prob_000_neg = sum(sum(htrt_ed_000_neg_counts_cos))./sum(sum(htrt_ed_000_counts_cos));

htrt_hist_100_pos = sum(htrt_ed_100_pos_counts_cos,1)./sum(sum(htrt_ed_100_pos_counts_cos));
t_prob_100_pos = sum(sum(htrt_ed_100_pos_counts_cos))./sum(sum(htrt_ed_100_counts_cos));

htrt_hist_100_neg = sum(htrt_ed_100_neg_counts_cos,1)./sum(sum(htrt_ed_100_neg_counts_cos));
t_prob_100_neg = sum(sum(htrt_ed_100_neg_counts_cos))./sum(sum(htrt_ed_100_counts_cos));


%plot
figure
h_000=bar(xbins,htrt_hist_000,'r');
alpha(get(h_000,'children'),.5);
set(h_000,'EdgeColor','none')
ylim([0 0.25])
xlim([-10 10])
set(gca,'FontSize',15);
xlabel('Diabatic heating, K/day')
ylabel('Probability')
title('PDF of diabatic heating in the dry model')
print('-dpng','htrt_hist_plot_dry.png')

figure
h_100=bar(xbins,htrt_hist_100);
alpha(get(h_100,'children'),.25);
ylim([0 0.25])
xlim([-10 10])
set(gca,'FontSize',15);
xlabel('Diabatic heating, K/day')
ylabel('Probability')
title('PDF of diabatic heating in the wet model')
print('-dpng','htrt_hist_plot_wet.png')



figure
h_000=bar(xbins,htrt_hist_000_pos,'r');
hold on;
h_100=bar(xbins,htrt_hist_100_pos);
alpha(get(h_000,'children'),.5);
alpha(get(h_100,'children'),.25);
set(h_000,'EdgeColor','none')
ylim([0 0.25])
xlim([-10 10])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with T''>1, K/day')
ylabel('Probability')
title('Diabatic heating associated with positive T'' in the dry and wet models')
dryleg = ['Dry (' num2str(round(10000.*t_prob_000_pos)./100) '%)'];
wetleg = ['Wet (' num2str(round(10000.*t_prob_100_pos)./100) '%)'];
legend(dryleg, wetleg)
print('-dpng','htrt_hist_pos_plot_wide.png')


figure
h_000=bar(xbins,htrt_hist_000_neg,'r');
hold on;
h_100=bar(xbins,htrt_hist_100_neg);
alpha(get(h_000,'children'),.5);
alpha(get(h_100,'children'),.25);
set(h_000,'EdgeColor','none')
ylim([0 0.25])
xlim([-10 10])
set(gca,'FontSize',15);
xlabel('Diabatic heating associated with T''<-1, K/day')
ylabel('Probability')
title('Diabatic heating associated with negative T'' in the dry and wet models')
dryleg = ['Dry (' num2str(round(10000.*t_prob_000_neg)./100) '%)'];
wetleg = ['Wet (' num2str(round(10000.*t_prob_100_neg)./100) '%)'];
legend(dryleg, wetleg)
print('-dpng','htrt_hist_neg_plot_wide.png')

