%load in theta and q, calculate theta_eq and delT across storm track at 500hPa and compare with Juckes result roughly


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

convthetatoT=(rC/101325.0).^(2./7.);
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'SALT    '));
q_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i)=dyn(:,:,:,J);
for j=1:size(rC)
t_w(:,:,j,i)=theta_w(:,:,j).*convthetatoT(j,1);
end


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearh/';

convthetatoT=(rC/101325.0).^(2./7.);
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'SALT    '));
q_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_h(:,:,:,i)=dyn(:,:,:,J);
for j=1:size(rC)
t_h(:,:,j,i)=theta_h(:,:,j).*convthetatoT(j,1);
end


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearq/';

convthetatoT=(rC/101325.0).^(2./7.);
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'SALT    '));
q_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_q(:,:,:,i)=dyn(:,:,:,J);
for j=1:size(rC)
t_q(:,:,j,i)=theta_q(:,:,j).*convthetatoT(j,1);
end


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yeard/';

convthetatoT=(rC/101325.0).^(2./7.);
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'SALT    '));
q_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_d(:,:,:,i)=dyn(:,:,:,J);
for j=1:size(rC)
t_d(:,:,j,i)=theta_d(:,:,j).*convthetatoT(j,1);
end

end


theta_w_mean = mean(theta_w,4);
t_w_mean = mean(t_w,4);
q_w_mean = mean(q_w,4);

theta_h_mean = mean(theta_h,4);
t_h_mean = mean(t_h,4);
q_h_mean = mean(q_h,4);

theta_q_mean = mean(theta_q,4);
t_q_mean = mean(t_q,4);
q_q_mean = mean(q_q,4);

theta_d_mean = mean(theta_d,4);
t_d_mean = mean(t_d,4);
q_d_mean = mean(q_d,4);

xi=-179:2:180;yi=-89:2:90;
thetall_w=cube2latlon(xc,yc,theta_w_mean,xi,yi);
tll_w=cube2latlon(xc,yc,t_w_mean,xi,yi);
qll_w=cube2latlon(xc,yc,q_w_mean,xi,yi);
thetall_h=cube2latlon(xc,yc,theta_h_mean,xi,yi);
tll_h=cube2latlon(xc,yc,t_h_mean,xi,yi);
qll_h=cube2latlon(xc,yc,q_h_mean,xi,yi);
thetall_q=cube2latlon(xc,yc,theta_q_mean,xi,yi);
tll_q=cube2latlon(xc,yc,t_q_mean,xi,yi);
qll_q=cube2latlon(xc,yc,q_q_mean,xi,yi);
thetall_d=cube2latlon(xc,yc,theta_d_mean,xi,yi);
tll_d=cube2latlon(xc,yc,t_d_mean,xi,yi);
qll_d=cube2latlon(xc,yc,q_d_mean,xi,yi);

theta_w_zav(:,:) = mean(thetall_w,1);
t_w_zav(:,:) = mean(tll_w,1);
q_w_zav(:,:) = mean(qll_w,1);
theta_h_zav(:,:) = mean(thetall_h,1);
t_h_zav(:,:) = mean(tll_h,1);
q_h_zav(:,:) = mean(qll_h,1);
theta_q_zav(:,:) = mean(thetall_q,1);
t_q_zav(:,:) = mean(tll_q,1);
q_q_zav(:,:) = mean(qll_q,1);
theta_d_zav(:,:) = mean(thetall_d,1);
t_d_zav(:,:) = mean(tll_d,1);
q_d_zav(:,:) = mean(qll_d,1);

for i = 1:45

