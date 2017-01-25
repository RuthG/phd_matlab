%load up convective and diffusive heating rates and produce histograms filtered for T' ranges


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

load('/project/rg312/mat_files/heat_rates_best.mat','cnvht_100')
cnvht_100_ll = squeeze(cube2latlon(xc,yc,cnvht_100(:,:,5,1:719),xi,yi)).*86400;
cnvht_100_ll_tav = repmat(mean(cnvht_100_ll,3),[1 1 719]);
cnvht_ed_100_ll = cnvht_100_ll - cnvht_100_ll_tav;
clear('cnvht_100')

load('/project/rg312/mat_files/heat_rates_best.mat','difht_100')
difht_100_ll = squeeze(cube2latlon(xc,yc,difht_100(:,:,5,1:719),xi,yi)).*86400;
difht_100_ll_tav = repmat(mean(difht_100_ll,3),[1 1 719]);
difht_ed_100_ll = difht_100_ll - difht_100_ll_tav;
clear('difht_100')

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_100')
t_100_ll = squeeze(cube2latlon(xc,yc,t_100(:,:,5,1:719),xi,yi));
t_100_ll_tav = repmat(mean(t_100_ll,3),[1 1 719]);
t_ed_100_ll = t_100_ll - t_100_ll_tav;
clear('t_100')

%define masks

t_mask_5_pos = +(t_ed_100_ll > 4 & t_ed_100_ll <= 5);
t_mask_5_neg = +(t_ed_100_ll >= -5 & t_ed_100_ll < -4);

cnvht_ed_100_5_pos = cnvht_ed_100_ll.*t_mask_5_pos;
cnvht_ed_100_5_pos(cnvht_ed_100_5_pos == 0) =[];
cnvht_ed_100_5_neg = cnvht_ed_100_ll.*t_mask_5_neg;
cnvht_ed_100_5_neg(cnvht_ed_100_5_neg == 0) =[];

difht_ed_100_5_pos = difht_ed_100_ll.*t_mask_5_pos;
difht_ed_100_5_pos(difht_ed_100_5_pos == 0) =[];
difht_ed_100_5_neg = difht_ed_100_ll.*t_mask_5_neg;
difht_ed_100_5_neg(difht_ed_100_5_neg == 0) =[];

t_mask_4_pos = +(t_ed_100_ll > 3 & t_ed_100_ll <= 4);
t_mask_4_neg = +(t_ed_100_ll >= -4 & t_ed_100_ll < -3);

cnvht_ed_100_4_pos = cnvht_ed_100_ll.*t_mask_4_pos;
cnvht_ed_100_4_pos(cnvht_ed_100_4_pos == 0) =[];
cnvht_ed_100_4_neg = cnvht_ed_100_ll.*t_mask_4_neg;
cnvht_ed_100_4_neg(cnvht_ed_100_4_neg == 0) =[];

difht_ed_100_4_pos = difht_ed_100_ll.*t_mask_4_pos;
difht_ed_100_4_pos(difht_ed_100_4_pos == 0) =[];
difht_ed_100_4_neg = difht_ed_100_ll.*t_mask_4_neg;
difht_ed_100_4_neg(difht_ed_100_4_neg == 0) =[];

t_mask_3_pos = +(t_ed_100_ll > 2 & t_ed_100_ll <= 3);
t_mask_3_neg = +(t_ed_100_ll >= -3 & t_ed_100_ll < -2);

cnvht_ed_100_3_pos = cnvht_ed_100_ll.*t_mask_3_pos;
cnvht_ed_100_3_pos(cnvht_ed_100_3_pos == 0) =[];
cnvht_ed_100_3_neg = cnvht_ed_100_ll.*t_mask_3_neg;
cnvht_ed_100_3_neg(cnvht_ed_100_3_neg == 0) =[];

