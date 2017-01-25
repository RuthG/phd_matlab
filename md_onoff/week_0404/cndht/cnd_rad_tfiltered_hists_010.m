%load up convective and diffusive heating rates and produce histograms filtered for T' ranges


rDir='/project/rg312/wv_on_rad_off/run_010_best/';
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

load('/project/rg312/mat_files/heat_rates_best.mat','cndht_010')
cndht_010_ll = squeeze(cube2latlon(xc,yc,cndht_010(:,:,5,1:719),xi,yi)).*86400;
cndht_010_ll_tav = repmat(mean(cndht_010_ll,3),[1 1 719]);
cndht_ed_010_ll = cndht_010_ll - cndht_010_ll_tav;
clear('cndht_010')

load('/project/rg312/mat_files/heat_rates_best.mat','radht_010')
radht_010_ll = squeeze(cube2latlon(xc,yc,radht_010(:,:,5,1:719),xi,yi)).*86400;
radht_010_ll_tav = repmat(mean(radht_010_ll,3),[1 1 719]);
radht_ed_010_ll = radht_010_ll - radht_010_ll_tav;
clear('radht_010')

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_010')
t_010_ll = squeeze(cube2latlon(xc,yc,t_010(:,:,5,1:719),xi,yi));
t_010_ll_tav = repmat(mean(t_010_ll,3),[1 1 719]);
t_ed_010_ll = t_010_ll - t_010_ll_tav;
clear('t_010')

%define masks

t_mask_5_pos = +(t_ed_010_ll > 4 & t_ed_010_ll <= 5);
t_mask_5_neg = +(t_ed_010_ll >= -5 & t_ed_010_ll < -4);

cndht_ed_010_5_pos = cndht_ed_010_ll.*t_mask_5_pos;
cndht_ed_010_5_pos(cndht_ed_010_5_pos == 0) =[];
cndht_ed_010_5_neg = cndht_ed_010_ll.*t_mask_5_neg;
cndht_ed_010_5_neg(cndht_ed_010_5_neg == 0) =[];

radht_ed_010_5_pos = radht_ed_010_ll.*t_mask_5_pos;
radht_ed_010_5_pos(radht_ed_010_5_pos == 0) =[];
radht_ed_010_5_neg = radht_ed_010_ll.*t_mask_5_neg;
radht_ed_010_5_neg(radht_ed_010_5_neg == 0) =[];

t_mask_4_pos = +(t_ed_010_ll > 3 & t_ed_010_ll <= 4);
t_mask_4_neg = +(t_ed_010_ll >= -4 & t_ed_010_ll < -3);

cndht_ed_010_4_pos = cndht_ed_010_ll.*t_mask_4_pos;
cndht_ed_010_4_pos(cndht_ed_010_4_pos == 0) =[];
cndht_ed_010_4_neg = cndht_ed_010_ll.*t_mask_4_neg;
cndht_ed_010_4_neg(cndht_ed_010_4_neg == 0) =[];

radht_ed_010_4_pos = radht_ed_010_ll.*t_mask_4_pos;
radht_ed_010_4_pos(radht_ed_010_4_pos == 0) =[];
radht_ed_010_4_neg = radht_ed_010_ll.*t_mask_4_neg;
radht_ed_010_4_neg(radht_ed_010_4_neg == 0) =[];

t_mask_3_pos = +(t_ed_010_ll > 2 & t_ed_010_ll <= 3);
t_mask_3_neg = +(t_ed_010_ll >= -3 & t_ed_010_ll < -2);

cndht_ed_010_3_pos = cndht_ed_010_ll.*t_mask_3_pos;
cndht_ed_010_3_pos(cndht_ed_010_3_pos == 0) =[];
cndht_ed_010_3_neg = cndht_ed_010_ll.*t_mask_3_neg;
cndht_ed_010_3_neg(cndht_ed_010_3_neg == 0) =[];

radht_ed_010_3_pos = radht_ed_010_ll.*t_mask_3_pos;
radht_ed_010_3_pos(radht_ed_010_3_pos == 0) =[];
radht_ed_010_3_neg = radht_ed_010_ll.*t_mask_3_neg;
radht_ed_010_3_neg(radht_ed_010_3_neg == 0) =[];

t_mask_2_pos = +(t_ed_010_ll > 1 & t_ed_010_ll <= 2);
t_mask_2_neg = +(t_ed_010_ll >= -2 & t_ed_010_ll < -1);

cndht_ed_010_2_pos = cndht_ed_010_ll.*t_mask_2_pos;
cndht_ed_010_2_pos(cndht_ed_010_2_pos == 0) =[];
cndht_ed_010_2_neg = cndht_ed_010_ll.*t_mask_2_neg;
cndht_ed_010_2_neg(cndht_ed_010_2_neg == 0) =[];

radht_ed_010_2_pos = radht_ed_010_ll.*t_mask_2_pos;
radht_ed_010_2_pos(radht_ed_010_2_pos == 0) =[];
radht_ed_010_2_neg = radht_ed_010_ll.*t_mask_2_neg;
radht_ed_010_2_neg(radht_ed_010_2_neg == 0) =[];

