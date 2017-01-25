%copy heat_budg.m, but just do vint plot for all wv runs

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

%heating rates
convthetatoT=(rC/101325.0).^(2./7.);
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

for j=1:size(rC)
J=find(strcmp(fldList,'AtPhdTdt'));
htrt_w(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_w(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_w(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_w(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_w(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
end

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv/';

%heating rates
convthetatoT=(rC/101325.0).^(2./7.);
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

for j=1:size(rC)
J=find(strcmp(fldList,'AtPhdTdt'));
htrt_h(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_h(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_h(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_h(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_h(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
end

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_quarterwv/';

%heating rates
convthetatoT=(rC/101325.0).^(2./7.);
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

for j=1:size(rC)
J=find(strcmp(fldList,'AtPhdTdt'));
htrt_q(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_q(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_q(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_q(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_q(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
end

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_5year_c/';

%heating rates
convthetatoT=(rC/101325.0).^(2./7.);
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

for j=1:size(rC)
J=find(strcmp(fldList,'AtPhdTdt'));
htrt_d(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_d(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_d(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_d(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_d(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
end

end


htrt_w_mean = mean(htrt_w,4);
difht_w_mean = mean(difht_w,4);
radht_w_mean = mean(radht_w,4);
cndht_w_mean = mean(cndht_w,4);
cnvht_w_mean = mean(cnvht_w,4);

htrt_h_mean = mean(htrt_h,4);
difht_h_mean = mean(difht_h,4);
radht_h_mean = mean(radht_h,4);
cndht_h_mean = mean(cndht_h,4);
cnvht_h_mean = mean(cnvht_h,4);

htrt_q_mean = mean(htrt_q,4);
difht_q_mean = mean(difht_q,4);
radht_q_mean = mean(radht_q,4);
cndht_q_mean = mean(cndht_q,4);
cnvht_q_mean = mean(cnvht_q,4);

htrt_d_mean = mean(htrt_d,4);
difht_d_mean = mean(difht_d,4);
radht_d_mean = mean(radht_d,4);
cndht_d_mean = mean(cndht_d,4);
cnvht_d_mean = mean(cnvht_d,4);


g=9.81;
cp=1004.64;
intfac = 4000.*cp./g;
htrt_w_vint = sum(htrt_w_mean,3).*intfac;
difht_w_vint = sum(difht_w_mean,3).*intfac;
radht_w_vint = sum(radht_w_mean,3).*intfac;
cndht_w_vint = sum(cndht_w_mean,3).*intfac;
cnvht_w_vint = sum(cnvht_w_mean,3).*intfac;

htrt_h_vint = sum(htrt_h_mean,3).*intfac;
difht_h_vint = sum(difht_h_mean,3).*intfac;
radht_h_vint = sum(radht_h_mean,3).*intfac;
cndht_h_vint = sum(cndht_h_mean,3).*intfac;
cnvht_h_vint = sum(cnvht_h_mean,3).*intfac;

htrt_q_vint = sum(htrt_q_mean,3).*intfac;
difht_q_vint = sum(difht_q_mean,3).*intfac;
radht_q_vint = sum(radht_q_mean,3).*intfac;
cndht_q_vint = sum(cndht_q_mean,3).*intfac;
cnvht_q_vint = sum(cnvht_q_mean,3).*intfac;

htrt_d_vint = sum(htrt_d_mean,3).*intfac;
difht_d_vint = sum(difht_d_mean,3).*intfac;
radht_d_vint = sum(radht_d_mean,3).*intfac;
cndht_d_vint = sum(cndht_d_mean,3).*intfac;
cnvht_d_vint = sum(cnvht_d_mean,3).*intfac;

[htrt_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_w_vint,ny,yc,ar,hc);
[difht_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_w_vint,ny,yc,ar,hc);
[radht_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_w_vint,ny,yc,ar,hc);
[cndht_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_w_vint,ny,yc,ar,hc);
[cnvht_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_w_vint,ny,yc,ar,hc);

[htrt_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_h_vint,ny,yc,ar,hc);
[difht_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_h_vint,ny,yc,ar,hc);
[radht_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_h_vint,ny,yc,ar,hc);
[cndht_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_h_vint,ny,yc,ar,hc);
[cnvht_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_h_vint,ny,yc,ar,hc);

[htrt_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_q_vint,ny,yc,ar,hc);
[difht_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_q_vint,ny,yc,ar,hc);
[radht_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_q_vint,ny,yc,ar,hc);
[cndht_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_q_vint,ny,yc,ar,hc);
[cnvht_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_q_vint,ny,yc,ar,hc);

[htrt_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_d_vint,ny,yc,ar,hc);
[difht_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_d_vint,ny,yc,ar,hc);
[radht_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_d_vint,ny,yc,ar,hc);
[cndht_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_d_vint,ny,yc,ar,hc);
[cnvht_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_d_vint,ny,yc,ar,hc);

figure
plot(ylat,htrt_w_zav,'k')
hold on
xlabel('Latitude')
ylabel('Vertically integrated heating rate, Wm^{-2}')
title('Vertically integrated heating rates: 1xe_{s0}')
plot(ylat,cndht_w_zav+cnvht_w_zav)
plot(ylat,radht_w_zav,'g')
plot(ylat,difht_w_zav,'r')
ylim([-100 500])
legend('Total','Latent','Radiative','Diffusive')
print('-dpng','vheat_wet.png')

figure
plot(ylat,htrt_h_zav,'k')
hold on
xlabel('Latitude')
ylabel('Vertically integrated heating rate, Wm^{-2}')
title('Vertically integrated heating rates: 0.5xe_{s0}')
plot(ylat,cndht_h_zav+cnvht_h_zav)
plot(ylat,radht_h_zav,'g')
plot(ylat,difht_h_zav,'r')
ylim([-100 500])
legend('Total','Latent','Radiative','Diffusive')
print('-dpng','vheat_half.png')

figure
plot(ylat,htrt_q_zav,'k')
hold on
xlabel('Latitude')
ylabel('Vertically integrated heating rate, Wm^{-2}')
title('Vertically integrated heating rates: 0.25xe_{s0}')
plot(ylat,cndht_q_zav+cnvht_q_zav)
plot(ylat,radht_q_zav,'g')
plot(ylat,difht_q_zav,'r')
ylim([-100 500])
legend('Total','Latent','Radiative','Diffusive')
print('-dpng','vheat_quarter.png')

figure
plot(ylat,htrt_d_zav,'k')
hold on
xlabel('Latitude')
ylabel('Vertically integrated heating rate, Wm^{-2}')
title('Vertically integrated heating rates: 0xe_{s0}')
plot(ylat,cndht_d_zav+cnvht_d_zav)
plot(ylat,radht_d_zav,'g')
plot(ylat,difht_d_zav,'r')
ylim([-100 500])
legend('Total','Latent','Radiative','Diffusive')
print('-dpng','vheat_dry.png')
