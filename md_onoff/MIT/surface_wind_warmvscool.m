%load in heat fluxes for both warm and cool experiment and overplot
rDir='/project/rg312/final_runs/run_radon_short/';

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
yi=-89:2:89;
xi = -179:2:179;
A=0.06;
L = 2.500e6;
cp = 287.04./(2./7.);
g=9.8;
a=6371.0e3;

nit = 172800;

rDir='/project/rg312/final_runs/run_radon_short/';

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    ')); ucs = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    ')); vcs = dyn(:,:,:,J);

[uE,vN] = rotate_uv2uvEN(ucs,vcs,AngleCS,AngleSN,Grid);
uE_ll = squeeze(mean(cube2latlon(xc,yc,uE,xi,yi),1));



rDir='/project/rg312/final_runs/run_radon_short_70/';

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    ')); ucs = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    ')); vcs = dyn(:,:,:,J);

[uE,vN] = rotate_uv2uvEN(ucs,vcs,AngleCS,AngleSN,Grid);
uE_ll_70 = squeeze(mean(cube2latlon(xc,yc,uE,xi,yi),1));


figure
plot(yi,uE_ll(:,1))
hold on
plot(yi,uE_ll_70(:,1),'r')
legend('ctrl','warmer')
print('-dpng','surface_wind_warmvscold.png')





v=-20:5:45;

figure
[C,h] = contourf(yi,rC./100,uE_ll',v); 
set(gca,'YDir','reverse','FontSize',10)
colormap(b2r(-20,45));
colorbar
xlabel('Latitude','FontSize',12);
ylabel('Pressure, hPa','FontSize',12)
title('ctrl','FontSize',12)
print('-dpng','uE_ctrl.png')

figure
[C,h] = contourf(yi,rC./100,uE_ll_70',v); 
set(gca,'YDir','reverse','FontSize',10)
colormap(b2r(-20,45));
colorbar
xlabel('Latitude','FontSize',12);
ylabel('Pressure, hPa','FontSize',12)
title('warmer','FontSize',12)
print('-dpng','uE_warmer.png')
