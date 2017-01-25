%yet another go at looking at the heat budget. 
%This time load in utheta, vtheta, wtheta, htrt, and see how close a match we can get on a one day daily lat-lon plot


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

load('/project/rg312/mat_files/heat_rates.mat','htrt_100')
htrt_100_ll = cube2latlon(xc,yc,htrt_100(:,:,:,360),xi,yi).*86400;

load('/project/rg312/mat_files/heat_budg_fluxes.mat','wth_100','uEth_100','vNth_100')

uEth_100_ll = cube2latlon(xc,yc,uEth_100(:,:,:,360),xi,yi);
vNth_100_ll = cube2latlon(xc,yc,vNth_100(:,:,:,360),xi,yi);
wth_100_ll_half = zeros(180,90,26);
wth_100_ll_half(:,:,1:25) = cube2latlon(xc,yc,wth_100(:,:,:,360),xi,yi);


clear('wth_100_ll')


dwthdp = diff(wth_100_ll_half,1,3)./-4000;

[a,duthdxrcos,b] = gradient(uEth_100_ll,pi./90);

for i=1:90

duthdx(:,i,:) = duthdxrcos(:,i,:)./cos(yi(i).*pi./180)./radius;
vNthcos(:,i,:) = vNth_100_ll(:,i,:).*cos(yi(i).*pi./180);

end

[dvthdyrcos,a,b] = gradient(vNthcos,pi./90);

for i=1:90

dvthdy(:,i,:) = dvthdyrcos(:,i,:)./cos(yi(i).*pi./180)./radius;

end

