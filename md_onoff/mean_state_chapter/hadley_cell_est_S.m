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
rad=6371.0e3;				%radius of earth


%HH needs cell height, vert av change in rad eq pot temp
%H needs cell height, bulk stability av 20-40 degrees
%S needs near surface stability, near surface pot temp gradient
%Soooo
%load in tropopause height, psi, potential temperature, LW fluxes

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


for i=1:44
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

teq_hzav_000 = t_hzav_000 + L./cp .* q_hzav_000;
teq_hzav_010 = t_hzav_010 + L./cp .* q_hzav_010;
teq_hzav_025 = t_hzav_025 + L./cp .* q_hzav_025;
teq_hzav_050 = t_hzav_050 + L./cp .* q_hzav_050;
teq_hzav_075 = t_hzav_075 + L./cp .* q_hzav_075;
teq_hzav_100 = t_hzav_100 + L./cp .* q_hzav_100;
teq_hzav_125 = t_hzav_125 + L./cp .* q_hzav_125;
teq_hzav_150 = t_hzav_150 + L./cp .* q_hzav_150;

for k=1:size(rC)
thetaeq_hzav_000(:,k)=teq_hzav_000(:,k)./convthetatoT(k,1);
thetaeq_hzav_010(:,k)=teq_hzav_010(:,k)./convthetatoT(k,1);
thetaeq_hzav_025(:,k)=teq_hzav_025(:,k)./convthetatoT(k,1);
thetaeq_hzav_050(:,k)=teq_hzav_050(:,k)./convthetatoT(k,1);
thetaeq_hzav_075(:,k)=teq_hzav_075(:,k)./convthetatoT(k,1);
thetaeq_hzav_100(:,k)=teq_hzav_100(:,k)./convthetatoT(k,1);
thetaeq_hzav_125(:,k)=teq_hzav_125(:,k)./convthetatoT(k,1);
thetaeq_hzav_150(:,k)=teq_hzav_150(:,k)./convthetatoT(k,1);
end

load('/project/rg312/mat_files/trop_levs_final.mat');
for i=1:44
trop_press_000(i) = rC(trop_lev_000(45+i));
trop_press_010(i) = rC(trop_lev_010(45+i));
trop_press_025(i) = rC(trop_lev_025(45+i));
trop_press_050(i) = rC(trop_lev_050(45+i));
trop_press_075(i) = rC(trop_lev_075(45+i));
trop_press_100(i) = rC(trop_lev_100(45+i));
trop_press_125(i) = rC(trop_lev_125(45+i));
trop_press_150(i) = rC(trop_lev_150(45+i));
end

%now lets try Schneiders way! Need near surface theta gradients (dp and dy), f, beta

f = 2.*omega.*sin(yi.*pi./180);
beta = 2.*omega.*cos(yi.*pi./180)./rad;

[dthetadp_000, dthetady_000] = gradient(theta_hzav_000,-4000,pi./90);
[dthetaeqdp_000, dthetaeqdy_000] = gradient(thetaeq_hzav_000,-4000,pi./90);
dthetady_000 = dthetady_000./rad;
dthetaeqdy_000 = dthetaeqdy_000./rad;
for i=1:25
delta_v_000(:,i) = -2.* dthetadp_000(:,i).*(98000 - trop_press_000)';
Sc_000(:,i) = -f(46:89)'./ beta(46:89)' .*dthetady_000(:,i) ./ delta_v_000(:,i);
delta_veq_000(:,i) = -2.* dthetaeqdp_000(:,i).*(98000 - trop_press_000)';
Sceq_000(:,i) = -f(46:89)'./ beta(46:89)' .*dthetaeqdy_000(:,i) ./ delta_veq_000(:,i);
end
phi_s_000 = yi(45 + min(find(Sc_000(:,1)>=1)));
phi_seq_000 = yi(45 + min(find(Sceq_000(:,1)>=1)));

