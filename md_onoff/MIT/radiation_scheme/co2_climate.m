%look at 4xco2 climate vs control in more detail

%read in data for different co2 concs and see if the code worked plus how the climate changes...

rDir='/project/rg312/final_runs/run_100_rad_on_1co2/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));
drC=squeeze(rdmds([rDir,'DRC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
xi=-179:2:179;
yi=-89:2:89;

nit = 172800;

rDir='/project/rg312/final_runs/run_100_rad_on_1co2/';

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    ')); u_1co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    ')); v_1co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVEL    ')); w_1co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    ')); q_1co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   ')); theta_1co2 = dyn(:,:,:,J);

[dyn,iter,M]=rdmds([rDir,'AtPhDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhdTdt')); htrt_1co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv')); cnvht_1co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd')); cndht_1co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf')); difht_1co2 = dyn(:,:,:,J); 
J=find(strcmp(fldList,'AtPhdTrd')); radht_1co2 = dyn(:,:,:,J);

[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhEvap')); evap_1co2 = surf(:,:,J);
J=find(strcmp(fldList,'AtPhSens')); sens_1co2 = surf(:,:,J);
J=find(strcmp(fldList,'AtPhCnvP')); cnvp_1co2 = surf(:,:,J);
J=find(strcmp(fldList,'AtPhLscP')); lscp_1co2 = surf(:,:,J);
J=find(strcmp(fldList,'AtPhOLR ')); olr_1co2  = surf(:,:,J);
J=find(strcmp(fldList,'AtPhDSLR')); dslr_1co2 = surf(:,:,J);
J=find(strcmp(fldList,'AtPhUSLR')); uslr_1co2 = surf(:,:,J);
J=find(strcmp(fldList,'AtPhInSR')); insr_1co2 = surf(:,:,J);
J=find(strcmp(fldList,'AtPhNSSR')); nssr_1co2 = surf(:,:,J);

[uE_1co2,vN_1co2] = rotate_uv2uvEN(u_1co2,v_1co2,AngleCS,AngleSN,Grid);

    convthetatoT=(rC/100000.0).^(2./7.);
    for k=1:size(rC)
      t_1co2(:,:,k)=theta_1co2(:,:,k).*convthetatoT(k,1);
    end

uE_1co2_ll=cube2latlon(xc,yc,uE_1co2,xi,yi);
t_1co2_ll=cube2latlon(xc,yc,t_1co2,xi,yi);
theta_1co2_ll=cube2latlon(xc,yc,theta_1co2,xi,yi);
q_1co2_ll=cube2latlon(xc,yc,q_1co2,xi,yi);
w_1co2_ll=cube2latlon(xc,yc,w_1co2,xi,yi);
htrt_1co2_ll=cube2latlon(xc,yc,htrt_1co2,xi,yi);
cnvht_1co2_ll=cube2latlon(xc,yc,cnvht_1co2,xi,yi);
cndht_1co2_ll=cube2latlon(xc,yc,cndht_1co2,xi,yi);
radht_1co2_ll=cube2latlon(xc,yc,radht_1co2,xi,yi);
difht_1co2_ll=cube2latlon(xc,yc,difht_1co2,xi,yi);
evap_1co2_ll=cube2latlon(xc,yc,evap_1co2,xi,yi);
sens_1co2_ll=cube2latlon(xc,yc,sens_1co2,xi,yi);
cnvp_1co2_ll=cube2latlon(xc,yc,cnvp_1co2,xi,yi);
lscp_1co2_ll=cube2latlon(xc,yc,lscp_1co2,xi,yi);
olr_1co2_ll=cube2latlon(xc,yc,olr_1co2,xi,yi);
dslr_1co2_ll=cube2latlon(xc,yc,dslr_1co2,xi,yi);
uslr_1co2_ll=cube2latlon(xc,yc,uslr_1co2,xi,yi);
insr_1co2_ll=cube2latlon(xc,yc,insr_1co2,xi,yi);
nssr_1co2_ll=cube2latlon(xc,yc,nssr_1co2,xi,yi);

uE_1co2_zav(:,:) = mean(uE_1co2_ll,1);
t_1co2_zav(:,:) = mean(t_1co2_ll,1);
theta_1co2_zav(:,:) = mean(theta_1co2_ll,1);
q_1co2_zav(:,:) = mean(q_1co2_ll,1);
w_1co2_zav(:,:) = mean(w_1co2_ll,1);
htrt_1co2_zav(:,:) = mean(htrt_1co2_ll,1);
cnvht_1co2_zav(:,:) = mean(cnvht_1co2_ll,1);
cndht_1co2_zav(:,:) = mean(cndht_1co2_ll,1);
radht_1co2_zav(:,:) = mean(radht_1co2_ll,1);
difht_1co2_zav(:,:) = mean(difht_1co2_ll,1);
evap_1co2_zav = mean(evap_1co2_ll,1);
sens_1co2_zav = mean(sens_1co2_ll,1);
cnvp_1co2_zav = mean(cnvp_1co2_ll,1);
lscp_1co2_zav = mean(lscp_1co2_ll,1);
olr_1co2_zav = mean(olr_1co2_ll,1);
dslr_1co2_zav = mean(dslr_1co2_ll,1);
uslr_1co2_zav = mean(uslr_1co2_ll,1);
insr_1co2_zav = mean(insr_1co2_ll,1);
nssr_1co2_zav = mean(nssr_1co2_ll,1);



rDir='/project/rg312/final_runs/run_rad_on_4co2/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    ')); u_4co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    ')); v_4co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVEL    ')); w_4co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    ')); q_4co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   ')); theta_4co2 = dyn(:,:,:,J);

