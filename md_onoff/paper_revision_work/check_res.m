%Load in gridding files, try to somehow transfer to a lat-lon grid to figure out our midlatitude resolution
	
rDir='/project/rg312/final_runs/run_000_final_noshallow/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
dxc=rdmds([rDir,'DXC']);
dyc=rdmds([rDir,'DYC']);
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
xi=-179:2:180;
yi=-89:2:90;


ar_ll = cube2latlon(xc,yc,ar,xi,yi);
dxc_ll = cube2latlon(xc,yc,dxc,xi,yi);
dyc_ll = cube2latlon(xc,yc,dyc,xi,yi);

figure
contourf(xi,yi,sqrt(ar_ll)'./1000.)
colorbar

figure
contourf(xi,yi,dxc_ll'./1000.)
colorbar

figure
contourf(xi,yi,dyc_ll'./1000.)
colorbar

figure
plot(yi,mean(sqrt(ar_ll)'./1000.,2))
hold on
plot(yi,min(sqrt(ar_ll)./1000.),'r')
plot(yi,max(sqrt(ar_ll)./1000.),'g')
title('Min, mean, and max resolution')
xlabel('Latitude')
ylabel('Grid spacing, km')
print('-dpng','check_res.png')
