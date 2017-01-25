%function to load up radhts and produce area weighted histograms from this

function out = diabatic_tfiltered_hists_fun(run)

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

%load heat rates
radht_var = ['radht_' run];
t_var = ['t_' run];

radht_cs = load('/project/rg312/mat_files/heat_rates_best.mat',radht_var);
radht_cs = radht_cs.(radht_var);
radht_ll = squeeze(cube2latlon(xc,yc,radht_cs(:,:,5,1:719),xi,yi)).*86400;
radht_ll_tav = repmat(mean(radht_ll,3),[1 1 719]);
radht_ed_ll = radht_ll - radht_ll_tav;
clear radht_cs

t_cs = load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat',t_var);
t_cs = t_cs.(t_var);
t_ll = squeeze(cube2latlon(xc,yc,t_cs(:,:,5,1:719),xi,yi));
t_ll_tav = repmat(mean(t_ll,3),[1 1 719]);
t_ed_ll = t_ll - t_ll_tav;
clear t_cs


%define masks

t_mask_5_pos = +(t_ed_ll > 4 & t_ed_ll <= 5);
t_mask_5_neg = +(t_ed_ll >= -5 & t_ed_ll < -4);
radht_ed_5_pos = radht_ed_ll.*t_mask_5_pos;
radht_ed_5_neg = radht_ed_ll.*t_mask_5_neg;

t_mask_4_pos = +(t_ed_ll > 3 & t_ed_ll <= 4);
t_mask_4_neg = +(t_ed_ll >= -4 & t_ed_ll < -3);
radht_ed_4_pos = radht_ed_ll.*t_mask_4_pos;
radht_ed_4_neg = radht_ed_ll.*t_mask_4_neg;

t_mask_3_pos = +(t_ed_ll > 2 & t_ed_ll <= 3);
t_mask_3_neg = +(t_ed_ll >= -3 & t_ed_ll < -2);
radht_ed_3_pos = radht_ed_ll.*t_mask_3_pos;
radht_ed_3_neg = radht_ed_ll.*t_mask_3_neg;

t_mask_2_pos = +(t_ed_ll > 1 & t_ed_ll <= 2);
t_mask_2_neg = +(t_ed_ll >= -2 & t_ed_ll < -1);
radht_ed_2_pos = radht_ed_ll.*t_mask_2_pos;
radht_ed_2_neg = radht_ed_ll.*t_mask_2_neg;

t_mask_1_pos = +(t_ed_ll > 0 & t_ed_ll <= 1);
t_mask_1_neg = +(t_ed_ll >= -1 & t_ed_ll < 0);
radht_ed_1_pos = radht_ed_ll.*t_mask_1_pos;
radht_ed_1_neg = radht_ed_ll.*t_mask_1_neg;

t_mask_wide_pos = +(t_ed_ll > 2);
t_mask_wide_neg = +(t_ed_ll < -2);
radht_ed_wide_pos = radht_ed_ll.*t_mask_wide_pos;
radht_ed_wide_neg = radht_ed_ll.*t_mask_wide_neg;


for i=1:90
%include lat weighting too
i
xbins = -45:0.2:45;

%for each T range bin data at each latitude and weight bin contribution by area (i.e. cos(lat))
%select lat to look at for masked plots, and empty out 0 (i.e. masked) elements

radht_ed_5_pos_in = radht_ed_5_pos(:,i,:);
radht_ed_5_pos_in(radht_ed_5_pos_in == 0) =[];
radht_ed_5_neg_in = radht_ed_5_neg(:,i,:);
radht_ed_5_neg_in(radht_ed_5_neg_in == 0) =[];

radht_ed_4_pos_in = radht_ed_4_pos(:,i,:);
radht_ed_4_pos_in(radht_ed_4_pos_in == 0) =[];
radht_ed_4_neg_in = radht_ed_4_neg(:,i,:);
radht_ed_4_neg_in(radht_ed_4_neg_in == 0) =[];

radht_ed_3_pos_in = radht_ed_3_pos(:,i,:);
radht_ed_3_pos_in(radht_ed_3_pos_in == 0) =[];
radht_ed_3_neg_in = radht_ed_3_neg(:,i,:);
radht_ed_3_neg_in(radht_ed_3_neg_in == 0) =[];

radht_ed_2_pos_in = radht_ed_2_pos(:,i,:);
radht_ed_2_pos_in(radht_ed_2_pos_in == 0) =[];
radht_ed_2_neg_in = radht_ed_2_neg(:,i,:);
radht_ed_2_neg_in(radht_ed_2_neg_in == 0) =[];

radht_ed_1_pos_in = radht_ed_1_pos(:,i,:);
radht_ed_1_pos_in(radht_ed_1_pos_in == 0) =[];
radht_ed_1_neg_in = radht_ed_1_neg(:,i,:);
radht_ed_1_neg_in(radht_ed_1_neg_in == 0) =[];

