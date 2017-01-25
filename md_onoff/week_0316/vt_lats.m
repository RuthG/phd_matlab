%vt_extremes.m
%load in vt data
%take time average and zonal average and locate maxima, use these to locate composites (+-15 degrees from max)
%find peaks of v't' (transient) at these latitudes 


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

xi=-179:2:179;
yi=-89:2:89;

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat')
'v loaded'

vN_ll = cube2latlon(xc,yc,vN_000,xi,yi);
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_000 = vN_ll - vN_ll_tav;
vN_ll = cube2latlon(xc,yc,vN_010,xi,yi);
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_010 = vN_ll - vN_ll_tav;
vN_ll = cube2latlon(xc,yc,vN_025,xi,yi);
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_025 = vN_ll - vN_ll_tav;
vN_ll = cube2latlon(xc,yc,vN_050,xi,yi);
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_050 = vN_ll - vN_ll_tav;
vN_ll = cube2latlon(xc,yc,vN_075,xi,yi);
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_075 = vN_ll - vN_ll_tav;
vN_ll = cube2latlon(xc,yc,vN_100,xi,yi);
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_100 = vN_ll - vN_ll_tav;
vN_ll = cube2latlon(xc,yc,vN_125,xi,yi);
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_125 = vN_ll - vN_ll_tav;
vN_ll = cube2latlon(xc,yc,vN_150,xi,yi);
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_150 = vN_ll - vN_ll_tav;

'v ll done'
clear('vN_000','vN_010','vN_025','vN_050','vN_075','vN_100','vN_125','vN_150')

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat')
't loaded'
t_ll = cube2latlon(xc,yc,t_000,xi,yi);
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_000 = t_ll - t_ll_tav;
t_ll = cube2latlon(xc,yc,t_010,xi,yi);
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_010 = t_ll - t_ll_tav;
t_ll = cube2latlon(xc,yc,t_025,xi,yi);
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_025 = t_ll - t_ll_tav;
t_ll = cube2latlon(xc,yc,t_050,xi,yi);
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_050 = t_ll - t_ll_tav;
t_ll = cube2latlon(xc,yc,t_075,xi,yi);
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_075 = t_ll - t_ll_tav;
t_ll = cube2latlon(xc,yc,t_100,xi,yi);
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_100 = t_ll - t_ll_tav;
t_ll = cube2latlon(xc,yc,t_125,xi,yi);
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_125 = t_ll - t_ll_tav;
t_ll = cube2latlon(xc,yc,t_150,xi,yi);
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_150 = t_ll - t_ll_tav;

't ll done'
clear('t_000','t_010','t_025','t_050','t_075','t_100','t_125','t_150')

vt_ed_000 = squeeze(mean(mean(vN_ed_000.*t_ed_000,4),1));
vt_ed_010 = squeeze(mean(mean(vN_ed_010.*t_ed_010,4),1));
vt_ed_025 = squeeze(mean(mean(vN_ed_025.*t_ed_025,4),1));
vt_ed_050 = squeeze(mean(mean(vN_ed_050.*t_ed_050,4),1));
vt_ed_075 = squeeze(mean(mean(vN_ed_075.*t_ed_075,4),1));
vt_ed_100 = squeeze(mean(mean(vN_ed_100.*t_ed_100,4),1));
vt_ed_125 = squeeze(mean(mean(vN_ed_125.*t_ed_125,4),1));
vt_ed_150 = squeeze(mean(mean(vN_ed_150.*t_ed_150,4),1));

'vt eds'


[x000n,y000n] = ind2sub([90 25], find( vt_ed_000 == max(max(vt_ed_000)) ));
[x000s,y000s] = ind2sub([90 25], find( vt_ed_000 == min(min(vt_ed_000)) ));

[x010n,y010n] = ind2sub([90 25], find( vt_ed_010 == max(max(vt_ed_010)) ));
[x010s,y010s] = ind2sub([90 25], find( vt_ed_010 == min(min(vt_ed_010)) ));

[x025n,y025n] = ind2sub([90 25], find( vt_ed_025 == max(max(vt_ed_025)) ));
[x025s,y025s] = ind2sub([90 25], find( vt_ed_025 == min(min(vt_ed_025)) ));

[x050n,y050n] = ind2sub([90 25], find( vt_ed_050 == max(max(vt_ed_050)) ));
[x050s,y050s] = ind2sub([90 25], find( vt_ed_050 == min(min(vt_ed_050)) ));

[x075n,y075n] = ind2sub([90 25], find( vt_ed_075 == max(max(vt_ed_075)) ));
[x075s,y075s] = ind2sub([90 25], find( vt_ed_075 == min(min(vt_ed_075)) ));

[x100n,y100n] = ind2sub([90 25], find( vt_ed_100 == max(max(vt_ed_100)) ));
[x100s,y100s] = ind2sub([90 25], find( vt_ed_100 == min(min(vt_ed_100)) ));

[x125n,y125n] = ind2sub([90 25], find( vt_ed_125 == max(max(vt_ed_125)) ));
[x125s,y125s] = ind2sub([90 25], find( vt_ed_125 == min(min(vt_ed_125)) ));

[x150n,y150n] = ind2sub([90 25], find( vt_ed_150 == max(max(vt_ed_150)) ));
[x150s,y150s] = ind2sub([90 25], find( vt_ed_150 == min(min(vt_ed_150)) ));

save('/project/rg312/mat_files/vt_lats_best.mat','x000n','x010n','x025n','x050n','x075n','x100n','x125n','x150n','x000s','x010s','x025s','x050s','x075s','x100s','x125s','x150s')

return
