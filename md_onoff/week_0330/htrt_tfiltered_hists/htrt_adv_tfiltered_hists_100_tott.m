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

load('/project/rg312/mat_files/heat_rates_best.mat','htrt_100')
load('/project/rg312/mat_files/totttend_100_best.mat','totttend_snap_100')

advtend_100 = totttend_snap_100 - htrt_100.*86400;

totttend_snap_100_ll = squeeze(cube2latlon(xc,yc,totttend_snap_100(:,:,5,1:719),xi,yi));
totttend_snap_100_ll_tav = repmat(mean(totttend_snap_100_ll,3),[1 1 719]);
totttend_snap_ed_100_ll = totttend_snap_100_ll - totttend_snap_100_ll_tav;
clear('totttend_snap_100')

advtend_100_ll = squeeze(cube2latlon(xc,yc,advtend_100(:,:,5,1:719),xi,yi));
advtend_100_ll_tav = repmat(mean(advtend_100_ll,3),[1 1 719]);
advtend_ed_100_ll = advtend_100_ll - advtend_100_ll_tav;
clear('advtend_100')

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_100')
t_100_ll = squeeze(cube2latlon(xc,yc,t_100(:,:,5,1:719),xi,yi));
t_100_ll_tav = repmat(mean(t_100_ll,3),[1 1 719]);
t_ed_100_ll = t_100_ll - t_100_ll_tav;
clear('t_100')


%masking

t_mask_5_pos = +(t_ed_100_ll >= 4 & t_ed_100_ll <= 5);
t_mask_5_neg = +(t_ed_100_ll >= -5 & t_ed_100_ll <= -4);

totttend_snap_ed_100_5_pos = totttend_snap_ed_100_ll.*t_mask_5_pos;
totttend_snap_ed_100_5_pos(totttend_snap_ed_100_5_pos == 0) =[];
totttend_snap_ed_100_5_neg = totttend_snap_ed_100_ll.*t_mask_5_neg;
totttend_snap_ed_100_5_neg(totttend_snap_ed_100_5_neg == 0) =[];

advtend_ed_100_5_pos = advtend_ed_100_ll.*t_mask_5_pos;
advtend_ed_100_5_pos(advtend_ed_100_5_pos == 0) =[];
advtend_ed_100_5_neg = advtend_ed_100_ll.*t_mask_5_neg;
advtend_ed_100_5_neg(advtend_ed_100_5_neg == 0) =[];


t_mask_4_pos = +(t_ed_100_ll >= 3 & t_ed_100_ll <= 4);
t_mask_4_neg = +(t_ed_100_ll >= -4 & t_ed_100_ll <= -3);

totttend_snap_ed_100_4_pos = totttend_snap_ed_100_ll.*t_mask_4_pos;
totttend_snap_ed_100_4_pos(totttend_snap_ed_100_4_pos == 0) =[];
totttend_snap_ed_100_4_neg = totttend_snap_ed_100_ll.*t_mask_4_neg;
totttend_snap_ed_100_4_neg(totttend_snap_ed_100_4_neg == 0) =[];

advtend_ed_100_4_pos = advtend_ed_100_ll.*t_mask_4_pos;
advtend_ed_100_4_pos(advtend_ed_100_4_pos == 0) =[];
advtend_ed_100_4_neg = advtend_ed_100_ll.*t_mask_4_neg;
advtend_ed_100_4_neg(advtend_ed_100_4_neg == 0) =[];



t_mask_3_pos = +(t_ed_100_ll >= 2 & t_ed_100_ll <= 3);
t_mask_3_neg = +(t_ed_100_ll >= -3 & t_ed_100_ll <= -2);

totttend_snap_ed_100_3_pos = totttend_snap_ed_100_ll.*t_mask_3_pos;
totttend_snap_ed_100_3_pos(totttend_snap_ed_100_3_pos == 0) =[];
totttend_snap_ed_100_3_neg = totttend_snap_ed_100_ll.*t_mask_3_neg;
totttend_snap_ed_100_3_neg(totttend_snap_ed_100_3_neg == 0) =[];

