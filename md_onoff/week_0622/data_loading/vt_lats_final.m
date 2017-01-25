%vt_extremes.m
%load in vt data
%take time average and zonal average and locate maxima, use these to locate composites (+-15 degrees from max)
%find peaks of v't' (transient) at these latitudes 


rDir='/project/rg312/final_runs/run_000_final/';
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
xi=-179:2:179;
yi=-89:2:89;

load('/project/rg312/mat_files/snapshot_data_final/run_000_ns/vN_000_timemean.mat');
vN_000_tav = vN_ll_tav;
load('/project/rg312/mat_files/snapshot_data_final/run_010/vN_010_timemean.mat');
vN_010_tav = vN_ll_tav;
load('/project/rg312/mat_files/snapshot_data_final/run_025/vN_025_timemean.mat');
vN_025_tav = vN_ll_tav;
load('/project/rg312/mat_files/snapshot_data_final/run_050/vN_050_timemean.mat');
vN_050_tav = vN_ll_tav;
load('/project/rg312/mat_files/snapshot_data_final/run_075/vN_075_timemean.mat');
vN_075_tav = vN_ll_tav;
load('/project/rg312/mat_files/snapshot_data_final/run_100/vN_100_timemean.mat');
vN_100_tav = vN_ll_tav;
load('/project/rg312/mat_files/snapshot_data_final/run_125/vN_125_timemean.mat');
vN_125_tav = vN_ll_tav;
load('/project/rg312/mat_files/snapshot_data_final/run_150/vN_150_timemean.mat');
vN_150_tav = vN_ll_tav;

load('/project/rg312/mat_files/snapshot_data_final/run_000_ns/t_000_timemean.mat');
t_000_tav = t_ll_tav;
load('/project/rg312/mat_files/snapshot_data_final/run_010/t_010_timemean.mat');
t_010_tav = t_ll_tav;
load('/project/rg312/mat_files/snapshot_data_final/run_025/t_025_timemean.mat');
t_025_tav = t_ll_tav;
load('/project/rg312/mat_files/snapshot_data_final/run_050/t_050_timemean.mat');
t_050_tav = t_ll_tav;
load('/project/rg312/mat_files/snapshot_data_final/run_075/t_075_timemean.mat');
t_075_tav = t_ll_tav;
load('/project/rg312/mat_files/snapshot_data_final/run_100/t_100_timemean.mat');
t_100_tav = t_ll_tav;
load('/project/rg312/mat_files/snapshot_data_final/run_125/t_125_timemean.mat');
t_125_tav = t_ll_tav;
load('/project/rg312/mat_files/snapshot_data_final/run_150/t_150_timemean.mat');
t_150_tav = t_ll_tav;

for year = 1:10
year
load(['/project/rg312/mat_files/snapshot_data_final/run_000_ns/vN_000_' num2str(year)  '.mat']);
vN_ed = cube2latlon(xc,yc,vN_000,xi,yi) - repmat(vN_000_tav,[1 1 1 360]);
load(['/project/rg312/mat_files/snapshot_data_final/run_000_ns/t_000_' num2str(year)  '.mat']);
t_ed = cube2latlon(xc,yc,t_000,xi,yi) - repmat(t_000_tav,[1 1 1 360]);
vNt_ed_000(:,:,year) = squeeze(mean(mean(vN_ed.*t_ed,4),1));

load(['/project/rg312/mat_files/snapshot_data_final/run_010/vN_010_' num2str(year)  '.mat']);
vN_ed = cube2latlon(xc,yc,vN_010,xi,yi) - repmat(vN_010_tav,[1 1 1 360]);
load(['/project/rg312/mat_files/snapshot_data_final/run_010/t_010_' num2str(year)  '.mat']);
t_ed = cube2latlon(xc,yc,t_010,xi,yi) - repmat(t_010_tav,[1 1 1 360]);
vNt_ed_010(:,:,year) = squeeze(mean(mean(vN_ed.*t_ed,4),1));

load(['/project/rg312/mat_files/snapshot_data_final/run_025/vN_025_' num2str(year)  '.mat']);
vN_ed = cube2latlon(xc,yc,vN_025,xi,yi) - repmat(vN_025_tav,[1 1 1 360]);
load(['/project/rg312/mat_files/snapshot_data_final/run_025/t_025_' num2str(year)  '.mat']);
t_ed = cube2latlon(xc,yc,t_025,xi,yi) - repmat(t_025_tav,[1 1 1 360]);
vNt_ed_025(:,:,year) = squeeze(mean(mean(vN_ed.*t_ed,4),1));

load(['/project/rg312/mat_files/snapshot_data_final/run_050/vN_050_' num2str(year)  '.mat']);
vN_ed = cube2latlon(xc,yc,vN_050,xi,yi) - repmat(vN_050_tav,[1 1 1 360]);
load(['/project/rg312/mat_files/snapshot_data_final/run_050/t_050_' num2str(year)  '.mat']);
t_ed = cube2latlon(xc,yc,t_050,xi,yi) - repmat(t_050_tav,[1 1 1 360]);
vNt_ed_050(:,:,year) = squeeze(mean(mean(vN_ed.*t_ed,4),1));

