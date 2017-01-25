%Load in convective and condensational precip data, plus convection flags for equivalent snapshots to those used for the paper
%How well do we simulate the storms?

rDir='/net/spat-nas/project/rg312/final_runs/run_000_final_noshallow/';
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

load('/net/spat-nas/project/rg312/mat_files/snapshot_data_final/front_diag.mat')

day000 = 1;
day100 = 61;


rDir='/project/rg312/final_runs/run_000_final_noshallow/';
nit = 86400.*5+240*day000;
load('/project/rg312/mat_files/vt_lats_final.mat');


u_000=cube2latlon(xc,yc,rdmds([rDir,'U'],nit),xi,yi);
v_000=cube2latlon(xc,yc,rdmds([rDir,'V'],nit),xi,yi);
theta_000=cube2latlon(xc,yc,rdmds([rDir,'T'],nit),xi,yi);
q_000=cube2latlon(xc,yc,rdmds([rDir,'S'],nit),xi,yi);

wspd_000 = sqrt(u_000.^2 + v_000.^2);

rDir='/project/rg312/final_runs/run_100_final/';
nit = 86400.*5+240*day100;

u_100=cube2latlon(xc,yc,rdmds([rDir,'U'],nit),xi,yi);
v_100=cube2latlon(xc,yc,rdmds([rDir,'V'],nit),xi,yi);
theta_100=cube2latlon(xc,yc,rdmds([rDir,'T'],nit),xi,yi);
q_100=cube2latlon(xc,yc,rdmds([rDir,'S'],nit),xi,yi);

wspd_100 = sqrt(u_100.^2 + v_100.^2);

figure
[C,h] = contourf(xi,rC(1:10)./100, squeeze(theta_100(:,x100n,1:10))',270:5:300);
colorbar('FontSize',15)
caxis([270 300])
set(gca,'YDir','reverse','FontSize',12)
xlim([-90 90])
title('\Theta, wet','FontSize',12)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
print('-dpng','theta_pbl_wet.png')

figure
[C,h] = contourf(xi,rC(1:10)./100, squeeze(wspd_100(:,x100n,1:10))' , 0:5:30);
colorbar('FontSize',15)
caxis([0 30])
set(gca,'YDir','reverse','FontSize',12)
xlim([-90 90])
title('Wind speed, wet','FontSize',12)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
print('-dpng','wspd_pbl_wet.png')


figure
[C,h] = contourf(xi,rC(1:10)./100, squeeze(theta_000(:,x000n,1:10))',270:5:300 );
colorbar('FontSize',15)
caxis([270 300])
set(gca,'YDir','reverse','FontSize',12)
xlim([-90 90])
title('\Theta, dry','FontSize',12)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
print('-dpng','theta_pbl_dry.png')


figure
[C,h] = contourf(xi,rC(1:10)./100, squeeze(wspd_000(:,x000n,1:10))' , 0:5:30);
colorbar('FontSize',15)
caxis([0 30])
set(gca,'YDir','reverse','FontSize',12)
xlim([-90 90])
title('Wind speed, dry','FontSize',12)
xlabel('Longitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
print('-dpng','wspd_pbl_dry.png')


return


figure
v=0:250:5000.;
[C,h] = contourf(xi,yi,zpbl_000');
set(h,'LineColor','none')
set(gca,'FontSize',12)
hold on
v = -0.9:1:0.1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,day000)',v,'Color',[0.6,0.6,0.6],'LineWidth',1);
caxis([0 5000]); freezeColors
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('Boundary layer depth, 0es0');
ylabel('Latitude','FontSize',15)
xlabel('Longitude','FontSize',15)
print('-dpng','zpbl_000.png')


figure
v=0:250:5000.;
[C,h] = contourf(xi,yi,zpbl_100');
set(h,'LineColor','none')
set(gca,'FontSize',12)
hold on
v = -0.9:1:0.1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,day100)',v,'Color',[0.6,0.6,0.6],'LineWidth',1);
caxis([0 5000]); freezeColors
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('Boundary layer depth, 1es0');
ylabel('Latitude','FontSize',15)
xlabel('Longitude','FontSize',15)
print('-dpng','zpbl_100.png')