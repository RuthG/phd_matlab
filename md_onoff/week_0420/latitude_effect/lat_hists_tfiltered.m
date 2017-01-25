%produce histograms of latitudes associated with a given T' range to see if double peaks can be explained this way

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

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_000')
t_000_ll = squeeze(cube2latlon(xc,yc,t_000(:,:,3,1:719),xi,yi));
t_000_ll_tav = repmat(mean(t_000_ll,3),[1 1 719]);
t_ed_000_ll = t_000_ll - t_000_ll_tav;
clear('t_000')

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_100')
t_100_ll = squeeze(cube2latlon(xc,yc,t_100(:,:,3,1:719),xi,yi));
t_100_ll_tav = repmat(mean(t_100_ll,3),[1 1 719]);
t_ed_100_ll = t_100_ll - t_100_ll_tav;
clear('t_100')

latmatrix = repmat(yi,[180,1,719]);

t_mask_4_pos_000 = +(t_ed_000_ll > 3 & t_ed_000_ll <= 4);
t_mask_4_neg_000 = +(t_ed_000_ll >= -4 & t_ed_000_ll < -3);

lat_000_4_pos = latmatrix.*t_mask_4_pos_000;
lat_000_4_pos(lat_000_4_pos == 0) =[];
lat_000_4_neg = latmatrix.*t_mask_4_neg_000;
lat_000_4_neg(lat_000_4_neg == 0) =[];

t_mask_4_pos_100 = +(t_ed_100_ll > 3 & t_ed_100_ll <= 4);
t_mask_4_neg_100 = +(t_ed_100_ll >= -4 & t_ed_100_ll < -3);

lat_100_4_pos = latmatrix.*t_mask_4_pos_100;
lat_100_4_pos(lat_100_4_pos == 0) =[];
lat_100_4_neg = latmatrix.*t_mask_4_neg_100;
lat_100_4_neg(lat_100_4_neg == 0) =[];

t_mask_3_pos_000 = +(t_ed_000_ll > 2 & t_ed_000_ll <= 3);
t_mask_3_neg_000 = +(t_ed_000_ll >= -3 & t_ed_000_ll < -2);

lat_000_3_pos = latmatrix.*t_mask_3_pos_000;
lat_000_3_pos(lat_000_3_pos == 0) =[];
lat_000_3_neg = latmatrix.*t_mask_3_neg_000;
lat_000_3_neg(lat_000_3_neg == 0) =[];

t_mask_3_pos_100 = +(t_ed_100_ll > 2 & t_ed_100_ll <= 3);
t_mask_3_neg_100 = +(t_ed_100_ll >= -3 & t_ed_100_ll < -2);

lat_100_3_pos = latmatrix.*t_mask_3_pos_100;
lat_100_3_pos(lat_100_3_pos == 0) =[];
lat_100_3_neg = latmatrix.*t_mask_3_neg_100;
lat_100_3_neg(lat_100_3_neg == 0) =[];


t_mask_2_pos_000 = +(t_ed_000_ll > 1 & t_ed_000_ll <= 2);
t_mask_2_neg_000 = +(t_ed_000_ll >= -2 & t_ed_000_ll < -1);

lat_000_2_pos = latmatrix.*t_mask_2_pos_000;
lat_000_2_pos(lat_000_2_pos == 0) =[];
lat_000_2_neg = latmatrix.*t_mask_2_neg_000;
lat_000_2_neg(lat_000_2_neg == 0) =[];

t_mask_2_pos_100 = +(t_ed_100_ll > 1 & t_ed_100_ll <= 2);
t_mask_2_neg_100 = +(t_ed_100_ll >= -2 & t_ed_100_ll < -1);

lat_100_2_pos = latmatrix.*t_mask_2_pos_100;
lat_100_2_pos(lat_100_2_pos == 0) =[];
lat_100_2_neg = latmatrix.*t_mask_2_neg_100;
lat_100_2_neg(lat_100_2_neg == 0) =[];



t_mask_1_pos_000 = +(t_ed_000_ll > 0 & t_ed_000_ll <= 1);
t_mask_1_neg_000 = +(t_ed_000_ll >= -1 & t_ed_000_ll < 0);

lat_000_1_pos = latmatrix.*t_mask_1_pos_000;
lat_000_1_pos(lat_000_1_pos == 0) =[];
lat_000_1_neg = latmatrix.*t_mask_1_neg_000;
lat_000_1_neg(lat_000_1_neg == 0) =[];

t_mask_1_pos_100 = +(t_ed_100_ll > 0 & t_ed_100_ll <= 1);
t_mask_1_neg_100 = +(t_ed_100_ll >= -1 & t_ed_100_ll < 0);

