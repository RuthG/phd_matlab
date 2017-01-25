%Look at heating on isentropic coordinates....

theta_grid = 290:5:350;

rDir='/project/rg312/final_runs/run_100_rad_on/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xi=-179:2:179; yi=-89:2:89;
nit = 432000;

theta=rdmds([rDir,'T'],nit);

[snap,iter,M]=rdmds([rDir,'snapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhdTdt'));
dTdt = snap(:,:,:,J).*86400;

dTdt_th = x_on_theta(theta,dTdt);

dTdt_th_ll = cube2latlon(xc,yc,dTdt_th,xi,yi);

figure
[C,h] = contourf(xi,yi,dTdt_th_ll(:,:,9)',-10:0.6:10);
colormap(b2r(-10,10));
colorbar;
set(h,'LineColor','none');
set(gca,'FontSize',12);
colorbar('FontSize',15);
title('dT/dt (K/day), 330K','FontSize',15);
ylabel('Latitude','FontSize',15);
xlabel('Longitude','FontSize',15);
print('-dpng','dTdt_330.png')


figure
[C,h] = contourf(xi,yi,dTdt_th_ll(:,:,3)',-10:0.6:10);
colormap(b2r(-10,10));
colorbar;
set(h,'LineColor','none');
set(gca,'FontSize',12);
colorbar('FontSize',15);
title('dT/dt (K/day), 300K','FontSize',15);
ylabel('Latitude','FontSize',15);
xlabel('Longitude','FontSize',15);
print('-dpng','dTdt_300.png')


figure
[C,h] = contourf(xi,yi,dTdt_th_ll(:,:,6)',-10:0.6:10);
colormap(b2r(-10,10));
colorbar;
set(h,'LineColor','none');
set(gca,'FontSize',12);
colorbar('FontSize',15);
title('dT/dt (K/day), 315K','FontSize',15);
ylabel('Latitude','FontSize',15);
xlabel('Longitude','FontSize',15);
print('-dpng','dTdt_315.png')