difht_ed_100_3_pos = difht_ed_100_ll.*t_mask_3_pos;
difht_ed_100_3_pos(difht_ed_100_3_pos == 0) =[];
difht_ed_100_3_neg = difht_ed_100_ll.*t_mask_3_neg;
difht_ed_100_3_neg(difht_ed_100_3_neg == 0) =[];

t_mask_2_pos = +(t_ed_100_ll > 1 & t_ed_100_ll <= 2);
t_mask_2_neg = +(t_ed_100_ll >= -2 & t_ed_100_ll < -1);

cnvht_ed_100_2_pos = cnvht_ed_100_ll.*t_mask_2_pos;
cnvht_ed_100_2_pos(cnvht_ed_100_2_pos == 0) =[];
cnvht_ed_100_2_neg = cnvht_ed_100_ll.*t_mask_2_neg;
cnvht_ed_100_2_neg(cnvht_ed_100_2_neg == 0) =[];

difht_ed_100_2_pos = difht_ed_100_ll.*t_mask_2_pos;
difht_ed_100_2_pos(difht_ed_100_2_pos == 0) =[];
difht_ed_100_2_neg = difht_ed_100_ll.*t_mask_2_neg;
difht_ed_100_2_neg(difht_ed_100_2_neg == 0) =[];

t_mask_1_pos = +(t_ed_100_ll > 0 & t_ed_100_ll <= 1);
t_mask_1_neg = +(t_ed_100_ll >= -1 & t_ed_100_ll < 0);

cnvht_ed_100_1_pos = cnvht_ed_100_ll.*t_mask_1_pos;
cnvht_ed_100_1_pos(cnvht_ed_100_1_pos == 0) =[];
cnvht_ed_100_1_neg = cnvht_ed_100_ll.*t_mask_1_neg;
cnvht_ed_100_1_neg(cnvht_ed_100_1_neg == 0) =[];

difht_ed_100_1_pos = difht_ed_100_ll.*t_mask_1_pos;
difht_ed_100_1_pos(difht_ed_100_1_pos == 0) =[];
difht_ed_100_1_neg = difht_ed_100_ll.*t_mask_1_neg;
difht_ed_100_1_neg(difht_ed_100_1_neg == 0) =[];


for i=1:90
%include lat weighting too
i
xbins = -45:0.2:45;

cnvht_ed_100_5_pos_counts = hist(reshape(cnvht_ed_100_5_pos,[numel(cnvht_ed_100_5_pos),1]),xbins);
cnvht_ed_100_5_pos_counts_cos(i,:) = cnvht_ed_100_5_pos_counts.*cos(yi(i).*pi./180);

cnvht_ed_100_5_neg_counts = hist(reshape(cnvht_ed_100_5_neg,[numel(cnvht_ed_100_5_neg),1]),xbins);
cnvht_ed_100_5_neg_counts_cos(i,:) = cnvht_ed_100_5_neg_counts.*cos(yi(i).*pi./180);


cnvht_ed_100_4_pos_counts = hist(reshape(cnvht_ed_100_4_pos,[numel(cnvht_ed_100_4_pos),1]),xbins);
cnvht_ed_100_4_pos_counts_cos(i,:) = cnvht_ed_100_4_pos_counts.*cos(yi(i).*pi./180);

cnvht_ed_100_4_neg_counts = hist(reshape(cnvht_ed_100_4_neg,[numel(cnvht_ed_100_4_neg),1]),xbins);
cnvht_ed_100_4_neg_counts_cos(i,:) = cnvht_ed_100_4_neg_counts.*cos(yi(i).*pi./180);


cnvht_ed_100_3_pos_counts = hist(reshape(cnvht_ed_100_3_pos,[numel(cnvht_ed_100_3_pos),1]),xbins);
cnvht_ed_100_3_pos_counts_cos(i,:) = cnvht_ed_100_3_pos_counts.*cos(yi(i).*pi./180);

