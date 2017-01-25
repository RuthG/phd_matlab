

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
yi = -89:2:89;
xi = -179:2:179;

Rd = 287.04;
g = 9.81;

load('/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat','theta_000','theta_100')
theta_000_ll = squeeze(cube2latlon(xc,yc,theta_000(:,:,:,360),xi,yi));
theta_100_ll = squeeze(cube2latlon(xc,yc,theta_100(:,:,:,360),xi,yi));
clear('theta_000','theta_100')

load('/project/rg312/mat_files/snapshot_data/uE_snapshots_best.mat','uE_000','uE_100')
uE_000_ll = squeeze(cube2latlon(xc,yc,uE_000(:,:,:,360),xi,yi));
uE_100_ll = squeeze(cube2latlon(xc,yc,uE_100(:,:,:,360),xi,yi));
clear('uE_000','uE_100')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_000','vN_100')
vN_000_ll = squeeze(cube2latlon(xc,yc,vN_000(:,:,:,360),xi,yi));
vN_100_ll = squeeze(cube2latlon(xc,yc,vN_100(:,:,:,360),xi,yi));
clear('vN_000','vN_100')

yy=repmat(yi,[180,1])*pi/180;
sst=sin(1.5*yy); sst=1.-sst.*sst; 
sst(find(abs(repmat(yi,[180,1])) > 60.))=0.;
sst=273.15+27*sst;

ri_a = 9.81.*((theta_000_ll(:,:,1)' - sst')./sst')./(uE_000_ll(:,:,1)'.^2 + vN_000_ll(:,:,1)'.^2);

for i=2:25
ri_000(:,:,i-1) = 9.81.*((theta_000_ll(:,:,i)' - theta_000_ll(:,:,1)')./theta_000_ll(:,:,1)')./(uE_000_ll(:,:,i)'.^2 + vN_000_ll(:,:,i)'.^2);

ri_100(:,:,i-1) = 9.81.*((theta_100_ll(:,:,i)' - theta_100_ll(:,:,1)')./theta_100_ll(:,:,1)')./(uE_100_ll(:,:,i)'.^2 + vN_100_ll(:,:,i)'.^2);
end

