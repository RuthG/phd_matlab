%load up KE and calculate rhines scale
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
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
yi = -89:2:89;
xi = -179:2:179;

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_000.mat','uE_tav','vN_tav')
load('/project/rg312/mat_files/chapter2_variables/epvars_tav_000.mat','usq_tav','vsq_tav')
tke_tav = (usq_tav + vsq_tav)./2;
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
tkell=cube2latlon(xc,yc,tke_tav,xi,yi);
uE_zav(:,:) = mean(uEll,1);
vN_zav(:,:) = mean(vNll,1);
tke_zav(:,:) = mean(tkell,1);
zke_zav = (uE_zav.^2 + vN_zav.^2)./2;
eke_000_zav =  tke_zav - zke_zav;

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_010.mat','uE_tav','vN_tav')
load('/project/rg312/mat_files/chapter2_variables/epvars_tav_010.mat','usq_tav','vsq_tav')
tke_tav = (usq_tav + vsq_tav)./2;
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
tkell=cube2latlon(xc,yc,tke_tav,xi,yi);
uE_zav(:,:) = mean(uEll,1);
vN_zav(:,:) = mean(vNll,1);
tke_zav(:,:) = mean(tkell,1);
zke_zav = (uE_zav.^2 + vN_zav.^2)./2;
eke_010_zav =  tke_zav - zke_zav;

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_025.mat','uE_tav','vN_tav')
load('/project/rg312/mat_files/chapter2_variables/epvars_tav_025.mat','usq_tav','vsq_tav')
tke_tav = (usq_tav + vsq_tav)./2;
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
tkell=cube2latlon(xc,yc,tke_tav,xi,yi);
uE_zav(:,:) = mean(uEll,1);
vN_zav(:,:) = mean(vNll,1);
tke_zav(:,:) = mean(tkell,1);
zke_zav = (uE_zav.^2 + vN_zav.^2)./2;
eke_025_zav =  tke_zav - zke_zav;

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_050.mat','uE_tav','vN_tav')
load('/project/rg312/mat_files/chapter2_variables/epvars_tav_050.mat','usq_tav','vsq_tav')
tke_tav = (usq_tav + vsq_tav)./2;
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
tkell=cube2latlon(xc,yc,tke_tav,xi,yi);
uE_zav(:,:) = mean(uEll,1);
vN_zav(:,:) = mean(vNll,1);
tke_zav(:,:) = mean(tkell,1);
zke_zav = (uE_zav.^2 + vN_zav.^2)./2;
eke_050_zav =  tke_zav - zke_zav;

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_050_tropheat.mat','uE_tav','vN_tav')
load('/project/rg312/mat_files/chapter2_variables/epvars_tav_050_tropheat.mat','usq_tav','vsq_tav')
tke_tav = (usq_tav + vsq_tav)./2;
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
tkell=cube2latlon(xc,yc,tke_tav,xi,yi);
uE_zav(:,:) = mean(uEll,1);
vN_zav(:,:) = mean(vNll,1);
tke_zav(:,:) = mean(tkell,1);
zke_zav = (uE_zav.^2 + vN_zav.^2)./2;
eke_th_zav =  tke_zav - zke_zav;

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_075.mat','uE_tav','vN_tav')
load('/project/rg312/mat_files/chapter2_variables/epvars_tav_075.mat','usq_tav','vsq_tav')
tke_tav = (usq_tav + vsq_tav)./2;
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
tkell=cube2latlon(xc,yc,tke_tav,xi,yi);
uE_zav(:,:) = mean(uEll,1);
vN_zav(:,:) = mean(vNll,1);
tke_zav(:,:) = mean(tkell,1);
zke_zav = (uE_zav.^2 + vN_zav.^2)./2;
eke_075_zav =  tke_zav - zke_zav;

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_100.mat','uE_tav','vN_tav')
load('/project/rg312/mat_files/chapter2_variables/epvars_tav_100.mat','usq_tav','vsq_tav')
tke_tav = (usq_tav + vsq_tav)./2;
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
tkell=cube2latlon(xc,yc,tke_tav,xi,yi);
uE_zav(:,:) = mean(uEll,1);
vN_zav(:,:) = mean(vNll,1);
tke_zav(:,:) = mean(tkell,1);
zke_zav = (uE_zav.^2 + vN_zav.^2)./2;
eke_100_zav =  tke_zav - zke_zav;

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_125.mat','uE_tav','vN_tav')
load('/project/rg312/mat_files/chapter2_variables/epvars_tav_125.mat','usq_tav','vsq_tav')
tke_tav = (usq_tav + vsq_tav)./2;
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
tkell=cube2latlon(xc,yc,tke_tav,xi,yi);
uE_zav(:,:) = mean(uEll,1);
vN_zav(:,:) = mean(vNll,1);
tke_zav(:,:) = mean(tkell,1);
zke_zav = (uE_zav.^2 + vN_zav.^2)./2;
eke_125_zav =  tke_zav - zke_zav;

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_150.mat','uE_tav','vN_tav')
load('/project/rg312/mat_files/chapter2_variables/epvars_tav_150.mat','usq_tav','vsq_tav')
tke_tav = (usq_tav + vsq_tav)./2;
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
tkell=cube2latlon(xc,yc,tke_tav,xi,yi);
uE_zav(:,:) = mean(uEll,1);
vN_zav(:,:) = mean(vNll,1);
tke_zav(:,:) = mean(tkell,1);
zke_zav = (uE_zav.^2 + vN_zav.^2)./2;
eke_150_zav =  tke_zav - zke_zav;



