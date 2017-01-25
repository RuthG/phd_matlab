%vt_extremes.m
%load in vt data
%take time average and zonal average and locate maxima, use these to locate composites (+-15 degrees from max)
%find peaks of v't' (transient) at these latitudes 


rDir='/project/rg312/final_runs/run_050_final_tropheat/';
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

load('/project/rg312/mat_files/snapshot_data_final/run_th/vN_th_timemean.mat');
vN_th_tav = vN_ll_tav;

load('/project/rg312/mat_files/snapshot_data_final/run_th/t_th_timemean.mat');
t_th_tav = t_ll_tav;


for year = 1:10
year

load(['/project/rg312/mat_files/snapshot_data_final/run_th/vN_th_' num2str(year)  '.mat']);
vN_ed = cube2latlon(xc,yc,vN_th,xi,yi) - repmat(vN_th_tav,[1 1 1 360]);
load(['/project/rg312/mat_files/snapshot_data_final/run_th/t_th_' num2str(year)  '.mat']);
t_ed = cube2latlon(xc,yc,t_th,xi,yi) - repmat(t_th_tav,[1 1 1 360]);
vNt_ed_th(:,:,year) = squeeze(mean(mean(vN_ed.*t_ed,4),1));

end
vNt_ed_th = mean(vNt_ed_th,3);


save('/project/rg312/mat_files/snapshot_data_final/vNt_ed_mean_data.mat','vNt_ed_th','-append')

[xthn,ythn] = ind2sub([90 25], find( vNt_ed_th == max(max(vNt_ed_th)) ));
[xths,yths] = ind2sub([90 25], find( vNt_ed_th == min(min(vNt_ed_th)) ));


save('/project/rg312/mat_files/vt_lats_final.mat','xthn','xths','-append')

return
