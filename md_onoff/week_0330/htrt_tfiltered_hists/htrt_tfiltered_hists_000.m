


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

%load up 000 snapshots and calculate eddy quantities

load('/project/rg312/mat_files/heat_rates_best.mat','htrt_000')
htrt_000_ll = squeeze(cube2latlon(xc,yc,htrt_000(:,:,5,1:719),xi,yi)).*86400;
htrt_000_ll_tav = repmat(mean(htrt_000_ll,3),[1 1 719]);
htrt_ed_000_ll = htrt_000_ll - htrt_000_ll_tav;
clear('htrt_000')

%load('/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat','theta_000')
%theta_000_ll = squeeze(cube2latlon(xc,yc,theta_000(:,:,:,1:719),xi,yi));
%theta_000_ll_tav = repmat(mean(theta_000_ll,4),[1 1 1 719]);
%theta_ed_000_ll = theta_000_ll - theta_000_ll_tav;
%clear('theta_000')

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_000')
t_000_ll = squeeze(cube2latlon(xc,yc,t_000(:,:,5,1:719),xi,yi));
t_000_ll_tav = repmat(mean(t_000_ll,3),[1 1 719]);
t_ed_000_ll = t_000_ll - t_000_ll_tav;
clear('t_000')

%load('/project/rg312/mat_files/snapshot_data/uE_snapshots_best.mat','uE_000')
%uE_000_ll = squeeze(cube2latlon(xc,yc,uE_000(:,:,5,1:719),xi,yi));
%uE_000_ll_tav = repmat(mean(uE_000_ll,3),[1 1 719]);
%uE_ed_000_ll = uE_000_ll - uE_000_ll_tav;
%clear('uE_000')

%load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_000')
%vN_000_ll = squeeze(cube2latlon(xc,yc,vN_000(:,:,5,1:719),xi,yi));
%vN_000_ll_tav = repmat(mean(vN_000_ll,3),[1 1 719]);
%vN_ed_000_ll = vN_000_ll - vN_000_ll_tav;
%clear('vN_000')

%load('/project/rg312/mat_files/snapshot_data/w_snapshots_best.mat','w_000')
%interpolate first
%w_000_half = zeros(192,32,26,719);
%w_000_half(:,:,1:25,:) = w_000(:,:,:,1:719);
%rC_half = (100000:-4000:0)';

%w_000_plev = shiftdim(interp1(rC_half,shiftdim(w_000_half,2),rC),2);

%w_000_ll = squeeze(cube2latlon(xc,yc,w_000(:,:,:,1:719),xi,yi));
%w_000_ll_tav = repmat(mean(w_000_ll,4),[1 1 1 719]);
%w_ed_000_ll = w_000_ll - w_000_ll_tav;


%radius = 6371.0e3;

%[dtheta_ed_dy_000,dtheta_ed_dx_000,dtheta_ed_dp_000] = gradient(theta_ed_000_ll,pi./90,pi./90,-4000,1);
%dtheta_ed_dy_000 = dtheta_ed_dy_000./radius;

%[dthetady_000_tav,dthetadx_000_tav,dthetadp_000_tav] = gradient(theta_000_ll_tav,pi./90,pi./90,-4000,1);
%dthetady_000_tav = dthetady_000_tav./radius;

%for i=1:90
%dtheta_ed_dx_000(:,i,:,:) = dtheta_ed_dx_000(:,i,:,:)./cos(yi(i).*pi./180)./radius;
%dthetadx_000_tav(:,i,:,:) = dthetadx_000_tav(:,i,:,:)./cos(yi(i).*pi./180)./radius;
%end

%udtheta_ed_dx_000 = -uE_000_ll_tav.*squeeze(dtheta_ed_dx_000(:,:,5,:)).*86400;
%vdtheta_ed_dy_000 = -vN_000_ll_tav.*squeeze(dtheta_ed_dx_000(:,:,5,:)).*86400;
%wdtheta_ed_dp_000 = -squeeze(w_000_ll_tav(:,:,5,:).*dtheta_ed_dp_000(:,:,5,:)).*86400;

