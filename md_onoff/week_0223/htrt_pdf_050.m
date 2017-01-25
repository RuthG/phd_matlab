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

load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat','t_050')
t_ll = squeeze(cube2latlon(xc,yc,t_050(:,:,5,:),xi,yi));
t_ll_tav = repmat(mean(squeeze(t_ll(:,:,5,:)),3),[1 1 720]);
t_ed_ll = t_ll - t_ll_tav;


warm_mask = (t_ed_ll > 0);
cold_mask = (t_ed_ll < 0);
clear('t_050','t_ll','t_ll_tav')

load('/project/rg312/mat_files/heat_rates.mat','htrt_050','radht_050','difht_050','cndht_050','cnvht_050')
htrt_ll = squeeze(cube2latlon(xc,yc,htrt_050(:,:,5,:),xi,yi));
htrt_ll_tav = repmat(mean(squeeze(htrt_ll(:,:,5,:)),3),[1 1 720]);
htrt_ed_ll = htrt_ll - htrt_ll_tav;
radht_ll = squeeze(cube2latlon(xc,yc,radht_050(:,:,5,:),xi,yi));
radht_ll_tav = repmat(mean(squeeze(radht_ll(:,:,5,:)),3),[1 1 720]);
radht_ed_ll = radht_ll - radht_ll_tav;
difht_ll = squeeze(cube2latlon(xc,yc,difht_050(:,:,5,:),xi,yi));
difht_ll_tav = repmat(mean(squeeze(difht_ll(:,:,5,:)),3),[1 1 720]);
difht_ed_ll = difht_ll - difht_ll_tav;
cndht_ll = squeeze(cube2latlon(xc,yc,cndht_050(:,:,5,:),xi,yi));
cndht_ll_tav = repmat(mean(squeeze(cndht_ll(:,:,5,:)),3),[1 1 720]);
cndht_ed_ll = cndht_ll - cndht_ll_tav;
cnvht_ll = squeeze(cube2latlon(xc,yc,cnvht_050(:,:,5,:),xi,yi));
cnvht_ll_tav = repmat(mean(squeeze(cnvht_ll(:,:,5,:)),3),[1 1 720]);
cnvht_ed_ll = cnvht_ll - cnvht_ll_tav;

htrt_ed_cold = squeeze(cold_mask.*htrt_ed_ll).*86400;
htrt_ed_warm = squeeze(warm_mask.*htrt_ed_ll).*86400;
radht_ed_cold = squeeze(cold_mask.*radht_ed_ll).*86400;
radht_ed_warm = squeeze(warm_mask.*radht_ed_ll).*86400;
difht_ed_cold = squeeze(cold_mask.*difht_ed_ll).*86400;
difht_ed_warm = squeeze(warm_mask.*difht_ed_ll).*86400;
cndht_ed_cold = squeeze(cold_mask.*cndht_ed_ll).*86400;
cndht_ed_warm = squeeze(warm_mask.*cndht_ed_ll).*86400;
cnvht_ed_cold = squeeze(cold_mask.*cnvht_ed_ll).*86400;
cnvht_ed_warm = squeeze(warm_mask.*cnvht_ed_ll).*86400;


xbins=-27:0.5:27;
for i=1:90
htrt_counts_cold(i,:) = hist(reshape(htrt_ed_cold(:,i,:),[1,numel(htrt_ed_cold(:,i,:))]),xbins);
htrt_counts_cold_cos(i,:) = htrt_counts_cold(i,:).*cos(yi(i).*pi./180);
htrt_counts_warm(i,:) = hist(reshape(htrt_ed_warm(:,i,:),[1,numel(htrt_ed_warm(:,i,:))]),xbins);
htrt_counts_warm_cos(i,:) = htrt_counts_warm(i,:).*cos(yi(i).*pi./180);
radht_counts_cold(i,:) = hist(reshape(radht_ed_cold(:,i,:),[1,numel(radht_ed_cold(:,i,:))]),xbins);
radht_counts_cold_cos(i,:) = radht_counts_cold(i,:).*cos(yi(i).*pi./180);
radht_counts_warm(i,:) = hist(reshape(radht_ed_warm(:,i,:),[1,numel(radht_ed_warm(:,i,:))]),xbins);
radht_counts_warm_cos(i,:) = radht_counts_warm(i,:).*cos(yi(i).*pi./180);
difht_counts_cold(i,:) = hist(reshape(difht_ed_cold(:,i,:),[1,numel(difht_ed_cold(:,i,:))]),xbins);
difht_counts_cold_cos(i,:) = difht_counts_cold(i,:).*cos(yi(i).*pi./180);
difht_counts_warm(i,:) = hist(reshape(difht_ed_warm(:,i,:),[1,numel(difht_ed_warm(:,i,:))]),xbins);
difht_counts_warm_cos(i,:) = difht_counts_warm(i,:).*cos(yi(i).*pi./180);
cndht_counts_cold(i,:) = hist(reshape(cndht_ed_cold(:,i,:),[1,numel(cndht_ed_cold(:,i,:))]),xbins);
cndht_counts_cold_cos(i,:) = cndht_counts_cold(i,:).*cos(yi(i).*pi./180);
cndht_counts_warm(i,:) = hist(reshape(cndht_ed_warm(:,i,:),[1,numel(cndht_ed_warm(:,i,:))]),xbins);
cndht_counts_warm_cos(i,:) = cndht_counts_warm(i,:).*cos(yi(i).*pi./180);
cnvht_counts_cold(i,:) = hist(reshape(cnvht_ed_cold(:,i,:),[1,numel(cnvht_ed_cold(:,i,:))]),xbins);
cnvht_counts_cold_cos(i,:) = cnvht_counts_cold(i,:).*cos(yi(i).*pi./180);
cnvht_counts_warm(i,:) = hist(reshape(cnvht_ed_warm(:,i,:),[1,numel(cnvht_ed_warm(:,i,:))]),xbins);
cnvht_counts_warm_cos(i,:) = cnvht_counts_warm(i,:).*cos(yi(i).*pi./180);
end