lat_100_1_pos = latmatrix.*t_mask_1_pos_100;
lat_100_1_pos(lat_100_1_pos == 0) =[];
lat_100_1_neg = latmatrix.*t_mask_1_neg_100;
lat_100_1_neg(lat_100_1_neg == 0) =[];



for i=1:90
%include lat weighting too
i
xbins = -90:1:90;
lat_000_4_pos_counts = hist(reshape(lat_000_4_pos,[numel(lat_000_4_pos),1]),xbins);
lat_000_4_pos_counts_cos(i,:) = lat_000_4_pos_counts.*cos(yi(i).*pi./180);

lat_000_4_neg_counts = hist(reshape(lat_000_4_neg,[numel(lat_000_4_neg),1]),xbins);
lat_000_4_neg_counts_cos(i,:) = lat_000_4_neg_counts.*cos(yi(i).*pi./180);

lat_000_3_pos_counts = hist(reshape(lat_000_3_pos,[numel(lat_000_3_pos),1]),xbins);
lat_000_3_pos_counts_cos(i,:) = lat_000_3_pos_counts.*cos(yi(i).*pi./180);

lat_000_3_neg_counts = hist(reshape(lat_000_3_neg,[numel(lat_000_3_neg),1]),xbins);
lat_000_3_neg_counts_cos(i,:) = lat_000_3_neg_counts.*cos(yi(i).*pi./180);

lat_000_2_pos_counts = hist(reshape(lat_000_2_pos,[numel(lat_000_2_pos),1]),xbins);
lat_000_2_pos_counts_cos(i,:) = lat_000_2_pos_counts.*cos(yi(i).*pi./180);

lat_000_2_neg_counts = hist(reshape(lat_000_2_neg,[numel(lat_000_2_neg),1]),xbins);
lat_000_2_neg_counts_cos(i,:) = lat_000_2_neg_counts.*cos(yi(i).*pi./180);

lat_000_1_pos_counts = hist(reshape(lat_000_1_pos,[numel(lat_000_1_pos),1]),xbins);
lat_000_1_pos_counts_cos(i,:) = lat_000_1_pos_counts.*cos(yi(i).*pi./180);

lat_000_1_neg_counts = hist(reshape(lat_000_1_neg,[numel(lat_000_1_neg),1]),xbins);
lat_000_1_neg_counts_cos(i,:) = lat_000_1_neg_counts.*cos(yi(i).*pi./180);



lat_100_4_pos_counts = hist(reshape(lat_100_4_pos,[numel(lat_100_4_pos),1]),xbins);
lat_100_4_pos_counts_cos(i,:) = lat_100_4_pos_counts.*cos(yi(i).*pi./180);

lat_100_4_neg_counts = hist(reshape(lat_100_4_neg,[numel(lat_100_4_neg),1]),xbins);
lat_100_4_neg_counts_cos(i,:) = lat_100_4_neg_counts.*cos(yi(i).*pi./180);

lat_100_3_pos_counts = hist(reshape(lat_100_3_pos,[numel(lat_100_3_pos),1]),xbins);
lat_100_3_pos_counts_cos(i,:) = lat_100_3_pos_counts.*cos(yi(i).*pi./180);

lat_100_3_neg_counts = hist(reshape(lat_100_3_neg,[numel(lat_100_3_neg),1]),xbins);
lat_100_3_neg_counts_cos(i,:) = lat_100_3_neg_counts.*cos(yi(i).*pi./180);

lat_100_2_pos_counts = hist(reshape(lat_100_2_pos,[numel(lat_100_2_pos),1]),xbins);
lat_100_2_pos_counts_cos(i,:) = lat_100_2_pos_counts.*cos(yi(i).*pi./180);

lat_100_2_neg_counts = hist(reshape(lat_100_2_neg,[numel(lat_100_2_neg),1]),xbins);
lat_100_2_neg_counts_cos(i,:) = lat_100_2_neg_counts.*cos(yi(i).*pi./180);

lat_100_1_pos_counts = hist(reshape(lat_100_1_pos,[numel(lat_100_1_pos),1]),xbins);
lat_100_1_pos_counts_cos(i,:) = lat_100_1_pos_counts.*cos(yi(i).*pi./180);

lat_100_1_neg_counts = hist(reshape(lat_100_1_neg,[numel(lat_100_1_neg),1]),xbins);
lat_100_1_neg_counts_cos(i,:) = lat_100_1_neg_counts.*cos(yi(i).*pi./180);

end

