
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
xi=-179:2:179;
yi = -89:2:89;

g=9.8;
cp=1005;
L=2.5e6;
Ra=287.04;
Rv=461.50;
epsilon = Ra/Rv;
T0 = 273.16;

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


%load lw
load('/project/rg312/mat_files/chapter2_variables/lw_tav_000.mat')
lwn_ll=cube2latlon(xc,yc,lwn_tav,xi,yi);
lwn_zav_000(:,:) = mean(lwn_ll,1);
lwd_ll=cube2latlon(xc,yc,lwd_tav,xi,yi);
lwd_zav_000(:,:) = mean(lwd_ll,1);
load('/project/rg312/mat_files/chapter2_variables/lw_tav_010.mat')
lwn_ll=cube2latlon(xc,yc,lwn_tav,xi,yi);
lwn_zav_010(:,:) = mean(lwn_ll,1);
lwd_ll=cube2latlon(xc,yc,lwd_tav,xi,yi);
lwd_zav_010(:,:) = mean(lwd_ll,1);
load('/project/rg312/mat_files/chapter2_variables/lw_tav_025.mat')
lwn_ll=cube2latlon(xc,yc,lwn_tav,xi,yi);
lwn_zav_025(:,:) = mean(lwn_ll,1);
lwd_ll=cube2latlon(xc,yc,lwd_tav,xi,yi);
lwd_zav_025(:,:) = mean(lwd_ll,1);
load('/project/rg312/mat_files/chapter2_variables/lw_tav_050.mat')
lwn_ll=cube2latlon(xc,yc,lwn_tav,xi,yi);
lwn_zav_050(:,:) = mean(lwn_ll,1);
lwd_ll=cube2latlon(xc,yc,lwd_tav,xi,yi);
lwd_zav_050(:,:) = mean(lwd_ll,1);
load('/project/rg312/mat_files/chapter2_variables/lw_tav_075.mat')
lwn_ll=cube2latlon(xc,yc,lwn_tav,xi,yi);
lwn_zav_075(:,:) = mean(lwn_ll,1);
lwd_ll=cube2latlon(xc,yc,lwd_tav,xi,yi);
lwd_zav_075(:,:) = mean(lwd_ll,1);
load('/project/rg312/mat_files/chapter2_variables/lw_tav_100.mat')
lwn_ll=cube2latlon(xc,yc,lwn_tav,xi,yi);
lwn_zav_100(:,:) = mean(lwn_ll,1);
lwd_ll=cube2latlon(xc,yc,lwd_tav,xi,yi);
lwd_zav_100(:,:) = mean(lwd_ll,1);
load('/project/rg312/mat_files/chapter2_variables/lw_tav_125.mat')
lwn_ll=cube2latlon(xc,yc,lwn_tav,xi,yi);
lwn_zav_125(:,:) = mean(lwn_ll,1);
lwd_ll=cube2latlon(xc,yc,lwd_tav,xi,yi);
lwd_zav_125(:,:) = mean(lwd_ll,1);
load('/project/rg312/mat_files/chapter2_variables/lw_tav_150.mat')
lwn_ll=cube2latlon(xc,yc,lwn_tav,xi,yi);
lwn_zav_150(:,:) = mean(lwn_ll,1);
lwd_ll=cube2latlon(xc,yc,lwd_tav,xi,yi);
lwd_zav_150(:,:) = mean(lwd_ll,1);

