%make a quick stab at calculating the radiative equilibrium temperature...


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

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5year/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhLWD '));
lwd_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhLWN '));
lwn_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i)=dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearh/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhLWD '));
lwd_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhLWN '));
lwn_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_h(:,:,:,i)=dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearq/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhLWD '));
lwd_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhLWN '));
lwn_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_q(:,:,:,i)=dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yeard/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhLWD '));
lwd_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhLWN '));
lwn_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_d(:,:,:,i)=dyn(:,:,:,J);

end

%take time means
lwn_w_mean = mean(lwn_w,4);
lwd_w_mean = mean(lwd_w,4);
theta_w_mean = mean(theta_w,4);
lwn_h_mean = mean(lwn_h,4);
lwd_h_mean = mean(lwd_h,4);
theta_h_mean = mean(theta_h,4);
lwn_q_mean = mean(lwn_q,4);
lwd_q_mean = mean(lwd_q,4);
theta_q_mean = mean(theta_q,4);
lwn_d_mean = mean(lwn_d,4);
lwd_d_mean = mean(lwd_d,4);
theta_d_mean = mean(theta_d,4);

xi=-179:2:180;yi=-89:2:90;
lwnll_w=cube2latlon(xc,yc,lwn_w_mean,xi,yi);
lwdll_w=cube2latlon(xc,yc,lwd_w_mean,xi,yi);
thetall_w=cube2latlon(xc,yc,theta_w_mean,xi,yi);
lwnll_h=cube2latlon(xc,yc,lwn_h_mean,xi,yi);
lwdll_h=cube2latlon(xc,yc,lwd_h_mean,xi,yi);
thetall_h=cube2latlon(xc,yc,theta_h_mean,xi,yi);
lwnll_q=cube2latlon(xc,yc,lwn_q_mean,xi,yi);
lwdll_q=cube2latlon(xc,yc,lwd_q_mean,xi,yi);
thetall_q=cube2latlon(xc,yc,theta_q_mean,xi,yi);
lwnll_d=cube2latlon(xc,yc,lwn_d_mean,xi,yi);
lwdll_d=cube2latlon(xc,yc,lwd_d_mean,xi,yi);
thetall_d=cube2latlon(xc,yc,theta_d_mean,xi,yi);

lwn_w_zav(:,:) = mean(lwnll_w,1);
lwd_w_zav(:,:) = mean(lwdll_w,1);
theta_w_zav(:,:) = mean(thetall_w,1);
lwn_h_zav(:,:) = mean(lwnll_h,1);
lwd_h_zav(:,:) = mean(lwdll_h,1);
theta_h_zav(:,:) = mean(thetall_h,1);
lwn_q_zav(:,:) = mean(lwnll_q,1);
lwd_q_zav(:,:) = mean(lwdll_q,1);
theta_q_zav(:,:) = mean(thetall_q,1);
lwn_d_zav(:,:) = mean(lwnll_d,1);
lwd_d_zav(:,:) = mean(lwdll_d,1);
theta_d_zav(:,:) = mean(thetall_d,1);

lwu_w_zav = lwn_w_zav + lwd_w_zav;
lwu_h_zav = lwn_h_zav + lwd_h_zav;
lwu_q_zav = lwn_q_zav + lwd_q_zav;
lwu_d_zav = lwn_d_zav + lwd_d_zav;

b_eq_w = (lwu_w_zav + lwd_w_zav)./2;
b_eq_h = (lwu_h_zav + lwd_h_zav)./2;
b_eq_q = (lwu_q_zav + lwd_q_zav)./2;
b_eq_d = (lwu_d_zav + lwd_d_zav)./2;

stefan = 5.67e-8;

t_eq_w = (b_eq_w./stefan).^(1/4);
t_eq_h = (b_eq_h./stefan).^(1/4);
t_eq_q = (b_eq_q./stefan).^(1/4);
t_eq_d = (b_eq_d./stefan).^(1/4);

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:size(rC)
T_w(:,k)=theta_w_zav(:,k).*convthetatoT(k,1);
T_h(:,k)=theta_h_zav(:,k).*convthetatoT(k,1);
T_q(:,k)=theta_q_zav(:,k).*convthetatoT(k,1);
T_d(:,k)=theta_d_zav(:,k).*convthetatoT(k,1);
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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
v=-20:5:25;
[C,h]=contourf(yi,rC./100.,T_d'-t_eq_d',v);
hold on
colorbar
colormap(b2r(-20,25));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title(['0xwv'])
hold off

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-20:5:25;
[C,h]=contourf(yi,rC./100.,T_q'-t_eq_q',v);
hold on
colorbar
colormap(b2r(-20,25));
title(['0.25xwv'])
set(gca,'YDir','reverse')
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-20:5:25;
[C,h]=contourf(yi,rC./100.,T_h'-t_eq_h',v);
hold on
colorbar
colormap(b2r(-20,25));
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
title(['0.5xwv'])
hold off

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-20:5:25;
[C,h]=contourf(yi,rC./100.,T_w'-t_eq_w',v);
hold on
colorbar
colormap(b2r(-20,25));
set(gca,'YDir','reverse')
xlabel('Latitude')
title(['1xwv'])
hold off

print('-dpdf','rad_eq_t.pdf')

