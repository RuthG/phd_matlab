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
xi=-179:2:180;yi=-89:2:90;

g=9.8;
cp=1005;
L=2.5e6;
Ra=287.04;
Rv=461.50;
epsilon = Ra/Rv;
T0 = 273.16;
rad=6371.0e3;	
omega = 2.*pi./24./60./60;

%HH needs cell height, vert av change in rad eq pot temp
%H needs cell height, bulk stability
%S needs near surface stability, near surface pot temp gradient
%Soooo
%load in tropopause height, psi, potential temperature, LW fluxes

load('/project/rg312/mat_files/trop_levs_final.mat');

load('/project/rg312/mat_files/snapshot_data_final/run_000_ns/ph_000_timemean.mat');
ph_ll_zav(:,:) = mean(ph_ll_tav,1);
cell_height_000 = ph_ll_zav(45,trop_lev_000(45))./g;
cell_height_err_000(1) = abs( ph_ll_zav(45,trop_lev_000(45)-1) - ph_ll_zav(45,trop_lev_000(45)) )./g;
cell_height_err_000(2) = abs( ph_ll_zav(45,trop_lev_000(45)+1) - ph_ll_zav(45,trop_lev_000(45)) )./g;

load('/project/rg312/mat_files/snapshot_data_final/run_010/ph_010_timemean.mat');
ph_ll_zav(:,:) = mean(ph_ll_tav,1);
cell_height_010 = ph_ll_zav(45,trop_lev_010(45))./g;
cell_height_err_010(1) = abs( ph_ll_zav(45,trop_lev_010(45)-1) - ph_ll_zav(45,trop_lev_010(45)) )./g;
cell_height_err_010(2) = abs( ph_ll_zav(45,trop_lev_010(45)+1) - ph_ll_zav(45,trop_lev_010(45)) )./g;

load('/project/rg312/mat_files/snapshot_data_final/run_025/ph_025_timemean.mat');
ph_ll_zav(:,:) = mean(ph_ll_tav,1);
cell_height_025 = ph_ll_zav(45,trop_lev_025(45))./g;
cell_height_err_025(1) = abs( ph_ll_zav(45,trop_lev_025(45)-1) - ph_ll_zav(45,trop_lev_025(45)) )./g;
cell_height_err_025(2) = abs( ph_ll_zav(45,trop_lev_025(45)+1) - ph_ll_zav(45,trop_lev_025(45)) )./g

load('/project/rg312/mat_files/snapshot_data_final/run_050/ph_050_timemean.mat');
ph_ll_zav(:,:) = mean(ph_ll_tav,1);
cell_height_050 = ph_ll_zav(45,trop_lev_050(45))./g;
cell_height_err_050(1) = abs( ph_ll_zav(45,trop_lev_050(45)-1) - ph_ll_zav(45,trop_lev_050(45)) )./g;
cell_height_err_050(2) = abs( ph_ll_zav(45,trop_lev_050(45)+1) - ph_ll_zav(45,trop_lev_050(45)) )./g

load('/project/rg312/mat_files/snapshot_data_final/run_075/ph_075_timemean.mat');
ph_ll_zav(:,:) = mean(ph_ll_tav,1);
cell_height_075 = ph_ll_zav(45,trop_lev_075(45))./g;
cell_height_err_075(1) = abs( ph_ll_zav(45,trop_lev_075(45)-1) - ph_ll_zav(45,trop_lev_075(45)) )./g;
cell_height_err_075(2) = abs( ph_ll_zav(45,trop_lev_075(45)+1) - ph_ll_zav(45,trop_lev_075(45)) )./g

load('/project/rg312/mat_files/snapshot_data_final/run_100/ph_100_timemean.mat');
ph_ll_zav(:,:) = mean(ph_ll_tav,1);
cell_height_100 = ph_ll_zav(45,trop_lev_100(45))./g;
cell_height_err_100(1) = abs( ph_ll_zav(45,trop_lev_100(45)-1) - ph_ll_zav(45,trop_lev_100(45)) )./g;
cell_height_err_100(2) = abs( ph_ll_zav(45,trop_lev_100(45)+1) - ph_ll_zav(45,trop_lev_100(45)) )./g

load('/project/rg312/mat_files/snapshot_data_final/run_125/ph_125_timemean.mat');
ph_ll_zav(:,:) = mean(ph_ll_tav,1);
cell_height_125 = ph_ll_zav(45,trop_lev_125(45))./g;
cell_height_err_125(1) = abs( ph_ll_zav(45,trop_lev_125(45)-1) - ph_ll_zav(45,trop_lev_125(45)) )./g;
cell_height_err_125(2) = abs( ph_ll_zav(45,trop_lev_125(45)+1) - ph_ll_zav(45,trop_lev_125(45)) )./g