radht_ed_wide_pos_in = radht_ed_wide_pos(:,i,:);
radht_ed_wide_pos_in(radht_ed_wide_pos_in == 0) =[];
radht_ed_wide_neg_in = radht_ed_wide_neg(:,i,:);
radht_ed_wide_neg_in(radht_ed_wide_neg_in == 0) =[];



radht_ed_5_pos_counts = hist(reshape(radht_ed_5_pos_in,[numel(radht_ed_5_pos_in),1]),xbins);
radht_ed_5_pos_counts_cos(i,:) = radht_ed_5_pos_counts.*cos(yi(i).*pi./180);
radht_ed_5_neg_counts = hist(reshape(radht_ed_5_neg_in,[numel(radht_ed_5_neg_in),1]),xbins);
radht_ed_5_neg_counts_cos(i,:) = radht_ed_5_neg_counts.*cos(yi(i).*pi./180);


radht_ed_4_pos_counts = hist(reshape(radht_ed_4_pos_in,[numel(radht_ed_4_pos_in),1]),xbins);
radht_ed_4_pos_counts_cos(i,:) = radht_ed_4_pos_counts.*cos(yi(i).*pi./180);
radht_ed_4_neg_counts = hist(reshape(radht_ed_4_neg_in,[numel(radht_ed_4_neg_in),1]),xbins);
radht_ed_4_neg_counts_cos(i,:) = radht_ed_4_neg_counts.*cos(yi(i).*pi./180);


radht_ed_3_pos_counts = hist(reshape(radht_ed_3_pos_in,[numel(radht_ed_3_pos_in),1]),xbins);
radht_ed_3_pos_counts_cos(i,:) = radht_ed_3_pos_counts.*cos(yi(i).*pi./180);
radht_ed_3_neg_counts = hist(reshape(radht_ed_3_neg_in,[numel(radht_ed_3_neg_in),1]),xbins);
radht_ed_3_neg_counts_cos(i,:) = radht_ed_3_neg_counts.*cos(yi(i).*pi./180);


radht_ed_2_pos_counts = hist(reshape(radht_ed_2_pos_in,[numel(radht_ed_2_pos_in),1]),xbins);
radht_ed_2_pos_counts_cos(i,:) = radht_ed_2_pos_counts.*cos(yi(i).*pi./180);
radht_ed_2_neg_counts = hist(reshape(radht_ed_2_neg_in,[numel(radht_ed_2_neg_in),1]),xbins);
radht_ed_2_neg_counts_cos(i,:) = radht_ed_2_neg_counts.*cos(yi(i).*pi./180);


radht_ed_1_pos_counts = hist(reshape(radht_ed_1_pos_in,[numel(radht_ed_1_pos_in),1]),xbins);
radht_ed_1_pos_counts_cos(i,:) = radht_ed_1_pos_counts.*cos(yi(i).*pi./180);
radht_ed_1_neg_counts = hist(reshape(radht_ed_1_neg_in,[numel(radht_ed_1_neg_in),1]),xbins);
radht_ed_1_neg_counts_cos(i,:) = radht_ed_1_neg_counts.*cos(yi(i).*pi./180);


radht_ed_wide_pos_counts = hist(reshape(radht_ed_wide_pos_in,[numel(radht_ed_wide_pos_in),1]),xbins);
radht_ed_wide_pos_counts_cos(i,:) = radht_ed_wide_pos_counts.*cos(yi(i).*pi./180);
radht_ed_wide_neg_counts = hist(reshape(radht_ed_wide_neg_in,[numel(radht_ed_wide_neg_in),1]),xbins);
radht_ed_wide_neg_counts_cos(i,:) = radht_ed_wide_neg_counts.*cos(yi(i).*pi./180);


end


radht_hist_5_pos = sum(radht_ed_5_pos_counts_cos,1)./sum(sum(radht_ed_5_pos_counts_cos));
radht_hist_5_neg = sum(radht_ed_5_neg_counts_cos,1)./sum(sum(radht_ed_5_neg_counts_cos));

radht_hist_4_pos = sum(radht_ed_4_pos_counts_cos,1)./sum(sum(radht_ed_4_pos_counts_cos));
radht_hist_4_neg = sum(radht_ed_4_neg_counts_cos,1)./sum(sum(radht_ed_4_neg_counts_cos));

radht_hist_3_pos = sum(radht_ed_3_pos_counts_cos,1)./sum(sum(radht_ed_3_pos_counts_cos));
radht_hist_3_neg = sum(radht_ed_3_neg_counts_cos,1)./sum(sum(radht_ed_3_neg_counts_cos));

radht_hist_2_pos = sum(radht_ed_2_pos_counts_cos,1)./sum(sum(radht_ed_2_pos_counts_cos));
radht_hist_2_neg = sum(radht_ed_2_neg_counts_cos,1)./sum(sum(radht_ed_2_neg_counts_cos));

radht_hist_1_pos = sum(radht_ed_1_pos_counts_cos,1)./sum(sum(radht_ed_1_pos_counts_cos));
radht_hist_1_neg = sum(radht_ed_1_neg_counts_cos,1)./sum(sum(radht_ed_1_neg_counts_cos));

