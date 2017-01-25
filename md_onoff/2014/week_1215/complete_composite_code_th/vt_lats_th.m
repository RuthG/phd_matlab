%vt_extremes.m
%load in vt data
%take time average and zonal average and locate maxima, use these to locate composites (+-15 degrees from max)
%find peaks of v't' (transient) at these latitudes 


rDir='/project/rg312/wv_on_rad_off/run_doshallowerth/';
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

load('/project/rg312/mat_files/vNt_tseries_th.mat')
'vt loaded'
xi=-179:2:180;yi=-89:2:90;
vt_th_ll = cube2latlon(xc,yc,vNt_th,xi,yi);

'vt ll done'
clear('vNt_th')

vt_th_tzav = squeeze(mean(mean(vt_th_ll,4),1));
'vt t mean' 
clear('vt_th_ll')


load('/project/rg312/mat_files/vN_tseries_th.mat')
'v loaded'

v_th_ll = cube2latlon(xc,yc,vN_th,xi,yi);

'v ll done'
clear('vN_th')

v_th_tzav = squeeze(mean(mean(v_th_ll,4),1));

'v t mean'

clear('v_th_ll')


load('/project/rg312/mat_files/t_tseries_th.mat')
't loaded'

t_th_ll = cube2latlon(xc,yc,t_th,xi,yi);

't ll done'
clear('t_th')

t_th_tzav = squeeze(mean(mean(t_th_ll,4),1));

't t mean'

clear('t_th_ll')


vt_ed_th = vt_th_tzav - v_th_tzav.*t_th_tzav;

'vt eds'


[xthn,ythn] = ind2sub([90 25], find( vt_ed_th == max(max(vt_ed_th)) ));
[xths,yths] = ind2sub([90 25], find( vt_ed_th == min(min(vt_ed_th)) ));

save('/project/rg312/mat_files/vt_lats_th.mat','xthn','xths')

return