advtend_ed_100_3_pos = advtend_ed_100_ll.*t_mask_3_pos;
advtend_ed_100_3_pos(advtend_ed_100_3_pos == 0) =[];
advtend_ed_100_3_neg = advtend_ed_100_ll.*t_mask_3_neg;
advtend_ed_100_3_neg(advtend_ed_100_3_neg == 0) =[];


t_mask_2_pos = +(t_ed_100_ll >= 1 & t_ed_100_ll <= 2);
t_mask_2_neg = +(t_ed_100_ll >= -2 & t_ed_100_ll <= -1);

totttend_snap_ed_100_2_pos = totttend_snap_ed_100_ll.*t_mask_2_pos;
totttend_snap_ed_100_2_pos(totttend_snap_ed_100_2_pos == 0) =[];
totttend_snap_ed_100_2_neg = totttend_snap_ed_100_ll.*t_mask_2_neg;
totttend_snap_ed_100_2_neg(totttend_snap_ed_100_2_neg == 0) =[];

advtend_ed_100_2_pos = advtend_ed_100_ll.*t_mask_2_pos;
advtend_ed_100_2_pos(advtend_ed_100_2_pos == 0) =[];
advtend_ed_100_2_neg = advtend_ed_100_ll.*t_mask_2_neg;
advtend_ed_100_2_neg(advtend_ed_100_2_neg == 0) =[];



t_mask_1_pos = +(t_ed_100_ll >= 0 & t_ed_100_ll <= 1);
t_mask_1_neg = +(t_ed_100_ll >= -1 & t_ed_100_ll <= 0);

totttend_snap_ed_100_1_pos = totttend_snap_ed_100_ll.*t_mask_1_pos;
totttend_snap_ed_100_1_pos(totttend_snap_ed_100_1_pos == 0) =[];
totttend_snap_ed_100_1_neg = totttend_snap_ed_100_ll.*t_mask_1_neg;
totttend_snap_ed_100_1_neg(totttend_snap_ed_100_1_neg == 0) =[];

advtend_ed_100_1_pos = advtend_ed_100_ll.*t_mask_1_pos;
advtend_ed_100_1_pos(advtend_ed_100_1_pos == 0) =[];
advtend_ed_100_1_neg = advtend_ed_100_ll.*t_mask_1_neg;
advtend_ed_100_1_neg(advtend_ed_100_1_neg == 0) =[];





for i=1:90
%include lat weighting too
i
xbins = -33:0.1:33;

totttend_snap_ed_100_5_pos_counts = hist(reshape(totttend_snap_ed_100_5_pos,[numel(totttend_snap_ed_100_5_pos),1]),xbins);
totttend_snap_ed_100_5_pos_counts_cos(i,:) = totttend_snap_ed_100_5_pos_counts.*cos(yi(i).*pi./180);
totttend_snap_ed_100_5_neg_counts = hist(reshape(totttend_snap_ed_100_5_neg,[numel(totttend_snap_ed_100_5_neg),1]),xbins);
totttend_snap_ed_100_5_neg_counts_cos(i,:) = totttend_snap_ed_100_5_neg_counts.*cos(yi(i).*pi./180);

advtend_ed_100_5_pos_counts = hist(reshape(advtend_ed_100_5_pos,[numel(advtend_ed_100_5_pos),1]),xbins);
advtend_ed_100_5_pos_counts_cos(i,:) = advtend_ed_100_5_pos_counts.*cos(yi(i).*pi./180);
advtend_ed_100_5_neg_counts = hist(reshape(advtend_ed_100_5_neg,[numel(advtend_ed_100_5_neg),1]),xbins);
advtend_ed_100_5_neg_counts_cos(i,:) = advtend_ed_100_5_neg_counts.*cos(yi(i).*pi./180);


totttend_snap_ed_100_4_pos_counts = hist(reshape(totttend_snap_ed_100_4_pos,[numel(totttend_snap_ed_100_4_pos),1]),xbins);
totttend_snap_ed_100_4_pos_counts_cos(i,:) = totttend_snap_ed_100_4_pos_counts.*cos(yi(i).*pi./180);
totttend_snap_ed_100_4_neg_counts = hist(reshape(totttend_snap_ed_100_4_neg,[numel(totttend_snap_ed_100_4_neg),1]),xbins);
totttend_snap_ed_100_4_neg_counts_cos(i,:) = totttend_snap_ed_100_4_neg_counts.*cos(yi(i).*pi./180);

