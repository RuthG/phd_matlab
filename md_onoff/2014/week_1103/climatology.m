%load and plot:
%u, v, w
%T, theta, q
%heat rates
%eddy mom fluxes
%eddy heat fluxes
%lat lon snapshots of u, v, w



% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_doshallower10/';
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run %%%%%%%%%%%%%%%%

htrt_000 = zeros(192,32,25);
htrt_010 = zeros(192,32,25);
htrt_025 = zeros(192,32,25);
htrt_050 = zeros(192,32,25);
htrt_075 = zeros(192,32,25);
htrt_100 = zeros(192,32,25);
radht_000 = zeros(192,32,25);
radht_010 = zeros(192,32,25);
radht_025 = zeros(192,32,25);
radht_050 = zeros(192,32,25);
radht_075 = zeros(192,32,25);
radht_100 = zeros(192,32,25);
cnvht_000 = zeros(192,32,25);
cnvht_010 = zeros(192,32,25);
cnvht_025 = zeros(192,32,25);
cnvht_050 = zeros(192,32,25);
cnvht_075 = zeros(192,32,25);
cnvht_100 = zeros(192,32,25);
cndht_000 = zeros(192,32,25);
cndht_010 = zeros(192,32,25);
cndht_025 = zeros(192,32,25);
cndht_050 = zeros(192,32,25);
cndht_075 = zeros(192,32,25);
cndht_100 = zeros(192,32,25);
difht_000 = zeros(192,32,25);
difht_010 = zeros(192,32,25);
difht_025 = zeros(192,32,25);
difht_050 = zeros(192,32,25);
difht_075 = zeros(192,32,25);
difht_100 = zeros(192,32,25);

q_000 = zeros(192,32,25);
q_010 = zeros(192,32,25);
q_025 = zeros(192,32,25);
q_050 = zeros(192,32,25);
q_075 = zeros(192,32,25);
q_100 = zeros(192,32,25);
theta_000 = zeros(192,32,25);
theta_010 = zeros(192,32,25);
theta_025 = zeros(192,32,25);
theta_050 = zeros(192,32,25);
theta_075 = zeros(192,32,25);
theta_100 = zeros(192,32,25);

v_000 = zeros(192,32,25);
v_010 = zeros(192,32,25);
v_025 = zeros(192,32,25);
v_050 = zeros(192,32,25);
v_075 = zeros(192,32,25);
v_100 = zeros(192,32,25);
u_000 = zeros(192,32,25);
u_010 = zeros(192,32,25);
u_025 = zeros(192,32,25);
u_050 = zeros(192,32,25);
u_075 = zeros(192,32,25);
u_100 = zeros(192,32,25);
w_000 = zeros(192,32,25);
w_010 = zeros(192,32,25);
w_025 = zeros(192,32,25);
w_050 = zeros(192,32,25);
w_075 = zeros(192,32,25);
w_100 = zeros(192,32,25);

uv_000 = zeros(192,32,25);
uv_010 = zeros(192,32,25);
uv_025 = zeros(192,32,25);
uv_050 = zeros(192,32,25);
uv_075 = zeros(192,32,25);
uv_100 = zeros(192,32,25);
vth_000 = zeros(192,32,25);
vth_010 = zeros(192,32,25);
vth_025 = zeros(192,32,25);
vth_050 = zeros(192,32,25);
vth_075 = zeros(192,32,25);
vth_100 = zeros(192,32,25);
uth_000 = zeros(192,32,25);
uth_010 = zeros(192,32,25);
uth_025 = zeros(192,32,25);
uth_050 = zeros(192,32,25);
uth_075 = zeros(192,32,25);
uth_100 = zeros(192,32,25);

i=0
for nit = 86640:240:259200;
i=i+1

rDir = '/project/rg312/wv_on_rad_off/run_doshallower00/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_000 = htrt_000 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTrd'));
radht_000 = radht_000 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_000 = cndht_000 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_000 = cnvht_000 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTdf'));
difht_000 = difht_000 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'SALT    '));
q_000 = q_000 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'THETA   '));
theta_000 = theta_000 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'UVEL    '));
u_000 = u_000 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVEL    '));
v_000 = v_000 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'WVEL    '));
w_000 = w_000 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'UV_VEL_C'));
uv_000 = uv_000 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'UVELTH  '));
uth_000 = uth_000 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVELTH  '));
vth_000 = vth_000 + dyn(:,:,:,J)./720;


