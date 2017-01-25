%load in total tendency and subtract diabatic tendency to get advective part
%can't because not done totttend for dry yet. Balls.


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

load('/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat','theta_100')
theta_100_ll = squeeze(cube2latlon(xc,yc,theta_100(:,:,:,1:719),xi,yi));
theta_100_ll_tav = repmat(mean(theta_100_ll,4),[1 1 1 719]);
theta_ed_100_ll = theta_100_ll - theta_100_ll_tav;
clear('theta_100')

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_100')
t_100_ll = squeeze(cube2latlon(xc,yc,t_100(:,:,5,1:719),xi,yi));
t_100_ll_tav = repmat(mean(t_100_ll,3),[1 1 719]);
t_ed_100_ll = t_100_ll - t_100_ll_tav;
clear('t_100')

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

total_adv_heat = udtheta_ed_dx_100 + vdtheta_ed_dy_100 + wdtheta_ed_dp_100 + u_ed_dthetadx_100 + v_ed_dthetady_100 + w_ed_dthetadp_100;

%masking: do total, udtheta'dx, v'dthetady, w'dthetadp

t_mask_5_pos = +(t_ed_100_ll >= 4 & t_ed_100_ll <= 5);
t_mask_5_neg = +(t_ed_100_ll >= -5 & t_ed_100_ll <= -4);

totadv_ed_100_5_pos = total_adv_heat.*t_mask_5_pos;
totadv_ed_100_5_pos(totadv_ed_100_5_pos == 0) =[];
totadv_ed_100_5_neg = total_adv_heat.*t_mask_5_neg;
totadv_ed_100_5_neg(totadv_ed_100_5_neg == 0) =[];

uht_100_5_pos = udtheta_ed_dx_100.*t_mask_5_pos;
uht_100_5_pos(uht_100_5_pos == 0) =[];
uht_100_5_neg = udtheta_ed_dx_100.*t_mask_5_neg;
uht_100_5_neg(uht_100_5_neg == 0) =[];

vht_100_5_pos = v_ed_dthetady_100.*t_mask_5_pos;
vht_100_5_pos(vht_100_5_pos == 0) =[];
vht_100_5_neg = v_ed_dthetady_100.*t_mask_5_neg;
vht_100_5_neg(vht_100_5_neg == 0) =[];

wht_100_5_pos = w_ed_dthetadp_100.*t_mask_5_pos;
wht_100_5_pos(wht_100_5_pos == 0) =[];
wht_100_5_neg = w_ed_dthetadp_100.*t_mask_5_neg;
wht_100_5_neg(wht_100_5_neg == 0) =[];


t_mask_4_pos = +(t_ed_100_ll >= 3 & t_ed_100_ll <= 4);
t_mask_4_neg = +(t_ed_100_ll >= -4 & t_ed_100_ll <= -3);

totadv_ed_100_4_pos = total_adv_heat.*t_mask_4_pos;
totadv_ed_100_4_pos(totadv_ed_100_4_pos == 0) =[];
totadv_ed_100_4_neg = total_adv_heat.*t_mask_4_neg;
totadv_ed_100_4_neg(totadv_ed_100_4_neg == 0) =[];

uht_100_4_pos = udtheta_ed_dx_100.*t_mask_4_pos;
uht_100_4_pos(uht_100_4_pos == 0) =[];
uht_100_4_neg = udtheta_ed_dx_100.*t_mask_4_neg;
uht_100_4_neg(uht_100_4_neg == 0) =[];

vht_100_4_pos = v_ed_dthetady_100.*t_mask_4_pos;
vht_100_4_pos(vht_100_4_pos == 0) =[];
vht_100_4_neg = v_ed_dthetady_100.*t_mask_4_neg;
vht_100_4_neg(vht_100_4_neg == 0) =[];

wht_100_4_pos = w_ed_dthetadp_100.*t_mask_4_pos;
wht_100_4_pos(wht_100_4_pos == 0) =[];
wht_100_4_neg = w_ed_dthetadp_100.*t_mask_4_neg;
wht_100_4_neg(wht_100_4_neg == 0) =[];


