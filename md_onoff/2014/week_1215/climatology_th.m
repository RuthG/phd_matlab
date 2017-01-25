%load and plot:
%u, v, w
%T, theta, q
%heat rates
%eddy mom fluxes
%eddy heat fluxes
%lat lon snapshots of u, v, w



% choose directory, load grid
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
yi = -89:2:89;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run %%%%%%%%%%%%%%%%

htrt_th = zeros(192,32,25);
radht_th = zeros(192,32,25);
cnvht_th = zeros(192,32,25);
cndht_th = zeros(192,32,25);
difht_th = zeros(192,32,25);

q_th = zeros(192,32,25);
theta_th = zeros(192,32,25);

v_th = zeros(192,32,25);
u_th = zeros(192,32,25);
w_th = zeros(192,32,25);

uv_th = zeros(192,32,25);
vth_th = zeros(192,32,25);
uth_th = zeros(192,32,25);


i=0
for nit = 86640:240:259200;
i=i+1

rDir = '/project/rg312/wv_on_rad_off/run_doshallowerth/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_th = htrt_th + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTrd'));
radht_th = radht_th + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_th = cndht_th + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_th = cnvht_th + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTdf'));
difht_th = difht_th + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'SALT    '));
q_th = q_th + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'THETA   '));
theta_th = theta_th + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'UVEL    '));
u_th = u_th + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVEL    '));
v_th = v_th + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'WVEL    '));
w_th = w_th + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'UV_VEL_C'));
uv_th = uv_th + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'UVELTH  '));
uth_th = uth_th + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVELTH  '));
vth_th = vth_th + dyn(:,:,:,J)./720;


end


nit = 259200;


rDir = '/project/rg312/wv_on_rad_off/run_doshallowerth/';
u_snap_th=rdmds([rDir,'U'],nit);
v_snap_th=rdmds([rDir,'V'],nit);
[uE_snap_th,vN_snap_th] = rotate_uv2uvEN(u_snap_th,v_snap_th,AngleCS,AngleSN,Grid);
w_snap_th=rdmds([rDir,'W'],nit);


[uE_th,vN_th] = rotate_uv2uvEN(u_th,v_th,AngleCS,AngleSN,Grid);


clear('u_th','v_th')

[uEth_th,vNth_th] = rotate_uv2uvEN(uth_th,vth_th,AngleCS,AngleSN,Grid);

clear('uth_th','vth_th')

convtheta(1,1,:,1)=(rC/101325.0).^(2./7.);
convthetatoT = repmat(convtheta,[192,32,1]);

vNt_th=vNth_th.*convthetatoT;

clear('vNth_th')

htrt_th=htrt_th.*convthetatoT;

radht_th=radht_th.*convthetatoT;

cndht_th=cndht_th.*convthetatoT;

cnvht_th=cnvht_th.*convthetatoT;

difht_th=difht_th.*convthetatoT;

t_th=theta_th.*convthetatoT;

yi=-89:2:89;
xi = -179:2:179;
htrt_th_zav = squeeze(mean(cube2latlon(xc,yc,htrt_th,xi,yi),1));

radht_th_zav = squeeze(mean(cube2latlon(xc,yc,radht_th,xi,yi),1));

cndht_th_zav = squeeze(mean(cube2latlon(xc,yc,cndht_th,xi,yi),1));

cnvht_th_zav = squeeze(mean(cube2latlon(xc,yc,cnvht_th,xi,yi),1));

difht_th_zav = squeeze(mean(cube2latlon(xc,yc,difht_th,xi,yi),1));

q_th_zav = squeeze(mean(cube2latlon(xc,yc,q_th,xi,yi),1));

theta_th_zav = squeeze(mean(cube2latlon(xc,yc,theta_th,xi,yi),1));

t_th_zav = squeeze(mean(cube2latlon(xc,yc,t_th,xi,yi),1));

uE_th_zav = squeeze(mean(cube2latlon(xc,yc,uE_th,xi,yi),1));

vN_th_zav = squeeze(mean(cube2latlon(xc,yc,vN_th,xi,yi),1));

w_th_zav = squeeze(mean(cube2latlon(xc,yc,w_th,xi,yi),1));

vNt_th_zav = squeeze(mean(cube2latlon(xc,yc,vNt_th,xi,yi),1));

uv_th_zav = squeeze(mean(cube2latlon(xc,yc,uv_th,xi,yi),1));

uE_snap_th_ll = cube2latlon(xc,yc,uE_snap_th,xi,yi);

vN_snap_th_ll = cube2latlon(xc,yc,vN_snap_th,xi,yi);

w_snap_th_ll = cube2latlon(xc,yc,w_snap_th,xi,yi);


save('/project/rg312/mat_files/climatology_vars_th.mat')
