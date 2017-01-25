%plot up eady growth rate

%need vertical theta and u gradients.


%Read in iteration number, directory, MITgcm output and grid details

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

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_000.mat','uE_tav','vN_tav','theta_tav')
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);
uE_zav_000(:,:) = mean(uEll,1);
vN_zav_000(:,:) = mean(vNll,1);
theta_zav_000(:,:) = mean(thetall,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_010.mat','uE_tav','vN_tav','theta_tav')
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);
uE_zav_010(:,:) = mean(uEll,1);
vN_zav_010(:,:) = mean(vNll,1);
theta_zav_010(:,:) = mean(thetall,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_025.mat','uE_tav','vN_tav','theta_tav')
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);
uE_zav_025(:,:) = mean(uEll,1);
vN_zav_025(:,:) = mean(vNll,1);
theta_zav_025(:,:) = mean(thetall,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_050.mat','uE_tav','vN_tav','theta_tav')
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);
uE_zav_050(:,:) = mean(uEll,1);
vN_zav_050(:,:) = mean(vNll,1);
theta_zav_050(:,:) = mean(thetall,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_075.mat','uE_tav','vN_tav','theta_tav')
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);
uE_zav_075(:,:) = mean(uEll,1);
vN_zav_075(:,:) = mean(vNll,1);
theta_zav_075(:,:) = mean(thetall,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_100.mat','uE_tav','vN_tav','theta_tav')
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);
uE_zav_100(:,:) = mean(uEll,1);
vN_zav_100(:,:) = mean(vNll,1);
theta_zav_100(:,:) = mean(thetall,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_125.mat','uE_tav','vN_tav','theta_tav')
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);
uE_zav_125(:,:) = mean(uEll,1);
vN_zav_125(:,:) = mean(vNll,1);
theta_zav_125(:,:) = mean(thetall,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_150.mat','uE_tav','vN_tav','theta_tav')
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);
uE_zav_150(:,:) = mean(uEll,1);
vN_zav_150(:,:) = mean(vNll,1);
theta_zav_150(:,:) = mean(thetall,1);




convthetatoT=(rC/100000.0).^(2./7.);
for k=1:size(rC)
T_zav_000(:,k)=theta_zav_000(:,k).*convthetatoT(k,1);
T_zav_010(:,k)=theta_zav_010(:,k).*convthetatoT(k,1);
T_zav_025(:,k)=theta_zav_025(:,k).*convthetatoT(k,1);
T_zav_050(:,k)=theta_zav_050(:,k).*convthetatoT(k,1);
T_zav_075(:,k)=theta_zav_075(:,k).*convthetatoT(k,1);
T_zav_100(:,k)=theta_zav_100(:,k).*convthetatoT(k,1);
T_zav_125(:,k)=theta_zav_125(:,k).*convthetatoT(k,1);
T_zav_150(:,k)=theta_zav_150(:,k).*convthetatoT(k,1);
end

Ra = 287.04;
g= 9.8;
omega = 2.*pi./24./60./60;

for i=1:25
rho_000(:,i) = rC(i)./Ra./T_zav_000(:,i);
rho_010(:,i) = rC(i)./Ra./T_zav_010(:,i);
rho_025(:,i) = rC(i)./Ra./T_zav_025(:,i);
rho_050(:,i) = rC(i)./Ra./T_zav_050(:,i);
rho_075(:,i) = rC(i)./Ra./T_zav_075(:,i);
rho_100(:,i) = rC(i)./Ra./T_zav_100(:,i);
rho_125(:,i) = rC(i)./Ra./T_zav_125(:,i);
rho_150(:,i) = rC(i)./Ra./T_zav_150(:,i);
end

f = zeros(90,25);
for i=1:25
f(:,i) = 2.*omega.*sin(yi.*pi./180);
end
a = 6371.0e3;

dthetadp_000 = gradient(theta_zav_000,-4000);
[moo,dthetady_000] = gradient(theta_zav_000,pi./90);
dudp_000 = gradient(uE_zav_000,-4000);
dudz_000 = -g.*rho_000.*dudp_000;
Nsq_000 = - g.^2 .* rho_000 .* dthetadp_000 ./theta_zav_000;
eady_000 = 0.31.*f./sqrt(Nsq_000) .*dudz_000; 
eadyt_000 = -0.31.*g./sqrt(Nsq_000)./theta_zav_000 .*dthetady_000./a;

