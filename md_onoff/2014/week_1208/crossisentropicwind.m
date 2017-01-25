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
ny=90;

%have a go at evaluating cross isentropic wind to use as a diagnostic

%need total diabatic heating (dthetadt), difference in theta over time, and dthetadx,y,z

load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat')
xi=-179:2:180;yi=-89:2:90;
t_000_ll = cube2latlon(xc,yc,t_000(:,:,:,91:100),xi,yi);
clear t_000
t_010_ll = cube2latlon(xc,yc,t_010(:,:,:,658:658+9),xi,yi);
clear t_010
t_025_ll = cube2latlon(xc,yc,t_025(:,:,:,455:455+9),xi,yi);
clear t_025
t_050_ll = cube2latlon(xc,yc,t_050(:,:,:,70:79),xi,yi);
clear t_050
t_075_ll = cube2latlon(xc,yc,t_075(:,:,:,201:210),xi,yi);
clear t_075
t_100_ll = cube2latlon(xc,yc,t_100(:,:,:,394:394+9),xi,yi);
clear t_100

load('/project/rg312/mat_files/snapshot_data/theta_snapshots.mat')
theta_000_ll = cube2latlon(xc,yc,theta_000(:,:,:,91:100),xi,yi);
clear theta_000
theta_010_ll = cube2latlon(xc,yc,theta_010(:,:,:,658:658+9),xi,yi);
clear theta_010
theta_025_ll = cube2latlon(xc,yc,theta_025(:,:,:,455:455+9),xi,yi);
clear theta_025
theta_050_ll = cube2latlon(xc,yc,theta_050(:,:,:,70:79),xi,yi);
clear theta_050
theta_075_ll = cube2latlon(xc,yc,theta_075(:,:,:,201:210),xi,yi);
clear theta_075
theta_100_ll = cube2latlon(xc,yc,theta_100(:,:,:,394:394+9),xi,yi);
clear theta_100

load('/project/rg312/mat_files/snapshot_data/uE_snapshots.mat')
uE_000_ll = cube2latlon(xc,yc,uE_000(:,:,:,91:100),xi,yi);
clear uE_000
uE_010_ll = cube2latlon(xc,yc,uE_010(:,:,:,658:658+9),xi,yi);
clear uE_010
uE_025_ll = cube2latlon(xc,yc,uE_025(:,:,:,455:455+9),xi,yi);
clear uE_025
uE_050_ll = cube2latlon(xc,yc,uE_050(:,:,:,70:79),xi,yi);
clear uE_050
uE_075_ll = cube2latlon(xc,yc,uE_075(:,:,:,201:210),xi,yi);
clear uE_075
uE_100_ll = cube2latlon(xc,yc,uE_100(:,:,:,394:394+9),xi,yi);
clear uE_100

load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')
vN_000_ll = cube2latlon(xc,yc,vN_000(:,:,:,91:100),xi,yi);
clear vN_000
vN_010_ll = cube2latlon(xc,yc,vN_010(:,:,:,658:658+9),xi,yi);
clear vN_010
vN_025_ll = cube2latlon(xc,yc,vN_025(:,:,:,455:455+9),xi,yi);
clear vN_025
vN_050_ll = cube2latlon(xc,yc,vN_050(:,:,:,70:79),xi,yi);
clear vN_050
vN_075_ll = cube2latlon(xc,yc,vN_075(:,:,:,201:210),xi,yi);
clear vN_075
vN_100_ll = cube2latlon(xc,yc,vN_100(:,:,:,394:394+9),xi,yi);
clear vN_100

load('/project/rg312/mat_files/snapshot_data/w_snapshots.mat')
w_000_ll = cube2latlon(xc,yc,w_000(:,:,:,91:100),xi,yi);
clear w_000
w_010_ll = cube2latlon(xc,yc,w_010(:,:,:,658:658+9),xi,yi);
clear w_010
w_025_ll = cube2latlon(xc,yc,w_025(:,:,:,455:455+9),xi,yi);
clear w_025
w_050_ll = cube2latlon(xc,yc,w_050(:,:,:,70:79),xi,yi);
clear w_050
w_075_ll = cube2latlon(xc,yc,w_075(:,:,:,201:210),xi,yi);
clear w_075
w_100_ll = cube2latlon(xc,yc,w_100(:,:,:,394:394+9),xi,yi);
clear w_100


