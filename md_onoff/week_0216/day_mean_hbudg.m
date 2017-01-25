

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
xi = -179:2:179;

convtheta(1,1,:,1)=(rC/101325.0).^(2./7.);
convthetatoT = repmat(convtheta,[192,32,1]);

load('/project/rg312/mat_files/climatology_vars.mat')

t_000_ll_tav = cube2latlon(xc,yc,t_000,xi,yi);
t_010_ll_tav = cube2latlon(xc,yc,t_010,xi,yi);
t_025_ll_tav = cube2latlon(xc,yc,t_025,xi,yi);
t_050_ll_tav = cube2latlon(xc,yc,t_050,xi,yi);
t_075_ll_tav = cube2latlon(xc,yc,t_075,xi,yi);
t_100_ll_tav = cube2latlon(xc,yc,t_100,xi,yi);

w_000_ll_tav_half = zeros(180,90,26);
w_010_ll_tav_half = zeros(180,90,26);
w_025_ll_tav_half = zeros(180,90,26);
w_050_ll_tav_half = zeros(180,90,26);
w_075_ll_tav_half = zeros(180,90,26);
w_100_ll_tav_half = zeros(180,90,26);

w_000_ll_tav_half(:,:,1:25) = cube2latlon(xc,yc,w_000,xi,yi);
w_010_ll_tav_half(:,:,1:25) = cube2latlon(xc,yc,w_010,xi,yi);
w_025_ll_tav_half(:,:,1:25) = cube2latlon(xc,yc,w_025,xi,yi);
w_050_ll_tav_half(:,:,1:25) = cube2latlon(xc,yc,w_050,xi,yi);
w_075_ll_tav_half(:,:,1:25) = cube2latlon(xc,yc,w_075,xi,yi);
w_100_ll_tav_half(:,:,1:25) = cube2latlon(xc,yc,w_100,xi,yi);

nit=172800;

rDir = '/project/rg312/wv_on_rad_off/run_doshallower00/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'THETA   '));
theta_000 = dyn(:,:,:,J);
t_000 = theta_000.*convthetatoT;

J=find(strcmp(fldList,'UVEL    '));
u_000 = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
v_000 = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVEL    '));
w_000 = dyn(:,:,:,J);


rDir = '/project/rg312/wv_on_rad_off/run_doshallower01/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'THETA   '));
theta_010 = dyn(:,:,:,J);
t_010 = theta_010.*convthetatoT;

J=find(strcmp(fldList,'UVEL    '));
u_010 = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
v_010 = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVEL    '));
w_010 = dyn(:,:,:,J);


rDir = '/project/rg312/wv_on_rad_off/run_doshallower025/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'THETA   '));
theta_025 = dyn(:,:,:,J);
t_025 = theta_025.*convthetatoT;

J=find(strcmp(fldList,'UVEL    '));
u_025 = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
v_025 = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVEL    '));
w_025 = dyn(:,:,:,J);


rDir = '/project/rg312/wv_on_rad_off/run_doshallower05/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'THETA   '));
theta_050 = dyn(:,:,:,J);
t_050 = theta_050.*convthetatoT;

J=find(strcmp(fldList,'UVEL    '));
u_050 = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
v_050 = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVEL    '));
w_050 = dyn(:,:,:,J);


rDir = '/project/rg312/wv_on_rad_off/run_doshallower75/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'THETA   '));
theta_075 = dyn(:,:,:,J);
t_075 = theta_075.*convthetatoT;

J=find(strcmp(fldList,'UVEL    '));
u_075 = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
v_075 = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVEL    '));
w_075 = dyn(:,:,:,J);


rDir = '/project/rg312/wv_on_rad_off/run_doshallower10/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'THETA   '));
theta_100 = dyn(:,:,:,J);
t_100 = theta_100.*convthetatoT;

J=find(strcmp(fldList,'UVEL    '));
u_100 = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
v_100 = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVEL    '));
w_100 = dyn(:,:,:,J);



t_000_ll = cube2latlon(xc,yc,t_000,xi,yi);
t_010_ll = cube2latlon(xc,yc,t_010,xi,yi);
t_025_ll = cube2latlon(xc,yc,t_025,xi,yi);
t_050_ll = cube2latlon(xc,yc,t_050,xi,yi);
t_075_ll = cube2latlon(xc,yc,t_075,xi,yi);
t_100_ll = cube2latlon(xc,yc,t_100,xi,yi);

t_ed_000_ll = t_000_ll - t_000_ll_tav;
t_ed_010_ll = t_010_ll - t_010_ll_tav;
t_ed_025_ll = t_025_ll - t_025_ll_tav;
t_ed_050_ll = t_050_ll - t_050_ll_tav;
t_ed_075_ll = t_075_ll - t_075_ll_tav;
t_ed_100_ll = t_100_ll - t_100_ll_tav;


w_000_ll_half = zeros(180,90,26);
w_010_ll_half = zeros(180,90,26);
w_025_ll_half = zeros(180,90,26);
w_050_ll_half = zeros(180,90,26);
w_075_ll_half = zeros(180,90,26);
w_100_ll_half = zeros(180,90,26);

