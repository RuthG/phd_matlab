%load in lapse rates, average over descending branch, compare with sat lapse rate...


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
yi = 1:2:89;
g=9.81;
cp=1004.64;
intfac = 4000.*cp./g;

load('heat_budg_vars.mat')

%define the Hadley cell width as the latitude where psi becomes negative at 500hPa

psi_width(1) = yi(min(find(psi_w_hzav(:,13)<=0)));
psi_width(2) = yi(min(find(psi_h_hzav(:,13)<=0)));
psi_width(3) = yi(min(find(psi_q_hzav(:,13)<=0)));
psi_width(4) = yi(min(find(psi_d_hzav(:,13)<=0)));
psi_width(5) = yi(min(find(psi_th_hzav(:,13)<=0)));

y_wid_w = min(find(psi_w_hzav(:,13)<=0));
y_wid_h = min(find(psi_h_hzav(:,13)<=0));
y_wid_q = min(find(psi_q_hzav(:,13)<=0));
y_wid_d = min(find(psi_d_hzav(:,13)<=0));
y_wid_th = min(find(psi_th_hzav(:,13)<=0));

%to find start of descent, find maximum
psi_max(1) = yi(find(psi_w_hzav(:,13)==max(psi_w_hzav(:,13))));
psi_max(2) = yi(find(psi_h_hzav(:,13)==max(psi_h_hzav(:,13))));
psi_max(3) = yi(find(psi_q_hzav(:,13)==max(psi_q_hzav(:,13))));
psi_max(4) = yi(find(psi_d_hzav(:,13)==max(psi_d_hzav(:,13))));
psi_max(5) = yi(find(psi_th_hzav(:,13)==max(psi_th_hzav(:,13))));

y_max_w = find(psi_w_hzav(:,13)==max(psi_w_hzav(:,13)));
y_max_h = find(psi_h_hzav(:,13)==max(psi_h_hzav(:,13)));
y_max_q = find(psi_q_hzav(:,13)==max(psi_q_hzav(:,13)));
y_max_d = find(psi_d_hzav(:,13)==max(psi_d_hzav(:,13)));
y_max_th = find(psi_th_hzav(:,13)==max(psi_th_hzav(:,13)));