dthetadp_010 = gradient(theta_zav_010,-4000);
[moo,dthetady_010] = gradient(theta_zav_010,pi./90);
dudp_010 = gradient(uE_zav_010,-4000);
dudz_010 = -g.*rho_010.*dudp_010;
Nsq_010 = - g.^2 .* rho_010 .* dthetadp_010 ./theta_zav_010;
eady_010 = 0.31.*f./sqrt(Nsq_010) .*dudz_010; 
eadyt_010 = -0.31.*g./sqrt(Nsq_010)./theta_zav_010 .*dthetady_010./a;

dthetadp_025 = gradient(theta_zav_025,-4000);
[moo,dthetady_025] = gradient(theta_zav_025,pi./90);
dudp_025 = gradient(uE_zav_025,-4000);
dudz_025 = -g.*rho_025.*dudp_025;
Nsq_025 = - g.^2 .* rho_025 .* dthetadp_025 ./theta_zav_025;
eady_025 = 0.31.*f./sqrt(Nsq_025) .*dudz_025; 
eadyt_025 = -0.31.*g./sqrt(Nsq_025)./theta_zav_025 .*dthetady_025./a;

dthetadp_050 = gradient(theta_zav_050,-4000);
[moo,dthetady_050] = gradient(theta_zav_050,pi./90);
dudp_050 = gradient(uE_zav_050,-4000);
dudz_050 = -g.*rho_050.*dudp_050;
Nsq_050 = - g.^2 .* rho_050 .* dthetadp_050 ./theta_zav_050;
eady_050 = 0.31.*f./sqrt(Nsq_050) .*dudz_050; 
eadyt_050 = -0.31.*g./sqrt(Nsq_050)./theta_zav_050 .*dthetady_050./a;

dthetadp_075 = gradient(theta_zav_075,-4000);
[moo,dthetady_075] = gradient(theta_zav_075,pi./90);
dudp_075 = gradient(uE_zav_075,-4000);
dudz_075 = -g.*rho_075.*dudp_075;
Nsq_075 = - g.^2 .* rho_075 .* dthetadp_075 ./theta_zav_075;
eady_075 = 0.31.*f./sqrt(Nsq_075) .*dudz_075; 
eadyt_075 = -0.31.*g./sqrt(Nsq_075)./theta_zav_075 .*dthetady_075./a;

dthetadp_100 = gradient(theta_zav_100,-4000);
[moo,dthetady_100] = gradient(theta_zav_100,pi./90);
dudp_100 = gradient(uE_zav_100,-4000);
dudz_100 = -g.*rho_100.*dudp_100;
Nsq_100 = - g.^2 .* rho_100 .* dthetadp_100 ./theta_zav_100;
eady_100 = 0.31.*f./sqrt(Nsq_100) .*dudz_100; 
eadyt_100 = -0.31.*g./sqrt(Nsq_100)./theta_zav_100 .*dthetady_100./a;

dthetadp_125 = gradient(theta_zav_125,-4000);
[moo,dthetady_125] = gradient(theta_zav_125,pi./90);
dudp_125 = gradient(uE_zav_125,-4000);
dudz_125 = -g.*rho_125.*dudp_125;
Nsq_125 = - g.^2 .* rho_125 .* dthetadp_125 ./theta_zav_125;
eady_125 = 0.31.*f./sqrt(Nsq_125) .*dudz_125; 
eadyt_125 = -0.31.*g./sqrt(Nsq_125)./theta_zav_125 .*dthetady_125./a;

dthetadp_150 = gradient(theta_zav_150,-4000);
[moo,dthetady_150] = gradient(theta_zav_150,pi./90);
dudp_150 = gradient(uE_zav_150,-4000);
dudz_150 = -g.*rho_150.*dudp_150;
Nsq_150 = - g.^2 .* rho_150 .* dthetadp_150 ./theta_zav_150;
eady_150 = 0.31.*f./sqrt(Nsq_150) .*dudz_150; 
eadyt_150 = -0.31.*g./sqrt(Nsq_150)./theta_zav_150 .*dthetady_150./a;


return

%Brayshaw averages through trop: 925-250 and near surf: 925-775
%use 900-260 and 900-780 = 3-19 3-6

eady_000_full = mean(eady_000(:,3:19),2);
eady_000_low = mean(eady_000(:,3:6),2);
eadyt_000_full = mean(eadyt_000(:,3:19),2);
eadyt_000_low = mean(eadyt_000(:,3:6),2);

eady_010_full = mean(eady_010(:,3:19),2);
eady_010_low = mean(eady_010(:,3:6),2);
eadyt_010_full = mean(eadyt_010(:,3:19),2);
eadyt_010_low = mean(eadyt_010(:,3:6),2);