rDir = '/project/rg312/wv_on_rad_off/run_doshallower01/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_010 = htrt_010 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTrd'));
radht_010 = radht_010 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_010 = cndht_010 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_010 = cnvht_010 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTdf'));
difht_010 = difht_010 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'SALT    '));
q_010 = q_010 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'THETA   '));
theta_010 = theta_010 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'UVEL    '));
u_010 = u_010 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVEL    '));
v_010 = v_010 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'WVEL    '));
w_010 = w_010 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'UV_VEL_C'));
uv_010 = uv_010 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'UVELTH  '));
uth_010 = uth_010 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVELTH  '));
vth_010 = vth_010 + dyn(:,:,:,J)./720;




rDir = '/project/rg312/wv_on_rad_off/run_doshallower025/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_025 = htrt_025 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTrd'));
radht_025 = radht_025 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_025 = cndht_025 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_025 = cnvht_025 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTdf'));
difht_025 = difht_025 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'SALT    '));
q_025 = q_025 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'THETA   '));
theta_025 = theta_025 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'UVEL    '));
u_025 = u_025 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVEL    '));
v_025 = v_025 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'WVEL    '));
w_025 = w_025 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'UV_VEL_C'));
uv_025 = uv_025 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'UVELTH  '));
uth_025 = uth_025 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVELTH  '));
vth_025 = vth_025 + dyn(:,:,:,J)./720;


rDir = '/project/rg312/wv_on_rad_off/run_doshallower05/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_050 = htrt_050 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTrd'));
radht_050 = radht_050 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_050 = cndht_050 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_050 = cnvht_050 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTdf'));
difht_050 = difht_050 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'SALT    '));
q_050 = q_050 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'THETA   '));
theta_050 = theta_050 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'UVEL    '));
u_050 = u_050 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVEL    '));
v_050 = v_050 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'WVEL    '));
w_050 = w_050 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'UV_VEL_C'));
uv_050 = uv_050 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'UVELTH  '));
uth_050 = uth_050 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVELTH  '));
vth_050 = vth_050 + dyn(:,:,:,J)./720;




rDir = '/project/rg312/wv_on_rad_off/run_doshallower75/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_075 = htrt_075 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTrd'));
radht_075 = radht_075 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_075 = cndht_075 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_075 = cnvht_075 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTdf'));
difht_075 = difht_075 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'SALT    '));
q_075 = q_075 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'THETA   '));
theta_075 = theta_075 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'UVEL    '));
u_075 = u_075 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVEL    '));
v_075 = v_075 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'WVEL    '));
w_075 = w_075 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'UV_VEL_C'));
uv_075 = uv_075 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'UVELTH  '));
uth_075 = uth_075 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVELTH  '));
vth_075 = vth_075 + dyn(:,:,:,J)./720;



rDir = '/project/rg312/wv_on_rad_off/run_doshallower10/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_100 = htrt_100 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTrd'));
radht_100 = radht_100 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_100 = cndht_100 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_100 = cnvht_100 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTdf'));
difht_100 = difht_100 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'SALT    '));
q_100 = q_100 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'THETA   '));
theta_100 = theta_100 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'UVEL    '));
u_100 = u_100 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVEL    '));
v_100 = v_100 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'WVEL    '));
w_100 = w_100 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'UV_VEL_C'));
uv_100 = uv_100 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'UVELTH  '));
uth_100 = uth_100 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVELTH  '));
vth_100 = vth_100 + dyn(:,:,:,J)./720;

end


nit = 259200;


rDir = '/project/rg312/wv_on_rad_off/run_doshallower00/';
u_snap_000=rdmds([rDir,'U'],nit);
v_snap_000=rdmds([rDir,'V'],nit);
[uE_snap_000,vN_snap_000] = rotate_uv2uvEN(u_snap_000,v_snap_000,AngleCS,AngleSN,Grid);
w_snap_000=rdmds([rDir,'W'],nit);

