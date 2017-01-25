%load in data from the vw run and plot up the resulting jet to justify using the 'worse' fit



rDir='/project/rg312/run_radon_varyingwin/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));
drC=squeeze(rdmds([rDir,'DRC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
ny=90;

%read files
i=0;
for nit = 62640:240:86400;
i=i+1

rDir='/project/rg312/run_radon_varyingwin/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE_vw(:,:,:,i),vN_vw(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);

end

uE_vw_mean = mean(uE_vw,4);
vN_vw_mean = mean(vN_vw,4);

xi=-179:2:180;yi=-89:2:90;
uEll_vw=cube2latlon(xc,yc,uE_vw_mean,xi,yi);
vNll_vw=cube2latlon(xc,yc,vN_vw_mean,xi,yi);

uE_vw_zav(:,:) = mean(uEll_vw,1);
vN_vw_zav(:,:) = mean(vNll_vw,1);




figure
v = - 20:10:50;
[C,h] = contour(yi,rC./100,uE_vw_zav',v,'k','LineWidth',1);
set(gca,'YDir','reverse','FontSize',15)
labels = -20:10:50;
clabel(C,h,labels,'FontSize',15);
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
%title('Zonal Wind, m/s, vw run')
print('-dpdf','-r300','u_vw.pdf')


