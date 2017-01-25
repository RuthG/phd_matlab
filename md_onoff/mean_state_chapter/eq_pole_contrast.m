

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

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_000.mat','theta_tav')
theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav_000(:,:) = mean(theta_ll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_010.mat','theta_tav')
theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav_010(:,:) = mean(theta_ll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_025.mat','theta_tav')
theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav_025(:,:) = mean(theta_ll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_050.mat','theta_tav')
theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav_050(:,:) = mean(theta_ll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_075.mat','theta_tav')
theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav_075(:,:) = mean(theta_ll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_100.mat','theta_tav')
theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav_100(:,:) = mean(theta_ll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_125.mat','theta_tav')
theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav_125(:,:) = mean(theta_ll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_150.mat','theta_tav')
theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav_150(:,:) = mean(theta_ll,1);

for i=1:45
theta_hzav_000(i,:) = (theta_zav_000(i+45,:) + theta_zav_000(46-i,:))./2;
theta_hzav_010(i,:) = (theta_zav_010(i+45,:) + theta_zav_010(46-i,:))./2;
theta_hzav_025(i,:) = (theta_zav_025(i+45,:) + theta_zav_025(46-i,:))./2;
theta_hzav_050(i,:) = (theta_zav_050(i+45,:) + theta_zav_050(46-i,:))./2;
theta_hzav_075(i,:) = (theta_zav_075(i+45,:) + theta_zav_075(46-i,:))./2;
theta_hzav_100(i,:) = (theta_zav_100(i+45,:) + theta_zav_100(46-i,:))./2;
theta_hzav_125(i,:) = (theta_zav_125(i+45,:) + theta_zav_125(46-i,:))./2;
theta_hzav_150(i,:) = (theta_zav_150(i+45,:) + theta_zav_150(46-i,:))./2;
end

theta_eqdiff(1,1) = theta_hzav_000(1,13) - theta_hzav_000(44,13);
theta_eqdiff(2,1) = theta_hzav_010(1,13) - theta_hzav_010(44,13);
theta_eqdiff(3,1) = theta_hzav_025(1,13) - theta_hzav_025(44,13);
theta_eqdiff(4,1) = theta_hzav_050(1,13) - theta_hzav_050(44,13);
theta_eqdiff(5,1) = theta_hzav_075(1,13) - theta_hzav_075(44,13);
theta_eqdiff(6,1) = theta_hzav_100(1,13) - theta_hzav_100(44,13);
theta_eqdiff(7,1) = theta_hzav_125(1,13) - theta_hzav_125(44,13);
theta_eqdiff(8,1) = theta_hzav_150(1,13) - theta_hzav_150(44,13);

es0 = [0,0.1,0.25,0.5,0.75,1,1.25,1.5];

load('/net/spat-nas/project/rg312/mat_files/vt_lats_final.mat');

theta_eqdiff(1,2) = theta_hzav_000(x000n-10-45,13) - theta_hzav_000(x000n+10-45,13);
theta_eqdiff(2,2) = theta_hzav_010(x010n-10-45,13) - theta_hzav_010(x010n+10-45,13);
theta_eqdiff(3,2) = theta_hzav_025(x025n-10-45,13) - theta_hzav_025(x025n+10-45,13);
theta_eqdiff(4,2) = theta_hzav_050(x050n-10-45,13) - theta_hzav_050(x050n+10-45,13);
theta_eqdiff(5,2) = theta_hzav_075(x075n-10-45,13) - theta_hzav_075(x075n+10-45,13);
theta_eqdiff(6,2) = theta_hzav_100(x100n-10-45,13) - theta_hzav_100(x100n+10-45,13);
theta_eqdiff(7,2) = theta_hzav_125(x125n-10-45,13) - theta_hzav_125(x125n+10-45,13);
theta_eqdiff(8,2) = theta_hzav_150(x150n-10-45,13) - theta_hzav_150(x150n+10-45,13);


%theta_eqdiff(1,3) = (theta_hzav_000(1,13) - theta_hzav_000(x000n-45,13))./theta_eqdiff(1,1);
%theta_eqdiff(2,3) = (theta_hzav_010(2,13) - theta_hzav_010(x010n-45,13))./theta_eqdiff(2,1);
%theta_eqdiff(3,3) = (theta_hzav_025(3,13) - theta_hzav_025(x025n-45,13))./theta_eqdiff(3,1);
%theta_eqdiff(4,3) = (theta_hzav_050(4,13) - theta_hzav_050(x050n-45,13))./theta_eqdiff(4,1);
%theta_eqdiff(5,3) = (theta_hzav_075(5,13) - theta_hzav_075(x075n-45,13))./theta_eqdiff(5,1);
%theta_eqdiff(6,3) = (theta_hzav_100(6,13) - theta_hzav_100(x100n-45,13))./theta_eqdiff(6,1);
%theta_eqdiff(7,3) = (theta_hzav_125(7,13) - theta_hzav_125(x125n-45,13))./theta_eqdiff(7,1);
%theta_eqdiff(8,3) = (theta_hzav_150(8,13) - theta_hzav_150(x150n-45,13))./theta_eqdiff(8,1);

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
plot(es0,theta_eqdiff,'x')
%plot(es0,theta_eqdiff(:,2),'xg')
set(gca,'FontSize',10)
hold on
xlabel('e_{s0} fraction','FontSize',12)
ylabel('500 hPa \Delta\theta, K','FontSize',12)
print('-dpdf','eqpolediff.pdf')
