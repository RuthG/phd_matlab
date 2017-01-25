%vt_extremes.m
%load in vt data
%take time average and zonal average and locate maxima, use these to locate composites (+-15 degrees from max)
%find peaks of v't' (transient) at these latitudes 


rDir='/project/rg312/wv_on_rad_off/run_doshallower00/';
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

load('/project/rg312/mat_files/vNt_tseries.mat')
'vt loaded'
xi=-179:2:180;yi=-89:2:90;
vt_000_ll = cube2latlon(xc,yc,vNt_000,xi,yi);
vt_010_ll = cube2latlon(xc,yc,vNt_010,xi,yi);
vt_025_ll = cube2latlon(xc,yc,vNt_025,xi,yi);
vt_050_ll = cube2latlon(xc,yc,vNt_050,xi,yi);
vt_075_ll = cube2latlon(xc,yc,vNt_075,xi,yi);
vt_100_ll = cube2latlon(xc,yc,vNt_100,xi,yi);
'vt ll done'
clear('vNt_000','vNt_010','vNt_025','vNt_050','vNt_075','vNt_100')

vt_000_tzav = squeeze(mean(mean(vt_000_ll,4),1));
vt_010_tzav = squeeze(mean(mean(vt_010_ll,4),1));
vt_025_tzav = squeeze(mean(mean(vt_025_ll,4),1));
vt_050_tzav = squeeze(mean(mean(vt_050_ll,4),1));
vt_075_tzav = squeeze(mean(mean(vt_075_ll,4),1));
vt_100_tzav = squeeze(mean(mean(vt_100_ll,4),1));
'vt t mean' 
clear('vt_000_ll','vt_010_ll','vt_025_ll','vt_050_ll','vt_075_ll','vt_100_ll')


load('/project/rg312/mat_files/vN_tseries.mat')
'v loaded'

v_000_ll = cube2latlon(xc,yc,vN_000,xi,yi);
v_010_ll = cube2latlon(xc,yc,vN_010,xi,yi);
v_025_ll = cube2latlon(xc,yc,vN_025,xi,yi);
v_050_ll = cube2latlon(xc,yc,vN_050,xi,yi);
v_075_ll = cube2latlon(xc,yc,vN_075,xi,yi);
v_100_ll = cube2latlon(xc,yc,vN_100,xi,yi);
'v ll done'
clear('vN_000','vN_010','vN_025','vN_050','vN_075','vN_100')

v_000_tzav = squeeze(mean(mean(v_000_ll,4),1));
v_010_tzav = squeeze(mean(mean(v_010_ll,4),1));
v_025_tzav = squeeze(mean(mean(v_025_ll,4),1));
v_050_tzav = squeeze(mean(mean(v_050_ll,4),1));
v_075_tzav = squeeze(mean(mean(v_075_ll,4),1));
v_100_tzav = squeeze(mean(mean(v_100_ll,4),1));
'v t mean'

clear('v_000_ll','v_010_ll','v_025_ll','v_050_ll','v_075_ll','v_100_ll')


load('/project/rg312/mat_files/t_tseries.mat')
't loaded'

t_000_ll = cube2latlon(xc,yc,t_000,xi,yi);
t_010_ll = cube2latlon(xc,yc,t_010,xi,yi);
t_025_ll = cube2latlon(xc,yc,t_025,xi,yi);
t_050_ll = cube2latlon(xc,yc,t_050,xi,yi);
t_075_ll = cube2latlon(xc,yc,t_075,xi,yi);
t_100_ll = cube2latlon(xc,yc,t_100,xi,yi);
't ll done'
clear('t_000','t_010','t_025','t_050','t_075','t_100')

t_000_tzav = squeeze(mean(mean(t_000_ll,4),1));
t_010_tzav = squeeze(mean(mean(t_010_ll,4),1));
t_025_tzav = squeeze(mean(mean(t_025_ll,4),1));
t_050_tzav = squeeze(mean(mean(t_050_ll,4),1));
t_075_tzav = squeeze(mean(mean(t_075_ll,4),1));
t_100_tzav = squeeze(mean(mean(t_100_ll,4),1));
't t mean'

clear('t_000_ll','t_010_ll','t_025_ll','t_050_ll','t_075_ll','t_100_ll')


vt_ed_000 = vt_000_tzav - v_000_tzav.*t_000_tzav;
vt_ed_010 = vt_010_tzav - v_010_tzav.*t_010_tzav;
vt_ed_025 = vt_025_tzav - v_025_tzav.*t_025_tzav;
vt_ed_050 = vt_050_tzav - v_050_tzav.*t_050_tzav;
vt_ed_075 = vt_075_tzav - v_075_tzav.*t_075_tzav;
vt_ed_100 = vt_100_tzav - v_100_tzav.*t_100_tzav;
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

save('/project/rg312/mat_files/vt_lats.mat','x000n','x010n','x025n','x050n','x075n','x100n','x000s','x010s','x025s','x050s','x075s','x100s')

return
