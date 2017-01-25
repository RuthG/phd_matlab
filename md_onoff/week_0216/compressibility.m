%test compressibility on lat-lon grid


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

radius = 6371.0e3;

load('/project/rg312/mat_files/snapshot_data/uE_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/w_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/theta_snapshots.mat')

w_000_ll = zeros(180,90,26);
w_000_ll(:,:,1:25) = cube2latlon(xc,yc,w_000(:,:,:,360),xi,yi);
clear('w_000','w_010','w_025','w_050','w_075','w_100')
uE_000_ll = cube2latlon(xc,yc,uE_000(:,:,:,360),xi,yi);
clear('uE_000','uE_010','uE_025','uE_050','uE_075','uE_100')
vN_000_ll = cube2latlon(xc,yc,vN_000(:,:,:,360),xi,yi);
clear('vN_000','vN_010','vN_025','vN_050','vN_075','vN_100')
theta_000_ll = cube2latlon(xc,yc,theta_000(:,:,:,360),xi,yi);
clear('theta_000','theta_010','theta_025','theta_050','theta_075','theta_100')

dwdp = diff(w_000_ll,1,3)./-4000;

[a,dudxrcos,b] = gradient(uE_000_ll,pi./90);

for i=1:90

dudx(:,i,:) = dudxrcos(:,i,:)./cos(yi(i).*pi./180)./radius;
vNcos(:,i,:) = vN_000_ll(:,i,:).*cos(yi(i).*pi./180);

end

[dvdyrcos,a,b] = gradient(vNcos,pi./90);

for i=1:90

dvdy(:,i,:) = dvdyrcos(:,i,:)./cos(yi(i).*pi./180)./radius;

end