radht_hist_wide_pos = sum(radht_ed_wide_pos_counts_cos,1)./sum(sum(radht_ed_wide_pos_counts_cos));
radht_hist_wide_neg = sum(radht_ed_wide_neg_counts_cos,1)./sum(sum(radht_ed_wide_neg_counts_cos));


xbins = -45:0.2:45;

figure
h=bar(xbins,radht_hist_1_pos);
ylim([0 0.15])
xlim([-15 15])
set(gca,'FontSize',15);
xlabel('Radiative heating associated with 0<T''<1, K/day')
ylabel('Probability')
title([num2str(str2num(run)./100) 'e_{s0}'])
print('-dpng',['radht_hist_1pos_' run '.png'])

figure
h=bar(xbins,radht_hist_2_pos);
ylim([0 0.15])
xlim([-15 15])
set(gca,'FontSize',15);
xlabel('Radiative heating associated with 1<T''<2, K/day')
ylabel('Probability')
title([num2str(str2num(run)./100) 'e_{s0}'])
print('-dpng',['radht_hist_2pos_' run '.png'])

figure
h=bar(xbins,radht_hist_3_pos);
ylim([0 0.15])
xlim([-15 15])
set(gca,'FontSize',15);
xlabel('Radiative heating associated with 2<T''<3, K/day')
ylabel('Probability')
title([num2str(str2num(run)./100) 'e_{s0}'])
print('-dpng',['radht_hist_3pos_' run '.png'])

figure
h=bar(xbins,radht_hist_4_pos);
ylim([0 0.15])
xlim([-15 15])
set(gca,'FontSize',15);
xlabel('Radiative heating associated with 3<T''<4, K/day')
ylabel('Probability')
title([num2str(str2num(run)./100) 'e_{s0}'])
print('-dpng',['radht_hist_4pos_' run '.png'])

figure
h=bar(xbins,radht_hist_5_pos);
ylim([0 0.15])
xlim([-15 15])
set(gca,'FontSize',15);
xlabel('Radiative heating associated with 4<T''<5, K/day')
ylabel('Probability')
title([num2str(str2num(run)./100) 'e_{s0}'])
print('-dpng',['radht_hist_5pos_' run '.png'])

figure
h=bar(xbins,radht_hist_wide_pos);
ylim([0 0.15])
xlim([-15 15])
set(gca,'FontSize',15);
xlabel('Radiative heating associated with T''>2, K/day')
ylabel('Probability')
title([num2str(str2num(run)./100) 'e_{s0}'])
print('-dpng',['radht_hist_widepos_' run '.png'])



figure
h=bar(xbins,radht_hist_1_neg);
ylim([0 0.15])
xlim([-15 15])
set(gca,'FontSize',15);
xlabel('Radiative heating associated with -1<T''<0, K/day')
ylabel('Probability')
title([num2str(str2num(run)./100) 'e_{s0}'])
print('-dpng',['radht_hist_1neg_' run '.png'])

figure
h=bar(xbins,radht_hist_2_neg);
ylim([0 0.15])
xlim([-15 15])
set(gca,'FontSize',15);
xlabel('Radiative heating associated with -2<T''<-1, K/day')
ylabel('Probability')
title([num2str(str2num(run)./100) 'e_{s0}'])
print('-dpng',['radht_hist_2neg_' run '.png'])

figure
h=bar(xbins,radht_hist_3_neg);
ylim([0 0.15])
xlim([-15 15])
set(gca,'FontSize',15);
xlabel('Radiative heating associated with -3<T''<-2, K/day')
ylabel('Probability')
title([num2str(str2num(run)./100) 'e_{s0}'])
print('-dpng',['radht_hist_3neg_' run '.png'])

figure
h=bar(xbins,radht_hist_4_neg);
ylim([0 0.15])
xlim([-15 15])
set(gca,'FontSize',15);
xlabel('Radiative heating associated with -4<T''<-3, K/day')
ylabel('Probability')
title([num2str(str2num(run)./100) 'e_{s0}'])
print('-dpng',['radht_hist_4neg_' run '.png'])

figure
h=bar(xbins,radht_hist_5_neg);
ylim([0 0.15])
xlim([-15 15])
set(gca,'FontSize',15);
xlabel('Radiative heating associated with -5<T''<-4, K/day')
ylabel('Probability')
title([num2str(str2num(run)./100) 'e_{s0}'])
print('-dpng',['radht_hist_5neg_' run '.png'])


figure
h=bar(xbins,radht_hist_wide_neg);
ylim([0 0.15])
xlim([-15 15])
set(gca,'FontSize',15);
xlabel('Radiative heating associated with T''<-2, K/day')
ylabel('Probability')
title([num2str(str2num(run)./100) 'e_{s0}'])
print('-dpng',['radht_hist_wideneg_' run '.png'])

out = 'woop';

end
