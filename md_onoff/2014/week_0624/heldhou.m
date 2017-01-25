%load in theta profile and try to calculate held hou width prediction based on this



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


%need del theta across cell, g, height of cell, omega, theta0<-- 'reference temperature'

omega = 2.*pi./24./60./60;
g = 9.81;
rd = 287;
a=6371.0e3;


theta_w_vzav = mean(theta_w_zav,2);
theta_h_vzav = mean(theta_h_zav,2);
theta_q_vzav = mean(theta_q_zav,2);
theta_d_vzav = mean(theta_d_zav,2);

deltheta_w = theta_w_vzav(46) - theta_w_vzav(90);
deltheta_h = theta_h_vzav(46) - theta_h_vzav(90);
deltheta_q = theta_q_vzav(46) - theta_q_vzav(90);
deltheta_d = theta_d_vzav(46) - theta_d_vzav(90);

%let 
T0 = 295;

%take H as trop height

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
t_w_zav(:,j)=theta_w_zav(:,j).*convthetatoT(j,1);
t_h_zav(:,j)=theta_h_zav(:,j).*convthetatoT(j,1);
t_q_zav(:,j)=theta_q_zav(:,j).*convthetatoT(j,1);
t_d_zav(:,j)=theta_d_zav(:,j).*convthetatoT(j,1);
end

%locate tropopause at 40 for each run

for k=1:25
rho_w(:,k) = rC(k)./(rd.*t_w_zav(:,k));
rho_h(:,k) = rC(k)./(rd.*t_h_zav(:,k));
rho_q(:,k) = rC(k)./(rd.*t_q_zav(:,k));
rho_d(:,k) = rC(k)./(rd.*t_d_zav(:,k));
end

dTdz_w = rho_w.*g.*gradient(t_w_zav,4000);
dTdz_h = rho_h.*g.*gradient(t_h_zav,4000);
dTdz_q = rho_q.*g.*gradient(t_q_zav,4000);
dTdz_d = rho_d.*g.*gradient(t_d_zav,4000);

%lapse rate = -dT/dz

trop_w = max(find(dTdz_w(46,:).*1000 <= -2));
trop_h = max(find(dTdz_h(46,:).*1000 <= -2));
trop_q = max(find(dTdz_q(46,:).*1000 <= -2));
trop_d = max(find(dTdz_d(46,:).*1000 <= -2));

for i=1:25
integrand_w(:,i) = rd.*t_w_zav(:,i)./rC(i)./g;
integrand_h(:,i) = rd.*t_h_zav(:,i)./rC(i)./g;
integrand_q(:,i) = rd.*t_q_zav(:,i)./rC(i)./g;
integrand_d(:,i) = rd.*t_d_zav(:,i)./rC(i)./g;
end

H_w = sum(integrand_w(46,1:trop_w),2).*4000;
H_h = sum(integrand_h(46,1:trop_h),2).*4000;
H_q = sum(integrand_q(46,1:trop_q),2).*4000;
H_d = sum(integrand_d(46,1:trop_d),2).*4000;


Y_w = sqrt( (5.*deltheta_w.*g.*H_w)./(3.*omega.^2.*T0) );
Y_h = sqrt( (5.*deltheta_h.*g.*H_h)./(3.*omega.^2.*T0) );
Y_q = sqrt( (5.*deltheta_q.*g.*H_q)./(3.*omega.^2.*T0) );
Y_d = sqrt( (5.*deltheta_d.*g.*H_d)./(3.*omega.^2.*T0) );