advtend_ed_100_4_pos_counts = hist(reshape(advtend_ed_100_4_pos,[numel(advtend_ed_100_4_pos),1]),xbins);
advtend_ed_100_4_pos_counts_cos(i,:) = advtend_ed_100_4_pos_counts.*cos(yi(i).*pi./180);
advtend_ed_100_4_neg_counts = hist(reshape(advtend_ed_100_4_neg,[numel(advtend_ed_100_4_neg),1]),xbins);
advtend_ed_100_4_neg_counts_cos(i,:) = advtend_ed_100_4_neg_counts.*cos(yi(i).*pi./180);


totttend_snap_ed_100_3_pos_counts = hist(reshape(totttend_snap_ed_100_3_pos,[numel(totttend_snap_ed_100_3_pos),1]),xbins);
totttend_snap_ed_100_3_pos_counts_cos(i,:) = totttend_snap_ed_100_3_pos_counts.*cos(yi(i).*pi./180);
totttend_snap_ed_100_3_neg_counts = hist(reshape(totttend_snap_ed_100_3_neg,[numel(totttend_snap_ed_100_3_neg),1]),xbins);
totttend_snap_ed_100_3_neg_counts_cos(i,:) = totttend_snap_ed_100_3_neg_counts.*cos(yi(i).*pi./180);

advtend_ed_100_3_pos_counts = hist(reshape(advtend_ed_100_3_pos,[numel(advtend_ed_100_3_pos),1]),xbins);
advtend_ed_100_3_pos_counts_cos(i,:) = advtend_ed_100_3_pos_counts.*cos(yi(i).*pi./180);
advtend_ed_100_3_neg_counts = hist(reshape(advtend_ed_100_3_neg,[numel(advtend_ed_100_3_neg),1]),xbins);
advtend_ed_100_3_neg_counts_cos(i,:) = advtend_ed_100_3_neg_counts.*cos(yi(i).*pi./180);

totttend_snap_ed_100_2_pos_counts = hist(reshape(totttend_snap_ed_100_2_pos,[numel(totttend_snap_ed_100_2_pos),1]),xbins);
totttend_snap_ed_100_2_pos_counts_cos(i,:) = totttend_snap_ed_100_2_pos_counts.*cos(yi(i).*pi./180);
totttend_snap_ed_100_2_neg_counts = hist(reshape(totttend_snap_ed_100_2_neg,[numel(totttend_snap_ed_100_2_neg),1]),xbins);
totttend_snap_ed_100_2_neg_counts_cos(i,:) = totttend_snap_ed_100_2_neg_counts.*cos(yi(i).*pi./180);

advtend_ed_100_2_pos_counts = hist(reshape(advtend_ed_100_2_pos,[numel(advtend_ed_100_2_pos),1]),xbins);
advtend_ed_100_2_pos_counts_cos(i,:) = advtend_ed_100_2_pos_counts.*cos(yi(i).*pi./180);
advtend_ed_100_2_neg_counts = hist(reshape(advtend_ed_100_2_neg,[numel(advtend_ed_100_2_neg),1]),xbins);
advtend_ed_100_2_neg_counts_cos(i,:) = advtend_ed_100_2_neg_counts.*cos(yi(i).*pi./180);

totttend_snap_ed_100_1_pos_counts = hist(reshape(totttend_snap_ed_100_1_pos,[numel(totttend_snap_ed_100_1_pos),1]),xbins);
totttend_snap_ed_100_1_pos_counts_cos(i,:) = totttend_snap_ed_100_1_pos_counts.*cos(yi(i).*pi./180);
totttend_snap_ed_100_1_neg_counts = hist(reshape(totttend_snap_ed_100_1_neg,[numel(totttend_snap_ed_100_1_neg),1]),xbins);
totttend_snap_ed_100_1_neg_counts_cos(i,:) = totttend_snap_ed_100_1_neg_counts.*cos(yi(i).*pi./180);