%u_ed_dthetadx_000 = -uE_ed_000_ll.*squeeze(dthetadx_000_tav(:,:,5,:)).*86400;
%v_ed_dthetady_000 = -vN_ed_000_ll.*squeeze(dthetady_000_tav(:,:,5,:)).*86400;
%w_ed_dthetadp_000 = -squeeze(w_ed_000_ll(:,:,5,:).*dthetadp_000_tav(:,:,5,:)).*86400;

%total_ed_ttend_guess = htrt_ed_000_ll + udtheta_ed_dx_000 + vdtheta_ed_dy_000 + wdtheta_ed_dp_000 + %u_ed_dthetadx_000 + v_ed_dthetady_000 + w_ed_dthetadp_000;

%total_adv_heat = udtheta_ed_dx_000 + vdtheta_ed_dy_000 + wdtheta_ed_dp_000 + u_ed_dthetadx_000 + v_ed_dthetady_000 + w_ed_dthetadp_000;

t_mask_5_pos = +(t_ed_000_ll >= 4 & t_ed_000_ll <= 5);
t_mask_5_neg = +(t_ed_000_ll >= -5 & t_ed_000_ll <= -4);

htrt_ed_000_5_pos = htrt_ed_000_ll.*t_mask_5_pos;
htrt_ed_000_5_pos(htrt_ed_000_5_pos == 0) =[];
htrt_ed_000_5_neg = htrt_ed_000_ll.*t_mask_5_neg;
htrt_ed_000_5_neg(htrt_ed_000_5_neg == 0) =[];


t_mask_4_pos = +(t_ed_000_ll >= 3 & t_ed_000_ll <= 4);
t_mask_4_neg = +(t_ed_000_ll >= -4 & t_ed_000_ll <= -3);

htrt_ed_000_4_pos = htrt_ed_000_ll.*t_mask_4_pos;
htrt_ed_000_4_pos(htrt_ed_000_4_pos == 0) =[];
htrt_ed_000_4_neg = htrt_ed_000_ll.*t_mask_4_neg;
htrt_ed_000_4_neg(htrt_ed_000_4_neg == 0) =[];

t_mask_3_pos = +(t_ed_000_ll >= 2 & t_ed_000_ll <= 3);
t_mask_3_neg = +(t_ed_000_ll >= -3 & t_ed_000_ll <= -2);

htrt_ed_000_3_pos = htrt_ed_000_ll.*t_mask_3_pos;
htrt_ed_000_3_pos(htrt_ed_000_3_pos == 0) =[];
htrt_ed_000_3_neg = htrt_ed_000_ll.*t_mask_3_neg;
htrt_ed_000_3_neg(htrt_ed_000_3_neg == 0) =[];

t_mask_2_pos = +(t_ed_000_ll >= 1 & t_ed_000_ll <= 2);
t_mask_2_neg = +(t_ed_000_ll >= -2 & t_ed_000_ll <= -1);

htrt_ed_000_2_pos = htrt_ed_000_ll.*t_mask_2_pos;
htrt_ed_000_2_pos(htrt_ed_000_2_pos == 0) =[];
htrt_ed_000_2_neg = htrt_ed_000_ll.*t_mask_2_neg;
htrt_ed_000_2_neg(htrt_ed_000_2_neg == 0) =[];

t_mask_1_pos = +(t_ed_000_ll >= 0 & t_ed_000_ll <= 1);
t_mask_1_neg = +(t_ed_000_ll >= -1 & t_ed_000_ll <= 0);

htrt_ed_000_1_pos = htrt_ed_000_ll.*t_mask_1_pos;
htrt_ed_000_1_pos(htrt_ed_000_1_pos == 0) =[];
htrt_ed_000_1_neg = htrt_ed_000_ll.*t_mask_1_neg;
htrt_ed_000_1_neg(htrt_ed_000_1_neg == 0) =[];


for i=1:90
%include lat weighting too
i
xbins = -33:0.1:8;

htrt_ed_000_5_pos_counts = hist(reshape(htrt_ed_000_5_pos,[numel(htrt_ed_000_5_pos),1]),xbins);
htrt_ed_000_5_pos_counts_cos(i,:) = htrt_ed_000_5_pos_counts.*cos(yi(i).*pi./180);

htrt_ed_000_5_neg_counts = hist(reshape(htrt_ed_000_5_neg,[numel(htrt_ed_000_5_neg),1]),xbins);
htrt_ed_000_5_neg_counts_cos(i,:) = htrt_ed_000_5_neg_counts.*cos(yi(i).*pi./180);