t_mask_3_pos = +(t_ed_100_ll >= 2 & t_ed_100_ll <= 3);
t_mask_3_neg = +(t_ed_100_ll >= -3 & t_ed_100_ll <= -2);

totadv_ed_100_3_pos = total_adv_heat.*t_mask_3_pos;
totadv_ed_100_3_pos(totadv_ed_100_3_pos == 0) =[];
totadv_ed_100_3_neg = total_adv_heat.*t_mask_3_neg;
totadv_ed_100_3_neg(totadv_ed_100_3_neg == 0) =[];

uht_100_3_pos = udtheta_ed_dx_100.*t_mask_3_pos;
uht_100_3_pos(uht_100_3_pos == 0) =[];
uht_100_3_neg = udtheta_ed_dx_100.*t_mask_3_neg;
uht_100_3_neg(uht_100_3_neg == 0) =[];

vht_100_3_pos = v_ed_dthetady_100.*t_mask_3_pos;
vht_100_3_pos(vht_100_3_pos == 0) =[];
vht_100_3_neg = v_ed_dthetady_100.*t_mask_3_neg;
vht_100_3_neg(vht_100_3_neg == 0) =[];

wht_100_3_pos = w_ed_dthetadp_100.*t_mask_3_pos;
wht_100_3_pos(wht_100_3_pos == 0) =[];
wht_100_3_neg = w_ed_dthetadp_100.*t_mask_3_neg;
wht_100_3_neg(wht_100_3_neg == 0) =[];


t_mask_2_pos = +(t_ed_100_ll >= 1 & t_ed_100_ll <= 2);
t_mask_2_neg = +(t_ed_100_ll >= -2 & t_ed_100_ll <= -1);

totadv_ed_100_2_pos = total_adv_heat.*t_mask_2_pos;
totadv_ed_100_2_pos(totadv_ed_100_2_pos == 0) =[];
totadv_ed_100_2_neg = total_adv_heat.*t_mask_2_neg;
totadv_ed_100_2_neg(totadv_ed_100_2_neg == 0) =[];

uht_100_2_pos = udtheta_ed_dx_100.*t_mask_2_pos;
uht_100_2_pos(uht_100_2_pos == 0) =[];
uht_100_2_neg = udtheta_ed_dx_100.*t_mask_2_neg;
uht_100_2_neg(uht_100_2_neg == 0) =[];

vht_100_2_pos = v_ed_dthetady_100.*t_mask_2_pos;
vht_100_2_pos(vht_100_2_pos == 0) =[];
vht_100_2_neg = v_ed_dthetady_100.*t_mask_2_neg;
vht_100_2_neg(vht_100_2_neg == 0) =[];

wht_100_2_pos = w_ed_dthetadp_100.*t_mask_2_pos;
wht_100_2_pos(wht_100_2_pos == 0) =[];
wht_100_2_neg = w_ed_dthetadp_100.*t_mask_2_neg;
wht_100_2_neg(wht_100_2_neg == 0) =[];


t_mask_1_pos = +(t_ed_100_ll >= 0 & t_ed_100_ll <= 1);
t_mask_1_neg = +(t_ed_100_ll >= -1 & t_ed_100_ll <= 0);

totadv_ed_100_1_pos = total_adv_heat.*t_mask_1_pos;
totadv_ed_100_1_pos(totadv_ed_100_1_pos == 0) =[];
totadv_ed_100_1_neg = total_adv_heat.*t_mask_1_neg;
totadv_ed_100_1_neg(totadv_ed_100_1_neg == 0) =[];

uht_100_1_pos = udtheta_ed_dx_100.*t_mask_1_pos;
uht_100_1_pos(uht_100_1_pos == 0) =[];
uht_100_1_neg = udtheta_ed_dx_100.*t_mask_1_neg;
uht_100_1_neg(uht_100_1_neg == 0) =[];

vht_100_1_pos = v_ed_dthetady_100.*t_mask_1_pos;
vht_100_1_pos(vht_100_1_pos == 0) =[];
vht_100_1_neg = v_ed_dthetady_100.*t_mask_1_neg;
vht_100_1_neg(vht_100_1_neg == 0) =[];

