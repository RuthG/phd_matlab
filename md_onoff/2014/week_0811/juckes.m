%load in theta and q, calculate theta_eq and delT across storm track at 500hPa and compare with Juckes result roughly


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


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv/';

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


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_quarterwv/';

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


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_5year_c/';

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

[theta_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_w_mean,ny,yc,ar,hc);
[t_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(t_w_mean,ny,yc,ar,hc);
[q_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(q_w_mean,ny,yc,ar,hc);

[theta_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_h_mean,ny,yc,ar,hc);
[t_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(t_h_mean,ny,yc,ar,hc);
[q_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(q_h_mean,ny,yc,ar,hc);

[theta_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_q_mean,ny,yc,ar,hc);
[t_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(t_q_mean,ny,yc,ar,hc);
[q_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(q_q_mean,ny,yc,ar,hc);

[theta_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_d_mean,ny,yc,ar,hc);
[t_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(t_d_mean,ny,yc,ar,hc);
[q_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(q_d_mean,ny,yc,ar,hc);


L  = 2.500e6;
cp = 1004.64;
rd = 287;
g=9.81;

teq_w_zav = t_w_zav + L./cp .* q_w_zav;
teq_h_zav = t_h_zav + L./cp .* q_h_zav;
teq_q_zav = t_q_zav + L./cp .* q_q_zav;
teq_d_zav = t_d_zav + L./cp .* q_d_zav;

for j=1:size(rC)
thetaeq_w_zav(:,j)=teq_w_zav(:,j)./convthetatoT(j,1);
thetaeq_h_zav(:,j)=teq_h_zav(:,j)./convthetatoT(j,1);
thetaeq_q_zav(:,j)=teq_q_zav(:,j)./convthetatoT(j,1);
thetaeq_d_zav(:,j)=teq_d_zav(:,j)./convthetatoT(j,1);
end

%locate tropopause at 40 for each run

for k=1:25
rho_w(:,k) = rC(k)./(rd.*t_w_zav(:,k));
rho_h(:,k) = rC(k)./(rd.*t_h_zav(:,k));
rho_q(:,k) = rC(k)./(rd.*t_q_zav(:,k));
rho_d(:,k) = rC(k)./(rd.*t_d_zav(:,k));
end

dTdz_w = rho_w.*g.*gradient(t_w_zav,4000);
dTdz_h = rho_h.*g.*gradient(t_h_zav,4000);
dTdz_q = rho_q.*g.*gradient(t_q_zav,4000);
dTdz_d = rho_d.*g.*gradient(t_d_zav,4000);

%lapse rate = -dT/dz

trop_w = max(find(dTdz_w(65,:).*1000 <= -2));
trop_h = max(find(dTdz_h(65,:).*1000 <= -2));
trop_q = max(find(dTdz_q(65,:).*1000 <= -2));
trop_d = max(find(dTdz_d(65,:).*1000 <= -2));

%65 = 40degN
%55 = 20degN
%75 = 60degN
%rC(13) = 500mb

delthetaeqz(1) = thetaeq_w_zav(65,trop_w) - thetaeq_w_zav(65,1);
delthetaeqz(2) = thetaeq_h_zav(65,trop_h) - thetaeq_h_zav(65,1);
delthetaeqz(3) = thetaeq_q_zav(65,trop_q) - thetaeq_q_zav(65,1);
delthetaeqz(4) = thetaeq_d_zav(65,trop_d) - thetaeq_d_zav(65,1);

delty(1) = t_w_zav(55,13) - t_w_zav(75,13);
delty(2) = t_h_zav(55,13) - t_h_zav(75,13);
delty(3) = t_q_zav(55,13) - t_q_zav(75,13);
delty(4) = t_d_zav(55,13) - t_d_zav(75,13);



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
plot([17 25],[17 25],'k:')
xlabel('\Delta_{z} \Theta _{eq} (K)')
ylabel('\Delta_{y} T (K)')
print('-dpdf','juckes.pdf')
