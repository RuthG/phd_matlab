%function to load up cnvhts and produce area weighted histograms from this

function out = cnvht_tfiltered_hists_allevs_fun(run,lev)

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
cnvht_var = ['cnvht_' run];
t_var = ['t_' run];

cnvht_cs = load('/project/rg312/mat_files/heat_rates_best.mat',cnvht_var);
cnvht_cs = cnvht_cs.(cnvht_var);
cnvht_ll = squeeze(cube2latlon(xc,yc,cnvht_cs(:,:,lev,1:719),xi,yi)).*86400;
cnvht_ll_tav = repmat(mean(cnvht_ll,3),[1 1 719]);
cnvht_ed_ll = cnvht_ll - cnvht_ll_tav;
clear cnvht_cs

t_cs = load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat',t_var);
t_cs = t_cs.(t_var);
t_ll = squeeze(cube2latlon(xc,yc,t_cs(:,:,lev,1:719),xi,yi));
t_ll_tav = repmat(mean(t_ll,3),[1 1 719]);
t_ed_ll = t_ll - t_ll_tav;
clear t_cs


%define masks

t_mask_wide_pos = +(t_ed_ll > 2);
t_mask_wide_neg = +(t_ed_ll < -2);
cnvht_ed_wide_pos = cnvht_ed_ll.*t_mask_wide_pos;
cnvht_ed_wide_neg = cnvht_ed_ll.*t_mask_wide_neg;


for i=1:90
%include lat weighting too
i
xbins = -45:0.2:45;

%for each T range bin data at each latitude and weight bin contribution by area (i.e. cos(lat))
%select lat to look at for masked plots, and empty out 0 (i.e. masked) elements

cnvht_ed_wide_pos_in = cnvht_ed_wide_pos(:,i,:);
cnvht_ed_wide_pos_in(cnvht_ed_wide_pos_in == 0) =[];
cnvht_ed_wide_neg_in = cnvht_ed_wide_neg(:,i,:);
cnvht_ed_wide_neg_in(cnvht_ed_wide_neg_in == 0) =[];

cnvht_ed_wide_pos_counts = hist(reshape(cnvht_ed_wide_pos_in,[numel(cnvht_ed_wide_pos_in),1]),xbins);
cnvht_ed_wide_pos_counts_cos(i,:) = cnvht_ed_wide_pos_counts.*cos(yi(i).*pi./180);
cnvht_ed_wide_neg_counts = hist(reshape(cnvht_ed_wide_neg_in,[numel(cnvht_ed_wide_neg_in),1]),xbins);
cnvht_ed_wide_neg_counts_cos(i,:) = cnvht_ed_wide_neg_counts.*cos(yi(i).*pi./180);

end

cnvht_hist_wide_pos = sum(cnvht_ed_wide_pos_counts_cos,1)./sum(sum(cnvht_ed_wide_pos_counts_cos));
cnvht_hist_wide_neg = sum(cnvht_ed_wide_neg_counts_cos,1)./sum(sum(cnvht_ed_wide_neg_counts_cos));


xbins = -45:0.2:45;

figure
h=bar(xbins,cnvht_hist_wide_pos);
ylim([0 0.15])
xlim([-15 15])
set(gca,'FontSize',15);
xlabel('Convective heating associated with T''>2, K/day')
ylabel('Probability')
title([num2str(str2num(run)./100) 'e_{s0}'])
print('-dpng',['cnvht_hist_widepos_' run '_l' num2str(lev) '.png'])


figure
h=bar(xbins,cnvht_hist_wide_neg);
ylim([0 0.15])
xlim([-15 15])
set(gca,'FontSize',15);
xlabel('Convective heating associated with T''<-2, K/day')
ylabel('Probability')
title([num2str(str2num(run)./100) 'e_{s0}'])
print('-dpng',['cnvht_hist_wideneg_' run '_l' num2str(lev) '.png'])

out = 'woop';

end
