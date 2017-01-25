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

for i=1:45

theta_w_hzav(i,:) = (theta_w_zav(45+i,:) + theta_w_zav(46-i,:))./2;
theta_h_hzav(i,:) = (theta_h_zav(45+i,:) + theta_h_zav(46-i,:))./2;
theta_q_hzav(i,:) = (theta_q_zav(45+i,:) + theta_q_zav(46-i,:))./2;
theta_d_hzav(i,:) = (theta_d_zav(45+i,:) + theta_d_zav(46-i,:))./2;

end

%also calculate tropopause to overplot

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:size(rC)
T_w_hzav(:,k)=theta_w_hzav(:,k).*convthetatoT(k,1);
T_h_hzav(:,k)=theta_h_hzav(:,k).*convthetatoT(k,1);
T_q_hzav(:,k)=theta_q_hzav(:,k).*convthetatoT(k,1);
T_d_hzav(:,k)=theta_d_hzav(:,k).*convthetatoT(k,1);
end

dlnTdp_w = gradient(log(T_w_hzav),-4000);
dlnTdp_h = gradient(log(T_h_hzav),-4000);
dlnTdp_q = gradient(log(T_q_hzav),-4000);
dlnTdp_d = gradient(log(T_d_hzav),-4000);

g=9.81;
cp=1005;
L=2.5e6;
Ra=287.04;
Rv=461.50;
epsilon = Ra/Rv;
T0 = 273.16;

prefac = zeros(45,25);
for k=1:25
prefac(:,k) = rC(k).*g./Ra;
end

dTdz_w = -prefac.*dlnTdp_w.*1000;
dTdz_h = -prefac.*dlnTdp_h.*1000;
dTdz_q = -prefac.*dlnTdp_q.*1000;
dTdz_d = -prefac.*dlnTdp_d.*1000;


for i=1:45
trop_w(i) = rC(min(find((dTdz_w(i,:) >= -2))));
trop_h(i) = rC(min(find((dTdz_h(i,:) >= -2))));
trop_q(i) = rC(min(find((dTdz_q(i,:) >= -2))));
trop_d(i) = rC(min(find((dTdz_d(i,:) >= -2))));
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 21.0;                  %# A4 paper size
X = 29.7;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 2*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 2*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.3; %0.4;
xSize_sub = 1./2-0.1;

pos1x = 0.1 ; 	pos1y = 0.45; %1/2+0.05;
pos2x = 0.55;	pos2y = 0.45; %1/2+0.05;
pos3x = 0.1; 	pos3y = 0.05;
pos4x = 0.55; 	pos4y = 0.05;



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=250:5:650;
[C,h] = contour(ylat(46:90),rC./100,theta_d_hzav',v,'k');
vec=250:10:650;
clabel(C,h,vec);
hold on
plot(ylat(46:90),trop_d./100,'k','LineWidth',2)
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['0xwv'])


axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=250:5:650;
[C,h] = contour(ylat(46:90),rC./100,theta_q_hzav',v,'k');
vec=250:10:650;
clabel(C,h,vec);
hold on
plot(ylat(46:90),trop_q./100,'k','LineWidth',2)
set(gca,'YDir','reverse')
title(['0.25xwv'])


axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=250:5:650;
[C,h] = contour(ylat(46:90),rC./100,theta_h_hzav',v,'k');
vec=250:10:650;
clabel(C,h,vec);
hold on
plot(ylat(46:90),trop_h./100,'k','LineWidth',2)
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title(['0.5xwv'])


axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=250:5:650;
[C,h] = contour(ylat(46:90),rC./100,theta_w_hzav',v,'k');
vec=250:10:650;
clabel(C,h,vec);
hold on
plot(ylat(46:90),trop_w./100,'k','LineWidth',2)
set(gca,'YDir','reverse')
xlabel('Latitude')
title(['1xwv'])
print('-dpdf','theta.pdf')
