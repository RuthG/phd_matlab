%load in theta and q, calculate theta_eq and delT across storm track at 500hPa and compare with Juckes result roughly


% choose directory, load grid
rDir='/project/rg312/final_runs/run_100_final/';
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
xi=-179:2:180;yi=-89:2:90;




load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_000.mat','q_tav','theta_tav')
convthetatoT=(rC/100000.0).^(2./7.);
for j=1:size(rC)
t_tav(:,:,j)=theta_tav(:,:,j).*convthetatoT(j,1);
end
thetall = cube2latlon(xc,yc,theta_tav,xi,yi);
tll = cube2latlon(xc,yc,t_tav,xi,yi);
qll = cube2latlon(xc,yc,q_tav,xi,yi);
theta_000_zav(:,:) = mean(thetall,1);
t_000_zav(:,:) = mean(tll,1);
q_000_zav(:,:) = mean(qll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_010.mat','q_tav','theta_tav')
convthetatoT=(rC/100000.0).^(2./7.);
for j=1:size(rC)
t_tav(:,:,j)=theta_tav(:,:,j).*convthetatoT(j,1);
end
thetall = cube2latlon(xc,yc,theta_tav,xi,yi);
tll = cube2latlon(xc,yc,t_tav,xi,yi);
qll = cube2latlon(xc,yc,q_tav,xi,yi);
theta_010_zav(:,:) = mean(thetall,1);
t_010_zav(:,:) = mean(tll,1);
q_010_zav(:,:) = mean(qll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_025.mat','q_tav','theta_tav')
convthetatoT=(rC/100000.0).^(2./7.);
for j=1:size(rC)
t_tav(:,:,j)=theta_tav(:,:,j).*convthetatoT(j,1);
end
thetall = cube2latlon(xc,yc,theta_tav,xi,yi);
tll = cube2latlon(xc,yc,t_tav,xi,yi);
qll = cube2latlon(xc,yc,q_tav,xi,yi);
theta_025_zav(:,:) = mean(thetall,1);
t_025_zav(:,:) = mean(tll,1);
q_025_zav(:,:) = mean(qll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_050.mat','q_tav','theta_tav')
convthetatoT=(rC/100000.0).^(2./7.);
for j=1:size(rC)
t_tav(:,:,j)=theta_tav(:,:,j).*convthetatoT(j,1);
end
thetall = cube2latlon(xc,yc,theta_tav,xi,yi);
tll = cube2latlon(xc,yc,t_tav,xi,yi);
qll = cube2latlon(xc,yc,q_tav,xi,yi);
theta_050_zav(:,:) = mean(thetall,1);
t_050_zav(:,:) = mean(tll,1);
q_050_zav(:,:) = mean(qll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_075.mat','q_tav','theta_tav')
convthetatoT=(rC/100000.0).^(2./7.);
for j=1:size(rC)
t_tav(:,:,j)=theta_tav(:,:,j).*convthetatoT(j,1);
end
thetall = cube2latlon(xc,yc,theta_tav,xi,yi);
tll = cube2latlon(xc,yc,t_tav,xi,yi);
qll = cube2latlon(xc,yc,q_tav,xi,yi);
theta_075_zav(:,:) = mean(thetall,1);
t_075_zav(:,:) = mean(tll,1);
q_075_zav(:,:) = mean(qll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_100.mat','q_tav','theta_tav')
convthetatoT=(rC/100000.0).^(2./7.);
for j=1:size(rC)
t_tav(:,:,j)=theta_tav(:,:,j).*convthetatoT(j,1);
end
thetall = cube2latlon(xc,yc,theta_tav,xi,yi);
tll = cube2latlon(xc,yc,t_tav,xi,yi);
qll = cube2latlon(xc,yc,q_tav,xi,yi);
theta_100_zav(:,:) = mean(thetall,1);
t_100_zav(:,:) = mean(tll,1);
q_100_zav(:,:) = mean(qll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_125.mat','q_tav','theta_tav')
convthetatoT=(rC/100000.0).^(2./7.);
for j=1:size(rC)
t_tav(:,:,j)=theta_tav(:,:,j).*convthetatoT(j,1);
end
thetall = cube2latlon(xc,yc,theta_tav,xi,yi);
tll = cube2latlon(xc,yc,t_tav,xi,yi);
qll = cube2latlon(xc,yc,q_tav,xi,yi);
theta_125_zav(:,:) = mean(thetall,1);
t_125_zav(:,:) = mean(tll,1);
q_125_zav(:,:) = mean(qll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_150.mat','q_tav','theta_tav')
convthetatoT=(rC/100000.0).^(2./7.);
for j=1:size(rC)
t_tav(:,:,j)=theta_tav(:,:,j).*convthetatoT(j,1);
end
thetall = cube2latlon(xc,yc,theta_tav,xi,yi);
tll = cube2latlon(xc,yc,t_tav,xi,yi);
qll = cube2latlon(xc,yc,q_tav,xi,yi);
theta_150_zav(:,:) = mean(thetall,1);
t_150_zav(:,:) = mean(tll,1);
q_150_zav(:,:) = mean(qll,1);



for i = 1:45
theta_000_hzav(i,:) = (theta_000_zav(45+i,:) + theta_000_zav(46-i,:))./2;
t_000_hzav(i,:) = (t_000_zav(45+i,:) + t_000_zav(46-i,:))./2;
q_000_hzav(i,:) = (q_000_zav(45+i,:) + q_000_zav(46-i,:))./2;
theta_010_hzav(i,:) = (theta_010_zav(45+i,:) + theta_010_zav(46-i,:))./2;
t_010_hzav(i,:) = (t_010_zav(45+i,:) + t_010_zav(46-i,:))./2;
q_010_hzav(i,:) = (q_010_zav(45+i,:) + q_010_zav(46-i,:))./2;
theta_025_hzav(i,:) = (theta_025_zav(45+i,:) + theta_025_zav(46-i,:))./2;
t_025_hzav(i,:) = (t_025_zav(45+i,:) + t_025_zav(46-i,:))./2;
q_025_hzav(i,:) = (q_025_zav(45+i,:) + q_025_zav(46-i,:))./2;
theta_050_hzav(i,:) = (theta_050_zav(45+i,:) + theta_050_zav(46-i,:))./2;
t_050_hzav(i,:) = (t_050_zav(45+i,:) + t_050_zav(46-i,:))./2;
q_050_hzav(i,:) = (q_050_zav(45+i,:) + q_050_zav(46-i,:))./2;
theta_075_hzav(i,:) = (theta_075_zav(45+i,:) + theta_075_zav(46-i,:))./2;
t_075_hzav(i,:) = (t_075_zav(45+i,:) + t_075_zav(46-i,:))./2;
q_075_hzav(i,:) = (q_075_zav(45+i,:) + q_075_zav(46-i,:))./2;
theta_100_hzav(i,:) = (theta_100_zav(45+i,:) + theta_100_zav(46-i,:))./2;
t_100_hzav(i,:) = (t_100_zav(45+i,:) + t_100_zav(46-i,:))./2;
q_100_hzav(i,:) = (q_100_zav(45+i,:) + q_100_zav(46-i,:))./2;
theta_125_hzav(i,:) = (theta_125_zav(45+i,:) + theta_125_zav(46-i,:))./2;
t_125_hzav(i,:) = (t_125_zav(45+i,:) + t_125_zav(46-i,:))./2;
q_125_hzav(i,:) = (q_125_zav(45+i,:) + q_125_zav(46-i,:))./2;
theta_150_hzav(i,:) = (theta_150_zav(45+i,:) + theta_150_zav(46-i,:))./2;
t_150_hzav(i,:) = (t_150_zav(45+i,:) + t_150_zav(46-i,:))./2;
q_150_hzav(i,:) = (q_150_zav(45+i,:) + q_150_zav(46-i,:))./2;
end


g=9.8;
kappa = 2/7;
L=2.5e6;
rd=287.04;
cp=rd./kappa;

teq_000_hzav = t_000_hzav + L./cp .* q_000_hzav;
teq_010_hzav = t_010_hzav + L./cp .* q_010_hzav;
teq_025_hzav = t_025_hzav + L./cp .* q_025_hzav;
teq_050_hzav = t_050_hzav + L./cp .* q_050_hzav;
teq_075_hzav = t_075_hzav + L./cp .* q_075_hzav;
teq_100_hzav = t_100_hzav + L./cp .* q_100_hzav;
teq_125_hzav = t_125_hzav + L./cp .* q_125_hzav;
teq_150_hzav = t_150_hzav + L./cp .* q_150_hzav;

for j=1:size(rC)
thetaeq_000_hzav(:,j)=teq_000_hzav(:,j)./convthetatoT(j,1);
thetaeq_010_hzav(:,j)=teq_010_hzav(:,j)./convthetatoT(j,1);
thetaeq_025_hzav(:,j)=teq_025_hzav(:,j)./convthetatoT(j,1);
thetaeq_050_hzav(:,j)=teq_050_hzav(:,j)./convthetatoT(j,1);
thetaeq_075_hzav(:,j)=teq_075_hzav(:,j)./convthetatoT(j,1);
thetaeq_100_hzav(:,j)=teq_100_hzav(:,j)./convthetatoT(j,1);
thetaeq_125_hzav(:,j)=teq_125_hzav(:,j)./convthetatoT(j,1);
thetaeq_150_hzav(:,j)=teq_150_hzav(:,j)./convthetatoT(j,1);
end

%locate tropopause at 40 for each run
for k=1:25
rho_000(:,k) = rC(k)./(rd.*t_000_hzav(:,k));
rho_010(:,k) = rC(k)./(rd.*t_010_hzav(:,k));
rho_025(:,k) = rC(k)./(rd.*t_025_hzav(:,k));
rho_050(:,k) = rC(k)./(rd.*t_050_hzav(:,k));
rho_075(:,k) = rC(k)./(rd.*t_075_hzav(:,k));
rho_100(:,k) = rC(k)./(rd.*t_100_hzav(:,k));
rho_125(:,k) = rC(k)./(rd.*t_125_hzav(:,k));
rho_150(:,k) = rC(k)./(rd.*t_150_hzav(:,k));
end

dTdz_000 = rho_000.*g.*gradient(t_000_hzav,4000);
dTdz_010 = rho_010.*g.*gradient(t_010_hzav,4000);
dTdz_025 = rho_025.*g.*gradient(t_025_hzav,4000);
dTdz_050 = rho_050.*g.*gradient(t_050_hzav,4000);
dTdz_075 = rho_075.*g.*gradient(t_075_hzav,4000);
dTdz_100 = rho_100.*g.*gradient(t_100_hzav,4000);
dTdz_125 = rho_125.*g.*gradient(t_125_hzav,4000);
dTdz_150 = rho_150.*g.*gradient(t_150_hzav,4000);

%lapse rate = -dT/dz
trop_000 = max(find(dTdz_000(20,:).*1000 <= -2));
trop_010 = max(find(dTdz_010(20,:).*1000 <= -2));
trop_025 = max(find(dTdz_025(20,:).*1000 <= -2));
trop_050 = max(find(dTdz_050(20,:).*1000 <= -2));
trop_075 = max(find(dTdz_075(20,:).*1000 <= -2));
trop_100 = max(find(dTdz_100(20,:).*1000 <= -2));
trop_125 = max(find(dTdz_125(20,:).*1000 <= -2));
trop_150 = max(find(dTdz_150(20,:).*1000 <= -2));


%20 = 40degN
%10 = 20degN
%30 = 60degN
%rC(13) = 500mb

delthetaeqz(1) = thetaeq_000_hzav(20,trop_000) - thetaeq_000_hzav(20,1);
delty(1) = t_000_hzav(10,13) - t_000_hzav(30,13);
delthetaeqz(2) = thetaeq_010_hzav(20,trop_010) - thetaeq_010_hzav(20,1);
delty(2) = t_010_hzav(10,13) - t_010_hzav(30,13);
delthetaeqz(3) = thetaeq_025_hzav(20,trop_025) - thetaeq_025_hzav(20,1);
delty(3) = t_025_hzav(10,13) - t_025_hzav(30,13);
delthetaeqz(4) = thetaeq_050_hzav(20,trop_050) - thetaeq_050_hzav(20,1);
delty(4) = t_050_hzav(10,13) - t_050_hzav(30,13);
delthetaeqz(5) = thetaeq_075_hzav(20,trop_075) - thetaeq_075_hzav(20,1);
delty(5) = t_075_hzav(10,13) - t_075_hzav(30,13);
delthetaeqz(6) = thetaeq_100_hzav(20,trop_100) - thetaeq_100_hzav(20,1);
delty(6) = t_100_hzav(10,13) - t_100_hzav(30,13);
delthetaeqz(7) = thetaeq_125_hzav(20,trop_125) - thetaeq_125_hzav(20,1);
delty(7) = t_125_hzav(10,13) - t_125_hzav(30,13);
delthetaeqz(8) = thetaeq_150_hzav(20,trop_150) - thetaeq_150_hzav(20,1);
delty(8) = t_150_hzav(10,13) - t_150_hzav(30,13);


load('/net/spat-nas/project/rg312/mat_files/vt_lats_final.mat');
load('/net/spat-nas/project/rg312/mat_files/trop_levs_final.mat');
trop_000 = trop_lev_000(x000n);
trop_010 = trop_lev_010(x010n);
trop_025 = trop_lev_025(x025n);
trop_050 = trop_lev_050(x050n);
trop_075 = trop_lev_075(x075n);
trop_100 = trop_lev_100(x100n);
trop_125 = trop_lev_125(x125n);
trop_150 = trop_lev_150(x150n);

delthetaeqz(1) = thetaeq_000_hzav(x000n-45,trop_000) - thetaeq_000_hzav(x000n-45,1);
delty(1) = t_000_hzav(x000n-10-45,13) - t_000_hzav(x000n+10-45,13);
delthetaeqz(2) = thetaeq_010_hzav(x010n-45,trop_010) - thetaeq_010_hzav(x010n-45,1);
delty(2) = t_010_hzav(x010n-10-45,13) - t_010_hzav(x010n+10-45,13);
delthetaeqz(3) = thetaeq_025_hzav(x025n-45,trop_025) - thetaeq_025_hzav(x025n-45,1);
delty(3) = t_025_hzav(x025n-10-45,13) - t_025_hzav(x025n+10-45,13);
delthetaeqz(4) = thetaeq_050_hzav(x050n-45,trop_050) - thetaeq_050_hzav(x050n-45,1);
delty(4) = t_050_hzav(x050n-10-45,13) - t_050_hzav(x050n+10-45,13);
delthetaeqz(5) = thetaeq_075_hzav(x075n-45,trop_075) - thetaeq_075_hzav(x075n-45,1);
delty(5) = t_075_hzav(x075n-10-45,13) - t_075_hzav(x075n+10-45,13);
delthetaeqz(6) = thetaeq_100_hzav(x100n-45,trop_100) - thetaeq_100_hzav(x100n-45,1);
delty(6) = t_100_hzav(x100n-10-45,13) - t_100_hzav(x100n+10-45,13);
delthetaeqz(7) = thetaeq_125_hzav(x125n-45,trop_125) - thetaeq_125_hzav(x125n-45,1);
delty(7) = t_125_hzav(x125n-10-45,13) - t_125_hzav(x125n+10-45,13);
delthetaeqz(8) = thetaeq_150_hzav(x150n-45,trop_150) - thetaeq_150_hzav(x150n-45,1);
delty(8) = t_150_hzav(x150n-10-45,13) - t_150_hzav(x150n+10-45,13);



%delthetaeqz(1) = thetaeq_000_hzav(x000n-45,trop_000) - thetaeq_000_hzav(x000n-45,1);
%delty(1) = t_000_hzav(1,13) - t_000_hzav(44,13);
%delthetaeqz(2) = thetaeq_010_hzav(x010n-45,trop_010) - thetaeq_010_hzav(x010n-45,1);
%delty(2) = t_010_hzav(1,13) - t_010_hzav(44,13);
%delthetaeqz(3) = thetaeq_025_hzav(x025n-45,trop_025) - thetaeq_025_hzav(x025n-45,1);
%delty(3) = t_025_hzav(1,13) - t_025_hzav(44,13);
%delthetaeqz(4) = thetaeq_050_hzav(x050n-45,trop_050) - thetaeq_050_hzav(x050n-45,1);
%delty(4) = t_050_hzav(1,13) - t_050_hzav(44,13);
%delthetaeqz(5) = thetaeq_075_hzav(x075n-45,trop_075) - thetaeq_075_hzav(x075n-45,1);
%delty(5) = t_075_hzav(1,13) - t_075_hzav(44,13);
%delthetaeqz(6) = thetaeq_100_hzav(x100n-45,trop_100) - thetaeq_100_hzav(x100n-45,1);
%delty(6) = t_100_hzav(1,13) - t_100_hzav(44,13);
%delthetaeqz(7) = thetaeq_125_hzav(x125n-45,trop_125) - thetaeq_125_hzav(x125n-45,1);
%delty(7) = t_125_hzav(1,13) - t_125_hzav(44,13);
%delthetaeqz(8) = thetaeq_150_hzav(x150n-45,trop_150) - thetaeq_150_hzav(x150n-45,1);
%delty(8) = t_150_hzav(1,13) - t_000_hzav(44,13);


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
plot(delthetaeqz(1),delty(1),'+k')
hold on
plot(delthetaeqz(2),delty(2),'*k')
plot(delthetaeqz(3),delty(3),'vk')
plot(delthetaeqz(4),delty(4),'sk')
plot(delthetaeqz(5),delty(5),'dk')
plot(delthetaeqz(6),delty(6),'xk')
plot(delthetaeqz(7),delty(7),'^k')
plot(delthetaeqz(8),delty(8),'pk')
legend('dry','010','025','050','075','100','125','150','Location','NorthWest')
set(gca,'FontSize',10)
hold on
plot([0 70],[0 70],'k:')
xlabel('\Delta_{z} \Theta _{eq}, K','FontSize',12)
ylabel('\Delta_{y} T, K','FontSize',12)
print('-dpdf','juckes.pdf')