[dyn,iter,M]=rdmds([rDir,'AtPhDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhdTdt')); htrt_4co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv')); cnvht_4co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd')); cndht_4co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf')); difht_4co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd')); radht_4co2 = dyn(:,:,:,J);

[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhEvap')); evap_4co2 = surf(:,:,J);
J=find(strcmp(fldList,'AtPhSens')); sens_4co2 = surf(:,:,J);
J=find(strcmp(fldList,'AtPhCnvP')); cnvp_4co2 = surf(:,:,J);
J=find(strcmp(fldList,'AtPhLscP')); lscp_4co2 = surf(:,:,J);
J=find(strcmp(fldList,'AtPhOLR ')); olr_4co2  = surf(:,:,J);
J=find(strcmp(fldList,'AtPhDSLR')); dslr_4co2 = surf(:,:,J);
J=find(strcmp(fldList,'AtPhUSLR')); uslr_4co2 = surf(:,:,J);
J=find(strcmp(fldList,'AtPhInSR')); insr_4co2 = surf(:,:,J);
J=find(strcmp(fldList,'AtPhNSSR')); nssr_4co2 = surf(:,:,J);

[uE_4co2,vN_4co2] = rotate_uv2uvEN(u_4co2,v_4co2,AngleCS,AngleSN,Grid);

    convthetatoT=(rC/100000.0).^(2./7.);
    for k=1:size(rC)
      t_4co2(:,:,k)=theta_4co2(:,:,k).*convthetatoT(k,1);
    end

uE_4co2_ll=cube2latlon(xc,yc,uE_4co2,xi,yi);
t_4co2_ll=cube2latlon(xc,yc,t_4co2,xi,yi);
theta_4co2_ll=cube2latlon(xc,yc,theta_4co2,xi,yi);
q_4co2_ll=cube2latlon(xc,yc,q_4co2,xi,yi);
w_4co2_ll=cube2latlon(xc,yc,w_4co2,xi,yi);
htrt_4co2_ll=cube2latlon(xc,yc,htrt_4co2,xi,yi);
cnvht_4co2_ll=cube2latlon(xc,yc,cnvht_4co2,xi,yi);
cndht_4co2_ll=cube2latlon(xc,yc,cndht_4co2,xi,yi);
radht_4co2_ll=cube2latlon(xc,yc,radht_4co2,xi,yi);
difht_4co2_ll=cube2latlon(xc,yc,difht_4co2,xi,yi);
evap_4co2_ll=cube2latlon(xc,yc,evap_4co2,xi,yi);
sens_4co2_ll=cube2latlon(xc,yc,sens_4co2,xi,yi);
cnvp_4co2_ll=cube2latlon(xc,yc,cnvp_4co2,xi,yi);
lscp_4co2_ll=cube2latlon(xc,yc,lscp_4co2,xi,yi);
olr_4co2_ll=cube2latlon(xc,yc,olr_4co2,xi,yi);
dslr_4co2_ll=cube2latlon(xc,yc,dslr_4co2,xi,yi);
uslr_4co2_ll=cube2latlon(xc,yc,uslr_4co2,xi,yi);
insr_4co2_ll=cube2latlon(xc,yc,insr_4co2,xi,yi);
nssr_4co2_ll=cube2latlon(xc,yc,nssr_4co2,xi,yi);

uE_4co2_zav(:,:) = mean(uE_4co2_ll,1);
t_4co2_zav(:,:) = mean(t_4co2_ll,1);
theta_4co2_zav(:,:) = mean(theta_4co2_ll,1);
q_4co2_zav(:,:) = mean(q_4co2_ll,1);
w_4co2_zav(:,:) = mean(w_4co2_ll,1);
htrt_4co2_zav(:,:) = mean(htrt_4co2_ll,1);
cnvht_4co2_zav(:,:) = mean(cnvht_4co2_ll,1);
cndht_4co2_zav(:,:) = mean(cndht_4co2_ll,1);
radht_4co2_zav(:,:) = mean(radht_4co2_ll,1);
difht_4co2_zav(:,:) = mean(difht_4co2_ll,1);
evap_4co2_zav = mean(evap_4co2_ll,1);
sens_4co2_zav = mean(sens_4co2_ll,1);
cnvp_4co2_zav = mean(cnvp_4co2_ll,1);
lscp_4co2_zav = mean(lscp_4co2_ll,1);
olr_4co2_zav  = mean(olr_4co2_ll,1);
dslr_4co2_zav = mean(dslr_4co2_ll,1);
uslr_4co2_zav = mean(uslr_4co2_ll,1);
insr_4co2_zav = mean(insr_4co2_ll,1);
nssr_4co2_zav = mean(nssr_4co2_ll,1);




rDir='/project/rg312/final_runs/run_100_rad_on_10co2/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    ')); u_10co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    ')); v_10co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVEL    ')); w_10co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    ')); q_10co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   ')); theta_10co2 = dyn(:,:,:,J);