load(['/project/rg312/mat_files/snapshot_data_final/run_075/vN_075_' num2str(year)  '.mat']);
vN_ed = cube2latlon(xc,yc,vN_075,xi,yi) - repmat(vN_075_tav,[1 1 1 360]);
load(['/project/rg312/mat_files/snapshot_data_final/run_075/t_075_' num2str(year)  '.mat']);
t_ed = cube2latlon(xc,yc,t_075,xi,yi) - repmat(t_075_tav,[1 1 1 360]);
vNt_ed_075(:,:,year) = squeeze(mean(mean(vN_ed.*t_ed,4),1));

load(['/project/rg312/mat_files/snapshot_data_final/run_100/vN_100_' num2str(year)  '.mat']);
vN_ed = cube2latlon(xc,yc,vN_100,xi,yi) - repmat(vN_100_tav,[1 1 1 360]);
load(['/project/rg312/mat_files/snapshot_data_final/run_100/t_100_' num2str(year)  '.mat']);
t_ed = cube2latlon(xc,yc,t_100,xi,yi) - repmat(t_100_tav,[1 1 1 360]);
vNt_ed_100(:,:,year) = squeeze(mean(mean(vN_ed.*t_ed,4),1));

load(['/project/rg312/mat_files/snapshot_data_final/run_125/vN_125_' num2str(year)  '.mat']);
vN_ed = cube2latlon(xc,yc,vN_125,xi,yi) - repmat(vN_125_tav,[1 1 1 360]);
load(['/project/rg312/mat_files/snapshot_data_final/run_125/t_125_' num2str(year)  '.mat']);
t_ed = cube2latlon(xc,yc,t_125,xi,yi) - repmat(t_125_tav,[1 1 1 360]);
vNt_ed_125(:,:,year) = squeeze(mean(mean(vN_ed.*t_ed,4),1));

load(['/project/rg312/mat_files/snapshot_data_final/run_150/vN_150_' num2str(year)  '.mat']);
vN_ed = cube2latlon(xc,yc,vN_150,xi,yi) - repmat(vN_150_tav,[1 1 1 360]);
load(['/project/rg312/mat_files/snapshot_data_final/run_150/t_150_' num2str(year)  '.mat']);
t_ed = cube2latlon(xc,yc,t_150,xi,yi) - repmat(t_150_tav,[1 1 1 360]);
vNt_ed_150(:,:,year) = squeeze(mean(mean(vN_ed.*t_ed,4),1));

end

vNt_ed_000 = mean(vNt_ed_000,3);
vNt_ed_010 = mean(vNt_ed_010,3);
vNt_ed_025 = mean(vNt_ed_025,3);
vNt_ed_050 = mean(vNt_ed_050,3);
vNt_ed_075 = mean(vNt_ed_075,3);
vNt_ed_100 = mean(vNt_ed_100,3);
vNt_ed_125 = mean(vNt_ed_125,3);
vNt_ed_150 = mean(vNt_ed_150,3);

save('/project/rg312/mat_files/snapshot_data_final/vNt_ed_mean_data.mat','vNt_ed_000','vNt_ed_010','vNt_ed_025','vNt_ed_050','vNt_ed_075','vNt_ed_100','vNt_ed_125','vNt_ed_150')

[x000n,y000n] = ind2sub([90 25], find( vNt_ed_000 == max(max(vNt_ed_000)) ));
[x000s,y000s] = ind2sub([90 25], find( vNt_ed_000 == min(min(vNt_ed_000)) ));

[x010n,y010n] = ind2sub([90 25], find( vNt_ed_010 == max(max(vNt_ed_010)) ));
[x010s,y010s] = ind2sub([90 25], find( vNt_ed_010 == min(min(vNt_ed_010)) ));

[x025n,y025n] = ind2sub([90 25], find( vNt_ed_025 == max(max(vNt_ed_025)) ));
[x025s,y025s] = ind2sub([90 25], find( vNt_ed_025 == min(min(vNt_ed_025)) ));

[x050n,y050n] = ind2sub([90 25], find( vNt_ed_050 == max(max(vNt_ed_050)) ));
[x050s,y050s] = ind2sub([90 25], find( vNt_ed_050 == min(min(vNt_ed_050)) ));

[x075n,y075n] = ind2sub([90 25], find( vNt_ed_075 == max(max(vNt_ed_075)) ));
[x075s,y075s] = ind2sub([90 25], find( vNt_ed_075 == min(min(vNt_ed_075)) ));

[x100n,y100n] = ind2sub([90 25], find( vNt_ed_100 == max(max(vNt_ed_100)) ));
[x100s,y100s] = ind2sub([90 25], find( vNt_ed_100 == min(min(vNt_ed_100)) ));

[x125n,y125n] = ind2sub([90 25], find( vNt_ed_125 == max(max(vNt_ed_125)) ));
[x125s,y125s] = ind2sub([90 25], find( vNt_ed_125 == min(min(vNt_ed_125)) ));

[x150n,y150n] = ind2sub([90 25], find( vNt_ed_150 == max(max(vNt_ed_150)) ));
[x150s,y150s] = ind2sub([90 25], find( vNt_ed_150 == min(min(vNt_ed_150)) ));

save('/project/rg312/mat_files/vt_lats_final.mat','x000n','x010n','x025n','x050n','x075n','x100n','x125n','x150n','x000s','x010s','x025s','x050s','x075s','x100s','x125s','x150s')

return
