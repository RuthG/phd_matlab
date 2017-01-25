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
omega = 2.*pi./24./60./60;

%HH needs cell height, vert av change in rad eq pot temp
%H needs cell height, bulk stability av 20-40 degrees
%S needs near surface stability, near surface pot temp gradient
%Soooo
%load in tropopause height, psi, potential temperature, LW fluxes

load('/project/rg312/mat_files/trop_levs_final.mat');

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
%clear('ph_ll_tav','ph_ll_zav')

for i=1:44
cell_height_000(i) = ph_ll_zav_000(45+i,trop_lev_000(45+i))./g;
cell_height_010(i) = ph_ll_zav_010(45+i,trop_lev_010(45+i))./g;
cell_height_025(i) = ph_ll_zav_025(45+i,trop_lev_025(45+i))./g;
cell_height_050(i) = ph_ll_zav_050(45+i,trop_lev_050(45+i))./g;
cell_height_075(i) = ph_ll_zav_075(45+i,trop_lev_075(45+i))./g;
cell_height_100(i) = ph_ll_zav_100(45+i,trop_lev_100(45+i))./g;
cell_height_125(i) = ph_ll_zav_125(45+i,trop_lev_125(45+i))./g;
cell_height_150(i) = ph_ll_zav_150(45+i,trop_lev_150(45+i))./g;
end

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

for i=1:44
theta_hzav_000(i,:) = (theta_zav_000(i+45,:) + theta_zav_000(46-i,:))./2;
theta_hzav_010(i,:) = (theta_zav_010(i+45,:) + theta_zav_010(46-i,:))./2;
theta_hzav_025(i,:) = (theta_zav_025(i+45,:) + theta_zav_025(46-i,:))./2;
theta_hzav_050(i,:) = (theta_zav_050(i+45,:) + theta_zav_050(46-i,:))./2;
theta_hzav_075(i,:) = (theta_zav_075(i+45,:) + theta_zav_075(46-i,:))./2;
theta_hzav_100(i,:) = (theta_zav_100(i+45,:) + theta_zav_100(46-i,:))./2;
theta_hzav_125(i,:) = (theta_zav_125(i+45,:) + theta_zav_125(46-i,:))./2;
theta_hzav_150(i,:) = (theta_zav_150(i+45,:) + theta_zav_150(46-i,:))./2;

bulk_stab_000(i) = theta_hzav_000(i,trop_lev_000(45+i)) - theta_hzav_000(i,1);
bulk_stab_010(i) = theta_hzav_010(i,trop_lev_010(45+i)) - theta_hzav_010(i,1);
bulk_stab_025(i) = theta_hzav_025(i,trop_lev_025(45+i)) - theta_hzav_025(i,1);
bulk_stab_050(i) = theta_hzav_050(i,trop_lev_050(45+i)) - theta_hzav_050(i,1);
bulk_stab_075(i) = theta_hzav_075(i,trop_lev_075(45+i)) - theta_hzav_075(i,1);
bulk_stab_100(i) = theta_hzav_100(i,trop_lev_100(45+i)) - theta_hzav_100(i,1);
bulk_stab_125(i) = theta_hzav_125(i,trop_lev_125(45+i)) - theta_hzav_125(i,1);
bulk_stab_150(i) = theta_hzav_150(i,trop_lev_150(45+i)) - theta_hzav_150(i,1);

bulk_stab_000_weighted(i) = bulk_stab_000(i).*cos(yi(45+i).*pi./180);
bulk_stab_010_weighted(i) = bulk_stab_010(i).*cos(yi(45+i).*pi./180);
bulk_stab_025_weighted(i) = bulk_stab_025(i).*cos(yi(45+i).*pi./180);
bulk_stab_050_weighted(i) = bulk_stab_050(i).*cos(yi(45+i).*pi./180);
bulk_stab_075_weighted(i) = bulk_stab_075(i).*cos(yi(45+i).*pi./180);
bulk_stab_100_weighted(i) = bulk_stab_100(i).*cos(yi(45+i).*pi./180);
bulk_stab_125_weighted(i) = bulk_stab_125(i).*cos(yi(45+i).*pi./180);
bulk_stab_150_weighted(i) = bulk_stab_150(i).*cos(yi(45+i).*pi./180);