cnvht_ed_100_3_neg_counts = hist(reshape(cnvht_ed_100_3_neg,[numel(cnvht_ed_100_3_neg),1]),xbins);
cnvht_ed_100_3_neg_counts_cos(i,:) = cnvht_ed_100_3_neg_counts.*cos(yi(i).*pi./180);


cnvht_ed_100_2_pos_counts = hist(reshape(cnvht_ed_100_2_pos,[numel(cnvht_ed_100_2_pos),1]),xbins);
cnvht_ed_100_2_pos_counts_cos(i,:) = cnvht_ed_100_2_pos_counts.*cos(yi(i).*pi./180);

cnvht_ed_100_2_neg_counts = hist(reshape(cnvht_ed_100_2_neg,[numel(cnvht_ed_100_2_neg),1]),xbins);
cnvht_ed_100_2_neg_counts_cos(i,:) = cnvht_ed_100_2_neg_counts.*cos(yi(i).*pi./180);



cnvht_ed_100_1_pos_counts = hist(reshape(cnvht_ed_100_1_pos,[numel(cnvht_ed_100_1_pos),1]),xbins);
cnvht_ed_100_1_pos_counts_cos(i,:) = cnvht_ed_100_1_pos_counts.*cos(yi(i).*pi./180);

cnvht_ed_100_1_neg_counts = hist(reshape(cnvht_ed_100_1_neg,[numel(cnvht_ed_100_1_neg),1]),xbins);
cnvht_ed_100_1_neg_counts_cos(i,:) = cnvht_ed_100_1_neg_counts.*cos(yi(i).*pi./180);




difht_ed_100_5_pos_counts = hist(reshape(difht_ed_100_5_pos,[numel(difht_ed_100_5_pos),1]),xbins);
difht_ed_100_5_pos_counts_cos(i,:) = difht_ed_100_5_pos_counts.*cos(yi(i).*pi./180);

difht_ed_100_5_neg_counts = hist(reshape(difht_ed_100_5_neg,[numel(difht_ed_100_5_neg),1]),xbins);
difht_ed_100_5_neg_counts_cos(i,:) = difht_ed_100_5_neg_counts.*cos(yi(i).*pi./180);


difht_ed_100_4_pos_counts = hist(reshape(difht_ed_100_4_pos,[numel(difht_ed_100_4_pos),1]),xbins);
difht_ed_100_4_pos_counts_cos(i,:) = difht_ed_100_4_pos_counts.*cos(yi(i).*pi./180);

difht_ed_100_4_neg_counts = hist(reshape(difht_ed_100_4_neg,[numel(difht_ed_100_4_neg),1]),xbins);
difht_ed_100_4_neg_counts_cos(i,:) = difht_ed_100_4_neg_counts.*cos(yi(i).*pi./180);


difht_ed_100_3_pos_counts = hist(reshape(difht_ed_100_3_pos,[numel(difht_ed_100_3_pos),1]),xbins);
difht_ed_100_3_pos_counts_cos(i,:) = difht_ed_100_3_pos_counts.*cos(yi(i).*pi./180);

difht_ed_100_3_neg_counts = hist(reshape(difht_ed_100_3_neg,[numel(difht_ed_100_3_neg),1]),xbins);
difht_ed_100_3_neg_counts_cos(i,:) = difht_ed_100_3_neg_counts.*cos(yi(i).*pi./180);


difht_ed_100_2_pos_counts = hist(reshape(difht_ed_100_2_pos,[numel(difht_ed_100_2_pos),1]),xbins);
difht_ed_100_2_pos_counts_cos(i,:) = difht_ed_100_2_pos_counts.*cos(yi(i).*pi./180);

difht_ed_100_2_neg_counts = hist(reshape(difht_ed_100_2_neg,[numel(difht_ed_100_2_neg),1]),xbins);
difht_ed_100_2_neg_counts_cos(i,:) = difht_ed_100_2_neg_counts.*cos(yi(i).*pi./180);