load('/project/rg312/mat_files/snapshot_data_final/run_000_ns/ph_000_timemean.mat');
ph_ll_zav_000(:,:) = mean(ph_ll_tav,1);
load('/project/rg312/mat_files/snapshot_data_final/run_010/ph_010_timemean.mat');
ph_ll_zav_010(:,:) = mean(ph_ll_tav,1);
load('/project/rg312/mat_files/snapshot_data_final/run_025/ph_025_timemean.mat');
ph_ll_zav_025(:,:) = mean(ph_ll_tav,1);
load('/project/rg312/mat_files/snapshot_data_final/run_050/ph_050_timemean.mat');
ph_ll_zav_050(:,:) = mean(ph_ll_tav,1);
load('/project/rg312/mat_files/snapshot_data_final/run_075/ph_075_timemean.mat');
ph_ll_zav_075(:,:) = mean(ph_ll_tav,1);
load('/project/rg312/mat_files/snapshot_data_final/run_100/ph_100_timemean.mat');
ph_ll_zav_100(:,:) = mean(ph_ll_tav,1);
load('/project/rg312/mat_files/snapshot_data_final/run_125/ph_125_timemean.mat');
ph_ll_zav_125(:,:) = mean(ph_ll_tav,1);
load('/project/rg312/mat_files/snapshot_data_final/run_150/ph_150_timemean.mat');
ph_ll_zav_150(:,:) = mean(ph_ll_tav,1);

for i=1:45
theta_hzav_000(i,:) = (theta_zav_000(i+45,:) + theta_zav_000(46-i,:))./2;
theta_hzav_010(i,:) = (theta_zav_010(i+45,:) + theta_zav_010(46-i,:))./2;
theta_hzav_025(i,:) = (theta_zav_025(i+45,:) + theta_zav_025(46-i,:))./2;
theta_hzav_050(i,:) = (theta_zav_050(i+45,:) + theta_zav_050(46-i,:))./2;
theta_hzav_075(i,:) = (theta_zav_075(i+45,:) + theta_zav_075(46-i,:))./2;
theta_hzav_100(i,:) = (theta_zav_100(i+45,:) + theta_zav_100(46-i,:))./2;
theta_hzav_125(i,:) = (theta_zav_125(i+45,:) + theta_zav_125(46-i,:))./2;
theta_hzav_150(i,:) = (theta_zav_150(i+45,:) + theta_zav_150(46-i,:))./2;

lwn_hzav_000(i,:) = (lwn_zav_000(i+45,:) + lwn_zav_000(46-i,:))./2;
lwn_hzav_010(i,:) = (lwn_zav_010(i+45,:) + lwn_zav_010(46-i,:))./2;
lwn_hzav_025(i,:) = (lwn_zav_025(i+45,:) + lwn_zav_025(46-i,:))./2;
lwn_hzav_050(i,:) = (lwn_zav_050(i+45,:) + lwn_zav_050(46-i,:))./2;
lwn_hzav_075(i,:) = (lwn_zav_075(i+45,:) + lwn_zav_075(46-i,:))./2;
lwn_hzav_100(i,:) = (lwn_zav_100(i+45,:) + lwn_zav_100(46-i,:))./2;
lwn_hzav_125(i,:) = (lwn_zav_125(i+45,:) + lwn_zav_125(46-i,:))./2;
lwn_hzav_150(i,:) = (lwn_zav_150(i+45,:) + lwn_zav_150(46-i,:))./2;

lwd_hzav_000(i,:) = (lwd_zav_000(i+45,:) + lwd_zav_000(46-i,:))./2;
lwd_hzav_010(i,:) = (lwd_zav_010(i+45,:) + lwd_zav_010(46-i,:))./2;
lwd_hzav_025(i,:) = (lwd_zav_025(i+45,:) + lwd_zav_025(46-i,:))./2;
lwd_hzav_050(i,:) = (lwd_zav_050(i+45,:) + lwd_zav_050(46-i,:))./2;
lwd_hzav_075(i,:) = (lwd_zav_075(i+45,:) + lwd_zav_075(46-i,:))./2;
lwd_hzav_100(i,:) = (lwd_zav_100(i+45,:) + lwd_zav_100(46-i,:))./2;
lwd_hzav_125(i,:) = (lwd_zav_125(i+45,:) + lwd_zav_125(46-i,:))./2;
lwd_hzav_150(i,:) = (lwd_zav_150(i+45,:) + lwd_zav_150(46-i,:))./2;
end

