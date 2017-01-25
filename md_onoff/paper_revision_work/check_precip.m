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

load('/net/spat-nas/project/rg312/mat_files/snapshot_data_final/fig2data.mat')
load('/net/spat-nas/project/rg312/mat_files/snapshot_data_final/front_diag.mat')

day000 = 1;
day100 = 61;


rDir='/project/rg312/final_runs/run_000_final_noshallow/';
nit = 86400.*5+240*day000;
[surf,iter,M]=rdmds([rDir,'sfsnapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhzpbl'));
zpbl_000 = cube2latlon(xc,yc,surf(:,:,J),xi,yi);


rDir='/project/rg312/final_runs/run_100_final/';
nit = 86400.*5+240*day100;
[surf,iter,M]=rdmds([rDir,'sfsnapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhzpbl'));
zpbl_100 = cube2latlon(xc,yc,surf(:,:,J),xi,yi);
J=find(strcmp(fldList,'AtPhConv'));
conv_100 = cube2latlon(xc,yc,surf(:,:,J),xi,yi);
J=find(strcmp(fldList,'AtPhLscP'));
lscp_100 = cube2latlon(xc,yc,surf(:,:,J),xi,yi)*86400.;
J=find(strcmp(fldList,'AtPhCnvP'));
cnvp_100 = cube2latlon(xc,yc,surf(:,:,J),xi,yi)*86400.;

[snap,iter,M]=rdmds([rDir,'snapDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhdQdt'));
dqdt_100 = cube2latlon(xc,yc,snap(:,:,:,J),xi,yi)*86400.;
J=find(strcmp(fldList,'AtPhdtQg'));
dq_diff_100 = cube2latlon(xc,yc,snap(:,:,:,J),xi,yi)*86400.;


figure
v=0:1:12;
[C,h] = contourf(xi,yi,lscp_100',v);
set(h,'LineColor','none')
set(gca,'FontSize',12)
hold on
v = -0.9:1:0.1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,day100)',v,'Color',[0.6,0.6,0.6],'LineWidth',1);
caxis([0 12]); freezeColors
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
ylabel('Latitude','FontSize',15)
xlabel('Longitude','FontSize',15)
print('-dpng','lsc_precip_100.png')


figure
v=0:1:12;
[C,h] = contourf(xi,yi,cnvp_100',v);
set(h,'LineColor','none')
set(gca,'FontSize',12)
hold on
v = -0.9:1:0.1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,day100)',v,'Color',[0.6,0.6,0.6],'LineWidth',1);
caxis([0 12]); freezeColors
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
ylabel('Latitude','FontSize',15)
xlabel('Longitude','FontSize',15)
print('-dpng','cnv_precip_100.png')

return


figure
v=0:1:2.;
[C,h] = contourf(xi,yi,conv_100',v);
set(h,'LineColor','none')
set(gca,'FontSize',12)
hold on
v = -0.9:1:0.1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,day100)',v,'Color',[0.6,0.6,0.6],'LineWidth',1);
caxis([0 2]); freezeColors
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('Convection flag, 1es0');
ylabel('Latitude','FontSize',15)
xlabel('Longitude','FontSize',15)
print('-dpng','convflag_100.png')


figure
v=-0.01:0.001:0.01;
[C,h] = contourf(xi,yi,dqdt_100(:,:,2)',v);
set(h,'LineColor','none')
set(gca,'FontSize',12)
hold on
v = -0.9:1:0.1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,day100)',v,'Color',[0.6,0.6,0.6],'LineWidth',1);
caxis([-0.01 0.01]); freezeColors
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('dqdt, 1es0');
ylabel('Latitude','FontSize',15)
xlabel('Longitude','FontSize',15)
print('-dpng','dqdt_l2_100.png')


figure
v=-0.01:0.001:0.01;
[C,h] = contourf(xi,yi,dqdt_100(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',12)
hold on
v = -0.9:1:0.1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,day100)',v,'Color',[0.6,0.6,0.6],'LineWidth',1);
caxis([-0.01 0.01]); freezeColors
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('dqdt, 1es0');
ylabel('Latitude','FontSize',15)
xlabel('Longitude','FontSize',15)
print('-dpng','dqdt_l5_100.png')

figure
v=-0.01:0.001:0.01;
[C,h] = contourf(xi,yi,dqdt_100(:,:,7)',v);
set(h,'LineColor','none')
set(gca,'FontSize',12)
hold on
v = -0.9:1:0.1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,day100)',v,'Color',[0.6,0.6,0.6],'LineWidth',1);
caxis([-0.01 0.01]); freezeColors
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('dqdt, 1es0');
ylabel('Latitude','FontSize',15)
xlabel('Longitude','FontSize',15)
print('-dpng','dqdt_l7_100.png')

figure
v=-0.01:0.001:0.01;
[C,h] = contourf(xi,yi,dq_diff_100(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',12)
hold on
v = -0.9:1:0.1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,day100)',v,'Color',[0.6,0.6,0.6],'LineWidth',1);
caxis([-0.01 0.01]); freezeColors
xlim([-90 90])
ylim([0 90])
colorbar('FontSize',15)
title('dq diff, 1es0');
ylabel('Latitude','FontSize',15)
xlabel('Longitude','FontSize',15)
print('-dpng','dq_diff_l5_100.png')


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