t_mask_1_pos = +(t_ed_010_ll > 0 & t_ed_010_ll <= 1);
t_mask_1_neg = +(t_ed_010_ll >= -1 & t_ed_010_ll < 0);

cndht_ed_010_1_pos = cndht_ed_010_ll.*t_mask_1_pos;
cndht_ed_010_1_pos(cndht_ed_010_1_pos == 0) =[];
cndht_ed_010_1_neg = cndht_ed_010_ll.*t_mask_1_neg;
cndht_ed_010_1_neg(cndht_ed_010_1_neg == 0) =[];

radht_ed_010_1_pos = radht_ed_010_ll.*t_mask_1_pos;
radht_ed_010_1_pos(radht_ed_010_1_pos == 0) =[];
radht_ed_010_1_neg = radht_ed_010_ll.*t_mask_1_neg;
radht_ed_010_1_neg(radht_ed_010_1_neg == 0) =[];


for i=1:90
%include lat weighting too
i
xbins = -45:0.2:45;

cndht_ed_010_5_pos_counts = hist(reshape(cndht_ed_010_5_pos,[numel(cndht_ed_010_5_pos),1]),xbins);
cndht_ed_010_5_pos_counts_cos(i,:) = cndht_ed_010_5_pos_counts.*cos(yi(i).*pi./180);

cndht_ed_010_5_neg_counts = hist(reshape(cndht_ed_010_5_neg,[numel(cndht_ed_010_5_neg),1]),xbins);
cndht_ed_010_5_neg_counts_cos(i,:) = cndht_ed_010_5_neg_counts.*cos(yi(i).*pi./180);


cndht_ed_010_4_pos_counts = hist(reshape(cndht_ed_010_4_pos,[numel(cndht_ed_010_4_pos),1]),xbins);
cndht_ed_010_4_pos_counts_cos(i,:) = cndht_ed_010_4_pos_counts.*cos(yi(i).*pi./180);

cndht_ed_010_4_neg_counts = hist(reshape(cndht_ed_010_4_neg,[numel(cndht_ed_010_4_neg),1]),xbins);
cndht_ed_010_4_neg_counts_cos(i,:) = cndht_ed_010_4_neg_counts.*cos(yi(i).*pi./180);


cndht_ed_010_3_pos_counts = hist(reshape(cndht_ed_010_3_pos,[numel(cndht_ed_010_3_pos),1]),xbins);
cndht_ed_010_3_pos_counts_cos(i,:) = cndht_ed_010_3_pos_counts.*cos(yi(i).*pi./180);

cndht_ed_010_3_neg_counts = hist(reshape(cndht_ed_010_3_neg,[numel(cndht_ed_010_3_neg),1]),xbins);
cndht_ed_010_3_neg_counts_cos(i,:) = cndht_ed_010_3_neg_counts.*cos(yi(i).*pi./180);


cndht_ed_010_2_pos_counts = hist(reshape(cndht_ed_010_2_pos,[numel(cndht_ed_010_2_pos),1]),xbins);
cndht_ed_010_2_pos_counts_cos(i,:) = cndht_ed_010_2_pos_counts.*cos(yi(i).*pi./180);

cndht_ed_010_2_neg_counts = hist(reshape(cndht_ed_010_2_neg,[numel(cndht_ed_010_2_neg),1]),xbins);
cndht_ed_010_2_neg_counts_cos(i,:) = cndht_ed_010_2_neg_counts.*cos(yi(i).*pi./180);



cndht_ed_010_1_pos_counts = hist(reshape(cndht_ed_010_1_pos,[numel(cndht_ed_010_1_pos),1]),xbins);
cndht_ed_010_1_pos_counts_cos(i,:) = cndht_ed_010_1_pos_counts.*cos(yi(i).*pi./180);

cndht_ed_010_1_neg_counts = hist(reshape(cndht_ed_010_1_neg,[numel(cndht_ed_010_1_neg),1]),xbins);
cndht_ed_010_1_neg_counts_cos(i,:) = cndht_ed_010_1_neg_counts.*cos(yi(i).*pi./180);




radht_ed_010_5_pos_counts = hist(reshape(radht_ed_010_5_pos,[numel(radht_ed_010_5_pos),1]),xbins);
radht_ed_010_5_pos_counts_cos(i,:) = radht_ed_010_5_pos_counts.*cos(yi(i).*pi./180);

radht_ed_010_5_neg_counts = hist(reshape(radht_ed_010_5_neg,[numel(radht_ed_010_5_neg),1]),xbins);
radht_ed_010_5_neg_counts_cos(i,:) = radht_ed_010_5_neg_counts.*cos(yi(i).*pi./180);


radht_ed_010_4_pos_counts = hist(reshape(radht_ed_010_4_pos,[numel(radht_ed_010_4_pos),1]),xbins);
radht_ed_010_4_pos_counts_cos(i,:) = radht_ed_010_4_pos_counts.*cos(yi(i).*pi./180);

radht_ed_010_4_neg_counts = hist(reshape(radht_ed_010_4_neg,[numel(radht_ed_010_4_neg),1]),xbins);
radht_ed_010_4_neg_counts_cos(i,:) = radht_ed_010_4_neg_counts.*cos(yi(i).*pi./180);


