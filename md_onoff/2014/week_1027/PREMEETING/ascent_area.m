%calculate the percentage area of the subsidence region occupied by ascent

load('w_snapshots_saved.mat')
load('w_sc.mat')

%select region for each run based on time/zonal averaged w

latmask_000 = (abs(yc(:,:)) > 12 & abs(yc(:,:) < 33));
latmask_010 = (abs(yc(:,:)) > 10 & abs(yc(:,:) < 32));
latmask_025 = (abs(yc(:,:)) > 8 & abs(yc(:,:) < 31));
latmask_050 = (abs(yc(:,:)) > 10 & abs(yc(:,:) < 36));
latmask_075 = (abs(yc(:,:)) > 12 & abs(yc(:,:) < 41));
latmask_100 = (abs(yc(:,:)) > 10 & abs(yc(:,:) < 46));

%also blank out corners (y = 1:3, 30:32, x = 1:3, 30:35, 62:67, 94:99, 126:131, 158:163, 190:192)

corner_cover = ones(192,32);
corner_cover(1:3,1:3) = 0; corner_cover(1:3,30:32) = 0;
corner_cover(30:35,1:3) = 0; corner_cover(30:35,30:32) = 0;
corner_cover(62:67,1:3) = 0; corner_cover(62:67,30:32) = 0;
corner_cover(94:99,1:3) = 0; corner_cover(94:99,30:32) = 0;
corner_cover(126:131,1:3) = 0; corner_cover(126:131,30:32) = 0;
corner_cover(158:163,1:3) = 0; corner_cover(158:163,30:32) = 0;
corner_cover(190:192,1:3) = 0; corner_cover(190:192,30:32) = 0;


%multiply corner mask by mask for selected latitudes by area to get a masked area matrix

latmaskar_000 = latmask_000.*corner_cover.*ar;
latmaskar_010 = latmask_010.*corner_cover.*ar;
latmaskar_025 = latmask_025.*corner_cover.*ar;
latmaskar_050 = latmask_050.*corner_cover.*ar;
latmaskar_075 = latmask_075.*corner_cover.*ar;
latmaskar_100 = latmask_100.*corner_cover.*ar;

%find locations where w is negative (=ascent in Pa/s) and average the count over time to find the average number of negative events at each grid point. Multiplying by area mask and summing over all points will then give average area of ascent

w_asc_000 = mean((w_000(:,:,11,:) < 0),4).*latmaskar_000;
w_asc_010 = mean((w_010(:,:,11,:) < 0),4).*latmaskar_010;
w_asc_025 = mean((w_025(:,:,11,:) < 0),4).*latmaskar_025;
w_asc_050 = mean((w_050(:,:,11,:) < 0),4).*latmaskar_050;
w_asc_075 = mean((w_075(:,:,11,:) < 0),4).*latmaskar_075;
w_asc_100 = mean((w_100(:,:,11,:) < 0),4).*latmaskar_100;


%divide average area of ascent by total area of the subsidence region to find fractional area of ascent

w_asc_frac_000 = sum(sum(w_asc_000,1),2)./sum(sum(latmaskar_000));
w_asc_frac_010 = sum(sum(w_asc_010,1),2)./sum(sum(latmaskar_010));
w_asc_frac_025 = sum(sum(w_asc_025,1),2)./sum(sum(latmaskar_025));
w_asc_frac_050 = sum(sum(w_asc_050,1),2)./sum(sum(latmaskar_050));
w_asc_frac_075 = sum(sum(w_asc_075,1),2)./sum(sum(latmaskar_075));
w_asc_frac_100 = sum(sum(w_asc_100,1),2)./sum(sum(latmaskar_100));