[dthetadp_010, dthetady_010] = gradient(theta_hzav_010,-4000,pi./90);
[dthetaeqdp_010, dthetaeqdy_010] = gradient(thetaeq_hzav_010,-4000,pi./90);
dthetady_010 = dthetady_010./rad;
dthetaeqdy_010 = dthetaeqdy_010./rad;
for i=1:25
delta_v_010(:,i) = -2.* dthetadp_010(:,i).*(98000 - trop_press_010)';
Sc_010(:,i) = -f(46:89)'./ beta(46:89)' .*dthetady_010(:,i) ./ delta_v_010(:,i);
delta_veq_010(:,i) = -2.* dthetaeqdp_010(:,i).*(98000 - trop_press_010)';
Sceq_010(:,i) = -f(46:89)'./ beta(46:89)' .*dthetaeqdy_010(:,i) ./ delta_veq_010(:,i);
end
phi_s_010 = yi(45 + min(find(Sc_010(:,1)>=1)));
phi_seq_010 = yi(45 + min(find(Sceq_010(:,1)>=1)));

[dthetadp_025, dthetady_025] = gradient(theta_hzav_025,-4000,pi./90);
[dthetaeqdp_025, dthetaeqdy_025] = gradient(thetaeq_hzav_025,-4000,pi./90);
dthetady_025 = dthetady_025./rad;
dthetaeqdy_025 = dthetaeqdy_025./rad;
for i=1:25
delta_v_025(:,i) = -2.* dthetadp_025(:,i).*(98000 - trop_press_025)';
Sc_025(:,i) = -f(46:89)'./ beta(46:89)' .*dthetady_025(:,i) ./ delta_v_025(:,i);
delta_veq_025(:,i) = -2.* dthetaeqdp_025(:,i).*(98000 - trop_press_025)';
Sceq_025(:,i) = -f(46:89)'./ beta(46:89)' .*dthetaeqdy_025(:,i) ./ delta_veq_025(:,i);
end
phi_s_025 = yi(45 + min(find(Sc_025(:,1)>=1)));
phi_seq_025 = yi(45 + min(find(Sceq_025(:,1)>=1)));

[dthetadp_050, dthetady_050] = gradient(theta_hzav_050,-4000,pi./90);
[dthetaeqdp_050, dthetaeqdy_050] = gradient(thetaeq_hzav_050,-4000,pi./90);
dthetady_050 = dthetady_050./rad;
dthetaeqdy_050 = dthetaeqdy_050./rad;
for i=1:25
delta_v_050(:,i) = -2.* dthetadp_050(:,i).*(98000 - trop_press_050)';
Sc_050(:,i) = -f(46:89)'./ beta(46:89)' .*dthetady_050(:,i) ./ delta_v_050(:,i);
delta_veq_050(:,i) = -2.* dthetaeqdp_050(:,i).*(98000 - trop_press_050)';
Sceq_050(:,i) = -f(46:89)'./ beta(46:89)' .*dthetaeqdy_050(:,i) ./ delta_veq_050(:,i);
end
phi_s_050 = yi(45 + min(find(Sc_050(:,1)>=1)));
phi_seq_050 = yi(45 + min(find(Sceq_050(:,1)>=1)));

[dthetadp_075, dthetady_075] = gradient(theta_hzav_075,-4000,pi./90);
[dthetaeqdp_075, dthetaeqdy_075] = gradient(thetaeq_hzav_075,-4000,pi./90);
dthetady_075 = dthetady_075./rad;
dthetaeqdy_075 = dthetaeqdy_075./rad;
for i=1:25
delta_v_075(:,i) = -2.* dthetadp_075(:,i).*(98000 - trop_press_075)';
Sc_075(:,i) = -f(46:89)'./ beta(46:89)' .*dthetady_075(:,i) ./ delta_v_075(:,i);
delta_veq_075(:,i) = -2.* dthetaeqdp_075(:,i).*(98000 - trop_press_075)';
Sceq_075(:,i) = -f(46:89)'./ beta(46:89)' .*dthetaeqdy_075(:,i) ./ delta_veq_075(:,i);
end
phi_s_075 = yi(45 + min(find(Sc_075(:,1)>=1)));
phi_seq_075 = yi(45 + min(find(Sceq_075(:,1)>=1)));