lwu_hzav_000 = lwn_hzav_000 + lwd_hzav_000;
lwu_hzav_010 = lwn_hzav_010 + lwd_hzav_010;
lwu_hzav_025 = lwn_hzav_025 + lwd_hzav_025;
lwu_hzav_050 = lwn_hzav_050 + lwd_hzav_050;
lwu_hzav_075 = lwn_hzav_075 + lwd_hzav_075;
lwu_hzav_100 = lwn_hzav_100 + lwd_hzav_100;
lwu_hzav_125 = lwn_hzav_125 + lwd_hzav_125;
lwu_hzav_150 = lwn_hzav_150 + lwd_hzav_150;

stefan = 5.67e-8;

t_eq_000 = (lwu_hzav_000(1,25)./stefan).^(1/4);
t_eq_010 = (lwu_hzav_010(1,25)./stefan).^(1/4);
t_eq_025 = (lwu_hzav_025(1,25)./stefan).^(1/4);
t_eq_050 = (lwu_hzav_050(1,25)./stefan).^(1/4);
t_eq_075 = (lwu_hzav_075(1,25)./stefan).^(1/4);
t_eq_100 = (lwu_hzav_100(1,25)./stefan).^(1/4);
t_eq_125 = (lwu_hzav_125(1,25)./stefan).^(1/4);
t_eq_150 = (lwu_hzav_150(1,25)./stefan).^(1/4);

convthetatoT=(rC/100000.0).^(2./7.);
for k=1:size(rC)
t_hzav_000(:,k)=theta_hzav_000(:,k).*convthetatoT(k,1);
t_hzav_010(:,k)=theta_hzav_010(:,k).*convthetatoT(k,1);
t_hzav_025(:,k)=theta_hzav_025(:,k).*convthetatoT(k,1);
t_hzav_050(:,k)=theta_hzav_050(:,k).*convthetatoT(k,1);
t_hzav_075(:,k)=theta_hzav_075(:,k).*convthetatoT(k,1);
t_hzav_100(:,k)=theta_hzav_100(:,k).*convthetatoT(k,1);
t_hzav_125(:,k)=theta_hzav_125(:,k).*convthetatoT(k,1);
t_hzav_150(:,k)=theta_hzav_150(:,k).*convthetatoT(k,1);
end

prefac = zeros(45,25);
for k=1:25
prefac(:,k) = rC(k).*g./Ra;
end

dlntdp_000 = gradient(log(t_hzav_000),-4000);
dtdz_000 = prefac.*dlntdp_000.*1000;
dlntdp_010 = gradient(log(t_hzav_010),-4000);
dtdz_010 = prefac.*dlntdp_010.*1000;
dlntdp_025 = gradient(log(t_hzav_025),-4000);
dtdz_025 = prefac.*dlntdp_025.*1000;
dlntdp_050 = gradient(log(t_hzav_050),-4000);
dtdz_050 = prefac.*dlntdp_050.*1000;
dlntdp_075 = gradient(log(t_hzav_075),-4000);
dtdz_075 = prefac.*dlntdp_075.*1000;
dlntdp_100 = gradient(log(t_hzav_100),-4000);
dtdz_100 = prefac.*dlntdp_100.*1000;
dlntdp_125 = gradient(log(t_hzav_125),-4000);
dtdz_125 = prefac.*dlntdp_125.*1000;
dlntdp_150 = gradient(log(t_hzav_150),-4000);
dtdz_150 = prefac.*dlntdp_150.*1000;

surfT=300;
alph = 2^-0.25;

radeq_lev_000 = min(find(t_hzav_000(1,:) - t_eq_000(1,:) <= 0));
emheight_000 = ph_ll_zav_000(46,find( abs(t_hzav_000(1,:) - t_eq_000(1,:)) == min ( abs(t_hzav_000(1,:) - t_eq_000(1,:))) ))./9.8;
lapseav_000 = mean(dtdz_000(1,1:17),2);
height_est_000 = (1-alph).*surfT./lapseav_000.*1000 + alph.*emheight_000;