[dyn,iter,M]=rdmds([rDir,'AtPhDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhdTdt')); htrt_10co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv')); cnvht_10co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd')); cndht_10co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf')); difht_10co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd')); radht_10co2 = dyn(:,:,:,J);

[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhEvap')); evap_10co2 = surf(:,:,J);
J=find(strcmp(fldList,'AtPhSens')); sens_10co2 = surf(:,:,J);
J=find(strcmp(fldList,'AtPhCnvP')); cnvp_10co2 = surf(:,:,J);
J=find(strcmp(fldList,'AtPhLscP')); lscp_10co2 = surf(:,:,J);
J=find(strcmp(fldList,'AtPhOLR ')); olr_10co2  = surf(:,:,J);
J=find(strcmp(fldList,'AtPhDSLR')); dslr_10co2 = surf(:,:,J);
J=find(strcmp(fldList,'AtPhUSLR')); uslr_10co2 = surf(:,:,J);
J=find(strcmp(fldList,'AtPhInSR')); insr_10co2 = surf(:,:,J);
J=find(strcmp(fldList,'AtPhNSSR')); nssr_10co2 = surf(:,:,J);

[uE_10co2,vN_10co2] = rotate_uv2uvEN(u_10co2,v_10co2,AngleCS,AngleSN,Grid);

    convthetatoT=(rC/100000.0).^(2./7.);
    for k=1:size(rC)
      t_10co2(:,:,k)=theta_10co2(:,:,k).*convthetatoT(k,1);
    end

uE_10co2_ll=cube2latlon(xc,yc,uE_10co2,xi,yi);
t_10co2_ll=cube2latlon(xc,yc,t_10co2,xi,yi);
theta_10co2_ll=cube2latlon(xc,yc,theta_10co2,xi,yi);
q_10co2_ll=cube2latlon(xc,yc,q_10co2,xi,yi);
w_10co2_ll=cube2latlon(xc,yc,w_10co2,xi,yi);
htrt_10co2_ll=cube2latlon(xc,yc,htrt_10co2,xi,yi);
cnvht_10co2_ll=cube2latlon(xc,yc,cnvht_10co2,xi,yi);
cndht_10co2_ll=cube2latlon(xc,yc,cndht_10co2,xi,yi);
radht_10co2_ll=cube2latlon(xc,yc,radht_10co2,xi,yi);
difht_10co2_ll=cube2latlon(xc,yc,difht_10co2,xi,yi);
evap_10co2_ll=cube2latlon(xc,yc,evap_10co2,xi,yi);
sens_10co2_ll=cube2latlon(xc,yc,sens_10co2,xi,yi);
cnvp_10co2_ll=cube2latlon(xc,yc,cnvp_10co2,xi,yi);
lscp_10co2_ll=cube2latlon(xc,yc,lscp_10co2,xi,yi);
olr_10co2_ll=cube2latlon(xc,yc,olr_10co2,xi,yi);
dslr_10co2_ll=cube2latlon(xc,yc,dslr_10co2,xi,yi);
uslr_10co2_ll=cube2latlon(xc,yc,uslr_10co2,xi,yi);
insr_10co2_ll=cube2latlon(xc,yc,insr_10co2,xi,yi);
nssr_10co2_ll=cube2latlon(xc,yc,nssr_10co2,xi,yi);

uE_10co2_zav(:,:) = mean(uE_10co2_ll,1);
t_10co2_zav(:,:) = mean(t_10co2_ll,1);
theta_10co2_zav(:,:) = mean(theta_10co2_ll,1);
q_10co2_zav(:,:) = mean(q_10co2_ll,1);
w_10co2_zav(:,:) = mean(w_10co2_ll,1);
htrt_10co2_zav(:,:) = mean(htrt_10co2_ll,1);
cnvht_10co2_zav(:,:) = mean(cnvht_10co2_ll,1);
cndht_10co2_zav(:,:) = mean(cndht_10co2_ll,1);
radht_10co2_zav(:,:) = mean(radht_10co2_ll,1);
difht_10co2_zav(:,:) = mean(difht_10co2_ll,1);
evap_10co2_zav = mean(evap_10co2_ll,1);
sens_10co2_zav = mean(sens_10co2_ll,1);
cnvp_10co2_zav = mean(cnvp_10co2_ll,1);
lscp_10co2_zav = mean(lscp_10co2_ll,1);
olr_10co2_zav = mean(olr_10co2_ll,1);
dslr_10co2_zav = mean(dslr_10co2_ll,1);
uslr_10co2_zav = mean(uslr_10co2_ll,1);
insr_10co2_zav = mean(insr_10co2_ll,1);
nssr_10co2_zav = mean(nssr_10co2_ll,1);

L = 2.500e6;

toa_budg_1co2 = insr_1co2_zav - olr_1co2_zav - 0.06*nssr_1co2_zav/(1-0.06);
toa_budg_4co2 = insr_4co2_zav - olr_4co2_zav - 0.06*nssr_4co2_zav/(1-0.06);
toa_budg_10co2 = insr_10co2_zav - olr_10co2_zav - 0.06*nssr_10co2_zav/(1-0.06);

surf_budg_1co2 = nssr_1co2_zav + dslr_1co2_zav - uslr_1co2_zav - sens_1co2_zav - evap_1co2_zav.*L;
surf_budg_4co2 = nssr_4co2_zav + dslr_4co2_zav - uslr_4co2_zav - sens_4co2_zav - evap_4co2_zav.*L;
surf_budg_10co2 = nssr_10co2_zav + dslr_10co2_zav - uslr_10co2_zav - sens_10co2_zav - evap_10co2_zav.*L;

figure
plot(yi(2:45),cnvp_1co2_zav(2:45)+lscp_1co2_zav(2:45))
hold on
plot(yi(2:45),cnvp_4co2_zav(2:45)+lscp_4co2_zav(2:45),'c')
plot(yi(2:45),cnvp_10co2_zav(2:45)+lscp_10co2_zav(2:45),'g')
legend('1co2','4co2','10co2','Location','NorthWest')
xlabel('Latitude')
ylabel('Precip, kg/m^{2}/s')
print('-dpng','precip_co2_clims.png')

figure
plot(yi(2:45),surf_budg_1co2(2:45))
hold on
plot(yi(2:45),surf_budg_4co2(2:45),'c')
plot(yi(2:45),surf_budg_10co2(2:45),'g')
legend('1co2','4co2','10co2','Location','NorthWest')
xlabel('Latitude')
ylabel('Surface energy budget, W/m^{2}')
print('-dpng','surf_budg_co2_clims.png')

figure
plot(yi(2:45),nssr_1co2_zav(2:45),'k')
hold on
plot(yi(2:45),dslr_1co2_zav(2:45)-1.*uslr_1co2_zav(2:45),'r')
plot(yi(2:45),-1.*sens_1co2_zav(2:45),'g')
plot(yi(2:45),-1.*evap_1co2_zav(2:45).*L,'b')
legend('NSSR','NSLR','-SENS','-EVAP','Location','NorthWest')
xlabel('Latitude')
ylabel('Surface energy budget, W/m^{2}, +ve down')
print('-dpng','surf_budg_parts_1co2.png')

figure
plot(yi(2:45),toa_budg_1co2(2:45))
hold on
plot(yi(2:45),toa_budg_4co2(2:45),'c')
plot(yi(2:45),toa_budg_10co2(2:45),'g')
legend('1co2','4co2','10co2','Location','NorthWest')
xlabel('Latitude')
ylabel('TOA energy budget, W/m^{2}')
print('-dpng','toa_budg_co2_clims.png')


figure
plot(yi(2:45),toa_budg_1co2(2:45))
hold on
plot(yi(2:45),toa_budg_4co2(2:45),'c')
plot(yi(2:45),toa_budg_10co2(2:45),'g')
plot(yi(2:45),surf_budg_1co2(2:45),'--')
plot(yi(2:45),surf_budg_4co2(2:45),'c--')
plot(yi(2:45),surf_budg_10co2(2:45),'g--')
legend('1co2','4co2','10co2','Location','NorthWest')
xlabel('Latitude')
ylabel('TOA and surface energy budget, W/m^{2}')
print('-dpng','toasurf_budg_co2_clims.png')

figure
plot(yi(2:45),olr_1co2_zav(2:45))
hold on
plot(yi(2:45),olr_4co2_zav(2:45),'c')
plot(yi(2:45),olr_10co2_zav(2:45),'g')
legend('1co2','4co2','10co2','Location','NorthWest')
xlabel('Latitude')
ylabel('OLR, W/m^{2}')
print('-dpng','olr_co2_clims.png')

figure
plot(yi(2:45),sens_1co2_zav(2:45))
hold on
plot(yi(2:45),sens_4co2_zav(2:45),'c')
plot(yi(2:45),sens_10co2_zav(2:45),'g')
legend('1co2','4co2','10co2','Location','NorthWest')
xlabel('Latitude')
ylabel('Sensible heat flux, W/m^{2}')
print('-dpng','sens_co2_clims.png')

figure
plot(yi(2:45),evap_1co2_zav(2:45).*L)
hold on
plot(yi(2:45),evap_4co2_zav(2:45).*L,'c')
plot(yi(2:45),evap_10co2_zav(2:45).*L,'g')
legend('1co2','4co2','10co2','Location','NorthWest')
xlabel('Latitude')
ylabel('Evaporative heat flux, W/m^{2}')
print('-dpng','evap_co2_clims.png')


return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 29.7;                  %# A4 paper size
X = 21;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 1*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 0*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.225; %0.4;
xSize_sub = 0.375;

pos1x = 0.1 ; 	pos1y = 0.7; 
pos2x = 0.55;	pos2y = 0.7; 
pos3x = 0.1; 	pos3y = 0.4;
pos4x = 0.55; 	pos4y = 0.4;

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

v=-6:0.5:2;
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contourf(yi,rC./100,radht_1co2_zav'.*86400,v);
hold on
originalSize = get(gca, 'Position');
set(gca, 'Position', originalSize);
colormap(b2r(-6,2));
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
title('1co2','FontSize',12)
xlabel('Latitude','FontSize',12)
freezeColors

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contourf(yi,rC./100,radht_4co2_zav'.*86400,v);
hold on
originalSize = get(gca, 'Position');
set(gca, 'Position', originalSize);
colormap(b2r(-6,2));
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
title('4co2','FontSize',12)
xlabel('Latitude','FontSize',12)
freezeColors

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contourf(yi,rC./100,radht_10co2_zav'.*86400,v);
hold on
originalSize = get(gca, 'Position');
c = colorbar('eastoutside','FontSize',10);
x = get(c,'Position');
x(1) = 0.95; x(2) = 0.7; x(3) = 0.015; x(4) = 0.225;
set(c,'Position',x);
set(gca, 'Position', originalSize);
colormap(b2r(-6,2));
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
title('10co2','FontSize',12)
xlabel('Latitude','FontSize',12)
freezeColors

print('-dpdf','radht_clims.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

v=-2:0.2:2;
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contourf(yi,rC./100,(radht_4co2_zav'-radht_1co2_zav').*86400,v);
hold on
originalSize = get(gca, 'Position');
set(gca, 'Position', originalSize);
colormap(b2r(-2,2));
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
title('4co2 - 1co2','FontSize',12)
xlabel('Latitude','FontSize',12)
freezeColors

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contourf(yi,rC./100,(radht_10co2_zav'-radht_1co2_zav').*86400,v);
hold on
originalSize = get(gca, 'Position');
c = colorbar('eastoutside','FontSize',10);
x = get(c,'Position');
x(1) = 0.95; x(2) = 0.7; x(3) = 0.015; x(4) = 0.225;
set(c,'Position',x);
set(gca, 'Position', originalSize);
colormap(b2r(-2,2));
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
title('10co2 - 1co2','FontSize',12)
xlabel('Latitude','FontSize',12)
freezeColors

print('-dpdf','radht_clims_diffs.pdf')




hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

v=-4:0.5:8;
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contourf(yi,rC./100,htrt_1co2_zav'.*86400,v);
hold on
originalSize = get(gca, 'Position');
set(gca, 'Position', originalSize);
colormap(b2r(-4,8));
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
title('1co2','FontSize',12)
xlabel('Latitude','FontSize',12)
freezeColors

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contourf(yi,rC./100,htrt_4co2_zav'.*86400,v);
hold on
originalSize = get(gca, 'Position');
set(gca, 'Position', originalSize);
colormap(b2r(-4,8));
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
title('4co2','FontSize',12)
xlabel('Latitude','FontSize',12)
freezeColors

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contourf(yi,rC./100,htrt_10co2_zav'.*86400,v);
hold on
originalSize = get(gca, 'Position');
c = colorbar('eastoutside','FontSize',10);
x = get(c,'Position');
x(1) = 0.95; x(2) = 0.7; x(3) = 0.015; x(4) = 0.225;
set(c,'Position',x);
set(gca, 'Position', originalSize);
colormap(b2r(-4,8));
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
title('10co2','FontSize',12)
xlabel('Latitude','FontSize',12)
freezeColors

print('-dpdf','htrt_clims.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

v=-2:0.2:2;
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contourf(yi,rC./100,(htrt_4co2_zav'-htrt_1co2_zav').*86400,v);
hold on
originalSize = get(gca, 'Position');
set(gca, 'Position', originalSize);
colormap(b2r(-2,2));
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
title('4co2 - 1co2','FontSize',12)
xlabel('Latitude','FontSize',12)
freezeColors

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contourf(yi,rC./100,(htrt_10co2_zav'-htrt_1co2_zav').*86400,v);
hold on
originalSize = get(gca, 'Position');
c = colorbar('eastoutside','FontSize',10);
x = get(c,'Position');
x(1) = 0.95; x(2) = 0.7; x(3) = 0.015; x(4) = 0.225;
set(c,'Position',x);
set(gca, 'Position', originalSize);
colormap(b2r(-2,2));
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
title('10co2 - 1co2','FontSize',12)
xlabel('Latitude','FontSize',12)
freezeColors

print('-dpdf','htrt_clims_diffs.pdf')







return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 29.7;                  %# A4 paper size
X = 21;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 1*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 0*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.2625; 
xSize_sub = 0.6; 

pos1x = 0.1 ; 	pos1y = 0.7; 

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-20:5:45;
label = 200:20:300;

[C,h] = contourf(yi,rC./100,uE_1co2_zav',v); set(h,'LineStyle','none');
hold on
originalSize = get(gca, 'Position');
colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-20,45));
[C,h] = contour(yi,rC./100,uE_1co2_zav',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
[C,h] = contour(yi,rC./100,t_1co2_zav','k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)

print('-dpdf','ut_1co2.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-20:5:45;
label = 200:20:300;

[C,h] = contourf(yi,rC./100,uE_4co2_zav',v); set(h,'LineStyle','none');
hold on
originalSize = get(gca, 'Position');
colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-20,45));
[C,h] = contour(yi,rC./100,uE_4co2_zav',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
[C,h] = contour(yi,rC./100,t_4co2_zav','k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)

print('-dpdf','ut_4co2.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-20:5:45;
label = 200:20:300;

[C,h] = contourf(yi,rC./100,uE_10co2_zav',v); set(h,'LineStyle','none');
hold on
originalSize = get(gca, 'Position');
colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-20,45));
[C,h] = contour(yi,rC./100,uE_10co2_zav',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
[C,h] = contour(yi,rC./100,t_10co2_zav','k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)

print('-dpdf','ut_10co2.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-20:1:45;

[C,h] = contourf(yi,rC./100,uE_4co2_zav' - uE_1co2_zav',v); set(h,'LineStyle','none');
hold on
originalSize = get(gca, 'Position');
colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-10,10));
[C,h] = contour(yi,rC./100,uE_4co2_zav' - uE_1co2_zav',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)

print('-dpdf','u_4m1co2.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-20:1:45;

[C,h] = contourf(yi,rC./100,uE_10co2_zav' - uE_1co2_zav',v); set(h,'LineStyle','none');
hold on
originalSize = get(gca, 'Position');
colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-10,10));
[C,h] = contour(yi,rC./100,uE_10co2_zav' - uE_1co2_zav',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)

print('-dpdf','u_10m1co2.pdf')




hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-40:1:5;

[C,h] = contourf(yi,rC./100,t_4co2_zav' - t_1co2_zav',v); set(h,'LineStyle','none');
hold on
originalSize = get(gca, 'Position');
colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-40,5));
[C,h] = contour(yi,rC./100,t_4co2_zav' - t_1co2_zav',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)

print('-dpdf','t_4m1co2.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-40:1:5;

[C,h] = contourf(yi,rC./100,t_10co2_zav' - t_1co2_zav',v); set(h,'LineStyle','none');
hold on
originalSize = get(gca, 'Position');
colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-40,5));
[C,h] = contour(yi,rC./100,t_10co2_zav' - t_1co2_zav',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)

print('-dpdf','t_10m1co2.pdf')





