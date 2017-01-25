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

v_000 = zeros(192,32,25);
v_010 = zeros(192,32,25);
v_025 = zeros(192,32,25);
v_050 = zeros(192,32,25);
v_075 = zeros(192,32,25);
v_100 = zeros(192,32,25);
v_th = zeros(192,32,25);
u_000 = zeros(192,32,25);
u_010 = zeros(192,32,25);
u_025 = zeros(192,32,25);
u_050 = zeros(192,32,25);
u_075 = zeros(192,32,25);
u_100 = zeros(192,32,25);
u_th = zeros(192,32,25);

vsq_000 = zeros(192,32,25);
vsq_010 = zeros(192,32,25);
vsq_025 = zeros(192,32,25);
vsq_050 = zeros(192,32,25);
vsq_075 = zeros(192,32,25);
vsq_100 = zeros(192,32,25);
vsq_th = zeros(192,32,25);
usq_000 = zeros(192,32,25);
usq_010 = zeros(192,32,25);
usq_025 = zeros(192,32,25);
usq_050 = zeros(192,32,25);
usq_075 = zeros(192,32,25);
usq_100 = zeros(192,32,25);
usq_th = zeros(192,32,25);

i=0
for nit = 86640:240:259200;
i=i+1

rDir = '/project/rg312/wv_on_rad_off/run_doshallower00/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
u_000 = u_000 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVEL    '));
v_000 = v_000 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'UVELSQ  '));
usq_000 = usq_000 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVELSQ  '));
vsq_000 = vsq_000 + dyn(:,:,:,J)./720;

rDir = '/project/rg312/wv_on_rad_off/run_doshallower01/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
u_010 = u_010 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVEL    '));
v_010 = v_010 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'UVELSQ  '));
usq_010 = usq_010 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVELSQ  '));
vsq_010 = vsq_010 + dyn(:,:,:,J)./720;


rDir = '/project/rg312/wv_on_rad_off/run_doshallower025/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
u_025 = u_025 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVEL    '));
v_025 = v_025 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'UVELSQ  '));
usq_025 = usq_025 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVELSQ  '));
vsq_025 = vsq_025 + dyn(:,:,:,J)./720;


rDir = '/project/rg312/wv_on_rad_off/run_doshallower05/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
u_050 = u_050 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVEL    '));
v_050 = v_050 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'UVELSQ  '));
usq_050 = usq_050 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVELSQ  '));
vsq_050 = vsq_050 + dyn(:,:,:,J)./720;



rDir = '/project/rg312/wv_on_rad_off/run_doshallower75/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
u_075 = u_075 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVEL    '));
v_075 = v_075 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'UVELSQ  '));
usq_075 = usq_075 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVELSQ  '));
vsq_075 = vsq_075 + dyn(:,:,:,J)./720;



rDir = '/project/rg312/wv_on_rad_off/run_doshallower10/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
u_100 = u_100 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVEL    '));
v_100 = v_100 + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'UVELSQ  '));
usq_100 = usq_100 + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVELSQ  '));
vsq_100 = vsq_100 + dyn(:,:,:,J)./720;


rDir = '/project/rg312/wv_on_rad_off/run_doshallowerth/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
u_th = u_th + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVEL    '));
v_th = v_th + dyn(:,:,:,J)./720;

J=find(strcmp(fldList,'UVELSQ  '));
usq_th = usq_th + dyn(:,:,:,J)./720;
J=find(strcmp(fldList,'VVELSQ  '));
vsq_th = vsq_th + dyn(:,:,:,J)./720;

end


nit = 259200;


[uE_000,vN_000] = rotate_uv2uvEN(u_000,v_000,AngleCS,AngleSN,Grid);
[uE_010,vN_010] = rotate_uv2uvEN(u_010,v_010,AngleCS,AngleSN,Grid);
[uE_025,vN_025] = rotate_uv2uvEN(u_025,v_025,AngleCS,AngleSN,Grid);
[uE_050,vN_050] = rotate_uv2uvEN(u_050,v_050,AngleCS,AngleSN,Grid);
[uE_075,vN_075] = rotate_uv2uvEN(u_075,v_075,AngleCS,AngleSN,Grid);
[uE_100,vN_100] = rotate_uv2uvEN(u_100,v_100,AngleCS,AngleSN,Grid);
[uE_th,vN_th] = rotate_uv2uvEN(u_th,v_th,AngleCS,AngleSN,Grid);

