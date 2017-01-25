
rDir='/project/rg312/final_runs/run_000_final_noshallow/';
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

g=9.8;
cp = 1004.64;
L=2.5e6;
Ra=287.04;
Rv=461.50;
epsilon = Ra/Rv;
T0 = 273.16;

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_000.mat','theta_tav', 'q_tav')
theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav_000(:,:) = mean(theta_ll,1);
q_ll=cube2latlon(xc,yc,q_tav,xi,yi);
q_zav_000(:,:) = mean(q_ll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_010.mat','theta_tav', 'q_tav')
theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav_010(:,:) = mean(theta_ll,1);
q_ll=cube2latlon(xc,yc,q_tav,xi,yi);
q_zav_010(:,:) = mean(q_ll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_025.mat','theta_tav', 'q_tav')
theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav_025(:,:) = mean(theta_ll,1);
q_ll=cube2latlon(xc,yc,q_tav,xi,yi);
q_zav_025(:,:) = mean(q_ll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_050.mat','theta_tav', 'q_tav')
theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav_050(:,:) = mean(theta_ll,1);
q_ll=cube2latlon(xc,yc,q_tav,xi,yi);
q_zav_050(:,:) = mean(q_ll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_075.mat','theta_tav', 'q_tav')
theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav_075(:,:) = mean(theta_ll,1);
q_ll=cube2latlon(xc,yc,q_tav,xi,yi);
q_zav_075(:,:) = mean(q_ll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_100.mat','theta_tav', 'q_tav')
theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav_100(:,:) = mean(theta_ll,1);
q_ll=cube2latlon(xc,yc,q_tav,xi,yi);
q_zav_100(:,:) = mean(q_ll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_125.mat','theta_tav', 'q_tav')
theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav_125(:,:) = mean(theta_ll,1);
q_ll=cube2latlon(xc,yc,q_tav,xi,yi);
q_zav_125(:,:) = mean(q_ll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_150.mat','theta_tav', 'q_tav')
theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav_150(:,:) = mean(theta_ll,1);
q_ll=cube2latlon(xc,yc,q_tav,xi,yi);
q_zav_150(:,:) = mean(q_ll,1);


for i=1:45
theta_hzav_000(i,:) = (theta_zav_000(i+45,:) + theta_zav_000(46-i,:))./2;
theta_hzav_010(i,:) = (theta_zav_010(i+45,:) + theta_zav_010(46-i,:))./2;
theta_hzav_025(i,:) = (theta_zav_025(i+45,:) + theta_zav_025(46-i,:))./2;
theta_hzav_050(i,:) = (theta_zav_050(i+45,:) + theta_zav_050(46-i,:))./2;
theta_hzav_075(i,:) = (theta_zav_075(i+45,:) + theta_zav_075(46-i,:))./2;
theta_hzav_100(i,:) = (theta_zav_100(i+45,:) + theta_zav_100(46-i,:))./2;
theta_hzav_125(i,:) = (theta_zav_125(i+45,:) + theta_zav_125(46-i,:))./2;
theta_hzav_150(i,:) = (theta_zav_150(i+45,:) + theta_zav_150(46-i,:))./2;

q_hzav_000(i,:) = (q_zav_000(i+45,:) + q_zav_000(46-i,:))./2;
q_hzav_010(i,:) = (q_zav_010(i+45,:) + q_zav_010(46-i,:))./2;
q_hzav_025(i,:) = (q_zav_025(i+45,:) + q_zav_025(46-i,:))./2;
q_hzav_050(i,:) = (q_zav_050(i+45,:) + q_zav_050(46-i,:))./2;
q_hzav_075(i,:) = (q_zav_075(i+45,:) + q_zav_075(46-i,:))./2;
q_hzav_100(i,:) = (q_zav_100(i+45,:) + q_zav_100(46-i,:))./2;
q_hzav_125(i,:) = (q_zav_125(i+45,:) + q_zav_125(46-i,:))./2;
q_hzav_150(i,:) = (q_zav_150(i+45,:) + q_zav_150(46-i,:))./2;
end

convthetatoT=(rC/100000.0).^(2./7.);
for j=1:size(rC)
t_hzav_000(:,j)=theta_hzav_000(:,j).*convthetatoT(j,1);
t_hzav_010(:,j)=theta_hzav_010(:,j).*convthetatoT(j,1);
t_hzav_025(:,j)=theta_hzav_025(:,j).*convthetatoT(j,1);
t_hzav_050(:,j)=theta_hzav_050(:,j).*convthetatoT(j,1);
t_hzav_075(:,j)=theta_hzav_075(:,j).*convthetatoT(j,1);
t_hzav_100(:,j)=theta_hzav_100(:,j).*convthetatoT(j,1);
t_hzav_125(:,j)=theta_hzav_125(:,j).*convthetatoT(j,1);
t_hzav_150(:,j)=theta_hzav_150(:,j).*convthetatoT(j,1);
end

es_000 = 0.*610.78.*exp((L./Rv).*(1./T0 - 1./t_hzav_000));
es_010 = 0.1.*610.78.*exp((L./Rv).*(1./T0 - 1./t_hzav_010));
es_025 = 0.25.*610.78.*exp((L./Rv).*(1./T0 - 1./t_hzav_025));
es_050 = 0.5.*610.78.*exp((L./Rv).*(1./T0 - 1./t_hzav_050));
es_075 = 0.75.*610.78.*exp((L./Rv).*(1./T0 - 1./t_hzav_075));
es_100 = 1.*610.78.*exp((L./Rv).*(1./T0 - 1./t_hzav_100));
es_125 = 1.25.*610.78.*exp((L./Rv).*(1./T0 - 1./t_hzav_125));
es_150 = 1.5.*610.78.*exp((L./Rv).*(1./T0 - 1./t_hzav_150));

for i=1:25
qs_000(:,i) = epsilon.*es_000(:,i)./(rC(i)-es_000(:,i)); 
qs_010(:,i) = epsilon.*es_010(:,i)./(rC(i)-es_010(:,i)); 
qs_025(:,i) = epsilon.*es_025(:,i)./(rC(i)-es_025(:,i)); 
qs_050(:,i) = epsilon.*es_050(:,i)./(rC(i)-es_050(:,i)); 
qs_075(:,i) = epsilon.*es_075(:,i)./(rC(i)-es_075(:,i)); 
qs_100(:,i) = epsilon.*es_100(:,i)./(rC(i)-es_100(:,i)); 
qs_125(:,i) = epsilon.*es_125(:,i)./(rC(i)-es_125(:,i)); 
qs_150(:,i) = epsilon.*es_150(:,i)./(rC(i)-es_150(:,i)); 
end

RH_000 = q_hzav_000./qs_000;
RH_010 = q_hzav_010./qs_010;
RH_025 = q_hzav_025./qs_025;
RH_050 = q_hzav_050./qs_050;
RH_075 = q_hzav_075./qs_075;
RH_100 = q_hzav_100./qs_100;
RH_125 = q_hzav_125./qs_125;
RH_150 = q_hzav_150./qs_150;




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
ySize_sub = 0.15; 
xSize_sub = 0.17; 

pos1x = 0.07 ; 	pos1y = 0.75; 
pos2x = 0.29 ; 	pos2y = 0.75; 
pos3x = 0.51 ; 	pos3y = 0.75; 
pos4x = 0.73 ; 	pos4y = 0.75; 
pos5x = 0.07 ; 	pos5y = 0.55; 
pos6x = 0.29 ; 	pos6y = 0.55; 
pos7x = 0.51 ; 	pos7y = 0.55; 
pos8x = 0.73 ; 	pos8y = 0.55; 

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

v=0:0.1:1.5;

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contour(yi(46:90),rC./100,RH_000',v,'k');
clabel(C,h,'FontSize',10)
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
title('0.0')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi(46:90),rC./100,RH_010',v,'k');
clabel(C,h,'FontSize',10)
set(gca,'YDir','reverse','FontSize',10)
title('0.1')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi(46:90),rC./100,RH_025',v,'k');
clabel(C,h,'FontSize',10)
set(gca,'YDir','reverse','FontSize',10)
title('0.25')


axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi(46:90),rC./100,RH_050',v,'k');
clabel(C,h,'FontSize',10)
set(gca,'YDir','reverse','FontSize',10)
title('0.5')


axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h] = contour(yi(46:90),rC./100,RH_075',v,'k');
clabel(C,h,'FontSize',10)
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
xlabel('Latitude','FontSize',12)
title('0.75')

axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h] = contour(yi(46:90),rC./100,RH_100',v,'k');
clabel(C,h,'FontSize',10)
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
title('1.0')


axes('position',[pos7x pos7y xSize_sub ySize_sub])
[C,h] = contour(yi(46:90),rC./100,RH_125',v,'k');
clabel(C,h,'FontSize',10)
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
title('1.25')

axes('position',[pos8x pos8y xSize_sub ySize_sub])
[C,h] = contour(yi(46:90),rC./100,RH_150',v,'k');
clabel(C,h,'FontSize',10)
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
title('1.5')


print('-dpdf','rh.pdf')