eady_025_full = mean(eady_025(:,3:19),2);
eady_025_low = mean(eady_025(:,3:6),2);
eadyt_025_full = mean(eadyt_025(:,3:19),2);
eadyt_025_low = mean(eadyt_025(:,3:6),2);

eady_050_full = mean(eady_050(:,3:19),2);
eady_050_low = mean(eady_050(:,3:6),2);
eadyt_050_full = mean(eadyt_050(:,3:19),2);
eadyt_050_low = mean(eadyt_050(:,3:6),2);

eady_075_full = mean(eady_075(:,3:19),2);
eady_075_low = mean(eady_075(:,3:6),2);
eadyt_075_full = mean(eadyt_075(:,3:19),2);
eadyt_075_low = mean(eadyt_075(:,3:6),2);

eady_100_full = mean(eady_100(:,3:19),2);
eady_100_low = mean(eady_100(:,3:6),2);
eadyt_100_full = mean(eadyt_100(:,3:19),2);
eadyt_100_low = mean(eadyt_100(:,3:6),2);

eady_125_full = mean(eady_125(:,3:19),2);
eady_125_low = mean(eady_125(:,3:6),2);
eadyt_125_full = mean(eadyt_125(:,3:19),2);
eadyt_125_low = mean(eadyt_125(:,3:6),2);

eady_150_full = mean(eady_150(:,3:19),2);
eady_150_low = mean(eady_150(:,3:6),2);
eadyt_150_full = mean(eadyt_150(:,3:19),2);
eadyt_150_low = mean(eadyt_150(:,3:6),2);



for i=1:45
eady_000_full_hzav(i) = (eady_000_full(45+i) - eady_000_full(46-i))./2;
eady_000_low_hzav(i) = (eady_000_low(45+i) - eady_000_low(46-i))./2;
eady_010_full_hzav(i) = (eady_010_full(45+i) - eady_010_full(46-i))./2;
eady_010_low_hzav(i) = (eady_010_low(45+i) - eady_010_low(46-i))./2;
eady_025_full_hzav(i) = (eady_025_full(45+i) - eady_025_full(46-i))./2;
eady_025_low_hzav(i) = (eady_025_low(45+i) - eady_025_low(46-i))./2;
eady_050_full_hzav(i) = (eady_050_full(45+i) - eady_050_full(46-i))./2;
eady_050_low_hzav(i) = (eady_050_low(45+i) - eady_050_low(46-i))./2;
eady_075_full_hzav(i) = (eady_075_full(45+i) - eady_075_full(46-i))./2;
eady_075_low_hzav(i) = (eady_075_low(45+i) - eady_075_low(46-i))./2;
eady_100_full_hzav(i) = (eady_100_full(45+i) - eady_100_full(46-i))./2;
eady_100_low_hzav(i) = (eady_100_low(45+i) - eady_100_low(46-i))./2;
eady_125_full_hzav(i) = (eady_125_full(45+i) - eady_125_full(46-i))./2;
eady_125_low_hzav(i) = (eady_125_low(45+i) - eady_125_low(46-i))./2;
eady_150_full_hzav(i) = (eady_150_full(45+i) - eady_150_full(46-i))./2;
eady_150_low_hzav(i) = (eady_150_low(45+i) - eady_150_low(46-i))./2;
end






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

pos1x = 0.1 ; 	pos1y = 0.6; 


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
set(gca,'FontSize',10)
plot(yi(46:90),real(eady_000_full_hzav),'r')
hold on
plot(yi(46:90),real(eady_010_full_hzav),'c')
plot(yi(46:90),real(eady_025_full_hzav),'g')
plot(yi(46:90),real(eady_050_full_hzav),'b')
plot(yi(46:90),real(eady_075_full_hzav),'m')
plot(yi(46:90),real(eady_100_full_hzav),'k')
plot(yi(46:90),real(eady_125_full_hzav),'k--')
plot(yi(46:90),real(eady_150_full_hzav),'k-.')
xlabel('Latitude','FontSize',12)
ylabel('Eady Growth Rate, s^{-1}','FontSize',12)
legend('dry','010','025','050','075','wet','125','150')
print('-dpdf','eady.pdf')



return
axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(yi(46:90),real(eady_w_low_hzav),'b')
hold on
plot(yi(46:90),real(eady_h_low_hzav),'k')
plot(yi(46:90),real(eady_q_low_hzav),'g')
plot(yi(46:90),real(eady_d_low_hzav),'r')
plot(yi(46:90),real(eady_th_low_hzav),'m')
xlabel('Latitude')
print('-dpdf','eady.pdf')

