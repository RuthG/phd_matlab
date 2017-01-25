%load up diffusive and sensible heat budget terms, for all runs look at structure and compare sizes/structures

% choose directory, load grid
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';
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
ny=90;

%read files
i=0;
for nit = 259200:86400:604800;
i=i+1

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';
%surface/toa fluxes
[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhSens'));
sens_w(:,:,i) = surf(:,:,J);

%heating rates
convthetatoT=(rC/101325.0).^(2./7.);
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

for j=1:size(rC)
J=find(strcmp(fldList,'AtPhdTdf'));
difht_w(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
end


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv/';
%surface/toa fluxes
[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhSens'));
sens_h(:,:,i) = surf(:,:,J);

%heating rates
convthetatoT=(rC/101325.0).^(2./7.);
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

for j=1:size(rC)
J=find(strcmp(fldList,'AtPhdTdf'));
difht_h(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
end


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_quarterwv/';
%surface/toa fluxes
[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhSens'));
sens_q(:,:,i) = surf(:,:,J);

%heating rates
convthetatoT=(rC/101325.0).^(2./7.);
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

for j=1:size(rC)
J=find(strcmp(fldList,'AtPhdTdf'));
difht_q(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
end


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_5year_c/';
%surface/toa fluxes
[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhSens'));
sens_d(:,:,i) = surf(:,:,J);

%heating rates
convthetatoT=(rC/101325.0).^(2./7.);
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

for j=1:size(rC)
J=find(strcmp(fldList,'AtPhdTdf'));
difht_d(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
end

end

%take time averages

sens_w_mean = mean(sens_w,3);
difht_w_mean = mean(difht_w,4);
sens_h_mean = mean(sens_h,3);
difht_h_mean = mean(difht_h,4);
sens_q_mean = mean(sens_q,3);
difht_q_mean = mean(difht_q,4);
sens_d_mean = mean(sens_d,3);
difht_d_mean = mean(difht_d,4);

g=9.81;
cp=1004.64;
intfac = 4000.*cp./g;
difht_w_vint = sum(difht_w_mean,3).*intfac;
difht_h_vint = sum(difht_h_mean,3).*intfac;
difht_q_vint = sum(difht_q_mean,3).*intfac;
difht_d_vint = sum(difht_d_mean,3).*intfac;

%take zonal avs
[sens_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(sens_w_mean,ny,yc,ar,hc);
[difht_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_w_vint,ny,yc,ar,hc);
[difht_w_full_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_w_mean,ny,yc,ar,hc);
[sens_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(sens_h_mean,ny,yc,ar,hc);
[difht_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_h_vint,ny,yc,ar,hc);
[difht_h_full_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_h_mean,ny,yc,ar,hc);
[sens_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(sens_q_mean,ny,yc,ar,hc);
[difht_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_q_vint,ny,yc,ar,hc);
[difht_q_full_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_q_mean,ny,yc,ar,hc);
[sens_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(sens_d_mean,ny,yc,ar,hc);
[difht_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_d_vint,ny,yc,ar,hc);
[difht_d_full_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_d_mean,ny,yc,ar,hc);

%compare sensible? terms
plot(ylat,difht_w_zav)
xlabel('Latitude')
ylabel('Heat flux, Wm^{-2}')
hold on
plot(ylat,difht_h_zav,'-.')
plot(ylat,difht_q_zav,':')
plot(ylat,difht_d_zav,'--')
plot(ylat,sens_w_zav,'r')
plot(ylat,sens_h_zav,'r-.')
plot(ylat,sens_q_zav,'r:')
plot(ylat,sens_d_zav,'r--')
title('Sensible heating rates for each run')
print('-dpng','sens_heat.png')

figure
v=-3:0.5:4;
[C,h] = contourf(ylat,rC./100,difht_w_full_zav'.*86400,v);
colorbar
colormap(b2r(-3,4));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['Diffusive heating, 1xe_{s0}, K/day'])
print('-dpng','diff_heat_w.png')

figure
[C,h] = contourf(ylat,rC./100,difht_h_full_zav'.*86400,v);
colorbar
colormap(b2r(-3,4));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['Diffusive heating, 0.5xe_{s0}, K/day'])
print('-dpng','diff_heat_h.png')

figure
[C,h] = contourf(ylat,rC./100,difht_q_full_zav'.*86400,v);
colorbar
colormap(b2r(-3,4));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['Diffusive heating, 0.25xe_{s0}, K/day'])
print('-dpng','diff_heat_q.png')

figure
[C,h] = contourf(ylat,rC./100,difht_d_full_zav'.*86400,v);
colorbar
colormap(b2r(-3,4));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['Diffusive heating, 0xe_{s0}, K/day'])
print('-dpng','diff_heat_d.png')

return



