
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
yi=-89:2:89;
xi = -179:2:179;

[htrt_ll_tzav_000, dthdy_000, dthdp_000, dthdz_000, cross_is_wind_000, w_ll_tzav_000, vN_ll_tzav_000] = cross_is_u_fun('000');
'000'
contourf(yi,rC,cross_is_wind_000')
set(gca,'YDir','reverse')



[htrt_ll_tzav_100, dthdy_100, dthdp_100, dthdz_100, cross_is_wind_100, w_ll_tzav_100, vN_ll_tzav_100] = cross_is_u_fun('100');
'100'
contourf(yi,rC,cross_is_wind_100')
set(gca,'YDir','reverse')