vrms_000 = sqrt(eke_000_zav);
vrms_010 = sqrt(eke_010_zav);
vrms_025 = sqrt(eke_025_zav);
vrms_050 = sqrt(eke_050_zav);
vrms_th = sqrt(eke_th_zav);
vrms_075 = sqrt(eke_075_zav);
vrms_100 = sqrt(eke_100_zav);
vrms_125 = sqrt(eke_125_zav);
vrms_150 = sqrt(eke_150_zav);

Ra = 287.04;
g= 9.81;
omega = 2.*pi./24./60./60;
yi = -89:2:90;
radius=6371.0e3;

beta = 2.*omega./radius.*cos(yi.*pi./180);

for i=1:90
lbeta_000_a(i,:) = 2.*pi.*sqrt(vrms_000(i,:)./beta(i));
lbeta_010_a(i,:) = 2.*pi.*sqrt(vrms_010(i,:)./beta(i));
lbeta_025_a(i,:) = 2.*pi.*sqrt(vrms_025(i,:)./beta(i));
lbeta_050_a(i,:) = 2.*pi.*sqrt(vrms_050(i,:)./beta(i));
lbeta_th_a(i,:) = 2.*pi.*sqrt(vrms_th(i,:)./beta(i));
lbeta_075_a(i,:) = 2.*pi.*sqrt(vrms_075(i,:)./beta(i));
lbeta_100_a(i,:) = 2.*pi.*sqrt(vrms_100(i,:)./beta(i));
lbeta_125_a(i,:) = 2.*pi.*sqrt(vrms_125(i,:)./beta(i));
lbeta_150_a(i,:) = 2.*pi.*sqrt(vrms_150(i,:)./beta(i));
end

lbeta_000 = mean(lbeta_000_a,2);
lbeta_010 = mean(lbeta_010_a,2);
lbeta_025 = mean(lbeta_025_a,2);
lbeta_050 = mean(lbeta_050_a,2);
lbeta_th = mean(lbeta_th_a,2);
lbeta_075 = mean(lbeta_075_a,2);
lbeta_100 = mean(lbeta_100_a,2);
lbeta_125 = mean(lbeta_125_a,2);
lbeta_150 = mean(lbeta_150_a,2);

kbeta_000 = 2.*pi.*radius.*cos(yi.*pi./180)./lbeta_000';
kbeta_010 = 2.*pi.*radius.*cos(yi.*pi./180)./lbeta_010';
kbeta_025 = 2.*pi.*radius.*cos(yi.*pi./180)./lbeta_025';
kbeta_050 = 2.*pi.*radius.*cos(yi.*pi./180)./lbeta_050';
kbeta_th = 2.*pi.*radius.*cos(yi.*pi./180)./lbeta_th';
kbeta_075 = 2.*pi.*radius.*cos(yi.*pi./180)./lbeta_075';
kbeta_100 = 2.*pi.*radius.*cos(yi.*pi./180)./lbeta_100';
kbeta_125 = 2.*pi.*radius.*cos(yi.*pi./180)./lbeta_125';
kbeta_150 = 2.*pi.*radius.*cos(yi.*pi./180)./lbeta_150';

save('/project/rg312/mat_files/chapter2_variables/rhines_scale.mat', 'kbeta_000', 'kbeta_010', 'kbeta_025', 'kbeta_050', 'kbeta_th', 'kbeta_075', 'kbeta_100', 'kbeta_125', 'kbeta_150')