wht_100_1_pos = w_ed_dthetadp_100.*t_mask_1_pos;
wht_100_1_pos(wht_100_1_pos == 0) =[];
wht_100_1_neg = w_ed_dthetadp_100.*t_mask_1_neg;
wht_100_1_neg(wht_100_1_neg == 0) =[];



for i=1:90
%include lat weighting too
i
xbins = -33:0.1:33;

totadv_ed_100_5_pos_counts = hist(reshape(totadv_ed_100_5_pos,[numel(totadv_ed_100_5_pos),1]),xbins);
totadv_ed_100_5_pos_counts_cos(i,:) = totadv_ed_100_5_pos_counts.*cos(yi(i).*pi./180);
totadv_ed_100_5_neg_counts = hist(reshape(totadv_ed_100_5_neg,[numel(totadv_ed_100_5_neg),1]),xbins);
totadv_ed_100_5_neg_counts_cos(i,:) = totadv_ed_100_5_neg_counts.*cos(yi(i).*pi./180);

uht_100_5_pos_counts = hist(reshape(uht_100_5_pos,[numel(uht_100_5_pos),1]),xbins);
uht_100_5_pos_counts_cos(i,:) = uht_100_5_pos_counts.*cos(yi(i).*pi./180);
uht_100_5_neg_counts = hist(reshape(uht_100_5_neg,[numel(uht_100_5_neg),1]),xbins);
uht_100_5_neg_counts_cos(i,:) = uht_100_5_neg_counts.*cos(yi(i).*pi./180);

vht_100_5_pos_counts = hist(reshape(vht_100_5_pos,[numel(vht_100_5_pos),1]),xbins);
vht_100_5_pos_counts_cos(i,:) = vht_100_5_pos_counts.*cos(yi(i).*pi./180);
vht_100_5_neg_counts = hist(reshape(vht_100_5_neg,[numel(vht_100_5_neg),1]),xbins);
vht_100_5_neg_counts_cos(i,:) = vht_100_5_neg_counts.*cos(yi(i).*pi./180);

wht_100_5_pos_counts = hist(reshape(wht_100_5_pos,[numel(wht_100_5_pos),1]),xbins);
wht_100_5_pos_counts_cos(i,:) = wht_100_5_pos_counts.*cos(yi(i).*pi./180);
wht_100_5_neg_counts = hist(reshape(wht_100_5_neg,[numel(wht_100_5_neg),1]),xbins);
wht_100_5_neg_counts_cos(i,:) = wht_100_5_neg_counts.*cos(yi(i).*pi./180);


totadv_ed_100_4_pos_counts = hist(reshape(totadv_ed_100_4_pos,[numel(totadv_ed_100_4_pos),1]),xbins);
totadv_ed_100_4_pos_counts_cos(i,:) = totadv_ed_100_4_pos_counts.*cos(yi(i).*pi./180);
totadv_ed_100_4_neg_counts = hist(reshape(totadv_ed_100_4_neg,[numel(totadv_ed_100_4_neg),1]),xbins);
totadv_ed_100_4_neg_counts_cos(i,:) = totadv_ed_100_4_neg_counts.*cos(yi(i).*pi./180);

uht_100_4_pos_counts = hist(reshape(uht_100_4_pos,[numel(uht_100_4_pos),1]),xbins);
uht_100_4_pos_counts_cos(i,:) = uht_100_4_pos_counts.*cos(yi(i).*pi./180);
uht_100_4_neg_counts = hist(reshape(uht_100_4_neg,[numel(uht_100_4_neg),1]),xbins);
uht_100_4_neg_counts_cos(i,:) = uht_100_4_neg_counts.*cos(yi(i).*pi./180);

vht_100_4_pos_counts = hist(reshape(vht_100_4_pos,[numel(vht_100_4_pos),1]),xbins);
vht_100_4_pos_counts_cos(i,:) = vht_100_4_pos_counts.*cos(yi(i).*pi./180);
vht_100_4_neg_counts = hist(reshape(vht_100_4_neg,[numel(vht_100_4_neg),1]),xbins);
vht_100_4_neg_counts_cos(i,:) = vht_100_4_neg_counts.*cos(yi(i).*pi./180);