htrt_counts_warm_hist = sum(htrt_counts_warm_cos,1)./sum(sum(htrt_counts_warm_cos));
htrt_counts_cold_hist = sum(htrt_counts_cold_cos,1)./sum(sum(htrt_counts_cold_cos));
radht_counts_warm_hist = sum(radht_counts_warm_cos,1)./sum(sum(radht_counts_warm_cos));
radht_counts_cold_hist = sum(radht_counts_cold_cos,1)./sum(sum(radht_counts_cold_cos));
difht_counts_warm_hist = sum(difht_counts_warm_cos,1)./sum(sum(difht_counts_warm_cos));
difht_counts_cold_hist = sum(difht_counts_cold_cos,1)./sum(sum(difht_counts_cold_cos));
cndht_counts_warm_hist = sum(cndht_counts_warm_cos,1)./sum(sum(cndht_counts_warm_cos));
cndht_counts_cold_hist = sum(cndht_counts_cold_cos,1)./sum(sum(cndht_counts_cold_cos));
cnvht_counts_warm_hist = sum(cnvht_counts_warm_cos,1)./sum(sum(cnvht_counts_warm_cos));
cnvht_counts_cold_hist = sum(cnvht_counts_cold_cos,1)./sum(sum(cnvht_counts_cold_cos));


xbins=-27:0.5:27;
figure
bar(xbins,htrt_counts_warm_hist);
ylim([0 1])
xlim([-27 27])
xlabel('Total eddy diabatic heating, K/day')
ylabel('Probability')
title('PDF of eddy diabatic heating associated with warm sector, 0.5 e_{s0}')
print('-dpng','warm_htrt_pdf_050.png')


xbins=-27:0.5:27;
figure
bar(xbins,htrt_counts_cold_hist);
ylim([0 1])
xlim([-27 27])
xlabel('Total eddy diabatic heating, K/day')
ylabel('Probability')
title('PDF of eddy diabatic heating associated with cold sector, 0.5 e_{s0}')
print('-dpng','cold_htrt_pdf_050.png')

xbins=-27:0.5:27;
figure
bar(xbins,radht_counts_warm_hist);
ylim([0 1])
xlim([-27 27])
xlabel('Total eddy radiative heating, K/day')
ylabel('Probability')
title('PDF of eddy diabatic heating associated with warm sector, 0.5 e_{s0}')
print('-dpng','warm_radht_pdf_050.png')


xbins=-27:0.5:27;
figure
bar(xbins,radht_counts_cold_hist);
ylim([0 1])
xlim([-27 27])
xlabel('Total eddy radiative heating, K/day')
ylabel('Probability')
title('PDF of eddy diabatic heating associated with cold sector, 0.5 e_{s0}')
print('-dpng','cold_radht_pdf_050.png')

xbins=-27:0.5:27;
figure
bar(xbins,difht_counts_warm_hist);
ylim([0 1])
xlim([-27 27])
xlabel('Total eddy diffusive heating, K/day')
ylabel('Probability')
title('PDF of eddy diabatic heating associated with warm sector, 0.5 e_{s0}')
print('-dpng','warm_difht_pdf_050.png')


xbins=-27:0.5:27;
figure
bar(xbins,difht_counts_cold_hist);
ylim([0 1])
xlim([-27 27])
xlabel('Total eddy diffusive heating, K/day')
ylabel('Probability')
title('PDF of eddy diabatic heating associated with cold sector, 0.5 e_{s0}')
print('-dpng','cold_difht_pdf_050.png')

xbins=-27:0.5:27;
figure
bar(xbins,cndht_counts_warm_hist);
ylim([0 1])
xlim([-27 27])
xlabel('Total eddy large-scale heating, K/day')
ylabel('Probability')
title('PDF of eddy diabatic heating associated with warm sector, 0.5 e_{s0}')
print('-dpng','warm_cndht_pdf_050.png')


xbins=-27:0.5:27;
figure
bar(xbins,cndht_counts_cold_hist);
ylim([0 1])
xlim([-27 27])
xlabel('Total eddy large-scale heating, K/day')
ylabel('Probability')
title('PDF of eddy diabatic heating associated with cold sector, 0.5 e_{s0}')
print('-dpng','cold_cndht_pdf_050.png')

xbins=-27:0.5:27;
figure
bar(xbins,cnvht_counts_warm_hist);
ylim([0 1])
xlim([-27 27])
xlabel('Total eddy convective heating, K/day')
ylabel('Probability')
title('PDF of eddy diabatic heating associated with warm sector, 0.5 e_{s0}')
print('-dpng','warm_cnvht_pdf_050.png')


xbins=-27:0.5:27;
figure
bar(xbins,cnvht_counts_cold_hist);
ylim([0 1])
xlim([-27 27])
xlabel('Total eddy convective heating, K/day')
ylabel('Probability')
title('PDF of eddy diabatic heating associated with cold sector, 0.5 e_{s0}')
print('-dpng','cold_cnvht_pdf_050.png')