htrt_ed_000_4_pos_counts = hist(reshape(htrt_ed_000_4_pos,[numel(htrt_ed_000_4_pos),1]),xbins);
htrt_ed_000_4_pos_counts_cos(i,:) = htrt_ed_000_4_pos_counts.*cos(yi(i).*pi./180);

htrt_ed_000_4_neg_counts = hist(reshape(htrt_ed_000_4_neg,[numel(htrt_ed_000_4_neg),1]),xbins);
htrt_ed_000_4_neg_counts_cos(i,:) = htrt_ed_000_4_neg_counts.*cos(yi(i).*pi./180);


htrt_ed_000_3_pos_counts = hist(reshape(htrt_ed_000_3_pos,[numel(htrt_ed_000_3_pos),1]),xbins);
htrt_ed_000_3_pos_counts_cos(i,:) = htrt_ed_000_3_pos_counts.*cos(yi(i).*pi./180);

htrt_ed_000_3_neg_counts = hist(reshape(htrt_ed_000_3_neg,[numel(htrt_ed_000_3_neg),1]),xbins);
htrt_ed_000_3_neg_counts_cos(i,:) = htrt_ed_000_3_neg_counts.*cos(yi(i).*pi./180);


htrt_ed_000_2_pos_counts = hist(reshape(htrt_ed_000_2_pos,[numel(htrt_ed_000_2_pos),1]),xbins);
htrt_ed_000_2_pos_counts_cos(i,:) = htrt_ed_000_2_pos_counts.*cos(yi(i).*pi./180);

htrt_ed_000_2_neg_counts = hist(reshape(htrt_ed_000_2_neg,[numel(htrt_ed_000_2_neg),1]),xbins);
htrt_ed_000_2_neg_counts_cos(i,:) = htrt_ed_000_2_neg_counts.*cos(yi(i).*pi./180);



htrt_ed_000_1_pos_counts = hist(reshape(htrt_ed_000_1_pos,[numel(htrt_ed_000_1_pos),1]),xbins);
htrt_ed_000_1_pos_counts_cos(i,:) = htrt_ed_000_1_pos_counts.*cos(yi(i).*pi./180);

htrt_ed_000_1_neg_counts = hist(reshape(htrt_ed_000_1_neg,[numel(htrt_ed_000_1_neg),1]),xbins);
htrt_ed_000_1_neg_counts_cos(i,:) = htrt_ed_000_1_neg_counts.*cos(yi(i).*pi./180);

end


htrt_hist_5_pos = sum(htrt_ed_000_5_pos_counts_cos,1)./sum(sum(htrt_ed_000_5_pos_counts_cos));
htrt_hist_5_neg = sum(htrt_ed_000_5_neg_counts_cos,1)./sum(sum(htrt_ed_000_5_neg_counts_cos));

htrt_hist_4_pos = sum(htrt_ed_000_4_pos_counts_cos,1)./sum(sum(htrt_ed_000_4_pos_counts_cos));
htrt_hist_4_neg = sum(htrt_ed_000_4_neg_counts_cos,1)./sum(sum(htrt_ed_000_4_neg_counts_cos));

htrt_hist_3_pos = sum(htrt_ed_000_3_pos_counts_cos,1)./sum(sum(htrt_ed_000_3_pos_counts_cos));
htrt_hist_3_neg = sum(htrt_ed_000_3_neg_counts_cos,1)./sum(sum(htrt_ed_000_3_neg_counts_cos));

htrt_hist_2_pos = sum(htrt_ed_000_2_pos_counts_cos,1)./sum(sum(htrt_ed_000_2_pos_counts_cos));
htrt_hist_2_neg = sum(htrt_ed_000_2_neg_counts_cos,1)./sum(sum(htrt_ed_000_2_neg_counts_cos));

htrt_hist_1_pos = sum(htrt_ed_000_1_pos_counts_cos,1)./sum(sum(htrt_ed_000_1_pos_counts_cos));
htrt_hist_1_neg = sum(htrt_ed_000_1_neg_counts_cos,1)./sum(sum(htrt_ed_000_1_neg_counts_cos));


save('/project/rg312/mat_files/htrt_hists_trange_000.mat')