wht_100_4_pos_counts = hist(reshape(wht_100_4_pos,[numel(wht_100_4_pos),1]),xbins);
wht_100_4_pos_counts_cos(i,:) = wht_100_4_pos_counts.*cos(yi(i).*pi./180);
wht_100_4_neg_counts = hist(reshape(wht_100_4_neg,[numel(wht_100_4_neg),1]),xbins);
wht_100_4_neg_counts_cos(i,:) = wht_100_4_neg_counts.*cos(yi(i).*pi./180);


totadv_ed_100_3_pos_counts = hist(reshape(totadv_ed_100_3_pos,[numel(totadv_ed_100_3_pos),1]),xbins);
totadv_ed_100_3_pos_counts_cos(i,:) = totadv_ed_100_3_pos_counts.*cos(yi(i).*pi./180);
totadv_ed_100_3_neg_counts = hist(reshape(totadv_ed_100_3_neg,[numel(totadv_ed_100_3_neg),1]),xbins);
totadv_ed_100_3_neg_counts_cos(i,:) = totadv_ed_100_3_neg_counts.*cos(yi(i).*pi./180);

uht_100_3_pos_counts = hist(reshape(uht_100_3_pos,[numel(uht_100_3_pos),1]),xbins);
uht_100_3_pos_counts_cos(i,:) = uht_100_3_pos_counts.*cos(yi(i).*pi./180);
uht_100_3_neg_counts = hist(reshape(uht_100_3_neg,[numel(uht_100_3_neg),1]),xbins);
uht_100_3_neg_counts_cos(i,:) = uht_100_3_neg_counts.*cos(yi(i).*pi./180);

vht_100_3_pos_counts = hist(reshape(vht_100_3_pos,[numel(vht_100_3_pos),1]),xbins);
vht_100_3_pos_counts_cos(i,:) = vht_100_3_pos_counts.*cos(yi(i).*pi./180);
vht_100_3_neg_counts = hist(reshape(vht_100_3_neg,[numel(vht_100_3_neg),1]),xbins);
vht_100_3_neg_counts_cos(i,:) = vht_100_3_neg_counts.*cos(yi(i).*pi./180);

wht_100_3_pos_counts = hist(reshape(wht_100_3_pos,[numel(wht_100_3_pos),1]),xbins);
wht_100_3_pos_counts_cos(i,:) = wht_100_3_pos_counts.*cos(yi(i).*pi./180);
wht_100_3_neg_counts = hist(reshape(wht_100_3_neg,[numel(wht_100_3_neg),1]),xbins);
wht_100_3_neg_counts_cos(i,:) = wht_100_3_neg_counts.*cos(yi(i).*pi./180);


totadv_ed_100_2_pos_counts = hist(reshape(totadv_ed_100_2_pos,[numel(totadv_ed_100_2_pos),1]),xbins);
totadv_ed_100_2_pos_counts_cos(i,:) = totadv_ed_100_2_pos_counts.*cos(yi(i).*pi./180);
totadv_ed_100_2_neg_counts = hist(reshape(totadv_ed_100_2_neg,[numel(totadv_ed_100_2_neg),1]),xbins);
totadv_ed_100_2_neg_counts_cos(i,:) = totadv_ed_100_2_neg_counts.*cos(yi(i).*pi./180);

uht_100_2_pos_counts = hist(reshape(uht_100_2_pos,[numel(uht_100_2_pos),1]),xbins);
uht_100_2_pos_counts_cos(i,:) = uht_100_2_pos_counts.*cos(yi(i).*pi./180);
uht_100_2_neg_counts = hist(reshape(uht_100_2_neg,[numel(uht_100_2_neg),1]),xbins);
uht_100_2_neg_counts_cos(i,:) = uht_100_2_neg_counts.*cos(yi(i).*pi./180);

vht_100_2_pos_counts = hist(reshape(vht_100_2_pos,[numel(vht_100_2_pos),1]),xbins);
vht_100_2_pos_counts_cos(i,:) = vht_100_2_pos_counts.*cos(yi(i).*pi./180);
vht_100_2_neg_counts = hist(reshape(vht_100_2_neg,[numel(vht_100_2_neg),1]),xbins);
vht_100_2_neg_counts_cos(i,:) = vht_100_2_neg_counts.*cos(yi(i).*pi./180);

