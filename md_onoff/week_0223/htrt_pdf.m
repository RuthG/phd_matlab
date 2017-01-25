%produce pdf of heat rate magnitude in warm and cold sectors of storms

rDir='/project/rg312/wv_on_rad_off/run_doshallower00/';
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

%read in t and heatrate data
%calculate t'
%plot heatrate dist where t' +ve and -ve to start. Weight count with area to account for lat

load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat','t_000','t_100')
t_000_ll = squeeze(cube2latlon(xc,yc,t_000(:,:,5,:),xi,yi));
t_000_ll_tav = repmat(mean(squeeze(t_000_ll(:,:,5,:)),3),[1 1 720]);
t_ed_000_ll = t_000_ll - t_000_ll_tav;
t_100_ll = squeeze(cube2latlon(xc,yc,t_100(:,:,5,:),xi,yi));
t_100_ll_tav = repmat(mean(squeeze(t_100_ll(:,:,5,:)),3),[1 1 720]);
t_ed_100_ll = t_100_ll - t_100_ll_tav;

warm_mask_000 = (t_ed_000_ll > 0);
cold_mask_000 = (t_ed_000_ll < 0);
warm_mask_100 = (t_ed_100_ll > 0);
cold_mask_100 = (t_ed_100_ll < 0);
clear('t_000','t_000_ll','t_000_ll_tav','t_100','t_100_ll','t_100_ll_tav')

load('/project/rg312/mat_files/heat_rates.mat','htrt_000','htrt_100')
htrt_000_ll = squeeze(cube2latlon(xc,yc,htrt_000(:,:,5,:),xi,yi));
htrt_000_ll_tav = repmat(mean(squeeze(htrt_000_ll(:,:,5,:)),3),[1 1 720]);
htrt_ed_000_ll = htrt_000_ll - htrt_000_ll_tav;
htrt_100_ll = squeeze(cube2latlon(xc,yc,htrt_100(:,:,5,:),xi,yi));
htrt_100_ll_tav = repmat(mean(squeeze(htrt_100_ll(:,:,5,:)),3),[1 1 720]);
htrt_ed_100_ll = htrt_100_ll - htrt_100_ll_tav;

htrt_ed_cold_000 = squeeze(cold_mask_000.*htrt_ed_000_ll).*86400;
htrt_ed_warm_000 = squeeze(warm_mask_000.*htrt_ed_000_ll).*86400;
htrt_ed_cold_100 = squeeze(cold_mask_100.*htrt_ed_100_ll).*86400;
htrt_ed_warm_100 = squeeze(warm_mask_100.*htrt_ed_100_ll).*86400;

xbins=-27:1:27;
for i=1:90
counts_cold_000(i,:) = hist(reshape(htrt_ed_cold_000(:,i,:),[1,numel(htrt_ed_cold_000(:,i,:))]),xbins);
counts_cold_cos_000(i,:) = counts_cold_000(i,:).*cos(yi(i).*pi./180);
counts_warm_000(i,:) = hist(reshape(htrt_ed_warm_000(:,i,:),[1,numel(htrt_ed_warm_000(:,i,:))]),xbins);
counts_warm_cos_000(i,:) = counts_warm_000(i,:).*cos(yi(i).*pi./180);

counts_cold_100(i,:) = hist(reshape(htrt_ed_cold_100(:,i,:),[1,numel(htrt_ed_cold_100(:,i,:))]),xbins);
counts_cold_cos_100(i,:) = counts_cold_100(i,:).*cos(yi(i).*pi./180);
counts_warm_100(i,:) = hist(reshape(htrt_ed_warm_100(:,i,:),[1,numel(htrt_ed_warm_100(:,i,:))]),xbins);
counts_warm_cos_100(i,:) = counts_warm_100(i,:).*cos(yi(i).*pi./180);
end

counts_warm_hist_000 = sum(counts_warm_cos_000,1)./sum(sum(counts_warm_cos_000));
counts_cold_hist_000 = sum(counts_cold_cos_000,1)./sum(sum(counts_cold_cos_000));

counts_warm_hist_100 = sum(counts_warm_cos_100,1)./sum(sum(counts_warm_cos_100));
counts_cold_hist_100 = sum(counts_cold_cos_100,1)./sum(sum(counts_cold_cos_100));


xbins=-27:1:27;
figure
bar(xbins,counts_warm_hist_000);
ylim([0 1])
xlim([-27 27])
xlabel('Total eddy diabatic heating, K/day')
ylabel('Probability')
title('PDF of eddy diabatic heating associated with warm sector, 0.0 e_{s0}')
print('-dpng','warm_htrt_pdf_000.png')


xbins=-27:1:27;
figure
bar(xbins,counts_cold_hist_000);
ylim([0 1])
xlim([-27 27])
xlabel('Total eddy diabatic heating, K/day')
ylabel('Probability')
title('PDF of eddy diabatic heating associated with cold sector, 0.0 e_{s0}')
print('-dpng','cold_htrt_pdf_000.png')



xbins=-27:1:27;
figure
bar(xbins,counts_warm_hist_100);
ylim([0 1])
xlim([-27 27])
xlabel('Total eddy diabatic heating, K/day')
ylabel('Probability')
title('PDF of eddy diabatic heating associated with warm sector, 1.0 e_{s0}')
print('-dpng','warm_htrt_pdf_100.png')


xbins=-27:1:27;
figure
bar(xbins,counts_cold_hist_100);
ylim([0 1])
xlim([-27 27])
xlabel('Total eddy diabatic heating, K/day')
ylabel('Probability')
title('PDF of eddy diabatic heating associated with cold sector, 1.0 e_{s0}')
print('-dpng','cold_htrt_pdf_100.png')