rDir = '/project/rg312/wv_on_rad_off/run_doshallower01/';
u_snap_010=rdmds([rDir,'U'],nit);
v_snap_010=rdmds([rDir,'V'],nit);
[uE_snap_010,vN_snap_010] = rotate_uv2uvEN(u_snap_010,v_snap_010,AngleCS,AngleSN,Grid);
w_snap_010=rdmds([rDir,'W'],nit);

rDir = '/project/rg312/wv_on_rad_off/run_doshallower025/';
u_snap_025=rdmds([rDir,'U'],nit);
v_snap_025=rdmds([rDir,'V'],nit);
[uE_snap_025,vN_snap_025] = rotate_uv2uvEN(u_snap_025,v_snap_025,AngleCS,AngleSN,Grid);
w_snap_025=rdmds([rDir,'W'],nit);

rDir = '/project/rg312/wv_on_rad_off/run_doshallower05/';
u_snap_050=rdmds([rDir,'U'],nit);
v_snap_050=rdmds([rDir,'V'],nit);
[uE_snap_050,vN_snap_050] = rotate_uv2uvEN(u_snap_050,v_snap_050,AngleCS,AngleSN,Grid);
w_snap_050=rdmds([rDir,'W'],nit);

rDir = '/project/rg312/wv_on_rad_off/run_doshallower75/';
u_snap_075=rdmds([rDir,'U'],nit);
v_snap_075=rdmds([rDir,'V'],nit);
[uE_snap_075,vN_snap_075] = rotate_uv2uvEN(u_snap_075,v_snap_075,AngleCS,AngleSN,Grid);
w_snap_075=rdmds([rDir,'W'],nit);

rDir = '/project/rg312/wv_on_rad_off/run_doshallower10/';
u_snap_100=rdmds([rDir,'U'],nit);
v_snap_100=rdmds([rDir,'V'],nit);
[uE_snap_100,vN_snap_100] = rotate_uv2uvEN(u_snap_100,v_snap_100,AngleCS,AngleSN,Grid);
w_snap_100=rdmds([rDir,'W'],nit);




[uE_000,vN_000] = rotate_uv2uvEN(u_000,v_000,AngleCS,AngleSN,Grid);
[uE_010,vN_010] = rotate_uv2uvEN(u_010,v_010,AngleCS,AngleSN,Grid);
[uE_025,vN_025] = rotate_uv2uvEN(u_025,v_025,AngleCS,AngleSN,Grid);
[uE_050,vN_050] = rotate_uv2uvEN(u_050,v_050,AngleCS,AngleSN,Grid);
[uE_075,vN_075] = rotate_uv2uvEN(u_075,v_075,AngleCS,AngleSN,Grid);
[uE_100,vN_100] = rotate_uv2uvEN(u_100,v_100,AngleCS,AngleSN,Grid);

clear('u_000','u_010','u_025','u_050','u_075','u_100','v_000','v_010','v_025','v_050','v_075','v_100')

[uEth_000,vNth_000] = rotate_uv2uvEN(uth_000,vth_000,AngleCS,AngleSN,Grid);
[uEth_010,vNth_010] = rotate_uv2uvEN(uth_010,vth_010,AngleCS,AngleSN,Grid);
[uEth_025,vNth_025] = rotate_uv2uvEN(uth_025,vth_025,AngleCS,AngleSN,Grid);
[uEth_050,vNth_050] = rotate_uv2uvEN(uth_050,vth_050,AngleCS,AngleSN,Grid);
[uEth_075,vNth_075] = rotate_uv2uvEN(uth_075,vth_075,AngleCS,AngleSN,Grid);
[uEth_100,vNth_100] = rotate_uv2uvEN(uth_100,vth_100,AngleCS,AngleSN,Grid);

clear('uth_000','uth_010','uth_025','uth_050','uth_075','uth_100','vth_000','vth_010','vth_025','vth_050','vth_075','vth_100')

convtheta(1,1,:,1)=(rC/101325.0).^(2./7.);
convthetatoT = repmat(convtheta,[192,32,1]);

