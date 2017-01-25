%load in heat budget data
%plot a histogram for the terms in the heat budget, look for any big assymetries in heating and cooling



rDir='/project/rg312/wv_on_rad_off/run_100_best/';
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

%load up 000 snapshots and calculate eddy quantities

load('/project/rg312/mat_files/heat_rates_best.mat','htrt_100')
htrt_100_ll = squeeze(cube2latlon(xc,yc,htrt_100(:,:,5,1:719),xi,yi)).*86400;
htrt_100_ll_tav = repmat(mean(htrt_100_ll,3),[1 1 719]);
htrt_ed_100_ll = htrt_100_ll - htrt_100_ll_tav;
clear('htrt_100')

load('/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat','theta_100')
theta_100_ll = squeeze(cube2latlon(xc,yc,theta_100(:,:,:,1:719),xi,yi));
theta_100_ll_tav = repmat(mean(theta_100_ll,4),[1 1 1 719]);
theta_ed_100_ll = theta_100_ll - theta_100_ll_tav;
clear('theta_100')

load('/project/rg312/mat_files/snapshot_data/uE_snapshots_best.mat','uE_100')
uE_100_ll = squeeze(cube2latlon(xc,yc,uE_100(:,:,5,1:719),xi,yi));
uE_100_ll_tav = repmat(mean(uE_100_ll,3),[1 1 719]);
uE_ed_100_ll = uE_100_ll - uE_100_ll_tav;
clear('uE_100')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_100')
vN_100_ll = squeeze(cube2latlon(xc,yc,vN_100(:,:,5,1:719),xi,yi));
vN_100_ll_tav = repmat(mean(vN_100_ll,3),[1 1 719]);
vN_ed_100_ll = vN_100_ll - vN_100_ll_tav;
clear('vN_100')

load('/project/rg312/mat_files/snapshot_data/w_snapshots_best.mat','w_100')
%interpolate first
w_100_half = zeros(192,32,26,719);
w_100_half(:,:,1:25,:) = w_100(:,:,:,1:719);
rC_half = (100000:-4000:0)';

w_100_plev = shiftdim(interp1(rC_half,shiftdim(w_100_half,2),rC),2);

w_100_ll = squeeze(cube2latlon(xc,yc,w_100(:,:,:,1:719),xi,yi));
w_100_ll_tav = repmat(mean(w_100_ll,4),[1 1 1 719]);
w_ed_100_ll = w_100_ll - w_100_ll_tav;


radius = 6371.0e3;

[dtheta_ed_dy_100,dtheta_ed_dx_100,dtheta_ed_dp_100] = gradient(theta_ed_100_ll,pi./90,pi./90,-4000,1);
dtheta_ed_dy_100 = dtheta_ed_dy_100./radius;

[dthetady_100_tav,dthetadx_100_tav,dthetadp_100_tav] = gradient(theta_100_ll_tav,pi./90,pi./90,-4000,1);
dthetady_100_tav = dthetady_100_tav./radius;

for i=1:90
dtheta_ed_dx_100(:,i,:,:) = dtheta_ed_dx_100(:,i,:,:)./cos(yi(i).*pi./180)./radius;
dthetadx_100_tav(:,i,:,:) = dthetadx_100_tav(:,i,:,:)./cos(yi(i).*pi./180)./radius;
end

udtheta_ed_dx_100 = -uE_100_ll_tav.*squeeze(dtheta_ed_dx_100(:,:,5,:)).*86400;
vdtheta_ed_dy_100 = -vN_100_ll_tav.*squeeze(dtheta_ed_dx_100(:,:,5,:)).*86400;
wdtheta_ed_dp_100 = -squeeze(w_100_ll_tav(:,:,5,:).*dtheta_ed_dp_100(:,:,5,:)).*86400;

u_ed_dthetadx_100 = -uE_ed_100_ll.*squeeze(dthetadx_100_tav(:,:,5,:)).*86400;
v_ed_dthetady_100 = -vN_ed_100_ll.*squeeze(dthetady_100_tav(:,:,5,:)).*86400;
w_ed_dthetadp_100 = -squeeze(w_ed_100_ll(:,:,5,:).*dthetadp_100_tav(:,:,5,:)).*86400;

total_ed_ttend_guess = htrt_ed_100_ll + udtheta_ed_dx_100 + vdtheta_ed_dy_100 + wdtheta_ed_dp_100 + u_ed_dthetadx_100 + v_ed_dthetady_100 + w_ed_dthetadp_100;

total_adv_heat = udtheta_ed_dx_100 + vdtheta_ed_dy_100 + wdtheta_ed_dp_100 + u_ed_dthetadx_100 + v_ed_dthetady_100 + w_ed_dthetadp_100;

htrt_o_theta = htrt_ed_100_ll./squeeze(theta_ed_100_ll(:,:,5,:));

for i=1:90
%include lat weighting too
i
xbins = -25:0.5:15;
total_ed_ttend_counts = hist(reshape(total_ed_ttend_guess,[numel(total_ed_ttend_guess),1]),xbins);
total_ed_ttend_counts_cos(i,:) = total_ed_ttend_counts.*cos(yi(i).*pi./180);

xbins = -33:0.5:14;
htrt_ed_counts = hist(reshape(htrt_ed_100_ll,[numel(htrt_ed_100_ll),1]),xbins);
htrt_ed_counts_cos(i,:) = htrt_ed_counts.*cos(yi(i).*pi./180);

xbins = -13:0.13:13;
udtheta_ed_counts = hist(reshape(udtheta_ed_dx_100,[numel(udtheta_ed_dx_100),1]),xbins);
udtheta_ed_counts_cos(i,:) = udtheta_ed_counts.*cos(yi(i).*pi./180);

