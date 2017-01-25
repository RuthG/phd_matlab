%what went wrong in the coupled ocean run? :o
%load up temperature and wind fields, see how they look..

% choose directory, load grid
%rDir='/project/rg312/final_runs/run_qflux_albedo_5yr/';
rDir='/project/MITgcm/MITgcm_150518/verification/atm_gray_ruth/run/';
%rDir='/project/rg312/final_runs/run_qflux_albedo_5yr_rf/';

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run %%%%%%%%%%%%%%%%

i=0;
v_c = zeros(192,32,25,4);
u_c = zeros(192,32,25,4);
w_c = zeros(192,32,25,4);
theta_c = zeros(192,32,25,4);
q_c = zeros(192,32,25,4);

for nit = 172800:86400:864000;
i=i+1;

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
u_c(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
v_c(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVEL    '));
w_c(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_c(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q_c(:,:,:,i) = dyn(:,:,:,J);

end %nit loop

[uE_c,vN_c] = rotate_uv2uvEN(u_c,v_c,AngleCS,AngleSN,Grid);

convthetatoT=(rC/100000.0).^(2./7.);
for k=1:size(rC)
t_c(:,:,k,:)=theta_c(:,:,k,:).*convthetatoT(k,1);
end

uE_c_zav = squeeze(mean(cube2latlon(xc,yc,uE_c,xi,yi),1));
vN_c_zav = squeeze(mean(cube2latlon(xc,yc,vN_c,xi,yi),1));
theta_c_zav = squeeze(mean(cube2latlon(xc,yc,theta_c,xi,yi),1));
t_c_zav = squeeze(mean(cube2latlon(xc,yc,t_c,xi,yi),1));
q_c_zav = squeeze(mean(cube2latlon(xc,yc,q_c,xi,yi),1));
w_c_zav = squeeze(mean(cube2latlon(xc,yc,w_c,xi,yi),1));
return


rDir='/project/rg312/final_runs/run_qflux_albedo_5yr_2co2/';

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run %%%%%%%%%%%%%%%%

i=0;
v_t = zeros(192,32,25,4);
u_t = zeros(192,32,25,4);
w_t = zeros(192,32,25,4);
theta_t = zeros(192,32,25,4);
q_t = zeros(192,32,25,4);

for nit = 172800:86400:432000;
i=i+1;

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
u_t(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
v_t(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVEL    '));
w_t(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_t(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q_t(:,:,:,i) = dyn(:,:,:,J);

end %nit loop

[uE_t,vN_t] = rotate_uv2uvEN(u_t,v_t,AngleCS,AngleSN,Grid);

convthetatoT=(rC/100000.0).^(2./7.);
for k=1:size(rC)
t_t(:,:,k,:)=theta_t(:,:,k,:).*convthetatoT(k,1);
end

uE_t_zav = squeeze(mean(cube2latlon(xc,yc,uE_t,xi,yi),1));
vN_t_zav = squeeze(mean(cube2latlon(xc,yc,vN_t,xi,yi),1));
theta_t_zav = squeeze(mean(cube2latlon(xc,yc,theta_t,xi,yi),1));
t_t_zav = squeeze(mean(cube2latlon(xc,yc,t_t,xi,yi),1));
q_zav = squeeze(mean(cube2latlon(xc,yc,q_t,xi,yi),1));
w_zav = squeeze(mean(cube2latlon(xc,yc,w_t,xi,yi),1));

v=180:10:320;
figure
[C,h] = contour(yi,rC./100,t_c_zav(:,:,4)',v,'k','LineWidth',1.5);
clabel(C,h);
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)
title('Temperature, K, control','FontSize',12)
print('-dpng','t_c_5yr.png')

figure
[C,h] = contour(yi,rC./100,t_t_zav(:,:,4)',v,'k','LineWidth',1.5);
clabel(C,h);
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)
title('Temperature, K, 2xco2','FontSize',12)
print('-dpng','t_2_5yr.png')

v=-30:5:30;
figure
[C,h] = contourf(yi,rC./100,t_t_zav(:,:,4)' - t_c_zav(:,:,4)',v,'LineWidth',1.5);
clabel(C,h);
colormap(b2r(-30,30));
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)
title('Temperature, K, 2xco2 - control','FontSize',12)
print('-dpng','t_diff_5yr.png')


v=-20:5:80;
figure
[C,h] = contour(yi,rC./100,uE_c_zav(:,:,4)',v,'k','LineWidth',1.5);
clabel(C,h);
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)
title('Zonal wind speed, m/s, control','FontSize',12)
print('-dpng','uE_c_5yr.png')

figure
[C,h] = contour(yi,rC./100,uE_t_zav(:,:,4)',v,'k','LineWidth',1.5);
clabel(C,h);
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)
title('Zonal wind speed, m/s, 2xco2','FontSize',12)
print('-dpng','uE_2_5yr.png')

v=-20:5:70;
figure
[C,h] = contourf(yi,rC./100,uE_t_zav(:,:,4)' - uE_c_zav(:,:,4)',v,'LineWidth',1.5);
clabel(C,h);
colormap(b2r(-20,70));
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)
title('Zonal wind speed, m/s, 2xco2 - control','FontSize',12)
print('-dpng','uE_diff_5yr.png')