vNt_000=vNth_000.*convthetatoT;
vNt_010=vNth_010.*convthetatoT;
vNt_025=vNth_025.*convthetatoT;
vNt_050=vNth_050.*convthetatoT;
vNt_075=vNth_075.*convthetatoT;
vNt_100=vNth_100.*convthetatoT;

clear('vNth_000','vNth_010','vNth_025','vNth_050','vNth_075','vNth_100')

htrt_000=htrt_000.*convthetatoT;
htrt_010=htrt_010.*convthetatoT;
htrt_025=htrt_025.*convthetatoT;
htrt_050=htrt_050.*convthetatoT;
htrt_075=htrt_075.*convthetatoT;
htrt_100=htrt_100.*convthetatoT;

radht_000=radht_000.*convthetatoT;
radht_010=radht_010.*convthetatoT;
radht_025=radht_025.*convthetatoT;
radht_050=radht_050.*convthetatoT;
radht_075=radht_075.*convthetatoT;
radht_100=radht_100.*convthetatoT;

cndht_000=cndht_000.*convthetatoT;
cndht_010=cndht_010.*convthetatoT;
cndht_025=cndht_025.*convthetatoT;
cndht_050=cndht_050.*convthetatoT;
cndht_075=cndht_075.*convthetatoT;
cndht_100=cndht_100.*convthetatoT;

cnvht_000=cnvht_000.*convthetatoT;
cnvht_010=cnvht_010.*convthetatoT;
cnvht_025=cnvht_025.*convthetatoT;
cnvht_050=cnvht_050.*convthetatoT;
cnvht_075=cnvht_075.*convthetatoT;
cnvht_100=cnvht_100.*convthetatoT;

difht_000=difht_000.*convthetatoT;
difht_010=difht_010.*convthetatoT;
difht_025=difht_025.*convthetatoT;
difht_050=difht_050.*convthetatoT;
difht_075=difht_075.*convthetatoT;
difht_100=difht_100.*convthetatoT;

t_000=theta_000.*convthetatoT;
t_010=theta_010.*convthetatoT;
t_025=theta_025.*convthetatoT;
t_050=theta_050.*convthetatoT;
t_075=theta_075.*convthetatoT;
t_100=theta_100.*convthetatoT;

yi=-89:2:89;
xi = -179:2:179;
htrt_000_zav = squeeze(mean(cube2latlon(xc,yc,htrt_000,xi,yi),1));
htrt_010_zav = squeeze(mean(cube2latlon(xc,yc,htrt_010,xi,yi),1));
htrt_025_zav = squeeze(mean(cube2latlon(xc,yc,htrt_025,xi,yi),1));
htrt_050_zav = squeeze(mean(cube2latlon(xc,yc,htrt_050,xi,yi),1));
htrt_075_zav = squeeze(mean(cube2latlon(xc,yc,htrt_075,xi,yi),1));
htrt_100_zav = squeeze(mean(cube2latlon(xc,yc,htrt_100,xi,yi),1));

radht_000_zav = squeeze(mean(cube2latlon(xc,yc,radht_000,xi,yi),1));
radht_010_zav = squeeze(mean(cube2latlon(xc,yc,radht_010,xi,yi),1));
radht_025_zav = squeeze(mean(cube2latlon(xc,yc,radht_025,xi,yi),1));
radht_050_zav = squeeze(mean(cube2latlon(xc,yc,radht_050,xi,yi),1));
radht_075_zav = squeeze(mean(cube2latlon(xc,yc,radht_075,xi,yi),1));
radht_100_zav = squeeze(mean(cube2latlon(xc,yc,radht_100,xi,yi),1));

cndht_000_zav = squeeze(mean(cube2latlon(xc,yc,cndht_000,xi,yi),1));
cndht_010_zav = squeeze(mean(cube2latlon(xc,yc,cndht_010,xi,yi),1));
cndht_025_zav = squeeze(mean(cube2latlon(xc,yc,cndht_025,xi,yi),1));
cndht_050_zav = squeeze(mean(cube2latlon(xc,yc,cndht_050,xi,yi),1));
cndht_075_zav = squeeze(mean(cube2latlon(xc,yc,cndht_075,xi,yi),1));
cndht_100_zav = squeeze(mean(cube2latlon(xc,yc,cndht_100,xi,yi),1));

