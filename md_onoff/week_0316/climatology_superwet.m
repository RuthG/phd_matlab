%load and plot:
%u, v, w
%T, theta, q
%heat rates
%eddy mom fluxes
%eddy heat fluxes
%lat lon snapshots of u, v, w



% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_125_best/';
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

htrt_125 = zeros(192,32,25);
htrt_150 = zeros(192,32,25);
radht_125 = zeros(192,32,25);
radht_150 = zeros(192,32,25);
cnvht_125 = zeros(192,32,25);
cnvht_150 = zeros(192,32,25);
cndht_125 = zeros(192,32,25);
cndht_150 = zeros(192,32,25);
difht_125 = zeros(192,32,25);
difht_150 = zeros(192,32,25);

q_125 = zeros(192,32,25);
q_150 = zeros(192,32,25);
theta_125 = zeros(192,32,25);
theta_150 = zeros(192,32,25);

v_125 = zeros(192,32,25);
v_150 = zeros(192,32,25);
u_125 = zeros(192,32,25);
u_150 = zeros(192,32,25);
w_125 = zeros(192,32,25);
w_150 = zeros(192,32,25);


uv_125 = zeros(192,32,25);
uv_150 = zeros(192,32,25);
vth_125 = zeros(192,32,25);
vth_150 = zeros(192,32,25);
uth_125 = zeros(192,32,25);
uth_150 = zeros(192,32,25);

i=0
for nit = 86640:240:259200;
i=i+1

rDir = '/project/rg312/wv_on_rad_off/run_125_best/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_125 = htrt_125 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTrd'));
radht_125 = radht_125 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_125 = cndht_125 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_125 = cnvht_125 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTdf'));
difht_125 = difht_125 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'SALT    '));
q_125 = q_125 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'THETA   '));
theta_125 = theta_125 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'UVEL    '));
u_125 = u_125 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVEL    '));
v_125 = v_125 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'WVEL    '));
w_125 = w_125 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'UV_VEL_C'));
uv_125 = uv_125 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'UVELTH  '));
uth_125 = uth_125 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVELTH  '));
vth_125 = vth_125 + dyn(:,:,:,J)./720;


rDir = '/project/rg312/wv_on_rad_off/run_150_best/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_150 = htrt_150 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTrd'));
radht_150 = radht_150 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_150 = cndht_150 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_150 = cnvht_150 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'AtPhdTdf'));
difht_150 = difht_150 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'SALT    '));
q_150 = q_150 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'THETA   '));
theta_150 = theta_150 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'UVEL    '));
u_150 = u_150 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVEL    '));
v_150 = v_150 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'WVEL    '));
w_150 = w_150 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'UV_VEL_C'));
uv_150 = uv_150 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'UVELTH  '));
uth_150 = uth_150 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVELTH  '));
vth_150 = vth_150 + dyn(:,:,:,J)./720;


end


nit = 259200;

rDir = '/project/rg312/wv_on_rad_off/run_125_best/';
u_snap_125=rdmds([rDir,'U'],nit);
v_snap_125=rdmds([rDir,'V'],nit);
[uE_snap_125,vN_snap_125] = rotate_uv2uvEN(u_snap_125,v_snap_125,AngleCS,AngleSN,Grid);
w_snap_125=rdmds([rDir,'W'],nit);

rDir = '/project/rg312/wv_on_rad_off/run_150_best/';
u_snap_150=rdmds([rDir,'U'],nit);
v_snap_150=rdmds([rDir,'V'],nit);
[uE_snap_150,vN_snap_150] = rotate_uv2uvEN(u_snap_150,v_snap_150,AngleCS,AngleSN,Grid);
w_snap_150=rdmds([rDir,'W'],nit);


[uE_125,vN_125] = rotate_uv2uvEN(u_125,v_125,AngleCS,AngleSN,Grid);
[uE_150,vN_150] = rotate_uv2uvEN(u_150,v_150,AngleCS,AngleSN,Grid);

clear('u_125','u_150','v_125','v_150')

[uEth_125,vNth_125] = rotate_uv2uvEN(uth_125,vth_125,AngleCS,AngleSN,Grid);
[uEth_150,vNth_150] = rotate_uv2uvEN(uth_150,vth_150,AngleCS,AngleSN,Grid);