radeq_press_010 = rC(min(find(t_hzav_010(1,:) - t_eq_010(1,:) <= 0)));
emheight_010 = ph_ll_zav_010(46,find( abs(t_hzav_010(1,:) - t_eq_010(1,:)) == min ( abs(t_hzav_010(1,:) - t_eq_010(1,:))) ))./9.8;
lapseav_010 = mean(dtdz_010(1,1:17),2);
height_est_010 = (1-alph).*surfT./lapseav_010.*1000 + alph.*emheight_010;

radeq_press_025 = rC(min(find(t_hzav_025(1,:) - t_eq_025(1,:) <= 0)));
emheight_025 = ph_ll_zav_025(46,find( abs(t_hzav_025(1,:) - t_eq_025(1,:)) == min ( abs(t_hzav_025(1,:) - t_eq_025(1,:))) ))./9.8;
lapseav_025 = mean(dtdz_025(1,1:17),2);
height_est_025 = (1-alph).*surfT./lapseav_025.*1000 + alph.*emheight_025;

radeq_press_050 = rC(min(find(t_hzav_050(1,:) - t_eq_050(1,:) <= 0)));
emheight_050 = ph_ll_zav_050(46,find( abs(t_hzav_050(1,:) - t_eq_050(1,:)) == min ( abs(t_hzav_050(1,:) - t_eq_050(1,:))) ))./9.8;
lapseav_050 = mean(dtdz_050(1,1:17),2);
height_est_050 = (1-alph).*surfT./lapseav_050.*1000 + alph.*emheight_050;

radeq_press_075 = rC(min(find(t_hzav_075(1,:) - t_eq_075(1,:) <= 0)));
emheight_075 = ph_ll_zav_075(46,find( abs(t_hzav_075(1,:) - t_eq_075(1,:)) == min ( abs(t_hzav_075(1,:) - t_eq_075(1,:))) ))./9.8;
lapseav_075 = mean(dtdz_075(1,1:17),2);
height_est_075 = (1-alph).*surfT./lapseav_075.*1000 + alph.*emheight_075;

radeq_press_100 = rC(min(find(t_hzav_100(1,:) - t_eq_100(1,:) <= 0)));
emheight_100 = ph_ll_zav_100(46,find( abs(t_hzav_100(1,:) - t_eq_100(1,:)) == min ( abs(t_hzav_100(1,:) - t_eq_100(1,:))) ))./9.8;
lapseav_100 = mean(dtdz_100(1,1:17),2);
height_est_100 = (1-alph).*surfT./lapseav_100.*1000 + alph.*emheight_100;

radeq_press_125 = rC(min(find(t_hzav_125(1,:) - t_eq_125(1,:) <= 0)));
emheight_125 = ph_ll_zav_125(46,find( abs(t_hzav_125(1,:) - t_eq_125(1,:)) == min ( abs(t_hzav_125(1,:) - t_eq_125(1,:))) ))./9.8;
lapseav_125 = mean(dtdz_125(1,1:17),2);
height_est_125 = (1-alph).*surfT./lapseav_125.*1000 + alph.*emheight_125;

radeq_press_150 = rC(min(find(t_hzav_150(1,:) - t_eq_150(1,:) <= 0)));
emheight_150 = ph_ll_zav_150(46,find( abs(t_hzav_150(1,:) - t_eq_150(1,:)) == min ( abs(t_hzav_150(1,:) - t_eq_150(1,:))) ))./9.8;
lapseav_150 = mean(dtdz_150(1,1:17),2);
height_est_150 = (1-alph).*surfT./lapseav_150.*1000 + alph.*emheight_150;

save('/project/rg312/mat_files/chapter2_variables/cell_height_est_new.mat', 'height_est_000', 'height_est_010', 'height_est_025', 'height_est_050', 'height_est_075', 'height_est_100', 'height_est_125', 'height_est_150')

save('/project/rg312/mat_files/chapter2_variables/emission_height_est.mat', 'emheight_000', 'emheight_010', 'emheight_025', 'emheight_050', 'emheight_075', 'emheight_100', 'emheight_125', 'emheight_150')