cnvht_000_zav = squeeze(mean(cube2latlon(xc,yc,cnvht_000,xi,yi),1));
cnvht_010_zav = squeeze(mean(cube2latlon(xc,yc,cnvht_010,xi,yi),1));
cnvht_025_zav = squeeze(mean(cube2latlon(xc,yc,cnvht_025,xi,yi),1));
cnvht_050_zav = squeeze(mean(cube2latlon(xc,yc,cnvht_050,xi,yi),1));
cnvht_075_zav = squeeze(mean(cube2latlon(xc,yc,cnvht_075,xi,yi),1));
cnvht_100_zav = squeeze(mean(cube2latlon(xc,yc,cnvht_100,xi,yi),1));

difht_000_zav = squeeze(mean(cube2latlon(xc,yc,difht_000,xi,yi),1));
difht_010_zav = squeeze(mean(cube2latlon(xc,yc,difht_010,xi,yi),1));
difht_025_zav = squeeze(mean(cube2latlon(xc,yc,difht_025,xi,yi),1));
difht_050_zav = squeeze(mean(cube2latlon(xc,yc,difht_050,xi,yi),1));
difht_075_zav = squeeze(mean(cube2latlon(xc,yc,difht_075,xi,yi),1));
difht_100_zav = squeeze(mean(cube2latlon(xc,yc,difht_100,xi,yi),1));

q_000_zav = squeeze(mean(cube2latlon(xc,yc,q_000,xi,yi),1));
q_010_zav = squeeze(mean(cube2latlon(xc,yc,q_010,xi,yi),1));
q_025_zav = squeeze(mean(cube2latlon(xc,yc,q_025,xi,yi),1));
q_050_zav = squeeze(mean(cube2latlon(xc,yc,q_050,xi,yi),1));
q_075_zav = squeeze(mean(cube2latlon(xc,yc,q_075,xi,yi),1));
q_100_zav = squeeze(mean(cube2latlon(xc,yc,q_100,xi,yi),1));

theta_000_zav = squeeze(mean(cube2latlon(xc,yc,theta_000,xi,yi),1));
theta_010_zav = squeeze(mean(cube2latlon(xc,yc,theta_010,xi,yi),1));
theta_025_zav = squeeze(mean(cube2latlon(xc,yc,theta_025,xi,yi),1));
theta_050_zav = squeeze(mean(cube2latlon(xc,yc,theta_050,xi,yi),1));
theta_075_zav = squeeze(mean(cube2latlon(xc,yc,theta_075,xi,yi),1));
theta_100_zav = squeeze(mean(cube2latlon(xc,yc,theta_100,xi,yi),1));

t_000_zav = squeeze(mean(cube2latlon(xc,yc,t_000,xi,yi),1));
t_010_zav = squeeze(mean(cube2latlon(xc,yc,t_010,xi,yi),1));
t_025_zav = squeeze(mean(cube2latlon(xc,yc,t_025,xi,yi),1));
t_050_zav = squeeze(mean(cube2latlon(xc,yc,t_050,xi,yi),1));
t_075_zav = squeeze(mean(cube2latlon(xc,yc,t_075,xi,yi),1));
t_100_zav = squeeze(mean(cube2latlon(xc,yc,t_100,xi,yi),1));

uE_000_zav = squeeze(mean(cube2latlon(xc,yc,uE_000,xi,yi),1));
uE_010_zav = squeeze(mean(cube2latlon(xc,yc,uE_010,xi,yi),1));
uE_025_zav = squeeze(mean(cube2latlon(xc,yc,uE_025,xi,yi),1));
uE_050_zav = squeeze(mean(cube2latlon(xc,yc,uE_050,xi,yi),1));
uE_075_zav = squeeze(mean(cube2latlon(xc,yc,uE_075,xi,yi),1));
uE_100_zav = squeeze(mean(cube2latlon(xc,yc,uE_100,xi,yi),1));