advtend_ed_100_1_pos_counts = hist(reshape(advtend_ed_100_1_pos,[numel(advtend_ed_100_1_pos),1]),xbins);
advtend_ed_100_1_pos_counts_cos(i,:) = advtend_ed_100_1_pos_counts.*cos(yi(i).*pi./180);
advtend_ed_100_1_neg_counts = hist(reshape(advtend_ed_100_1_neg,[numel(advtend_ed_100_1_neg),1]),xbins);
advtend_ed_100_1_neg_counts_cos(i,:) = advtend_ed_100_1_neg_counts.*cos(yi(i).*pi./180);

end


totttend_ed_5_pos = sum(totttend_snap_ed_100_5_pos_counts_cos,1)./sum(sum(totttend_snap_ed_100_5_pos_counts_cos));
totttend_ed_5_neg = sum(totttend_snap_ed_100_5_neg_counts_cos,1)./sum(sum(totttend_snap_ed_100_5_neg_counts_cos));
advtend_ed_5_pos = sum(advtend_ed_100_5_pos_counts_cos,1)./sum(sum(advtend_ed_100_5_pos_counts_cos));
advtend_ed_5_neg = sum(advtend_ed_100_5_neg_counts_cos,1)./sum(sum(advtend_ed_100_5_neg_counts_cos));


totttend_ed_4_pos = sum(totttend_snap_ed_100_4_pos_counts_cos,1)./sum(sum(totttend_snap_ed_100_4_pos_counts_cos));
totttend_ed_4_neg = sum(totttend_snap_ed_100_4_neg_counts_cos,1)./sum(sum(totttend_snap_ed_100_4_neg_counts_cos));
advtend_ed_4_pos = sum(advtend_ed_100_4_pos_counts_cos,1)./sum(sum(advtend_ed_100_4_pos_counts_cos));
advtend_ed_4_neg = sum(advtend_ed_100_4_neg_counts_cos,1)./sum(sum(advtend_ed_100_4_neg_counts_cos));


totttend_ed_3_pos = sum(totttend_snap_ed_100_3_pos_counts_cos,1)./sum(sum(totttend_snap_ed_100_3_pos_counts_cos));
totttend_ed_3_neg = sum(totttend_snap_ed_100_3_neg_counts_cos,1)./sum(sum(totttend_snap_ed_100_3_neg_counts_cos));
advtend_ed_3_pos = sum(advtend_ed_100_3_pos_counts_cos,1)./sum(sum(advtend_ed_100_3_pos_counts_cos));
advtend_ed_3_neg = sum(advtend_ed_100_3_neg_counts_cos,1)./sum(sum(advtend_ed_100_3_neg_counts_cos));


totttend_ed_2_pos = sum(totttend_snap_ed_100_2_pos_counts_cos,1)./sum(sum(totttend_snap_ed_100_2_pos_counts_cos));
totttend_ed_2_neg = sum(totttend_snap_ed_100_2_neg_counts_cos,1)./sum(sum(totttend_snap_ed_100_2_neg_counts_cos));
advtend_ed_2_pos = sum(advtend_ed_100_2_pos_counts_cos,1)./sum(sum(advtend_ed_100_2_pos_counts_cos));
advtend_ed_2_neg = sum(advtend_ed_100_2_neg_counts_cos,1)./sum(sum(advtend_ed_100_2_neg_counts_cos));


totttend_ed_1_pos = sum(totttend_snap_ed_100_1_pos_counts_cos,1)./sum(sum(totttend_snap_ed_100_1_pos_counts_cos));
totttend_ed_1_neg = sum(totttend_snap_ed_100_1_neg_counts_cos,1)./sum(sum(totttend_snap_ed_100_1_neg_counts_cos));
advtend_ed_1_pos = sum(advtend_ed_100_1_pos_counts_cos,1)./sum(sum(advtend_ed_100_1_pos_counts_cos));
advtend_ed_1_neg = sum(advtend_ed_100_1_neg_counts_cos,1)./sum(sum(advtend_ed_100_1_neg_counts_cos));



save('/project/rg312/mat_files/htrt_adv_hists_trange_100_tot.mat')