difht_ed_100_1_pos_counts = hist(reshape(difht_ed_100_1_pos,[numel(difht_ed_100_1_pos),1]),xbins);
difht_ed_100_1_pos_counts_cos(i,:) = difht_ed_100_1_pos_counts.*cos(yi(i).*pi./180);

difht_ed_100_1_neg_counts = hist(reshape(difht_ed_100_1_neg,[numel(difht_ed_100_1_neg),1]),xbins);
difht_ed_100_1_neg_counts_cos(i,:) = difht_ed_100_1_neg_counts.*cos(yi(i).*pi./180);


end


cnvht_hist_5_pos = sum(cnvht_ed_100_5_pos_counts_cos,1)./sum(sum(cnvht_ed_100_5_pos_counts_cos));
cnvht_hist_5_neg = sum(cnvht_ed_100_5_neg_counts_cos,1)./sum(sum(cnvht_ed_100_5_neg_counts_cos));

cnvht_hist_4_pos = sum(cnvht_ed_100_4_pos_counts_cos,1)./sum(sum(cnvht_ed_100_4_pos_counts_cos));
cnvht_hist_4_neg = sum(cnvht_ed_100_4_neg_counts_cos,1)./sum(sum(cnvht_ed_100_4_neg_counts_cos));

cnvht_hist_3_pos = sum(cnvht_ed_100_3_pos_counts_cos,1)./sum(sum(cnvht_ed_100_3_pos_counts_cos));
cnvht_hist_3_neg = sum(cnvht_ed_100_3_neg_counts_cos,1)./sum(sum(cnvht_ed_100_3_neg_counts_cos));

cnvht_hist_2_pos = sum(cnvht_ed_100_2_pos_counts_cos,1)./sum(sum(cnvht_ed_100_2_pos_counts_cos));
cnvht_hist_2_neg = sum(cnvht_ed_100_2_neg_counts_cos,1)./sum(sum(cnvht_ed_100_2_neg_counts_cos));

cnvht_hist_1_pos = sum(cnvht_ed_100_1_pos_counts_cos,1)./sum(sum(cnvht_ed_100_1_pos_counts_cos));
cnvht_hist_1_neg = sum(cnvht_ed_100_1_neg_counts_cos,1)./sum(sum(cnvht_ed_100_1_neg_counts_cos));


difht_hist_5_pos = sum(difht_ed_100_5_pos_counts_cos,1)./sum(sum(difht_ed_100_5_pos_counts_cos));
difht_hist_5_neg = sum(difht_ed_100_5_neg_counts_cos,1)./sum(sum(difht_ed_100_5_neg_counts_cos));

difht_hist_4_pos = sum(difht_ed_100_4_pos_counts_cos,1)./sum(sum(difht_ed_100_4_pos_counts_cos));
difht_hist_4_neg = sum(difht_ed_100_4_neg_counts_cos,1)./sum(sum(difht_ed_100_4_neg_counts_cos));

difht_hist_3_pos = sum(difht_ed_100_3_pos_counts_cos,1)./sum(sum(difht_ed_100_3_pos_counts_cos));
difht_hist_3_neg = sum(difht_ed_100_3_neg_counts_cos,1)./sum(sum(difht_ed_100_3_neg_counts_cos));

difht_hist_2_pos = sum(difht_ed_100_2_pos_counts_cos,1)./sum(sum(difht_ed_100_2_pos_counts_cos));
difht_hist_2_neg = sum(difht_ed_100_2_neg_counts_cos,1)./sum(sum(difht_ed_100_2_neg_counts_cos));

difht_hist_1_pos = sum(difht_ed_100_1_pos_counts_cos,1)./sum(sum(difht_ed_100_1_pos_counts_cos));
difht_hist_1_neg = sum(difht_ed_100_1_neg_counts_cos,1)./sum(sum(difht_ed_100_1_neg_counts_cos));


save('/project/rg312/mat_files/cnv_dif_hists_trange_100.mat')

