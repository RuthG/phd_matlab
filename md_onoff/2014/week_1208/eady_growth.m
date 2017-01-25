%plot up eady growth rate

%need vertical theta and u gradients.


%Read in iteration number, directory, MITgcm output and grid details

rDir='/project/rg312/wv_on_rad_off/run_doshallower10/';
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

load('/project/rg312/mat_files/snapshot_data/uE_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/theta_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat')


%transfer t to ll
xi=-179:2:180;yi=-89:2:90;
t_000_ll = cube2latlon(xc,yc,t_000,xi,yi);
t_010_ll = cube2latlon(xc,yc,t_010,xi,yi);
t_025_ll = cube2latlon(xc,yc,t_025,xi,yi);
t_050_ll = cube2latlon(xc,yc,t_050,xi,yi);
t_075_ll = cube2latlon(xc,yc,t_075,xi,yi);
t_100_ll = cube2latlon(xc,yc,t_100,xi,yi);

theta_000_ll = cube2latlon(xc,yc,theta_000,xi,yi);
theta_010_ll = cube2latlon(xc,yc,theta_010,xi,yi);
theta_025_ll = cube2latlon(xc,yc,theta_025,xi,yi);
theta_050_ll = cube2latlon(xc,yc,theta_050,xi,yi);
theta_075_ll = cube2latlon(xc,yc,theta_075,xi,yi);
theta_100_ll = cube2latlon(xc,yc,theta_100,xi,yi);

uE_000_ll = cube2latlon(xc,yc,uE_000,xi,yi);
uE_010_ll = cube2latlon(xc,yc,uE_010,xi,yi);
uE_025_ll = cube2latlon(xc,yc,uE_025,xi,yi);
uE_050_ll = cube2latlon(xc,yc,uE_050,xi,yi);
uE_075_ll = cube2latlon(xc,yc,uE_075,xi,yi);
uE_100_ll = cube2latlon(xc,yc,uE_100,xi,yi);


Ra = 287.04;
g= 9.81;
omega = 2.*pi./24./60./60;

for i=1:25
rho_000(:,:,i,:) = rC(i)./Ra./t_000_ll(:,:,i,:);
rho_010(:,:,i,:) = rC(i)./Ra./t_010_ll(:,:,i,:);
rho_025(:,:,i,:) = rC(i)./Ra./t_025_ll(:,:,i,:);
rho_050(:,:,i,:) = rC(i)./Ra./t_050_ll(:,:,i,:);
rho_075(:,:,i,:) = rC(i)./Ra./t_075_ll(:,:,i,:);
rho_100(:,:,i,:) = rC(i)./Ra./t_100_ll(:,:,i,:);
end

[a,b,dthetadp_000,d] = gradient(theta_000_ll,-4000);
[a,b,dthetadp_010,d] = gradient(theta_010_ll,-4000);
[a,b,dthetadp_025,d] = gradient(theta_025_ll,-4000);
[a,b,dthetadp_050,d] = gradient(theta_050_ll,-4000);
[a,b,dthetadp_075,d] = gradient(theta_075_ll,-4000);
[a,b,dthetadp_100,d] = gradient(theta_100_ll,-4000);

[a,b,dudp_000,d] = gradient(uE_000_ll,-4000);
[a,b,dudp_010,d] = gradient(uE_010_ll,-4000);
[a,b,dudp_025,d] = gradient(uE_025_ll,-4000);
[a,b,dudp_050,d] = gradient(uE_050_ll,-4000);
[a,b,dudp_075,d] = gradient(uE_075_ll,-4000);
[a,b,dudp_100,d] = gradient(uE_100_ll,-4000);

dudz_000 = -g.*rho_000.*dudp_000;
dudz_010 = -g.*rho_010.*dudp_010;
dudz_025 = -g.*rho_025.*dudp_025;
dudz_050 = -g.*rho_050.*dudp_050;
dudz_075 = -g.*rho_075.*dudp_075;
dudz_100 = -g.*rho_100.*dudp_100;

Nsq_000 = - g.^2 .* rho_000 .* dthetadp_000 ./theta_000_ll;
Nsq_010 = - g.^2 .* rho_010 .* dthetadp_010 ./theta_010_ll;
Nsq_025 = - g.^2 .* rho_025 .* dthetadp_025 ./theta_025_ll;
Nsq_050 = - g.^2 .* rho_050 .* dthetadp_050 ./theta_050_ll;
Nsq_075 = - g.^2 .* rho_075 .* dthetadp_075 ./theta_075_ll;
Nsq_100 = - g.^2 .* rho_100 .* dthetadp_100 ./theta_100_ll;


return

f = zeros(90,25);
for i=1:25
f(:,i) = 2.*omega.*sin(yi.*pi./180);
end

eady_w = 0.31.*f./sqrt(Nsq_w) .*dudz_w; 
eady_h = 0.31.*f./sqrt(Nsq_h) .*dudz_h; 
eady_q = 0.31.*f./sqrt(Nsq_q) .*dudz_q; 
eady_d = 0.31.*f./sqrt(Nsq_d) .*dudz_d; 

%Brayshaw averages through trop: 925-250 and near surf: 925-775
%use 900-260 and 900-780 = 3-19 3-6

eady_w_full = mean(eady_w(:,3:19),2);
eady_h_full = mean(eady_h(:,3:19),2);
eady_q_full = mean(eady_q(:,3:19),2);
eady_d_full = mean(eady_d(:,3:19),2);

eady_w_low = mean(eady_w(:,3:6),2);
eady_h_low = mean(eady_h(:,3:6),2);
eady_q_low = mean(eady_q(:,3:6),2);
eady_d_low = mean(eady_d(:,3:6),2);


