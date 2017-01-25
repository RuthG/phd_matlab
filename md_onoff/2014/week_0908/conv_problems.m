%load in and plot diabatic heating for the dry runs with shallow convection

% choose directory, load grid
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5year/';
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
for nit = 259200:86400:432000;
i=i+1

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yeard/';

%heating rates
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q_d(:,:,:,i)=dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yeard_not0/';

%heating rates
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_n(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht_n(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_n(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_n(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_n(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q_n(:,:,:,i)=dyn(:,:,:,J);

end


cndht_d_mean = mean(cndht_d,4);
cnvht_d_mean = mean(cnvht_d,4);
q_d_mean = mean(q_d,4);

cndht_n_mean = mean(cndht_n,4);
cnvht_n_mean = mean(cnvht_n,4);
q_n_mean = mean(q_n,4);

%put on lat lon grid and zonally average
xi=-179:2:180;yi=-89:2:90;
cnvhtll_d=cube2latlon(xc,yc,cnvht_d_mean,xi,yi);
cndhtll_d=cube2latlon(xc,yc,cndht_d_mean,xi,yi);
qll_d=cube2latlon(xc,yc,q_d_mean,xi,yi);

cnvhtll_n=cube2latlon(xc,yc,cnvht_n_mean,xi,yi);
cndhtll_n=cube2latlon(xc,yc,cndht_n_mean,xi,yi);
qll_n=cube2latlon(xc,yc,q_n_mean,xi,yi);

cnvhtll_d_zav(:,:) = mean(cnvhtll_d,1);
cndhtll_d_zav(:,:) = mean(cndhtll_d,1);
q_d_zav(:,:) = mean(qll_d,1);

cnvhtll_n_zav(:,:) = mean(cnvhtll_n,1);
cndhtll_n_zav(:,:) = mean(cndhtll_n,1);
q_n_zav(:,:) = mean(qll_n,1);


contourf(yi,rC,q_n_zav')
set(gca,'YDir','reverse')
title('Specific Humidity, g/kg')
colorbar
xlabel('Latitude')
ylabel('Pressure, Pa')
print('-dpng','q_conv.png')

figure
contourf(yi,rC,cnvhtll_n_zav')
colorbar
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, Pa')
title('Latent heating (convective), K/s; small wv content')
print('-dpng','cnvht_swv.png')

figure
contourf(yi,rC,cnvhtll_d_zav')
colorbar
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, Pa')
title('Latent heating (convective), K/s; 0 wv content')
print('-dpng','cnvht_snwv_conv.png')