wht_100_2_pos_counts = hist(reshape(wht_100_2_pos,[numel(wht_100_2_pos),1]),xbins);
wht_100_2_pos_counts_cos(i,:) = wht_100_2_pos_counts.*cos(yi(i).*pi./180);
wht_100_2_neg_counts = hist(reshape(wht_100_2_neg,[numel(wht_100_2_neg),1]),xbins);
wht_100_2_neg_counts_cos(i,:) = wht_100_2_neg_counts.*cos(yi(i).*pi./180);


totadv_ed_100_1_pos_counts = hist(reshape(totadv_ed_100_1_pos,[numel(totadv_ed_100_1_pos),1]),xbins);
totadv_ed_100_1_pos_counts_cos(i,:) = totadv_ed_100_1_pos_counts.*cos(yi(i).*pi./180);
totadv_ed_100_1_neg_counts = hist(reshape(totadv_ed_100_1_neg,[numel(totadv_ed_100_1_neg),1]),xbins);
totadv_ed_100_1_neg_counts_cos(i,:) = totadv_ed_100_1_neg_counts.*cos(yi(i).*pi./180);

uht_100_1_pos_counts = hist(reshape(uht_100_1_pos,[numel(uht_100_1_pos),1]),xbins);
uht_100_1_pos_counts_cos(i,:) = uht_100_1_pos_counts.*cos(yi(i).*pi./180);
uht_100_1_neg_counts = hist(reshape(uht_100_1_neg,[numel(uht_100_1_neg),1]),xbins);
uht_100_1_neg_counts_cos(i,:) = uht_100_1_neg_counts.*cos(yi(i).*pi./180);

vht_100_1_pos_counts = hist(reshape(vht_100_1_pos,[numel(vht_100_1_pos),1]),xbins);
vht_100_1_pos_counts_cos(i,:) = vht_100_1_pos_counts.*cos(yi(i).*pi./180);
vht_100_1_neg_counts = hist(reshape(vht_100_1_neg,[numel(vht_100_1_neg),1]),xbins);
vht_100_1_neg_counts_cos(i,:) = vht_100_1_neg_counts.*cos(yi(i).*pi./180);

wht_100_1_pos_counts = hist(reshape(wht_100_1_pos,[numel(wht_100_1_pos),1]),xbins);
wht_100_1_pos_counts_cos(i,:) = wht_100_1_pos_counts.*cos(yi(i).*pi./180);
wht_100_1_neg_counts = hist(reshape(wht_100_1_neg,[numel(wht_100_1_neg),1]),xbins);
wht_100_1_neg_counts_cos(i,:) = wht_100_1_neg_counts.*cos(yi(i).*pi./180);


end


totadv_ed_5_pos = sum(totadv_ed_100_5_pos_counts_cos,1)./sum(sum(totadv_ed_100_5_pos_counts_cos));
totadv_ed_5_neg = sum(totadv_ed_100_5_neg_counts_cos,1)./sum(sum(totadv_ed_100_5_neg_counts_cos));
uht_5_pos = sum(uht_100_5_pos_counts_cos,1)./sum(sum(uht_100_5_pos_counts_cos));
uht_5_neg = sum(uht_100_5_neg_counts_cos,1)./sum(sum(uht_100_5_neg_counts_cos));
vht_5_pos = sum(vht_100_5_pos_counts_cos,1)./sum(sum(vht_100_5_pos_counts_cos));
vht_5_neg = sum(vht_100_5_neg_counts_cos,1)./sum(sum(vht_100_5_neg_counts_cos));
wht_5_pos = sum(wht_100_5_pos_counts_cos,1)./sum(sum(wht_100_5_pos_counts_cos));
wht_5_neg = sum(wht_100_5_neg_counts_cos,1)./sum(sum(wht_100_5_neg_counts_cos));


