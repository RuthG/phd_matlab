%load in stability data and plot 


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
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i)=dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_h(:,:,:,i)=dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_quarterwv/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_q(:,:,:,i)=dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_5year_c/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_d(:,:,:,i)=dyn(:,:,:,J);

end

theta_w_mean = mean(theta_w,4);
theta_h_mean = mean(theta_h,4);
theta_q_mean = mean(theta_q,4);
theta_d_mean = mean(theta_d,4);

[theta_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_w_mean,ny,yc,ar,hc);
[theta_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_h_mean,ny,yc,ar,hc);
[theta_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_q_mean,ny,yc,ar,hc);
[theta_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_d_mean,ny,yc,ar,hc);

figure
v=250:5:650;
[C,h] = contour(ylat,rC./100,theta_w_zav',v,'k');
vec=250:10:650;
clabel(C,h,vec);
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['Theta, 1xe_{s0}, K'])
print('-dpng','theta_w.png')

figure
v=250:5:650;
[C,h] = contour(ylat,rC./100,theta_h_zav',v,'k');
vec=250:10:650;
clabel(C,h,vec);
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['Theta, 0.5xe_{s0}, K'])
print('-dpng','theta_h.png')

figure
v=250:5:650;
[C,h] = contour(ylat,rC./100,theta_q_zav',v,'k');
vec=250:10:650;
clabel(C,h,vec);
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['Theta, 0.25xe_{s0}, K'])
print('-dpng','theta_q.png')

figure
v=250:5:650;
[C,h] = contour(ylat,rC./100,theta_d_zav',v,'k');
vec=250:10:650;
clabel(C,h,vec);
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['Theta, 0xe_{s0}, K'])
print('-dpng','theta_d.png')