load('/project/rg312/mat_files/snapshot_data_final/run_150/ph_150_timemean.mat');
ph_ll_zav(:,:) = mean(ph_ll_tav,1);
cell_height_150 = ph_ll_zav(45,trop_lev_150(45))./g;
cell_height_err_150(1) = abs( ph_ll_zav(45,trop_lev_150(45)-1) - ph_ll_zav(45,trop_lev_150(45)) )./g;
cell_height_err_150(2) = abs( ph_ll_zav(45,trop_lev_150(45)+1) - ph_ll_zav(45,trop_lev_150(45)) )./g


clear('ph_ll_tav','ph_ll_zav')

save('/project/rg312/mat_files/chapter2_variables/cell_height_equator.mat') %, 'cell_height_000', 'cell_height_010', 'cell_height_025', 'cell_height_050', 'cell_height_075', 'cell_height_100', 'cell_height_125', 'cell_height_150')

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

for i=1:45
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

b_eq_000 = (lwu_hzav_000 + lwd_hzav_000)./2;
b_eq_010 = (lwu_hzav_010 + lwd_hzav_010)./2;
b_eq_025 = (lwu_hzav_025 + lwd_hzav_025)./2;
b_eq_050 = (lwu_hzav_050 + lwd_hzav_050)./2;
b_eq_075 = (lwu_hzav_075 + lwd_hzav_075)./2;
b_eq_100 = (lwu_hzav_100 + lwd_hzav_100)./2;
b_eq_125 = (lwu_hzav_125 + lwd_hzav_125)./2;
b_eq_150 = (lwu_hzav_150 + lwd_hzav_150)./2;

stefan = 5.67e-8;

t_eq_000 = (b_eq_000./stefan).^(1/4);
t_eq_010 = (b_eq_010./stefan).^(1/4);
t_eq_025 = (b_eq_025./stefan).^(1/4);
t_eq_050 = (b_eq_050./stefan).^(1/4);
t_eq_075 = (b_eq_075./stefan).^(1/4);
t_eq_100 = (b_eq_100./stefan).^(1/4);
t_eq_125 = (b_eq_125./stefan).^(1/4);
t_eq_150 = (b_eq_150./stefan).^(1/4);

%Held Hou estimate needs the vertically averaged equator to pole radiative equilibrium potential temperature difference: estimate it!

convthetatoT=(rC/100000.0).^(2./7.);
for k=1:size(rC)
theta_eq_000(:,k) = t_eq_000(:,k)./convthetatoT(k,1);
theta_eq_010(:,k) = t_eq_010(:,k)./convthetatoT(k,1);
theta_eq_025(:,k) = t_eq_025(:,k)./convthetatoT(k,1);
theta_eq_050(:,k) = t_eq_050(:,k)./convthetatoT(k,1);
theta_eq_075(:,k) = t_eq_075(:,k)./convthetatoT(k,1);
theta_eq_100(:,k) = t_eq_100(:,k)./convthetatoT(k,1);
theta_eq_125(:,k) = t_eq_125(:,k)./convthetatoT(k,1);
theta_eq_150(:,k) = t_eq_150(:,k)./convthetatoT(k,1);
end

theta_eq_000_vav = mean(theta_eq_000,2);
theta_eq_010_vav = mean(theta_eq_010,2);
theta_eq_025_vav = mean(theta_eq_025,2);
theta_eq_050_vav = mean(theta_eq_050,2);
theta_eq_075_vav = mean(theta_eq_075,2);
theta_eq_100_vav = mean(theta_eq_100,2);
theta_eq_125_vav = mean(theta_eq_125,2);
theta_eq_150_vav = mean(theta_eq_150,2);

deltheta_eq_000 = theta_eq_000_vav(1) - theta_eq_000_vav(44);
deltheta_eq_010 = theta_eq_010_vav(1) - theta_eq_010_vav(44);
deltheta_eq_025 = theta_eq_025_vav(1) - theta_eq_025_vav(44);
deltheta_eq_050 = theta_eq_050_vav(1) - theta_eq_050_vav(44);
deltheta_eq_075 = theta_eq_075_vav(1) - theta_eq_075_vav(44);
deltheta_eq_100 = theta_eq_100_vav(1) - theta_eq_100_vav(44);
deltheta_eq_125 = theta_eq_125_vav(1) - theta_eq_125_vav(44);
deltheta_eq_150 = theta_eq_150_vav(1) - theta_eq_150_vav(44);