ke_000 = (usq_000 + vsq_000)./2;
ke_010 = (usq_010 + vsq_010)./2;
ke_025 = (usq_025 + vsq_025)./2;
ke_050 = (usq_050 + vsq_050)./2;
ke_075 = (usq_075 + vsq_075)./2;
ke_100 = (usq_100 + vsq_100)./2;
ke_th = (usq_th + vsq_th)./2;

%clear('u_000','u_010','u_025','u_050','u_075','u_100','v_000','v_010','v_025','v_050','v_075','v_100')

yi=-89:2:89;
xi = -179:2:179;

uE_000_zav = squeeze(mean(cube2latlon(xc,yc,uE_000,xi,yi),1));
uE_010_zav = squeeze(mean(cube2latlon(xc,yc,uE_010,xi,yi),1));
uE_025_zav = squeeze(mean(cube2latlon(xc,yc,uE_025,xi,yi),1));
uE_050_zav = squeeze(mean(cube2latlon(xc,yc,uE_050,xi,yi),1));
uE_075_zav = squeeze(mean(cube2latlon(xc,yc,uE_075,xi,yi),1));
uE_100_zav = squeeze(mean(cube2latlon(xc,yc,uE_100,xi,yi),1));
uE_th_zav = squeeze(mean(cube2latlon(xc,yc,uE_th,xi,yi),1));

vN_000_zav = squeeze(mean(cube2latlon(xc,yc,vN_000,xi,yi),1));
vN_010_zav = squeeze(mean(cube2latlon(xc,yc,vN_010,xi,yi),1));
vN_025_zav = squeeze(mean(cube2latlon(xc,yc,vN_025,xi,yi),1));
vN_050_zav = squeeze(mean(cube2latlon(xc,yc,vN_050,xi,yi),1));
vN_075_zav = squeeze(mean(cube2latlon(xc,yc,vN_075,xi,yi),1));
vN_100_zav = squeeze(mean(cube2latlon(xc,yc,vN_100,xi,yi),1));
vN_th_zav = squeeze(mean(cube2latlon(xc,yc,vN_th,xi,yi),1));

ke_000_zav = squeeze(mean(cube2latlon(xc,yc,ke_000,xi,yi),1));
ke_010_zav = squeeze(mean(cube2latlon(xc,yc,ke_010,xi,yi),1));
ke_025_zav = squeeze(mean(cube2latlon(xc,yc,ke_025,xi,yi),1));
ke_050_zav = squeeze(mean(cube2latlon(xc,yc,ke_050,xi,yi),1));
ke_075_zav = squeeze(mean(cube2latlon(xc,yc,ke_075,xi,yi),1));
ke_100_zav = squeeze(mean(cube2latlon(xc,yc,ke_100,xi,yi),1));
ke_th_zav = squeeze(mean(cube2latlon(xc,yc,ke_th,xi,yi),1));

zke_000_zav  = (uE_000_zav.^2 + vN_000_zav.^2)./2;
zke_010_zav  = (uE_010_zav.^2 + vN_010_zav.^2)./2;
zke_025_zav  = (uE_025_zav.^2 + vN_025_zav.^2)./2;
zke_050_zav  = (uE_050_zav.^2 + vN_050_zav.^2)./2;
zke_075_zav  = (uE_075_zav.^2 + vN_075_zav.^2)./2;
zke_100_zav  = (uE_100_zav.^2 + vN_100_zav.^2)./2;
zke_th_zav  = (uE_th_zav.^2 + vN_th_zav.^2)./2;

eke_000_zav = ke_000_zav - zke_000_zav;
eke_010_zav = ke_010_zav - zke_010_zav;
eke_025_zav = ke_025_zav - zke_025_zav;
eke_050_zav = ke_050_zav - zke_050_zav;
eke_075_zav = ke_075_zav - zke_075_zav;
eke_100_zav = ke_100_zav - zke_100_zav;
eke_th_zav = ke_th_zav - zke_th_zav;

save('/project/rg312/mat_files/eke_loaded.mat')

