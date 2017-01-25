%load up some c-s data and use to test gridding files


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
xi = -189:2:189;

load('/project/rg312/mat_files/climatology_vars.mat')

u_snap_000_ll_wrong = cube2latlon(xc,yc,uE_snap_000,xi,yi);
v_snap_000_ll_wrong = cube2latlon(xc,yc,vN_snap_000,xi,yi);

[u_snap_000_ll_check,v_snap_000_ll_check] = uvcube2latlon(xi,yi,u_snap_000,v_snap_000,xc,yc,AngleCS,AngleSN);


%they're the same because the code that rotates to E/N ALSO interpolates. Hooray!