clear('uth_125','uth_150','vth_125','vth_150')

convtheta(1,1,:,1)=(rC/100000.0).^(2./7.);
convthetatoT = repmat(convtheta,[192,32,1]);

vNt_125=vNth_125.*convthetatoT;
vNt_150=vNth_150.*convthetatoT;


clear('vNth_125','vNth_150')

htrt_125=htrt_125;
htrt_150=htrt_150;

radht_125=radht_125;
radht_150=radht_150;

cndht_125=cndht_125;
cndht_150=cndht_150;

cnvht_125=cnvht_125;
cnvht_150=cnvht_150;

difht_125=difht_125;
difht_150=difht_150;

t_125=theta_125.*convthetatoT;
t_150=theta_150.*convthetatoT;


yi=-89:2:89;
xi = -179:2:179;

htrt_125_zav = squeeze(mean(cube2latlon(xc,yc,htrt_125,xi,yi),1));
htrt_150_zav = squeeze(mean(cube2latlon(xc,yc,htrt_150,xi,yi),1));

radht_125_zav = squeeze(mean(cube2latlon(xc,yc,radht_125,xi,yi),1));
radht_150_zav = squeeze(mean(cube2latlon(xc,yc,radht_150,xi,yi),1));

cndht_125_zav = squeeze(mean(cube2latlon(xc,yc,cndht_125,xi,yi),1));
cndht_150_zav = squeeze(mean(cube2latlon(xc,yc,cndht_150,xi,yi),1));

cnvht_125_zav = squeeze(mean(cube2latlon(xc,yc,cnvht_125,xi,yi),1));
cnvht_150_zav = squeeze(mean(cube2latlon(xc,yc,cnvht_150,xi,yi),1));

difht_125_zav = squeeze(mean(cube2latlon(xc,yc,difht_125,xi,yi),1));
difht_150_zav = squeeze(mean(cube2latlon(xc,yc,difht_150,xi,yi),1));

q_125_zav = squeeze(mean(cube2latlon(xc,yc,q_125,xi,yi),1));
q_150_zav = squeeze(mean(cube2latlon(xc,yc,q_150,xi,yi),1));

theta_125_zav = squeeze(mean(cube2latlon(xc,yc,theta_125,xi,yi),1));
theta_150_zav = squeeze(mean(cube2latlon(xc,yc,theta_150,xi,yi),1));

t_125_zav = squeeze(mean(cube2latlon(xc,yc,t_125,xi,yi),1));
t_150_zav = squeeze(mean(cube2latlon(xc,yc,t_150,xi,yi),1));

uE_125_zav = squeeze(mean(cube2latlon(xc,yc,uE_125,xi,yi),1));
uE_150_zav = squeeze(mean(cube2latlon(xc,yc,uE_150,xi,yi),1));

vN_125_zav = squeeze(mean(cube2latlon(xc,yc,vN_125,xi,yi),1));
vN_150_zav = squeeze(mean(cube2latlon(xc,yc,vN_150,xi,yi),1));

w_125_zav = squeeze(mean(cube2latlon(xc,yc,w_125,xi,yi),1));
w_150_zav = squeeze(mean(cube2latlon(xc,yc,w_150,xi,yi),1));

vNt_125_zav = squeeze(mean(cube2latlon(xc,yc,vNt_125,xi,yi),1));
vNt_150_zav = squeeze(mean(cube2latlon(xc,yc,vNt_150,xi,yi),1));

uv_125_zav = squeeze(mean(cube2latlon(xc,yc,uv_125,xi,yi),1));
uv_150_zav = squeeze(mean(cube2latlon(xc,yc,uv_150,xi,yi),1));

uE_snap_125_ll = cube2latlon(xc,yc,uE_snap_125,xi,yi);
uE_snap_150_ll = cube2latlon(xc,yc,uE_snap_150,xi,yi);

vN_snap_125_ll = cube2latlon(xc,yc,vN_snap_125,xi,yi);
vN_snap_150_ll = cube2latlon(xc,yc,vN_snap_150,xi,yi);

w_snap_125_ll = cube2latlon(xc,yc,w_snap_125,xi,yi);
w_snap_150_ll = cube2latlon(xc,yc,w_snap_150,xi,yi);


save('/project/rg312/mat_files/climatology_vars_best.mat','-append')
