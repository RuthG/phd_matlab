%load up heat budget terms, try to figure stuff out...


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

%surface/toa fluxes
[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhCnvP'));
cvprec(:,:,i) = surf(:,:,J);
J=find(strcmp(fldList,'AtPhLscP'));
lsprec(:,:,i) = surf(:,:,J);
J=find(strcmp(fldList,'AtPhSens'));
sens(:,:,i) = surf(:,:,J);
J=find(strcmp(fldList,'AtPhEvap'));
evap(:,:,i) = surf(:,:,J)*2.5e6;
J=find(strcmp(fldList,'AtPhNSSR'));
s_sw_net(:,:,i)=surf(:,:,J);
J=find(strcmp(fldList,'AtPhInSR'));
swin(:,:,i)=surf(:,:,J);
J=find(strcmp(fldList,'AtPhOLR '));
lwout(:,:,i)=surf(:,:,J);
J=find(strcmp(fldList,'AtPhDSLR'));
s_lw_dwn(:,:,i)=surf(:,:,J);
J=find(strcmp(fldList,'AtPhUSLR'));
s_lw_up(:,:,i)=surf(:,:,J);

%heating rates
convthetatoT=(rC/101325.0).^(2./7.);
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

for j=1:size(rC)

J=find(strcmp(fldList,'AtPhdTdt'));
htrt(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
J=find(strcmp(fldList,'AtPhdTdf'));
difht(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
J=find(strcmp(fldList,'AtPhdTrd'));
radht(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht(:,:,j,i)=dyn(:,:,j,J).*convthetatoT(j,1);

end


end

%take time averages
cvprec_mean = mean(cvprec,3);
lsprec_mean = mean(lsprec,3);
sens_mean = mean(sens,3);
evap_mean = mean(evap,3);
swin_mean = mean(swin,3);
lwout_mean = mean(lwout,3);
s_sw_net_mean = mean(s_sw_net,3);
s_lw_dwn_mean = mean(s_lw_dwn,3);
s_lw_up_mean = mean(s_lw_up,3);

htrt_mean = mean(htrt,4);
difht_mean = mean(difht,4);
radht_mean = mean(radht,4);
cndht_mean = mean(cndht,4);
cnvht_mean = mean(cnvht,4);


%first check budget makes sense for both; i.e. total heating is 0!
ar_tot = sum(sum(ar,2),1);
sens_arw = sens_mean.*ar;
evap_arw = evap_mean.*ar;
swin_arw = swin_mean.*ar;
lwout_arw = lwout_mean.*ar;
s_sw_net_arw = s_sw_net_mean.*ar;
s_lw_dwn_arw = s_lw_dwn_mean.*ar;
s_lw_up_arw = s_lw_up_mean.*ar;

g=9.81;
cp=1004.64;
intfac = 4000.*cp./g;
htrt_vint = sum(htrt_mean,3).*intfac;
difht_vint = sum(difht_mean,3).*intfac;
radht_vint = sum(radht_mean,3).*intfac;
cndht_vint = sum(cndht_mean,3).*intfac;
cnvht_vint = sum(cnvht_mean,3).*intfac;

htrt_arw = htrt_vint.*ar;
difht_arw = difht_vint.*ar;
radht_arw = radht_vint.*ar;
cndht_arw = cndht_vint.*ar;
cnvht_arw = cnvht_vint.*ar;

sens_av = sum(sum(sens_arw))./ar_tot;
evap_av = sum(sum(evap_arw))./ar_tot;
swin_av = sum(sum(swin_arw))./ar_tot;
lwout_av = sum(sum(lwout_arw))./ar_tot;
s_sw_net_av = sum(sum(s_sw_net_arw))./ar_tot;
A=0.06; s_sw_dwn_av = s_sw_net_av./(1-A);
s_lw_dwn_av = sum(sum(s_lw_dwn_arw))./ar_tot;
s_lw_up_av = sum(sum(s_lw_up_arw))./ar_tot;

htrt_av = sum(sum(htrt_arw))./ar_tot;
difht_av = sum(sum(difht_arw))./ar_tot;
radht_av = sum(sum(radht_arw))./ar_tot;
cndht_av = sum(sum(cndht_arw))./ar_tot;
cnvht_av = sum(sum(cnvht_arw))./ar_tot;

net_surf_flux_d = -sens_av - evap_av + s_sw_dwn_av + s_lw_dwn_av - s_lw_up_av;
net_toa_flux_d = swin_av - lwout_av;

%lw diff top and bottom
lw_diff_av = lwout_av - s_lw_up_av + s_lw_dwn_av;

%sw diff top and bottom
sw_diff_av = swin_av - s_sw_dwn_av;


%take zonal avs

[cvprec_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cvprec_mean,ny,yc,ar,hc);
[lsprec_zav,mskzon,ylat,areazon]=calcZonalAvgCube(lsprec_mean,ny,yc,ar,hc);
[sens_zav,mskzon,ylat,areazon]=calcZonalAvgCube(sens_mean,ny,yc,ar,hc);
[evap_zav,mskzon,ylat,areazon]=calcZonalAvgCube(evap_mean,ny,yc,ar,hc);
[swin_zav,mskzon,ylat,areazon]=calcZonalAvgCube(swin_mean,ny,yc,ar,hc);
[lwout_zav,mskzon,ylat,areazon]=calcZonalAvgCube(lwout_mean,ny,yc,ar,hc);
[s_sw_net_zav,mskzon,ylat,areazon]=calcZonalAvgCube(s_sw_net_mean,ny,yc,ar,hc);
[s_lw_dwn_zav,mskzon,ylat,areazon]=calcZonalAvgCube(s_lw_dwn_mean,ny,yc,ar,hc);
[s_lw_up_zav,mskzon,ylat,areazon]=calcZonalAvgCube(s_lw_up_mean,ny,yc,ar,hc);

[htrt_zav,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_vint,ny,yc,ar,hc);
[difht_zav,mskzon,ylat,areazon]=calcZonalAvgCube(difht_vint,ny,yc,ar,hc);
[radht_zav,mskzon,ylat,areazon]=calcZonalAvgCube(radht_vint,ny,yc,ar,hc);
[cndht_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_vint,ny,yc,ar,hc);
[cnvht_zav,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_vint,ny,yc,ar,hc);


s_sw_dwn_zav = s_sw_net_zav./(1-A);
s_sw_up_zav = s_sw_dwn_zav.*A;

s_lw_net_zav = s_lw_up_zav - s_lw_dwn_zav;
total_surface_heat_flux = - sens_zav - evap_zav - s_lw_net_zav + s_sw_net_zav;
total_toa_heat_flux = swin_zav - lwout_zav - s_sw_up_zav;

lw_diff_zav = lwout_zav - s_lw_up_zav + s_lw_dwn_zav;
sw_diff_zav = swin_zav - s_sw_dwn_zav;

%compare sensible? terms
plot(ylat,difht_zav)
xlabel('Latitude')
ylabel('Heat flux, Wm^{-2}')
hold on
plot(ylat,sens_zav,'r')
legend('Vertically integrated diffusive heating','Surface sensible heat flux')

%compare radiative terms
figure
plot(ylat,radht_zav)
xlabel('Latitude')
ylabel('Heat flux, Wm^{-2}')
hold on
plot(ylat,sw_diff_zav - lw_diff_zav,'r')
legend('Vertically integrated radiative heating','SW absorption + LW emission/absorption')

%compare evap/latent terms
figure
plot(ylat,cndht_zav+cnvht_zav)
xlabel('Latitude')
ylabel('Heat flux, Wm^{-2}')
hold on
plot(ylat,evap_zav,'r')
legend('Vertically integrated latent heating','Surface evaporative heat flux')

%plot heat budget via each method
figure
plot(ylat,-sw_diff_zav + lw_diff_zav-evap_zav-sens_zav,'k')
hold on
plot(ylat,-evap_zav,'b')
xlabel('Latitude')
ylabel('Heat flux, Wm^{-2}')
plot(ylat,-sens_zav,'r')
plot(ylat,-sw_diff_zav + lw_diff_zav,'g')
legend('Total','Evaporative','Sensible','SW absorption + LW emission/absorption')

figure
plot(ylat,htrt_zav,'k')
hold on
xlabel('Latitude')
ylabel('Vertically integrated heating rate, Wm^{-2}')
plot(ylat,cndht_zav+cnvht_zav)
plot(ylat,radht_zav,'g')
plot(ylat,difht_zav,'r')
legend('Total','Latent','Radiative','Diffusive')

return