%read files
i=0;
for nit = 259200:86400:432000;
i=i+1

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5year/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q_w(:,:,:,i)=dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearh/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q_h(:,:,:,i)=dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearq/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q_q(:,:,:,i)=dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yeard/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q_d(:,:,:,i)=dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearth/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_th(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q_th(:,:,:,i)=dyn(:,:,:,J);

end

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:size(rC)
T_w(:,:,k,:)=theta_w(:,:,k,:).*convthetatoT(k,1);
T_h(:,:,k,:)=theta_h(:,:,k,:).*convthetatoT(k,1);
T_q(:,:,k,:)=theta_q(:,:,k,:).*convthetatoT(k,1);
T_d(:,:,k,:)=theta_d(:,:,k,:).*convthetatoT(k,1);
T_th(:,:,k,:)=theta_th(:,:,k,:).*convthetatoT(k,1);
end

T_w_mean = mean(T_w,4);
T_h_mean = mean(T_h,4);
T_q_mean = mean(T_q,4);
T_d_mean = mean(T_d,4);
T_th_mean = mean(T_th,4);
q_w_mean = mean(q_w,4);
q_h_mean = mean(q_h,4);
q_q_mean = mean(q_q,4);
q_d_mean = mean(q_d,4);
q_th_mean = mean(q_th,4);

xi=-179:2:180;yi=-89:2:90;
Tll_w=cube2latlon(xc,yc,T_w_mean,xi,yi);
Tll_h=cube2latlon(xc,yc,T_h_mean,xi,yi);
Tll_q=cube2latlon(xc,yc,T_q_mean,xi,yi);
Tll_d=cube2latlon(xc,yc,T_d_mean,xi,yi);
Tll_th=cube2latlon(xc,yc,T_th_mean,xi,yi);
qll_w=cube2latlon(xc,yc,q_w_mean,xi,yi);
qll_h=cube2latlon(xc,yc,q_h_mean,xi,yi);
qll_q=cube2latlon(xc,yc,q_q_mean,xi,yi);
qll_d=cube2latlon(xc,yc,q_d_mean,xi,yi);
qll_th=cube2latlon(xc,yc,q_th_mean,xi,yi);

Tll_w_zav(:,:) = mean(Tll_w,1);
Tll_h_zav(:,:) = mean(Tll_h,1);
Tll_q_zav(:,:) = mean(Tll_q,1);
Tll_d_zav(:,:) = mean(Tll_d,1);
Tll_th_zav(:,:) = mean(Tll_th,1);
qll_w_zav(:,:) = mean(qll_w,1);
qll_h_zav(:,:) = mean(qll_h,1);
qll_q_zav(:,:) = mean(qll_q,1);
qll_d_zav(:,:) = mean(qll_d,1);
qll_th_zav(:,:) = mean(qll_th,1);

dTdp_w = gradient(Tll_w_zav,-4000);
dTdp_h = gradient(Tll_h_zav,-4000);
dTdp_q = gradient(Tll_q_zav,-4000);
dTdp_d = gradient(Tll_d_zav,-4000);
dTdp_th = gradient(Tll_th_zav,-4000);

g=9.81;
cp=1005;
L=2.5e6;
Ra=287.04;
Rv=461.50;
epsilon = Ra/Rv;
T0 = 273.16;


%now try again with calculating saturated lapse rate...

%want mus, need sat vapour pressure first:

es_w = 610.78.*exp((L./Rv).*(1./T0 - 1./Tll_w_zav));
es_h = 305.39.*exp((L./Rv).*(1./T0 - 1./Tll_h_zav));
es_q = 152.695.*exp((L./Rv).*(1./T0 - 1./Tll_q_zav));
es_d = 0.*exp((L./Rv).*(1./T0 - 1./Tll_d_zav));
es_th = 305.39.*exp((L./Rv).*(1./T0 - 1./Tll_th_zav));

for i=1:25
mus_w(:,i) = epsilon.*es_w(:,i)./(rC(i)-es_w(:,i)); 
mus_h(:,i) = epsilon.*es_h(:,i)./(rC(i)-es_h(:,i));
mus_q(:,i) = epsilon.*es_q(:,i)./(rC(i)-es_q(:,i));
mus_d(:,i) = epsilon.*es_d(:,i)./(rC(i)-es_d(:,i)); 
mus_th(:,i) = epsilon.*es_th(:,i)./(rC(i)-es_th(:,i)); 
end

relhum_w = qll_w_zav./mus_w;
relhum_h = qll_h_zav./mus_h;
relhum_q = qll_q_zav./mus_q;
relhum_d = qll_d_zav./mus_d;
relhum_th = qll_th_zav./mus_th;

for i=1:45

relhum_w_hzav(i,:) = (relhum_w(45+i,:) + relhum_w(46-i,:))./2;
relhum_h_hzav(i,:) = (relhum_h(45+i,:) + relhum_h(46-i,:))./2;
relhum_q_hzav(i,:) = (relhum_q(45+i,:) + relhum_q(46-i,:))./2;
relhum_d_hzav(i,:) = (relhum_d(45+i,:) + relhum_d(46-i,:))./2;
relhum_th_hzav(i,:) = (relhum_th(45+i,:) + relhum_th(46-i,:))./2;

end

gamma_s_w = -g./cp .* (1 + L.*mus_w./(Ra.*Tll_w_zav))./(1+ L^2.*mus_w./(cp.*Rv.*Tll_w_zav.^2));
gamma_s_h = -g./cp .* (1 + L.*mus_h./(Ra.*Tll_h_zav))./(1+ L^2.*mus_h./(cp.*Rv.*Tll_h_zav.^2));
gamma_s_q = -g./cp .* (1 + L.*mus_q./(Ra.*Tll_q_zav))./(1+ L^2.*mus_q./(cp.*Rv.*Tll_q_zav.^2));
gamma_s_d = -g./cp .* (1 + L.*mus_d./(Ra.*Tll_d_zav))./(1+ L^2.*mus_d./(cp.*Rv.*Tll_d_zav.^2));
gamma_s_th = -g./cp .* (1 + L.*mus_th./(Ra.*Tll_th_zav))./(1+ L^2.*mus_th./(cp.*Rv.*Tll_th_zav.^2));


for k=1:25
rho_w(:,k) = rC(k)./Ra./Tll_w_zav(:,k);
rho_h(:,k) = rC(k)./Ra./Tll_h_zav(:,k);
rho_q(:,k) = rC(k)./Ra./Tll_q_zav(:,k);
rho_d(:,k) = rC(k)./Ra./Tll_d_zav(:,k);
rho_th(:,k) = rC(k)./Ra./Tll_th_zav(:,k);
end

dTdp_s_w = -gamma_s_w./rho_w./g;
dTdp_s_h = -gamma_s_h./rho_h./g;
dTdp_s_q = -gamma_s_q./rho_q./g;
dTdp_s_d = -gamma_s_d./rho_d./g;
dTdp_s_th = -gamma_s_th./rho_th./g;
dTdp_s_dw = -gamma_s_d./rho_w./g;

dTdz_w = -dTdp_w.*rho_w.*g;
dTdz_h = -dTdp_h.*rho_h.*g;
dTdz_q = -dTdp_q.*rho_q.*g;
dTdz_d = -dTdp_d.*rho_d.*g;
dTdz_th = -dTdp_th.*rho_th.*g;


dTdp_w_asc = mean(dTdp_w(46:45+y_max_w,:),1);
dTdp_h_asc = mean(dTdp_h(46:45+y_max_h,:),1);
dTdp_q_asc = mean(dTdp_q(46:45+y_max_q,:),1);
dTdp_d_asc = mean(dTdp_d(46:45+y_max_d,:),1);
dTdp_th_asc = mean(dTdp_th(46:45+y_max_th,:),1);

dTdp_w_desc = mean(dTdp_w(45+y_max_w:45+y_wid_w,:),1);
dTdp_h_desc = mean(dTdp_h(45+y_max_h:45+y_wid_h,:),1);
dTdp_q_desc = mean(dTdp_q(45+y_max_q:45+y_wid_q,:),1);
dTdp_d_desc = mean(dTdp_d(45+y_max_d:45+y_wid_d,:),1);
dTdp_th_desc = mean(dTdp_th(45+y_max_th:45+y_wid_th,:),1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
plot(dTdp_d_asc,rC,'r')
xlim([0, 0.003])
hold on
set(gca,'YDir','reverse')
plot(dTdp_d_desc,rC,'r--')
plot(dTdp_q_asc,rC,'g')
plot(dTdp_q_desc,rC,'g--')
plot(dTdp_h_asc,rC,'k')
plot(dTdp_h_desc,rC,'k--')
plot(dTdp_w_asc,rC,'b')
plot(dTdp_w_desc,rC,'b--')
%plot(dTdp_th_asc,rC,'m')
%plot(dTdp_th_desc,rC,'m--')
print('-dpng','lapse_desc_asc.png')

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
plot(dTdp_w(46:45+y_max_w,:)',rC,'c')
hold on
plot(dTdp_w_asc,rC,'k');
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Lapse rate dT/dp, ascending branch')
xlim([-0.001, 0.003])

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(dTdp_w(45+y_max_w:45+y_wid_w,:)',rC,'c')
hold on
plot(dTdp_w_desc,rC,'k');
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Lapse rate dT/dp, descending branch')
xlim([-0.001, 0.003])

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(dTdp_s_w(46:45+y_max_w,:)',rC,'c')
hold on
plot(dTdp_w_asc,rC,'k');
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Saturated lapse rate dT/dp, ascending branch')
xlim([-0.001, 0.003])

axes('position',[pos4x pos4y xSize_sub ySize_sub])
plot(dTdp_s_w(45+y_max_w:45+y_wid_w,:)',rC,'c')
hold on
plot(dTdp_w_desc,rC,'k');
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Saturated lapse rate dT/dp, descending branch')
xlim([-0.001, 0.003])

print('-dpdf','dtdp_w.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(dTdp_h(46:45+y_max_h,:)',rC,'c')
hold on
plot(dTdp_h_asc,rC,'k');
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Lapse rate dT/dp, ascending branch')
xlim([-0.001, 0.003])

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(dTdp_h(45+y_max_h:45+y_wid_h,:)',rC,'c')
hold on
plot(dTdp_h_desc,rC,'k');
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Lapse rate dT/dp, descending branch')
xlim([-0.001, 0.003])

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(dTdp_s_h(46:45+y_max_h,:)',rC,'c')
hold on
plot(dTdp_h_asc,rC,'k');
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Saturated lapse rate dT/dp, ascending branch')
xlim([-0.001, 0.003])

axes('position',[pos4x pos4y xSize_sub ySize_sub])
plot(dTdp_s_h(45+y_max_h:45+y_wid_h,:)',rC,'c')
hold on
plot(dTdp_h_desc,rC,'k');
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Saturated lapse rate dT/dp, descending branch')
xlim([-0.001, 0.003])

print('-dpdf','dtdp_h.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(dTdp_q(46:45+y_max_q,:)',rC,'c')
hold on
plot(dTdp_q_asc,rC,'k');
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Lapse rate dT/dp, ascending branch')
xlim([-0.001, 0.003])

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(dTdp_q(45+y_max_q:45+y_wid_q,:)',rC,'c')
hold on
plot(dTdp_q_desc,rC,'k');
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Lapse rate dT/dp, descending branch')
xlim([-0.001, 0.003])

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(dTdp_s_q(46:45+y_max_q,:)',rC,'c')
hold on
plot(dTdp_q_asc,rC,'k');
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Saturated lapse rate dT/dp, ascending branch')
xlim([-0.001, 0.003])

axes('position',[pos4x pos4y xSize_sub ySize_sub])
plot(dTdp_s_q(45+y_max_q:45+y_wid_q,:)',rC,'c')
hold on
plot(dTdp_q_desc,rC,'k');
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Saturated lapse rate dT/dp, descending branch')
xlim([-0.001, 0.003])

print('-dpdf','dtdp_q.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(dTdp_d(46:45+y_max_d,:)',rC,'c')
hold on
plot(dTdp_d_asc,rC,'k');
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Lapse rate dT/dp, ascending branch')
xlim([-0.001, 0.003])

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(dTdp_d(45+y_max_d:45+y_wid_d,:)',rC,'c')
hold on
plot(dTdp_d_desc,rC,'k');
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Lapse rate dT/dp, descending branch')
xlim([-0.001, 0.003])

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(dTdp_s_d(46:45+y_max_d,:)',rC,'c')
hold on
plot(dTdp_d_asc,rC,'k');
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Saturated lapse rate dT/dp, ascending branch')
xlim([-0.001, 0.003])

axes('position',[pos4x pos4y xSize_sub ySize_sub])
plot(dTdp_s_d(45+y_max_d:45+y_wid_d,:)',rC,'c')
hold on
plot(dTdp_d_desc,rC,'k');
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Saturated lapse rate dT/dp, descending branch')
xlim([-0.001, 0.003])

print('-dpdf','dtdp_d.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(dTdp_th(46:45+y_max_th,:)',rC,'c')
hold on
plot(dTdp_th_asc,rC,'k');
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Lapse rate dT/dp, ascending branch')
xlim([-0.001, 0.003])

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(dTdp_th(45+y_max_th:45+y_wid_th,:)',rC,'c')
hold on
plot(dTdp_th_desc,rC,'k');
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Lapse rate dT/dp, descending branch')
xlim([-0.001, 0.003])

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(dTdp_s_th(46:45+y_max_th,:)',rC,'c')
hold on
plot(dTdp_th_asc,rC,'k');
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Saturated lapse rate dT/dp, ascending branch')
xlim([-0.001, 0.003])

axes('position',[pos4x pos4y xSize_sub ySize_sub])
plot(dTdp_s_th(45+y_max_th:45+y_wid_th,:)',rC,'c')
hold on
plot(dTdp_th_desc,rC,'k');
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Saturated lapse rate dT/dp, descending branch')
xlim([-0.001, 0.003])

print('-dpdf','dtdp_th.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=0:0.1:1.5
[C,h] = contour(yi(46:90),rC,relhum_d_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
title('0xwv')
ylabel('Pressure, hPa')
xlabel('Latitude')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi(46:90),rC,relhum_q_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
title('0.25xwv')
ylabel('Pressure, hPa')
xlabel('Latitude')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi(46:90),rC,relhum_h_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
title('0.5xwv')
ylabel('Pressure, hPa')
xlabel('Latitude')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi(46:90),rC,relhum_w_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
title('1xwv')
ylabel('Pressure, hPa')
xlabel('Latitude')

print('-dpdf','relhum.pdf')