a = 6371.0e3;		%radius of the earth
[dthetadx_000,dthetady_000,dthetadp_000,dthetadt_000] = gradient(theta_000_ll,2.*a,2.*a,-4000,1);
[dthetadx_010,dthetady_010,dthetadp_010,dthetadt_010] = gradient(theta_010_ll,2.*a,2.*a,-4000,1);
[dthetadx_025,dthetady_025,dthetadp_025,dthetadt_025] = gradient(theta_025_ll,2.*a,2.*a,-4000,1);
[dthetadx_050,dthetady_050,dthetadp_050,dthetadt_050] = gradient(theta_050_ll,2.*a,2.*a,-4000,1);
[dthetadx_075,dthetady_075,dthetadp_075,dthetadt_075] = gradient(theta_075_ll,2.*a,2.*a,-4000,1);
[dthetadx_100,dthetady_100,dthetadp_100,dthetadt_100] = gradient(theta_100_ll,2.*a,2.*a,-4000,1);

costheta = repmat(cos(yi.*pi./180),[180,1,25,10]);

dthetadx_000 = dthetadx_000./costheta;
dthetadx_010 = dthetadx_010./costheta;
dthetadx_025 = dthetadx_025./costheta;
dthetadx_050 = dthetadx_050./costheta;
dthetadx_075 = dthetadx_075./costheta;
dthetadx_100 = dthetadx_100./costheta;



[dudx_050,dudy_050,dudp_050,dudt_050] = gradient(uE_050_ll,2.*a,2.*a,-4000,1);
[dvdx_050,dvdy_050,dvdp_050,dvdt_050] = gradient(vN_050_ll.*costheta,2.*a,2.*a,-4000,1);
[dwdx_050,dwdy_050,dwdp_050,dwdt_050] = gradient(w_050_ll,2.*a,2.*a,-4000,1);

dvdy_050 = dvdy_050./costheta;

dudx_050 = dudx_050./costheta;



udthetadx_000 = uE_000_ll.*dthetadx_000;
udthetadx_010 = uE_010_ll.*dthetadx_010;
udthetadx_025 = uE_025_ll.*dthetadx_025;
udthetadx_050 = uE_050_ll.*dthetadx_050;
udthetadx_075 = uE_075_ll.*dthetadx_075;
udthetadx_100 = uE_100_ll.*dthetadx_100;

vdthetady_000 = vN_000_ll.*dthetady_000;
vdthetady_010 = vN_010_ll.*dthetady_010;
vdthetady_025 = vN_025_ll.*dthetady_025;
vdthetady_050 = vN_050_ll.*dthetady_050;
vdthetady_075 = vN_075_ll.*dthetady_075;
vdthetady_100 = vN_100_ll.*dthetady_100;

wdthetadp_000 = w_000_ll.*dthetadp_000;
wdthetadp_010 = w_010_ll.*dthetadp_010;
wdthetadp_025 = w_025_ll.*dthetadp_025;
wdthetadp_050 = w_050_ll.*dthetadp_050;
wdthetadp_075 = w_075_ll.*dthetadp_075;
wdthetadp_100 = w_100_ll.*dthetadp_100;

maggradtheta_000 = sqrt(dthetadx_000.^2 + dthetady_000.^2 + dthetadp_000.^2);
maggradtheta_010 = sqrt(dthetadx_010.^2 + dthetady_010.^2 + dthetadp_010.^2);
maggradtheta_025 = sqrt(dthetadx_025.^2 + dthetady_025.^2 + dthetadp_025.^2);
maggradtheta_050 = sqrt(dthetadx_050.^2 + dthetady_050.^2 + dthetadp_050.^2);
maggradtheta_075 = sqrt(dthetadx_075.^2 + dthetady_075.^2 + dthetadp_075.^2);
maggradtheta_100 = sqrt(dthetadx_100.^2 + dthetady_100.^2 + dthetadp_100.^2);




