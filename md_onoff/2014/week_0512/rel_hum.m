%Calculate relative humidity for 3 control runs and plot

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv/';

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

%read fields
i=0;
for nit = 432000:86400:604800;
i=i+1
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_c(:,:,:,i) = dyn(:,:,:,J);
convthetatoT=(rC/101325.0).^(2./7.);
for k=1:25
temp_c(:,:,k,i)=theta_c(:,:,k,i).*convthetatoT(k,1);
end
J=find(strcmp(fldList,'SALT    '));
q_c(:,:,:,i) = dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv_tropheat3eq/';
nit_th = nit + 518400;
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit_th);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_th(:,:,:,i) = dyn(:,:,:,J);
convthetatoT=(rC/101325.0).^(2./7.);
for k=1:25
temp_th(:,:,k,i)=theta_th(:,:,k,i).*convthetatoT(k,1);
end
J=find(strcmp(fldList,'SALT    '));
q_th(:,:,:,i) = dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i) = dyn(:,:,:,J);
convthetatoT=(rC/101325.0).^(2./7.);
for k=1:25
temp_w(:,:,k,i)=theta_w(:,:,k,i).*convthetatoT(k,1);
end
J=find(strcmp(fldList,'SALT    '));
q_w(:,:,:,i) = dyn(:,:,:,J);
end

temp_c_mean = mean(temp_c,4);
q_c_mean = mean(q_c,4);
temp_th_mean = mean(temp_th,4);
q_th_mean = mean(q_th,4);
temp_w_mean = mean(temp_w,4);
q_w_mean = mean(q_w,4);


Rd = 287.04;
Rv = 461.5;
Lv = 2.5e6;
T0 = 273.16;
e0_w = 610.78;
e0_h = 305.39;



for j=1:25
q_sat_c(:,:,j) = Rd./(Rv.*rC(j)).*e0_h.*exp(-Lv./Rv.*(1./temp_c_mean(:,:,j) - 1./T0));
q_sat_th(:,:,j) = Rd./(Rv.*rC(j)).*e0_h.*exp(-Lv./Rv.*(1./temp_th_mean(:,:,j) - 1./T0));
q_sat_w(:,:,j) = Rd./(Rv.*rC(j)).*e0_w.*exp(-Lv./Rv.*(1./temp_w_mean(:,:,j) - 1./T0));
end

RH_c = q_c_mean./q_sat_c;
RH_th = q_th_mean./q_sat_th;
RH_w = q_w_mean./q_sat_w;

[RH_c_zav,mskzon,ylat,areazon]=calcZonalAvgCube(RH_c,ny,yc,ar,hc);
[RH_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(RH_th,ny,yc,ar,hc);
[RH_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(RH_w,ny,yc,ar,hc);

v=0:0.1:1;
figure
[C,h] = contour(ylat,rC,RH_c_zav',v,'k');
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
clabel(C,h);
title('Relative Humidity: Control')
print('-dpng','rh_ctrl.m')

figure
[C,h] = contour(ylat,rC,RH_th_zav',v,'k');
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
clabel(C,h);
title('Relative Humidity: Tropical Heating')
print('-dpng','rh_th.m')

figure
[C,h] = contour(ylat,rC,RH_w_zav',v,'k');
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
clabel(C,h);
title('Relative Humidity: Wet')
print('-dpng','rh_w.m')