%load psi
load('/project/rg312/mat_files/chapter2_variables/psi_tav_000.mat','psi_000_hzav')
load('/project/rg312/mat_files/chapter2_variables/psi_tav_010.mat','psi_010_hzav')
load('/project/rg312/mat_files/chapter2_variables/psi_tav_025.mat','psi_025_hzav')
load('/project/rg312/mat_files/chapter2_variables/psi_tav_050.mat','psi_050_hzav')
load('/project/rg312/mat_files/chapter2_variables/psi_tav_075.mat','psi_075_hzav')
load('/project/rg312/mat_files/chapter2_variables/psi_tav_100.mat','psi_100_hzav')
load('/project/rg312/mat_files/chapter2_variables/psi_tav_125.mat','psi_125_hzav')
load('/project/rg312/mat_files/chapter2_variables/psi_tav_150.mat','psi_150_hzav')

mask = +psi_000_hzav(:,13)>=0;
lat = diff(mask);
term_lat_000 = yi(46+min(find(lat == -1)));
mask = +psi_010_hzav(:,13)>=0;
lat = diff(mask);
term_lat_010 = yi(46+min(find(lat == -1)));
mask = +psi_025_hzav(:,13)>=0;
lat = diff(mask);
term_lat_025 = yi(46+min(find(lat == -1)));
mask = +psi_050_hzav(:,13)>=0;
lat = diff(mask);
term_lat_050 = yi(46+min(find(lat == -1)));
mask = +psi_075_hzav(:,13)>=0;
lat = diff(mask);
term_lat_075 = yi(46+min(find(lat == -1)));
mask = +psi_100_hzav(:,13)>=0;
lat = diff(mask);
term_lat_100 = yi(46+min(find(lat == -1)));
mask = +psi_125_hzav(:,13)>=0;
lat = diff(mask);
term_lat_125 = yi(46+min(find(lat == -1)));
mask = +psi_150_hzav(:,13)>=0;
lat = diff(mask);
term_lat_150 = yi(46+min(find(lat == -1)));

save('/project/rg312/mat_files/chapter2_variables/cell_edge.mat', 'term_lat_000', 'term_lat_010', 'term_lat_025', 'term_lat_050', 'term_lat_075', 'term_lat_100', 'term_lat_125', 'term_lat_150')

T0_000 = sum(theta_eq_000_vav(1:44)'.*cos(yi(46:89).*pi./180))./sum(cos(yi(46:89).*pi./180));
T0_010 = sum(theta_eq_010_vav(1:44)'.*cos(yi(46:89).*pi./180))./sum(cos(yi(46:89).*pi./180));
T0_025 = sum(theta_eq_025_vav(1:44)'.*cos(yi(46:89).*pi./180))./sum(cos(yi(46:89).*pi./180));
T0_050 = sum(theta_eq_050_vav(1:44)'.*cos(yi(46:89).*pi./180))./sum(cos(yi(46:89).*pi./180));
T0_075 = sum(theta_eq_075_vav(1:44)'.*cos(yi(46:89).*pi./180))./sum(cos(yi(46:89).*pi./180));
T0_100 = sum(theta_eq_100_vav(1:44)'.*cos(yi(46:89).*pi./180))./sum(cos(yi(46:89).*pi./180));
T0_125 = sum(theta_eq_125_vav(1:44)'.*cos(yi(46:89).*pi./180))./sum(cos(yi(46:89).*pi./180));
T0_150 = sum(theta_eq_150_vav(1:44)'.*cos(yi(46:89).*pi./180))./sum(cos(yi(46:89).*pi./180));


consts = 5./3 .* g ./ (omega.*rad).^2;

phi_hh_000 = sqrt(consts .* cell_height_000 .* deltheta_eq_000 ./ T0_000).*180./pi;
phi_hh_010 = sqrt(consts .* cell_height_010 .* deltheta_eq_010 ./ T0_010).*180./pi;
phi_hh_025 = sqrt(consts .* cell_height_025 .* deltheta_eq_025 ./ T0_025).*180./pi;
phi_hh_050 = sqrt(consts .* cell_height_050 .* deltheta_eq_050 ./ T0_050).*180./pi;
phi_hh_075 = sqrt(consts .* cell_height_075 .* deltheta_eq_075 ./ T0_075).*180./pi;
phi_hh_100 = sqrt(consts .* cell_height_100 .* deltheta_eq_100 ./ T0_100).*180./pi;
phi_hh_125 = sqrt(consts .* cell_height_125 .* deltheta_eq_125 ./ T0_125).*180./pi;
phi_hh_150 = sqrt(consts .* cell_height_150 .* deltheta_eq_150 ./ T0_150).*180./pi;

save('/project/rg312/mat_files/chapter2_variables/cell_ext_HH.mat', 'phi_hh_000', 'phi_hh_010', 'phi_hh_025', 'phi_hh_050', 'phi_hh_075', 'phi_hh_100', 'phi_hh_125', 'phi_hh_150')