radht_ed_010_3_pos_counts = hist(reshape(radht_ed_010_3_pos,[numel(radht_ed_010_3_pos),1]),xbins);
radht_ed_010_3_pos_counts_cos(i,:) = radht_ed_010_3_pos_counts.*cos(yi(i).*pi./180);

radht_ed_010_3_neg_counts = hist(reshape(radht_ed_010_3_neg,[numel(radht_ed_010_3_neg),1]),xbins);
radht_ed_010_3_neg_counts_cos(i,:) = radht_ed_010_3_neg_counts.*cos(yi(i).*pi./180);


radht_ed_010_2_pos_counts = hist(reshape(radht_ed_010_2_pos,[numel(radht_ed_010_2_pos),1]),xbins);
radht_ed_010_2_pos_counts_cos(i,:) = radht_ed_010_2_pos_counts.*cos(yi(i).*pi./180);

radht_ed_010_2_neg_counts = hist(reshape(radht_ed_010_2_neg,[numel(radht_ed_010_2_neg),1]),xbins);
radht_ed_010_2_neg_counts_cos(i,:) = radht_ed_010_2_neg_counts.*cos(yi(i).*pi./180);



radht_ed_010_1_pos_counts = hist(reshape(radht_ed_010_1_pos,[numel(radht_ed_010_1_pos),1]),xbins);
radht_ed_010_1_pos_counts_cos(i,:) = radht_ed_010_1_pos_counts.*cos(yi(i).*pi./180);

radht_ed_010_1_neg_counts = hist(reshape(radht_ed_010_1_neg,[numel(radht_ed_010_1_neg),1]),xbins);
radht_ed_010_1_neg_counts_cos(i,:) = radht_ed_010_1_neg_counts.*cos(yi(i).*pi./180);


end


cndht_hist_5_pos = sum(cndht_ed_010_5_pos_counts_cos,1)./sum(sum(cndht_ed_010_5_pos_counts_cos));
cndht_hist_5_neg = sum(cndht_ed_010_5_neg_counts_cos,1)./sum(sum(cndht_ed_010_5_neg_counts_cos));

cndht_hist_4_pos = sum(cndht_ed_010_4_pos_counts_cos,1)./sum(sum(cndht_ed_010_4_pos_counts_cos));
cndht_hist_4_neg = sum(cndht_ed_010_4_neg_counts_cos,1)./sum(sum(cndht_ed_010_4_neg_counts_cos));

cndht_hist_3_pos = sum(cndht_ed_010_3_pos_counts_cos,1)./sum(sum(cndht_ed_010_3_pos_counts_cos));
cndht_hist_3_neg = sum(cndht_ed_010_3_neg_counts_cos,1)./sum(sum(cndht_ed_010_3_neg_counts_cos));

cndht_hist_2_pos = sum(cndht_ed_010_2_pos_counts_cos,1)./sum(sum(cndht_ed_010_2_pos_counts_cos));
cndht_hist_2_neg = sum(cndht_ed_010_2_neg_counts_cos,1)./sum(sum(cndht_ed_010_2_neg_counts_cos));

cndht_hist_1_pos = sum(cndht_ed_010_1_pos_counts_cos,1)./sum(sum(cndht_ed_010_1_pos_counts_cos));
cndht_hist_1_neg = sum(cndht_ed_010_1_neg_counts_cos,1)./sum(sum(cndht_ed_010_1_neg_counts_cos));


radht_hist_5_pos = sum(radht_ed_010_5_pos_counts_cos,1)./sum(sum(radht_ed_010_5_pos_counts_cos));
radht_hist_5_neg = sum(radht_ed_010_5_neg_counts_cos,1)./sum(sum(radht_ed_010_5_neg_counts_cos));

radht_hist_4_pos = sum(radht_ed_010_4_pos_counts_cos,1)./sum(sum(radht_ed_010_4_pos_counts_cos));
radht_hist_4_neg = sum(radht_ed_010_4_neg_counts_cos,1)./sum(sum(radht_ed_010_4_neg_counts_cos));

radht_hist_3_pos = sum(radht_ed_010_3_pos_counts_cos,1)./sum(sum(radht_ed_010_3_pos_counts_cos));
radht_hist_3_neg = sum(radht_ed_010_3_neg_counts_cos,1)./sum(sum(radht_ed_010_3_neg_counts_cos));

radht_hist_2_pos = sum(radht_ed_010_2_pos_counts_cos,1)./sum(sum(radht_ed_010_2_pos_counts_cos));
radht_hist_2_neg = sum(radht_ed_010_2_neg_counts_cos,1)./sum(sum(radht_ed_010_2_neg_counts_cos));

radht_hist_1_pos = sum(radht_ed_010_1_pos_counts_cos,1)./sum(sum(radht_ed_010_1_pos_counts_cos));
radht_hist_1_neg = sum(radht_ed_010_1_neg_counts_cos,1)./sum(sum(radht_ed_010_1_neg_counts_cos));


save('/project/rg312/mat_files/cnd_rad_hists_trange_010.mat')