xbins = -3:0.03:3;
vdtheta_ed_counts = hist(reshape(vdtheta_ed_dy_100,[numel(vdtheta_ed_dy_100),1]),xbins);
vdtheta_ed_counts_cos(i,:) = vdtheta_ed_counts.*cos(yi(i).*pi./180);

xbins = -2:0.02:2;
wdtheta_ed_counts = hist(reshape(wdtheta_ed_dp_100,[numel(wdtheta_ed_dp_100),1]),xbins);
wdtheta_ed_counts_cos(i,:) = wdtheta_ed_counts.*cos(yi(i).*pi./180);

xbins = -1.04:0.01:1;
u_ed_dthetadx_counts = hist(reshape(u_ed_dthetadx_100,[numel(u_ed_dthetadx_100),1]),xbins);
u_ed_dthetadx_counts_cos(i,:) = u_ed_dthetadx_counts.*cos(yi(i).*pi./180);

xbins = -13:0.13:13;
v_ed_dthetady_counts = hist(reshape(v_ed_dthetady_100,[numel(v_ed_dthetady_100),1]),xbins);
v_ed_dthetady_counts_cos(i,:) = v_ed_dthetady_counts.*cos(yi(i).*pi./180);

xbins = -20:0.2:20;
w_ed_dthetadp_counts = hist(reshape(w_ed_dthetadp_100,[numel(w_ed_dthetadp_100),1]),xbins);
w_ed_dthetadp_counts_cos(i,:) = w_ed_dthetadp_counts.*cos(yi(i).*pi./180);

end

total_ed_ttend_hist = sum(total_ed_ttend_counts_cos,1)./sum(sum(total_ed_ttend_counts_cos));

htrt_hist = sum(htrt_ed_counts_cos,1)./sum(sum(htrt_ed_counts_cos));

udtheta_ed_hist = sum(udtheta_ed_counts_cos,1)./sum(sum(udtheta_ed_counts_cos));
vdtheta_ed_hist = sum(vdtheta_ed_counts_cos,1)./sum(sum(vdtheta_ed_counts_cos));
wdtheta_ed_hist = sum(wdtheta_ed_counts_cos,1)./sum(sum(wdtheta_ed_counts_cos));

u_ed_dthetadx_hist = sum(u_ed_dthetadx_counts_cos,1)./sum(sum(u_ed_dthetadx_counts_cos));
v_ed_dthetady_hist = sum(v_ed_dthetady_counts_cos,1)./sum(sum(v_ed_dthetady_counts_cos));
w_ed_dthetadp_hist = sum(w_ed_dthetadp_counts_cos,1)./sum(sum(w_ed_dthetadp_counts_cos));

figure
plot(-25:0.5:15,total_ed_ttend_hist)
xlabel('Total T tendency calc, K/day')
ylabel('Probability')
print('-dpng','ttend_hist_100.png')

figure
plot(-33:0.5:14,htrt_hist)
xlabel('Total diabatic heating, K/day')
ylabel('Probability')
print('-dpng','htrt_hist_100.png')

figure
plot(-13:0.13:13,udtheta_ed_hist)
xlabel('<u>d\Theta''/dx, K/day')
ylabel('Probability')
print('-dpng','udthetapdx_hist_100.png')

figure
plot(-13:0.13:13,v_ed_dthetady_hist)
xlabel('v''d\Theta/dy, K/day')
ylabel('Probability')
print('-dpng','vpdthetady_hist_100.png')

figure
plot(-20:0.2:20,w_ed_dthetadp_hist)
xlabel('w''d\Theta/dp, K/day')
ylabel('Probability')
print('-dpng','wpdthetadp_hist_100.png')

save('/project/rg312/mat_files/heatbudg_100.mat')

return



vt_ed_ll = t_ed_ll.*vN_ed_ll;
vt_ed_ll(:,1:45,:) = -1.*vt_ed_ll(:,1:45,:);
vt_ed_series = reshape(vt_ed_ll,[numel(vt_ed_ll),1]);
t_ed_series = reshape(t_ed_ll,[numel(t_ed_ll),1]);

%find 95% threshold for v't'
xbins = -300:5:400;
[vt_dist,vt_val] = hist(vt_ed_series,xbins);
vt_sum = cumsum(vt_dist)./sum(vt_dist);
thresh_loc = min(find(vt_sum>=0.95));
vt_thresh = vt_val(thresh_loc);
vt_mask = +(vt_ed_series > vt_thresh);

t_neg_mask = +(t_ed_series < 0);
t_pos_mask = +(t_ed_series > 0);

vt_ed_series_masked_neg = t_neg_mask.*vt_ed_series; 
vt_ed_series_masked_neg(t_neg_mask==0) = [];
[vt_dist_neg,vt_val_neg] = hist(vt_ed_series_masked_neg,xbins);

vt_ed_series_masked_pos = t_pos_mask.*vt_ed_series; 
vt_ed_series_masked_pos(t_pos_mask==0) = [];
[vt_dist_pos,vt_val_pos] = hist(vt_ed_series_masked_pos,xbins);

vt_ed_series_95 = vt_ed_series.*vt_mask;
vt_ed_series_95(isnan(vt_ed_series_95)) = [];
vt_ed_series_95_neg = t_neg_mask.*vt_ed_series.*vt_mask;
vt_ed_series_95_neg(isnan(vt_ed_series_95_neg)) = [];
vt_ed_series_95_pos = t_pos_mask.*vt_ed_series.*vt_mask;
vt_ed_series_95_pos(isnan(vt_ed_series_95_pos)) = [];

sum(vt_ed_series_95)
sum(vt_ed_series_95_neg)./sum(vt_ed_series_95)
sum(vt_ed_series_95_pos)./sum(vt_ed_series_95)