lat_hist_000_4_pos = sum(lat_000_4_pos_counts_cos,1)./sum(sum(lat_000_4_pos_counts_cos));
lat_hist_000_3_pos = sum(lat_000_3_pos_counts_cos,1)./sum(sum(lat_000_3_pos_counts_cos));
lat_hist_000_2_pos = sum(lat_000_2_pos_counts_cos,1)./sum(sum(lat_000_2_pos_counts_cos));
lat_hist_000_1_pos = sum(lat_000_1_pos_counts_cos,1)./sum(sum(lat_000_1_pos_counts_cos));
lat_hist_000_4_neg = sum(lat_000_4_neg_counts_cos,1)./sum(sum(lat_000_4_neg_counts_cos));
lat_hist_000_3_neg = sum(lat_000_3_neg_counts_cos,1)./sum(sum(lat_000_3_neg_counts_cos));
lat_hist_000_2_neg = sum(lat_000_2_neg_counts_cos,1)./sum(sum(lat_000_2_neg_counts_cos));
lat_hist_000_1_neg = sum(lat_000_1_neg_counts_cos,1)./sum(sum(lat_000_1_neg_counts_cos));


lat_hist_100_4_pos = sum(lat_100_4_pos_counts_cos,1)./sum(sum(lat_100_4_pos_counts_cos));
lat_hist_100_3_pos = sum(lat_100_3_pos_counts_cos,1)./sum(sum(lat_100_3_pos_counts_cos));
lat_hist_100_2_pos = sum(lat_100_2_pos_counts_cos,1)./sum(sum(lat_100_2_pos_counts_cos));
lat_hist_100_1_pos = sum(lat_100_1_pos_counts_cos,1)./sum(sum(lat_100_1_pos_counts_cos));
lat_hist_100_4_neg = sum(lat_100_4_neg_counts_cos,1)./sum(sum(lat_100_4_neg_counts_cos));
lat_hist_100_3_neg = sum(lat_100_3_neg_counts_cos,1)./sum(sum(lat_100_3_neg_counts_cos));
lat_hist_100_2_neg = sum(lat_100_2_neg_counts_cos,1)./sum(sum(lat_100_2_neg_counts_cos));
lat_hist_100_1_neg = sum(lat_100_1_neg_counts_cos,1)./sum(sum(lat_100_1_neg_counts_cos));



figure
h_000=bar(xbins,lat_hist_000_1_neg,'r');
hold on;
h_100=bar(xbins,lat_hist_000_1_pos);
alpha(get(h_000,'children'),.5);
alpha(get(h_100,'children'),.25);
set(h_000,'EdgeColor','none')
%ylim([0 0.25])
%xlim([-20 20])
set(gca,'FontSize',15);
xlabel('Latitude')
ylabel('Probability')
title('PDF of latitudes associated with |T''|<1 in the dry model')
%dryleg = ['Dry'];
%wetleg = ['Wet'];
legend('-ve T''', '+ve T''')
print('-dpng','lathist_000_1.png')


figure
h_000=bar(xbins,lat_hist_100_1_neg,'r');
hold on;
h_100=bar(xbins,lat_hist_100_1_pos);
alpha(get(h_000,'children'),.5);
alpha(get(h_100,'children'),.25);
set(h_000,'EdgeColor','none')
%ylim([0 0.25])
%xlim([-20 20])
set(gca,'FontSize',15);
xlabel('Latitude')
ylabel('Probability')
title('PDF of latitudes associated with |T''|<1 in the wet model')
%dryleg = ['Dry'];
%wetleg = ['Wet'];
legend('-ve T''', '+ve T''')
print('-dpng','lathist_100_1.png')



figure
h_000=bar(xbins,lat_hist_000_2_neg,'r');
hold on;
h_100=bar(xbins,lat_hist_000_2_pos);
alpha(get(h_000,'children'),.5);
alpha(get(h_100,'children'),.25);
set(h_000,'EdgeColor','none')
%ylim([0 0.25])
%xlim([-20 20])
set(gca,'FontSize',15);
xlabel('Latitude')
ylabel('Probability')
title('PDF of latitudes associated with 1<|T''|<2 in the dry model')
%dryleg = ['Dry'];
%wetleg = ['Wet'];
legend('-ve T''', '+ve T''')
print('-dpng','lathist_000_2.png')


figure
h_000=bar(xbins,lat_hist_100_2_neg,'r');
hold on;
h_100=bar(xbins,lat_hist_100_2_pos);
alpha(get(h_000,'children'),.5);
alpha(get(h_100,'children'),.25);
set(h_000,'EdgeColor','none')
%ylim([0 0.25])
%xlim([-20 20])
set(gca,'FontSize',15);
xlabel('Latitude')
ylabel('Probability')
title('PDF of latitudes associated with 1<|T''|<2 in the wet model')
%dryleg = ['Dry'];
%wetleg = ['Wet'];
legend('-ve T''', '+ve T''')
print('-dpng','lathist_100_2.png')
