%load jets and find peak upper level winds, peak surface winds, peak vert av wind

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

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_000.mat','uE_tav')
uE_ll=cube2latlon(xc,yc,uE_tav,xi,yi);
uE_000_zav(:,:) = mean(uE_ll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_010.mat','uE_tav')
uE_ll=cube2latlon(xc,yc,uE_tav,xi,yi);
uE_010_zav(:,:) = mean(uE_ll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_025.mat','uE_tav')
uE_ll=cube2latlon(xc,yc,uE_tav,xi,yi);
uE_025_zav(:,:) = mean(uE_ll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_050.mat','uE_tav')
uE_ll=cube2latlon(xc,yc,uE_tav,xi,yi);
uE_050_zav(:,:) = mean(uE_ll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_050_tropheat.mat','uE_tav')
uE_ll=cube2latlon(xc,yc,uE_tav,xi,yi);
uE_th_zav(:,:) = mean(uE_ll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_075.mat','uE_tav')
uE_ll=cube2latlon(xc,yc,uE_tav,xi,yi);
uE_075_zav(:,:) = mean(uE_ll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_100.mat','uE_tav')
uE_ll=cube2latlon(xc,yc,uE_tav,xi,yi);
uE_100_zav(:,:) = mean(uE_ll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_125.mat','uE_tav')
uE_ll=cube2latlon(xc,yc,uE_tav,xi,yi);
uE_125_zav(:,:) = mean(uE_ll,1);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_150.mat','uE_tav')
uE_ll=cube2latlon(xc,yc,uE_tav,xi,yi);
uE_150_zav(:,:) = mean(uE_ll,1);



[a,b]=max(mean(uE_000_zav(46:90,:),2));
y_000 = yi(b+45);
[a,b]=max(mean(uE_010_zav(46:90,:),2));
y_010 = yi(b+45);
[a,b]=max(mean(uE_025_zav(46:90,:),2));
y_025 = yi(b+45);
[a,b]=max(mean(uE_050_zav(46:90,:),2));
y_050 = yi(b+45);
[a,b]=max(mean(uE_th_zav(46:90,:),2));
y_th = yi(b+45);
[a,b]=max(mean(uE_075_zav(46:90,:),2));
y_075 = yi(b+45);
[a,b]=max(mean(uE_100_zav(46:90,:),2));
y_100 = yi(b+45);
[a,b]=max(mean(uE_125_zav(46:90,:),2));
y_125 = yi(b+45);
[a,b]=max(mean(uE_150_zav(46:90,:),2));
y_150 = yi(b+45);



[a,b]=max(uE_000_zav(46:90,1));
yl_000 = yi(b+45);
[a,b]=max(uE_010_zav(46:90,1));
yl_010 = yi(b+45);
[a,b]=max(uE_025_zav(46:90,1));
yl_025 = yi(b+45);
[a,b]=max(uE_050_zav(46:90,1));
yl_050 = yi(b+45);
[a,b]=max(uE_th_zav(46:90,1));
yl_th = yi(b+45);
[a,b]=max(uE_075_zav(46:90,1));
yl_075 = yi(b+45);
[a,b]=max(uE_100_zav(46:90,1));
yl_100 = yi(b+45);
[a,b]=max(uE_125_zav(46:90,1));
yl_125 = yi(b+45);
[a,b]=max(uE_150_zav(46:90,1));
yl_150 = yi(b+45);


[a,b]=max(max(uE_000_zav(46:90,1:23),[],2));
yp_000 = yi(b+45);
[a,b]=max(max(uE_010_zav(46:90,1:23),[],2));
yp_010 = yi(b+45);
[a,b]=max(max(uE_025_zav(46:90,1:23),[],2));
yp_025 = yi(b+45);
[a,b]=max(max(uE_050_zav(46:90,1:23),[],2));
yp_050 = yi(b+45);
[a,b]=max(max(uE_th_zav(46:90,1:23),[],2));
yp_th = yi(b+45);
[a,b]=max(max(uE_075_zav(46:90,1:23),[],2));
yp_075 = yi(b+45);
[a,b]=max(max(uE_100_zav(46:90,1:23),[],2));
yp_100 = yi(b+45);
[a,b]=max(max(uE_125_zav(46:90,1:23),[],2));
yp_125 = yi(b+45);
[a,b]=max(max(uE_150_zav(46:90,1:23),[],2));
yp_150 = yi(b+45);

save('/project/rg312/mat_files/chapter2_variables/jet_peaks.mat', 'y_000', 'y_010', 'y_025', 'y_050', 'y_th', 'y_075', 'y_100', 'y_125', 'y_150', 'yl_000', 'yl_010', 'yl_025', 'yl_050', 'yl_th', 'yl_075', 'yl_100', 'yl_125', 'yl_150', 'yp_000', 'yp_010', 'yp_025', 'yp_050', 'yp_th', 'yp_075', 'yp_100', 'yp_125', 'yp_150')
