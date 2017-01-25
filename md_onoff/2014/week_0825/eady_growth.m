%plot up eady growth rate

%need vertical theta and u gradients.


%Read in iteration number, directory, MITgcm output and grid details

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

%read fields
i=0;
for nit = 259200:86400:432000;
i=i+1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Wet Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5year/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_w(:,:,:,i) = dyn(:,:,:,J);
[uE_w(:,:,:,i),vN_w(:,:,:,i)] = rotate_uv2uvEN(ucs_w(:,:,:,i),vcs_w(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i) = dyn(:,:,:,J);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Half WV Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearh/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_h(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_h(:,:,:,i) = dyn(:,:,:,J);
[uE_h(:,:,:,i),vN_h(:,:,:,i)] = rotate_uv2uvEN(ucs_h(:,:,:,i),vcs_h(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'THETA   '));
theta_h(:,:,:,i) = dyn(:,:,:,J);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Quarter WV Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearq/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_q(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_q(:,:,:,i) = dyn(:,:,:,J);
[uE_q(:,:,:,i),vN_q(:,:,:,i)] = rotate_uv2uvEN(ucs_q(:,:,:,i),vcs_q(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'THETA   '));
theta_q(:,:,:,i) = dyn(:,:,:,J);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Dry Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yeard/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_d(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_d(:,:,:,i) = dyn(:,:,:,J);
[uE_d(:,:,:,i),vN_d(:,:,:,i)] = rotate_uv2uvEN(ucs_d(:,:,:,i),vcs_d(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'THETA   '));
theta_d(:,:,:,i) = dyn(:,:,:,J);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Tropheat Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearth/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_th(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_th(:,:,:,i) = dyn(:,:,:,J);
[uE_th(:,:,:,i),vN_th(:,:,:,i)] = rotate_uv2uvEN(ucs_th(:,:,:,i),vcs_th(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'THETA   '));
theta_th(:,:,:,i) = dyn(:,:,:,J);


end

uE_w_mean = mean(uE_w,4);
vN_w_mean = mean(vN_w,4);
theta_w_mean = mean(theta_w,4);
uE_h_mean = mean(uE_h,4);
vN_h_mean = mean(vN_h,4);
theta_h_mean = mean(theta_h,4);
uE_q_mean = mean(uE_q,4);
vN_q_mean = mean(vN_q,4);
theta_q_mean = mean(theta_q,4);
uE_d_mean = mean(uE_d,4);
vN_d_mean = mean(vN_d,4);
theta_d_mean = mean(theta_d,4);
uE_th_mean = mean(uE_th,4);
vN_th_mean = mean(vN_th,4);
theta_th_mean = mean(theta_th,4);

xi=-179:2:180;yi=-89:2:90;
uEll_w=cube2latlon(xc,yc,uE_w_mean,xi,yi);
vNll_w=cube2latlon(xc,yc,vN_w_mean,xi,yi);
thetall_w=cube2latlon(xc,yc,theta_w_mean,xi,yi);
uEll_h=cube2latlon(xc,yc,uE_h_mean,xi,yi);
vNll_h=cube2latlon(xc,yc,vN_h_mean,xi,yi);
thetall_h=cube2latlon(xc,yc,theta_h_mean,xi,yi);
uEll_q=cube2latlon(xc,yc,uE_q_mean,xi,yi);
vNll_q=cube2latlon(xc,yc,vN_q_mean,xi,yi);
thetall_q=cube2latlon(xc,yc,theta_q_mean,xi,yi);
uEll_d=cube2latlon(xc,yc,uE_d_mean,xi,yi);
vNll_d=cube2latlon(xc,yc,vN_d_mean,xi,yi);
thetall_d=cube2latlon(xc,yc,theta_d_mean,xi,yi);
uEll_th=cube2latlon(xc,yc,uE_th_mean,xi,yi);
vNll_th=cube2latlon(xc,yc,vN_th_mean,xi,yi);
thetall_th=cube2latlon(xc,yc,theta_th_mean,xi,yi);

uE_w_zav(:,:) = mean(uEll_w,1);
vN_w_zav(:,:) = mean(vNll_w,1);
theta_w_zav(:,:) = mean(thetall_w,1);
uE_h_zav(:,:) = mean(uEll_h,1);
vN_h_zav(:,:) = mean(vNll_h,1);
theta_h_zav(:,:) = mean(thetall_h,1);
uE_q_zav(:,:) = mean(uEll_q,1);
vN_q_zav(:,:) = mean(vNll_q,1);
theta_q_zav(:,:) = mean(thetall_q,1);
uE_d_zav(:,:) = mean(uEll_d,1);
vN_d_zav(:,:) = mean(vNll_d,1);
theta_d_zav(:,:) = mean(thetall_d,1);
uE_th_zav(:,:) = mean(uEll_th,1);
vN_th_zav(:,:) = mean(vNll_th,1);
theta_th_zav(:,:) = mean(thetall_th,1);

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:size(rC)
T_w_zav(:,k)=theta_w_zav(:,k).*convthetatoT(k,1);
T_h_zav(:,k)=theta_h_zav(:,k).*convthetatoT(k,1);
T_q_zav(:,k)=theta_q_zav(:,k).*convthetatoT(k,1);
T_d_zav(:,k)=theta_d_zav(:,k).*convthetatoT(k,1);
T_th_zav(:,k)=theta_th_zav(:,k).*convthetatoT(k,1);
end

Ra = 287.04;
g= 9.81;
omega = 2.*pi./24./60./60;

for i=1:25
rho_w(:,i) = rC(i)./Ra./T_w_zav(:,i);
rho_h(:,i) = rC(i)./Ra./T_h_zav(:,i);
rho_q(:,i) = rC(i)./Ra./T_q_zav(:,i);
rho_d(:,i) = rC(i)./Ra./T_d_zav(:,i);
rho_th(:,i) = rC(i)./Ra./T_th_zav(:,i);
end

dthetadp_w = gradient(theta_w_zav,-4000);
dthetadp_h = gradient(theta_h_zav,-4000);
dthetadp_q = gradient(theta_q_zav,-4000);
dthetadp_d = gradient(theta_d_zav,-4000);
dthetadp_th = gradient(theta_th_zav,-4000);

[moo,dthetady_w] = gradient(theta_w_zav,pi./90);
[moo,dthetady_h] = gradient(theta_h_zav,pi./90);
[moo,dthetady_q] = gradient(theta_q_zav,pi./90);
[moo,dthetady_d] = gradient(theta_d_zav,pi./90);
[moo,dthetady_th] = gradient(theta_th_zav,pi./90);

dudp_w = gradient(uE_w_zav,-4000);
dudp_h = gradient(uE_h_zav,-4000);
dudp_q = gradient(uE_q_zav,-4000);
dudp_d = gradient(uE_d_zav,-4000);
dudp_th = gradient(uE_th_zav,-4000);

dudz_w = -g.*rho_w.*dudp_w;
dudz_h = -g.*rho_w.*dudp_h;
dudz_q = -g.*rho_w.*dudp_q;
dudz_d = -g.*rho_w.*dudp_d;
dudz_th = -g.*rho_w.*dudp_th;

Nsq_w = - g.^2 .* rho_w .* dthetadp_w ./theta_w_zav;
Nsq_h = - g.^2 .* rho_h .* dthetadp_h ./theta_h_zav;
Nsq_q = - g.^2 .* rho_q .* dthetadp_q ./theta_q_zav;
Nsq_d = - g.^2 .* rho_d .* dthetadp_d ./theta_d_zav;
Nsq_th = - g.^2 .* rho_th .* dthetadp_th ./theta_th_zav;


f = zeros(90,25);
for i=1:25
f(:,i) = 2.*omega.*sin(yi.*pi./180);
end

eady_w = 0.31.*f./sqrt(Nsq_w) .*dudz_w; 
eady_h = 0.31.*f./sqrt(Nsq_h) .*dudz_h; 
eady_q = 0.31.*f./sqrt(Nsq_q) .*dudz_q; 
eady_d = 0.31.*f./sqrt(Nsq_d) .*dudz_d; 
eady_th = 0.31.*f./sqrt(Nsq_th) .*dudz_th; 

a = 6371.0e3;

eadyt_w = -0.31.*g./sqrt(Nsq_w)./theta_w_zav .*dthetady_w./a;
eadyt_h = -0.31.*g./sqrt(Nsq_h)./theta_h_zav .*dthetady_h./a;
eadyt_q = -0.31.*g./sqrt(Nsq_q)./theta_q_zav .*dthetady_q./a;
eadyt_d = -0.31.*g./sqrt(Nsq_d)./theta_d_zav .*dthetady_d./a;
eadyt_th = -0.31.*g./sqrt(Nsq_th)./theta_th_zav .*dthetady_th./a;

%Brayshaw averages through trop: 925-250 and near surf: 925-775
%use 900-260 and 900-780 = 3-19 3-6

eady_w_full = mean(eady_w(:,3:19),2);
eady_h_full = mean(eady_h(:,3:19),2);
eady_q_full = mean(eady_q(:,3:19),2);
eady_d_full = mean(eady_d(:,3:19),2);
eady_th_full = mean(eady_th(:,3:19),2);

eady_w_low = mean(eady_w(:,3:6),2);
eady_h_low = mean(eady_h(:,3:6),2);
eady_q_low = mean(eady_q(:,3:6),2);
eady_d_low = mean(eady_d(:,3:6),2);
eady_th_low = mean(eady_th(:,3:6),2);

eadyt_w_full = mean(eadyt_w(:,3:19),2);
eadyt_h_full = mean(eadyt_h(:,3:19),2);
eadyt_q_full = mean(eadyt_q(:,3:19),2);
eadyt_d_full = mean(eadyt_d(:,3:19),2);
eadyt_th_full = mean(eadyt_th(:,3:19),2);

eadyt_w_low = mean(eadyt_w(:,3:6),2);
eadyt_h_low = mean(eadyt_h(:,3:6),2);
eadyt_q_low = mean(eadyt_q(:,3:6),2);
eadyt_d_low = mean(eadyt_d(:,3:6),2);
eadyt_th_low = mean(eadyt_th(:,3:6),2);


for i=1:45

eady_w_full_hzav(i) = (eady_w_full(45+i) - eady_w_full(46-i))./2;
eady_h_full_hzav(i) = (eady_h_full(45+i) - eady_h_full(46-i))./2;
eady_q_full_hzav(i) = (eady_q_full(45+i) - eady_q_full(46-i))./2;
eady_d_full_hzav(i) = (eady_d_full(45+i) - eady_d_full(46-i))./2;
eady_th_full_hzav(i) = (eady_th_full(45+i) - eady_th_full(46-i))./2;

eady_w_low_hzav(i) = (eady_w_low(45+i) - eady_w_low(46-i))./2;
eady_h_low_hzav(i) = (eady_h_low(45+i) - eady_h_low(46-i))./2;
eady_q_low_hzav(i) = (eady_q_low(45+i) - eady_q_low(46-i))./2;
eady_d_low_hzav(i) = (eady_d_low(45+i) - eady_d_low(46-i))./2;
eady_th_low_hzav(i) = (eady_th_low(45+i) - eady_th_low(46-i))./2;

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
plot(yi(46:90),real(eady_w_full_hzav),'b')
hold on
plot(yi(46:90),real(eady_h_full_hzav),'k')
plot(yi(46:90),real(eady_q_full_hzav),'g')
plot(yi(46:90),real(eady_d_full_hzav),'r')
plot(yi(46:90),real(eady_th_full_hzav),'m')
xlabel('Latitude')
ylabel('Eady Growth Rate, s^{-1}')
legend('1xwv','0.5xwv','0.25xwv','0xwv')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(yi(46:90),real(eady_w_low_hzav),'b')
hold on
plot(yi(46:90),real(eady_h_low_hzav),'k')
plot(yi(46:90),real(eady_q_low_hzav),'g')
plot(yi(46:90),real(eady_d_low_hzav),'r')
plot(yi(46:90),real(eady_th_low_hzav),'m')
xlabel('Latitude')
print('-dpdf','eady.pdf')

