function [htrt_ll_tzav,dthdy,dthdp,dthdz,cross_is_wind,w_ll_tzav,vN_ll_tzav] = cross_is_u_fun(run)

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

theta_var = ['theta_' run];
theta_cs = load('/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat',theta_var);
theta_cs = theta_cs.(theta_var);
theta_ll = squeeze(cube2latlon(xc,yc,theta_cs,xi,yi));
theta_ll_tzav = squeeze(mean(mean(theta_ll,4),1));
clear('theta_cs','theta_ll')

t_var = ['t_' run];
t_cs = load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat',t_var);
t_cs = t_cs.(t_var);
t_ll = squeeze(cube2latlon(xc,yc,t_cs,xi,yi));
t_ll_tzav = squeeze(mean(mean(t_ll,4),1));
clear('t_cs','t_ll')

htrt_var = ['htrt_' run];
htrt_cs = load('/project/rg312/mat_files/heat_rates_best.mat',htrt_var);
htrt_cs = htrt_cs.(htrt_var);
htrt_ll = squeeze(cube2latlon(xc,yc,htrt_cs,xi,yi));
htrt_ll_tzav = squeeze(mean(mean(htrt_ll,4),1));
clear('htrt_cs','htrt_ll')

vN_var = ['vN_' run];
vN_cs = load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat',vN_var);
vN_cs = vN_cs.(vN_var);
vN_ll = squeeze(cube2latlon(xc,yc,vN_cs,xi,yi));
vN_ll_tzav = squeeze(mean(mean(vN_ll,4),1));
clear('vN_cs','vN_ll')

w_var = ['w_' run];
w_cs = load('/project/rg312/mat_files/snapshot_data/w_snapshots_best.mat',w_var);
w_cs = w_cs.(w_var);
w_ll = squeeze(cube2latlon(xc,yc,w_cs,xi,yi));
w_ll_tzav = squeeze(mean(mean(w_ll,4),1));
clear('w_cs','w_ll')

radius = 6371.0e3;
g=9.8;
Ra=287.04;

for i=1:25
rho(:,i) = rC(i)./(Ra.*t_ll_tzav(:,i));
end

[dthdp,dthdy] = gradient(theta_ll_tzav,-4000,pi./90);

dthdy = dthdy./radius;

dthdz = -1.*dthdp.*rho.*g;

cross_is_wind = htrt_ll_tzav./sqrt(dthdy.^2 + dthdp.^2);

save(['/project/rg312/mat_files/cross_is_u_' run '.mat'],'htrt_ll_tzav', 'dthdy', 'dthdp','dthdz','cross_is_wind')