theta_w_hzav(i,:) = (theta_w_zav(45+i,:) + theta_w_zav(46-i,:))./2;
t_w_hzav(i,:) = (t_w_zav(45+i,:) + t_w_zav(46-i,:))./2;
q_w_hzav(i,:) = (q_w_zav(45+i,:) + q_w_zav(46-i,:))./2;
theta_h_hzav(i,:) = (theta_h_zav(45+i,:) + theta_h_zav(46-i,:))./2;
t_h_hzav(i,:) = (t_h_zav(45+i,:) + t_h_zav(46-i,:))./2;
q_h_hzav(i,:) = (q_h_zav(45+i,:) + q_h_zav(46-i,:))./2;
theta_q_hzav(i,:) = (theta_q_zav(45+i,:) + theta_q_zav(46-i,:))./2;
t_q_hzav(i,:) = (t_q_zav(45+i,:) + t_q_zav(46-i,:))./2;
q_q_hzav(i,:) = (q_q_zav(45+i,:) + q_q_zav(46-i,:))./2;
theta_d_hzav(i,:) = (theta_d_zav(45+i,:) + theta_d_zav(46-i,:))./2;
t_d_hzav(i,:) = (t_d_zav(45+i,:) + t_d_zav(46-i,:))./2;
q_d_hzav(i,:) = (q_d_zav(45+i,:) + q_d_zav(46-i,:))./2;

end



L  = 2.500e6;
cp = 1004.64;
rd = 287;
g=9.81;

teq_w_hzav = t_w_hzav + L./cp .* q_w_hzav;
teq_h_hzav = t_h_hzav + L./cp .* q_h_hzav;
teq_q_hzav = t_q_hzav + L./cp .* q_q_hzav;
teq_d_hzav = t_d_hzav + L./cp .* q_d_hzav;

for j=1:size(rC)
thetaeq_w_hzav(:,j)=teq_w_hzav(:,j)./convthetatoT(j,1);
thetaeq_h_hzav(:,j)=teq_h_hzav(:,j)./convthetatoT(j,1);
thetaeq_q_hzav(:,j)=teq_q_hzav(:,j)./convthetatoT(j,1);
thetaeq_d_hzav(:,j)=teq_d_hzav(:,j)./convthetatoT(j,1);
end

%locate tropopause at 40 for each run

for k=1:25
rho_w(:,k) = rC(k)./(rd.*t_w_hzav(:,k));
rho_h(:,k) = rC(k)./(rd.*t_h_hzav(:,k));
rho_q(:,k) = rC(k)./(rd.*t_q_hzav(:,k));
rho_d(:,k) = rC(k)./(rd.*t_d_hzav(:,k));
end

dTdz_w = rho_w.*g.*gradient(t_w_hzav,4000);
dTdz_h = rho_h.*g.*gradient(t_h_hzav,4000);
dTdz_q = rho_q.*g.*gradient(t_q_hzav,4000);
dTdz_d = rho_d.*g.*gradient(t_d_hzav,4000);

%lapse rate = -dT/dz

trop_w = max(find(dTdz_w(20,:).*1000 <= -2));
trop_h = max(find(dTdz_h(20,:).*1000 <= -2));
trop_q = max(find(dTdz_q(20,:).*1000 <= -2));
trop_d = max(find(dTdz_d(20,:).*1000 <= -2));

%20 = 40degN
%10 = 20degN
%30 = 60degN
%rC(13) = 500mb

delthetaeqz(1) = thetaeq_w_hzav(20,trop_w) - thetaeq_w_hzav(20,1);
delthetaeqz(2) = thetaeq_h_hzav(20,trop_h) - thetaeq_h_hzav(20,1);
delthetaeqz(3) = thetaeq_q_hzav(20,trop_q) - thetaeq_q_hzav(20,1);
delthetaeqz(4) = thetaeq_d_hzav(20,trop_d) - thetaeq_d_hzav(20,1);

delty(1) = t_w_hzav(10,13) - t_w_hzav(30,13);
delty(2) = t_h_hzav(10,13) - t_h_hzav(30,13);
delty(3) = t_q_hzav(10,13) - t_q_hzav(30,13);
delty(4) = t_d_hzav(10,13) - t_d_hzav(30,13);



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
plot(delthetaeqz,delty,'xk')
hold on
plot([0 60],[0 60],'k:')
xlabel('\Delta_{z} \Theta _{eq} (K)')
ylabel('\Delta_{y} T (K)')
print('-dpdf','juckes.pdf')