w_000_ll_half(:,:,1:25) = cube2latlon(xc,yc,w_000,xi,yi);
w_010_ll_half(:,:,1:25) = cube2latlon(xc,yc,w_010,xi,yi);
w_025_ll_half(:,:,1:25) = cube2latlon(xc,yc,w_025,xi,yi);
w_050_ll_half(:,:,1:25) = cube2latlon(xc,yc,w_050,xi,yi);
w_075_ll_half(:,:,1:25) = cube2latlon(xc,yc,w_075,xi,yi);
w_100_ll_half(:,:,1:25) = cube2latlon(xc,yc,w_100,xi,yi);

w_ed_000_ll_half = w_000_ll_half - w_000_ll_tav_half;
w_ed_010_ll_half = w_010_ll_half - w_010_ll_tav_half;
w_ed_025_ll_half = w_025_ll_half - w_025_ll_tav_half;
w_ed_050_ll_half = w_050_ll_half - w_050_ll_tav_half;
w_ed_075_ll_half = w_075_ll_half - w_075_ll_tav_half;
w_ed_100_ll_half = w_100_ll_half - w_100_ll_tav_half;

[a,b,dTdp_000] = gradient(t_000_ll_tav,-4000);
[a,b,dTdp_010] = gradient(t_010_ll_tav,-4000);
[a,b,dTdp_025] = gradient(t_025_ll_tav,-4000);
[a,b,dTdp_050] = gradient(t_050_ll_tav,-4000);
[a,b,dTdp_075] = gradient(t_075_ll_tav,-4000);
[a,b,dTdp_100] = gradient(t_100_ll_tav,-4000);

[a,b,dT_ed_dp_000] = gradient(t_ed_000_ll,-4000);
[a,b,dT_ed_dp_010] = gradient(t_ed_010_ll,-4000);
[a,b,dT_ed_dp_025] = gradient(t_ed_025_ll,-4000);
[a,b,dT_ed_dp_050] = gradient(t_ed_050_ll,-4000);
[a,b,dT_ed_dp_075] = gradient(t_ed_075_ll,-4000);
[a,b,dT_ed_dp_100] = gradient(t_ed_100_ll,-4000);



rC_half = (100000:-4000:0)';
w_ed_000_ll = shiftdim(interp1(rC_half,shiftdim(w_ed_000_ll_half,2),rC),1);
w_ed_010_ll = shiftdim(interp1(rC_half,shiftdim(w_ed_010_ll_half,2),rC),1);
w_ed_025_ll = shiftdim(interp1(rC_half,shiftdim(w_ed_025_ll_half,2),rC),1);
w_ed_050_ll = shiftdim(interp1(rC_half,shiftdim(w_ed_050_ll_half,2),rC),1);
w_ed_075_ll = shiftdim(interp1(rC_half,shiftdim(w_ed_075_ll_half,2),rC),1);
w_ed_100_ll = shiftdim(interp1(rC_half,shiftdim(w_ed_100_ll_half,2),rC),1);

w_000_ll_tav = shiftdim(interp1(rC_half,shiftdim(w_000_ll_tav_half,2),rC),1);
w_010_ll_tav = shiftdim(interp1(rC_half,shiftdim(w_010_ll_tav_half,2),rC),1);
w_025_ll_tav = shiftdim(interp1(rC_half,shiftdim(w_025_ll_tav_half,2),rC),1);
w_050_ll_tav = shiftdim(interp1(rC_half,shiftdim(w_050_ll_tav_half,2),rC),1);
w_075_ll_tav = shiftdim(interp1(rC_half,shiftdim(w_075_ll_tav_half,2),rC),1);
w_100_ll_tav = shiftdim(interp1(rC_half,shiftdim(w_100_ll_tav_half,2),rC),1);


wdT_ed_dp_000 = -dT_ed_dp_000.*w_000_ll_tav.*86400;
wdT_ed_dp_010 = -dT_ed_dp_010.*w_010_ll_tav.*86400;
wdT_ed_dp_025 = -dT_ed_dp_025.*w_025_ll_tav.*86400;
wdT_ed_dp_050 = -dT_ed_dp_050.*w_050_ll_tav.*86400;
wdT_ed_dp_075 = -dT_ed_dp_075.*w_075_ll_tav.*86400;
wdT_ed_dp_100 = -dT_ed_dp_100.*w_100_ll_tav.*86400;

w_ed_dTdp_000 = -dTdp_000.*w_ed_000_ll.*86400;
w_ed_dTdp_010 = -dTdp_010.*w_ed_010_ll.*86400;
w_ed_dTdp_025 = -dTdp_025.*w_ed_025_ll.*86400;
w_ed_dTdp_050 = -dTdp_050.*w_ed_050_ll.*86400;
w_ed_dTdp_075 = -dTdp_075.*w_ed_075_ll.*86400;
w_ed_dTdp_100 = -dTdp_100.*w_ed_100_ll.*86400;