vN_000_zav = squeeze(mean(cube2latlon(xc,yc,vN_000,xi,yi),1));
vN_010_zav = squeeze(mean(cube2latlon(xc,yc,vN_010,xi,yi),1));
vN_025_zav = squeeze(mean(cube2latlon(xc,yc,vN_025,xi,yi),1));
vN_050_zav = squeeze(mean(cube2latlon(xc,yc,vN_050,xi,yi),1));
vN_075_zav = squeeze(mean(cube2latlon(xc,yc,vN_075,xi,yi),1));
vN_100_zav = squeeze(mean(cube2latlon(xc,yc,vN_100,xi,yi),1));

w_000_zav = squeeze(mean(cube2latlon(xc,yc,w_000,xi,yi),1));
w_010_zav = squeeze(mean(cube2latlon(xc,yc,w_010,xi,yi),1));
w_025_zav = squeeze(mean(cube2latlon(xc,yc,w_025,xi,yi),1));
w_050_zav = squeeze(mean(cube2latlon(xc,yc,w_050,xi,yi),1));
w_075_zav = squeeze(mean(cube2latlon(xc,yc,w_075,xi,yi),1));
w_100_zav = squeeze(mean(cube2latlon(xc,yc,w_100,xi,yi),1));

vNt_000_zav = squeeze(mean(cube2latlon(xc,yc,vNt_000,xi,yi),1));
vNt_010_zav = squeeze(mean(cube2latlon(xc,yc,vNt_010,xi,yi),1));
vNt_025_zav = squeeze(mean(cube2latlon(xc,yc,vNt_025,xi,yi),1));
vNt_050_zav = squeeze(mean(cube2latlon(xc,yc,vNt_050,xi,yi),1));
vNt_075_zav = squeeze(mean(cube2latlon(xc,yc,vNt_075,xi,yi),1));
vNt_100_zav = squeeze(mean(cube2latlon(xc,yc,vNt_100,xi,yi),1));

uv_000_zav = squeeze(mean(cube2latlon(xc,yc,uv_000,xi,yi),1));
uv_010_zav = squeeze(mean(cube2latlon(xc,yc,uv_010,xi,yi),1));
uv_025_zav = squeeze(mean(cube2latlon(xc,yc,uv_025,xi,yi),1));
uv_050_zav = squeeze(mean(cube2latlon(xc,yc,uv_050,xi,yi),1));
uv_075_zav = squeeze(mean(cube2latlon(xc,yc,uv_075,xi,yi),1));
uv_100_zav = squeeze(mean(cube2latlon(xc,yc,uv_100,xi,yi),1));

uE_snap_000_ll = cube2latlon(xc,yc,uE_snap_000,xi,yi);
uE_snap_010_ll = cube2latlon(xc,yc,uE_snap_010,xi,yi);
uE_snap_025_ll = cube2latlon(xc,yc,uE_snap_025,xi,yi);
uE_snap_050_ll = cube2latlon(xc,yc,uE_snap_050,xi,yi);
uE_snap_075_ll = cube2latlon(xc,yc,uE_snap_075,xi,yi);
uE_snap_100_ll = cube2latlon(xc,yc,uE_snap_100,xi,yi);

vN_snap_000_ll = cube2latlon(xc,yc,vN_snap_000,xi,yi);
vN_snap_010_ll = cube2latlon(xc,yc,vN_snap_010,xi,yi);
vN_snap_025_ll = cube2latlon(xc,yc,vN_snap_025,xi,yi);
vN_snap_050_ll = cube2latlon(xc,yc,vN_snap_050,xi,yi);
vN_snap_075_ll = cube2latlon(xc,yc,vN_snap_075,xi,yi);
vN_snap_100_ll = cube2latlon(xc,yc,vN_snap_100,xi,yi);

w_snap_000_ll = cube2latlon(xc,yc,w_snap_000,xi,yi);
w_snap_010_ll = cube2latlon(xc,yc,w_snap_010,xi,yi);
w_snap_025_ll = cube2latlon(xc,yc,w_snap_025,xi,yi);
w_snap_050_ll = cube2latlon(xc,yc,w_snap_050,xi,yi);
w_snap_075_ll = cube2latlon(xc,yc,w_snap_075,xi,yi);
w_snap_100_ll = cube2latlon(xc,yc,w_snap_100,xi,yi);

save('climatology_vars.mat')