totadv_ed_4_pos = sum(totadv_ed_100_4_pos_counts_cos,1)./sum(sum(totadv_ed_100_4_pos_counts_cos));
totadv_ed_4_neg = sum(totadv_ed_100_4_neg_counts_cos,1)./sum(sum(totadv_ed_100_4_neg_counts_cos));
uht_4_pos = sum(uht_100_4_pos_counts_cos,1)./sum(sum(uht_100_4_pos_counts_cos));
uht_4_neg = sum(uht_100_4_neg_counts_cos,1)./sum(sum(uht_100_4_neg_counts_cos));
vht_4_pos = sum(vht_100_4_pos_counts_cos,1)./sum(sum(vht_100_4_pos_counts_cos));
vht_4_neg = sum(vht_100_4_neg_counts_cos,1)./sum(sum(vht_100_4_neg_counts_cos));
wht_4_pos = sum(wht_100_4_pos_counts_cos,1)./sum(sum(wht_100_4_pos_counts_cos));
wht_4_neg = sum(wht_100_4_neg_counts_cos,1)./sum(sum(wht_100_4_neg_counts_cos));


totadv_ed_3_pos = sum(totadv_ed_100_3_pos_counts_cos,1)./sum(sum(totadv_ed_100_3_pos_counts_cos));
totadv_ed_3_neg = sum(totadv_ed_100_3_neg_counts_cos,1)./sum(sum(totadv_ed_100_3_neg_counts_cos));
uht_3_pos = sum(uht_100_3_pos_counts_cos,1)./sum(sum(uht_100_3_pos_counts_cos));
uht_3_neg = sum(uht_100_3_neg_counts_cos,1)./sum(sum(uht_100_3_neg_counts_cos));
vht_3_pos = sum(vht_100_3_pos_counts_cos,1)./sum(sum(vht_100_3_pos_counts_cos));
vht_3_neg = sum(vht_100_3_neg_counts_cos,1)./sum(sum(vht_100_3_neg_counts_cos));
wht_3_pos = sum(wht_100_3_pos_counts_cos,1)./sum(sum(wht_100_3_pos_counts_cos));
wht_3_neg = sum(wht_100_3_neg_counts_cos,1)./sum(sum(wht_100_3_neg_counts_cos));


totadv_ed_2_pos = sum(totadv_ed_100_2_pos_counts_cos,1)./sum(sum(totadv_ed_100_2_pos_counts_cos));
totadv_ed_2_neg = sum(totadv_ed_100_2_neg_counts_cos,1)./sum(sum(totadv_ed_100_2_neg_counts_cos));
uht_2_pos = sum(uht_100_2_pos_counts_cos,1)./sum(sum(uht_100_2_pos_counts_cos));
uht_2_neg = sum(uht_100_2_neg_counts_cos,1)./sum(sum(uht_100_2_neg_counts_cos));
vht_2_pos = sum(vht_100_2_pos_counts_cos,1)./sum(sum(vht_100_2_pos_counts_cos));
vht_2_neg = sum(vht_100_2_neg_counts_cos,1)./sum(sum(vht_100_2_neg_counts_cos));
wht_2_pos = sum(wht_100_2_pos_counts_cos,1)./sum(sum(wht_100_2_pos_counts_cos));
wht_2_neg = sum(wht_100_2_neg_counts_cos,1)./sum(sum(wht_100_2_neg_counts_cos));


totadv_ed_1_pos = sum(totadv_ed_100_1_pos_counts_cos,1)./sum(sum(totadv_ed_100_1_pos_counts_cos));
totadv_ed_1_neg = sum(totadv_ed_100_1_neg_counts_cos,1)./sum(sum(totadv_ed_100_1_neg_counts_cos));
uht_1_pos = sum(uht_100_1_pos_counts_cos,1)./sum(sum(uht_100_1_pos_counts_cos));
uht_1_neg = sum(uht_100_1_neg_counts_cos,1)./sum(sum(uht_100_1_neg_counts_cos));
vht_1_pos = sum(vht_100_1_pos_counts_cos,1)./sum(sum(vht_100_1_pos_counts_cos));
vht_1_neg = sum(vht_100_1_neg_counts_cos,1)./sum(sum(vht_100_1_neg_counts_cos));
wht_1_pos = sum(wht_100_1_pos_counts_cos,1)./sum(sum(wht_100_1_pos_counts_cos));
wht_1_neg = sum(wht_100_1_neg_counts_cos,1)./sum(sum(wht_100_1_neg_counts_cos));





save('/project/rg312/mat_files/htrt_adv_hists_trange_100.mat')

