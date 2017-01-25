%function to load up advts and produce area weighted histograms from this

function out = diabatic_tfiltered_hists_allevs_fun(run,lev)

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
htrt_var = ['htrt_' run];
t_var = ['t_' run];
tott_var = ['totttend_snap_' run];

tott_cs = load(['/project/rg312/mat_files/totttend_' run '_best.mat'],tott_var);
tott_cs = tott_cs.(tott_var);
totttend_ll = squeeze(cube2latlon(xc,yc,tott_cs(:,:,lev,1:719),xi,yi));
totttend_ll_tav = repmat(mean(totttend_ll,3),[1 1 719]);
totttend_ed_ll = totttend_ll - totttend_ll_tav;
clear tott_cs

htrt_cs = load('/project/rg312/mat_files/heat_rates_best.mat',htrt_var);
htrt_cs = htrt_cs.(htrt_var);
htrt_ll = squeeze(cube2latlon(xc,yc,htrt_cs(:,:,lev,1:719),xi,yi)).*86400;
htrt_ll_tav = repmat(mean(htrt_ll,3),[1 1 719]);
htrt_ed_ll = htrt_ll - htrt_ll_tav;
clear htrt_cs

advt_ed_ll = totttend_ed_ll - htrt_ed_ll;

t_cs = load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat',t_var);
t_cs = t_cs.(t_var);
t_ll = squeeze(cube2latlon(xc,yc,t_cs(:,:,lev,1:719),xi,yi));
t_ll_tav = repmat(mean(t_ll,3),[1 1 719]);
t_ed_ll = t_ll - t_ll_tav;
clear t_cs


%define masks

t_mask_wide_pos = +(t_ed_ll > 2);
t_mask_wide_neg = +(t_ed_ll < -2);
advt_ed_wide_pos = advt_ed_ll.*t_mask_wide_pos;
advt_ed_wide_neg = advt_ed_ll.*t_mask_wide_neg;


for i=1:90
%include lat weighting too
i
xbins = -45:0.2:45;

%for each T range bin data at each latitude and weight bin contribution by area (i.e. cos(lat))
%select lat to look at for masked plots, and empty out 0 (i.e. masked) elements

advt_ed_wide_pos_in = advt_ed_wide_pos(:,i,:);
advt_ed_wide_pos_in(advt_ed_wide_pos_in == 0) =[];
advt_ed_wide_neg_in = advt_ed_wide_neg(:,i,:);
advt_ed_wide_neg_in(advt_ed_wide_neg_in == 0) =[];

advt_ed_wide_pos_counts = hist(reshape(advt_ed_wide_pos_in,[numel(advt_ed_wide_pos_in),1]),xbins);
advt_ed_wide_pos_counts_cos(i,:) = advt_ed_wide_pos_counts.*cos(yi(i).*pi./180);
advt_ed_wide_neg_counts = hist(reshape(advt_ed_wide_neg_in,[numel(advt_ed_wide_neg_in),1]),xbins);
advt_ed_wide_neg_counts_cos(i,:) = advt_ed_wide_neg_counts.*cos(yi(i).*pi./180);


end

advt_hist_wide_pos = sum(advt_ed_wide_pos_counts_cos,1)./sum(sum(advt_ed_wide_pos_counts_cos));
advt_hist_wide_neg = sum(advt_ed_wide_neg_counts_cos,1)./sum(sum(advt_ed_wide_neg_counts_cos));


xbins = -45:0.2:45;

figure
h=bar(xbins,advt_hist_wide_pos);
ylim([0 0.15])
xlim([-15 15])
set(gca,'FontSize',15);
xlabel('Advective \Theta tendency associated with T''>2, K/day')
ylabel('Probability')
title([num2str(str2num(run)./100) 'e_{s0}'])
print('-dpng',['advt_pos/' run '/advt_hist_widepos_' run '_l' num2str(lev) '.png'])

figure
h=bar(xbins,advt_hist_wide_neg);
ylim([0 0.15])
xlim([-15 15])
set(gca,'FontSize',15);
xlabel('Advective \Theta tendency associated with T''<-2, K/day')
ylabel('Probability')
title([num2str(str2num(run)./100) 'e_{s0}'])
print('-dpng',['advt_neg/' run '/advt_hist_wideneg_' run '_l' num2str(lev) '.png'])

out = 'woop';

close all
end