cell_height_000_weighted(i) = cell_height_000(i).*cos(yi(45+i).*pi./180);
cell_height_010_weighted(i) = cell_height_010(i).*cos(yi(45+i).*pi./180);
cell_height_025_weighted(i) = cell_height_025(i).*cos(yi(45+i).*pi./180);
cell_height_050_weighted(i) = cell_height_050(i).*cos(yi(45+i).*pi./180);
cell_height_075_weighted(i) = cell_height_075(i).*cos(yi(45+i).*pi./180);
cell_height_100_weighted(i) = cell_height_100(i).*cos(yi(45+i).*pi./180);
cell_height_125_weighted(i) = cell_height_125(i).*cos(yi(45+i).*pi./180);
cell_height_150_weighted(i) = cell_height_150(i).*cos(yi(45+i).*pi./180);
end

%load cell extent
load('/project/rg312/mat_files/chapter2_variables/cell_edge.mat')

bulk_stab_000_av = sum(bulk_stab_000_weighted(10:20))./sum(cos(yi(55:65).*pi./180));
bulk_stab_010_av = sum(bulk_stab_010_weighted(10:20))./sum(cos(yi(55:65).*pi./180));
bulk_stab_025_av = sum(bulk_stab_025_weighted(10:20))./sum(cos(yi(55:65).*pi./180));
bulk_stab_050_av = sum(bulk_stab_050_weighted(10:20))./sum(cos(yi(55:65).*pi./180));
bulk_stab_075_av = sum(bulk_stab_075_weighted(10:20))./sum(cos(yi(55:65).*pi./180));
bulk_stab_100_av = sum(bulk_stab_100_weighted(10:20))./sum(cos(yi(55:65).*pi./180));
bulk_stab_125_av = sum(bulk_stab_125_weighted(10:20))./sum(cos(yi(55:65).*pi./180));
bulk_stab_150_av = sum(bulk_stab_150_weighted(10:20))./sum(cos(yi(55:65).*pi./180));

cell_height_000_av = sum(cell_height_000_weighted(10:20))./sum(cos(yi(55:65).*pi./180));
cell_height_010_av = sum(cell_height_010_weighted(10:20))./sum(cos(yi(55:65).*pi./180));
cell_height_025_av = sum(cell_height_025_weighted(10:20))./sum(cos(yi(55:65).*pi./180));
cell_height_050_av = sum(cell_height_050_weighted(10:20))./sum(cos(yi(55:65).*pi./180));
cell_height_075_av = sum(cell_height_075_weighted(10:20))./sum(cos(yi(55:65).*pi./180));
cell_height_100_av = sum(cell_height_100_weighted(10:20))./sum(cos(yi(55:65).*pi./180));
cell_height_125_av = sum(cell_height_125_weighted(10:20))./sum(cos(yi(55:65).*pi./180));
cell_height_150_av = sum(cell_height_150_weighted(10:20))./sum(cos(yi(55:65).*pi./180));

phi_h_000 = (bulk_stab_000_av .* cell_height_000_av).^(0.25);
phi_h_010 = (bulk_stab_010_av .* cell_height_010_av).^(0.25);
phi_h_025 = (bulk_stab_025_av .* cell_height_025_av).^(0.25);
phi_h_050 = (bulk_stab_050_av .* cell_height_050_av).^(0.25);
phi_h_075 = (bulk_stab_075_av .* cell_height_075_av).^(0.25);
phi_h_100 = (bulk_stab_100_av .* cell_height_100_av).^(0.25);
phi_h_125 = (bulk_stab_125_av .* cell_height_125_av).^(0.25);
phi_h_150 = (bulk_stab_150_av .* cell_height_150_av).^(0.25);

save('/project/rg312/mat_files/chapter2_variables/cell_ext_H.mat', 'phi_h_000', 'phi_h_010', 'phi_h_025', 'phi_h_050', 'phi_h_075', 'phi_h_100', 'phi_h_125', 'phi_h_150')