[dthetadp_100, dthetady_100] = gradient(theta_hzav_100,-4000,pi./90);
[dthetaeqdp_100, dthetaeqdy_100] = gradient(thetaeq_hzav_100,-4000,pi./90);
dthetady_100 = dthetady_100./rad;
dthetaeqdy_100 = dthetaeqdy_100./rad;
for i=1:25
delta_v_100(:,i) = -2.* dthetadp_100(:,i).*(98000 - trop_press_100)';
Sc_100(:,i) = -f(46:89)'./ beta(46:89)' .*dthetady_100(:,i) ./ delta_v_100(:,i);
delta_veq_100(:,i) = -2.* dthetaeqdp_100(:,i).*(98000 - trop_press_100)';
Sceq_100(:,i) = -f(46:89)'./ beta(46:89)' .*dthetaeqdy_100(:,i) ./ delta_veq_100(:,i);
end
phi_s_100 = yi(45 + min(find(Sc_100(:,1)>=1)));
phi_seq_100 = yi(45 + min(find(Sceq_100(:,1)>=1)));

[dthetadp_125, dthetady_125] = gradient(theta_hzav_125,-4000,pi./90);
[dthetaeqdp_125, dthetaeqdy_125] = gradient(thetaeq_hzav_125,-4000,pi./90);
dthetady_125 = dthetady_125./rad;
dthetaeqdy_125 = dthetaeqdy_125./rad;
for i=1:25
delta_v_125(:,i) = -2.* dthetadp_125(:,i).*(98000 - trop_press_125)';
Sc_125(:,i) = -f(46:89)'./ beta(46:89)' .*dthetady_125(:,i) ./ delta_v_125(:,i);
delta_veq_125(:,i) = -2.* dthetaeqdp_125(:,i).*(98000 - trop_press_125)';
Sceq_125(:,i) = -f(46:89)'./ beta(46:89)' .*dthetaeqdy_125(:,i) ./ delta_veq_125(:,i);
end
phi_s_125 = yi(45 + min(find(Sc_125(:,1)>=1)));
phi_seq_125 = yi(45 + min(find(Sceq_125(:,1)>=1)));

[dthetadp_150, dthetady_150] = gradient(theta_hzav_150,-4000,pi./90);
[dthetaeqdp_150, dthetaeqdy_150] = gradient(thetaeq_hzav_150,-4000,pi./90);
dthetady_150 = dthetady_150./rad;
dthetaeqdy_150 = dthetaeqdy_150./rad;
for i=1:25
delta_v_150(:,i) = -2.* dthetadp_150(:,i).*(98000 - trop_press_150)';
Sc_150(:,i) = -f(46:89)'./ beta(46:89)' .*dthetady_150(:,i) ./ delta_v_150(:,i);
delta_veq_150(:,i) = -2.* dthetaeqdp_150(:,i).*(98000 - trop_press_150)';
Sceq_150(:,i) = -f(46:89)'./ beta(46:89)' .*dthetaeqdy_150(:,i) ./ delta_veq_150(:,i);
end
phi_s_150 = yi(45 + min(find(Sc_150(:,1)>=1)));
phi_seq_150 = yi(45 + min(find(Sceq_150(:,1)>=1)));



save('/project/rg312/mat_files/chapter2_variables/cell_ext_S.mat', 'phi_s_000', 'phi_s_010', 'phi_s_025', 'phi_s_050', 'phi_s_075', 'phi_s_100', 'phi_s_125', 'phi_s_150', 'phi_seq_000', 'phi_seq_010', 'phi_seq_025', 'phi_seq_050', 'phi_seq_075', 'phi_seq_100', 'phi_seq_125', 'phi_seq_150')