%load in fields so can calculate rossby radius with lat. Need buoyancy freq, tropopause height, f
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

load('/project/rg312/mat_files/trop_levs_final_th.mat')
load('/project/rg312/mat_files/trop_levs_final_z.mat')

Ra = 287.04;
g= 9.81;
omega = 2.*pi./24./60./60;
yi = -89:2:90;
radius=6371.0e3;




convthetatoT=(rC/100000.0).^(2./7.);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_000.mat','theta_tav');
theta_tav=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_000_zav(:,:) = mean(theta_tav,1);
for k=1:size(rC)
t_000_zav(:,k)=theta_000_zav(:,k).*convthetatoT(k,1);
end

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_010.mat','theta_tav');
theta_tav=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_010_zav(:,:) = mean(theta_tav,1);
for k=1:size(rC)
t_010_zav(:,k)=theta_010_zav(:,k).*convthetatoT(k,1);
end

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_025.mat','theta_tav');
theta_tav=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_025_zav(:,:) = mean(theta_tav,1);
for k=1:size(rC)
t_025_zav(:,k)=theta_025_zav(:,k).*convthetatoT(k,1);
end

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_050.mat','theta_tav');
theta_tav=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_050_zav(:,:) = mean(theta_tav,1);
for k=1:size(rC)
t_050_zav(:,k)=theta_050_zav(:,k).*convthetatoT(k,1);
end

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_050_tropheat.mat','theta_tav');
theta_tav=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_th_zav(:,:) = mean(theta_tav,1);
for k=1:size(rC)
t_th_zav(:,k)=theta_th_zav(:,k).*convthetatoT(k,1);
end

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_075.mat','theta_tav');
theta_tav=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_075_zav(:,:) = mean(theta_tav,1);
for k=1:size(rC)
t_075_zav(:,k)=theta_075_zav(:,k).*convthetatoT(k,1);
end

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_100.mat','theta_tav');
theta_tav=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_100_zav(:,:) = mean(theta_tav,1);
for k=1:size(rC)
t_100_zav(:,k)=theta_100_zav(:,k).*convthetatoT(k,1);
end

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_125.mat','theta_tav');
theta_tav=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_125_zav(:,:) = mean(theta_tav,1);
for k=1:size(rC)
t_125_zav(:,k)=theta_125_zav(:,k).*convthetatoT(k,1);
end

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_150.mat','theta_tav');
theta_tav=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_150_zav(:,:) = mean(theta_tav,1);
for k=1:size(rC)
t_150_zav(:,k)=theta_150_zav(:,k).*convthetatoT(k,1);
end





for i=1:25
rho_000(:,i) = rC(i)./Ra./t_000_zav(:,i);
rho_010(:,i) = rC(i)./Ra./t_010_zav(:,i);
rho_025(:,i) = rC(i)./Ra./t_025_zav(:,i);
rho_050(:,i) = rC(i)./Ra./t_050_zav(:,i);
rho_th(:,i) = rC(i)./Ra./t_th_zav(:,i);
rho_075(:,i) = rC(i)./Ra./t_075_zav(:,i);
rho_100(:,i) = rC(i)./Ra./t_100_zav(:,i);
rho_125(:,i) = rC(i)./Ra./t_125_zav(:,i);
rho_150(:,i) = rC(i)./Ra./t_150_zav(:,i);
end

[dthetadp_000,a] = gradient(theta_000_zav,-4000);
[dthetadp_010,a] = gradient(theta_010_zav,-4000);
[dthetadp_025,a] = gradient(theta_025_zav,-4000);
[dthetadp_050,a] = gradient(theta_050_zav,-4000);
[dthetadp_th,a] = gradient(theta_th_zav,-4000);
[dthetadp_075,a] = gradient(theta_075_zav,-4000);
[dthetadp_100,a] = gradient(theta_100_zav,-4000);
[dthetadp_125,a] = gradient(theta_125_zav,-4000);
[dthetadp_150,a] = gradient(theta_150_zav,-4000);

Nsq_000 = - g.^2 .* rho_000 .* dthetadp_000 ./theta_000_zav;
Nsq_010 = - g.^2 .* rho_010 .* dthetadp_010 ./theta_010_zav;
Nsq_025 = - g.^2 .* rho_025 .* dthetadp_025 ./theta_025_zav;
Nsq_050 = - g.^2 .* rho_050 .* dthetadp_050 ./theta_050_zav;
Nsq_th = - g.^2 .* rho_th .* dthetadp_th ./theta_th_zav;
Nsq_075 = - g.^2 .* rho_075 .* dthetadp_075 ./theta_075_zav;
Nsq_100 = - g.^2 .* rho_100 .* dthetadp_100 ./theta_100_zav;
Nsq_125 = - g.^2 .* rho_125 .* dthetadp_125 ./theta_125_zav;
Nsq_150 = - g.^2 .* rho_150 .* dthetadp_150 ./theta_150_zav;

N_000 = sqrt(Nsq_000);
N_010 = sqrt(Nsq_010);
N_025 = sqrt(Nsq_025);
N_050 = sqrt(Nsq_050);
N_th = sqrt(Nsq_th);
N_075 = sqrt(Nsq_075);
N_100 = sqrt(Nsq_100);
N_125 = sqrt(Nsq_125);
N_150 = sqrt(Nsq_150);




N_mean_000 = zeros(1,90);
N_mean_010 = zeros(1,90);
N_mean_025 = zeros(1,90);
N_mean_050 = zeros(1,90);
N_mean_th = zeros(1,90);
N_mean_075 = zeros(1,90);
N_mean_100 = zeros(1,90);
N_mean_125 = zeros(1,90);
N_mean_150 = zeros(1,90);

f = abs(2.*omega.*sin(yi.*pi./180));

for i=1:90
for j=1:25
  N_mask_000(i,j) = +isreal(N_000(i,j));
  if N_mask_000(i,j) < 1
   N_mask_000(i,j) = NaN;
  end
  N_mask_010(i,j) = +isreal(N_010(i,j));
  if N_mask_010(i,j) < 1
   N_mask_010(i,j) = NaN;
  end
  N_mask_025(i,j) = +isreal(N_025(i,j));
  if N_mask_025(i,j) < 1
   N_mask_025(i,j) = NaN;
  end
  N_mask_050(i,j) = +isreal(N_050(i,j));
  if N_mask_050(i,j) < 1
   N_mask_050(i,j) = NaN;
  end
  N_mask_th(i,j) = +isreal(N_th(i,j));
  if N_mask_th(i,j) < 1
   N_mask_th(i,j) = NaN;
  end
  N_mask_075(i,j) = +isreal(N_075(i,j));
  if N_mask_075(i,j) < 1
   N_mask_075(i,j) = NaN;
  end
  N_mask_100(i,j) = +isreal(N_100(i,j));
  if N_mask_100(i,j) < 1
   N_mask_100(i,j) = NaN;
  end
  N_mask_125(i,j) = +isreal(N_125(i,j));
  if N_mask_125(i,j) < 1
   N_mask_125(i,j) = NaN;
  end
  N_mask_150(i,j) = +isreal(N_150(i,j));
  if N_mask_150(i,j) < 1
   N_mask_150(i,j) = NaN;
  end
end
end


for i=2:89
N_mean_000(i) = nanmean( N_mask_000(i,1:trop_lev_000(i)).*N_000(i,1:trop_lev_000(i)) );
N_mean_010(i) = nanmean( N_mask_010(i,1:trop_lev_010(i)).*N_010(i,1:trop_lev_010(i)) );
N_mean_025(i) = nanmean( N_mask_025(i,1:trop_lev_025(i)).*N_025(i,1:trop_lev_025(i)) );
N_mean_050(i) = nanmean( N_mask_050(i,1:trop_lev_050(i)).*N_050(i,1:trop_lev_050(i)) );
N_mean_th(i) = nanmean( N_mask_th(i,1:trop_lev_th(i)).*N_th(i,1:trop_lev_th(i)) );
N_mean_075(i) = nanmean( N_mask_075(i,1:trop_lev_075(i)).*N_075(i,1:trop_lev_075(i)) );
N_mean_100(i) = nanmean( N_mask_100(i,1:trop_lev_100(i)).*N_100(i,1:trop_lev_100(i)) );
N_mean_125(i) = nanmean( N_mask_125(i,1:trop_lev_125(i)).*N_125(i,1:trop_lev_125(i)) );
N_mean_150(i) = nanmean( N_mask_150(i,1:trop_lev_150(i)).*N_150(i,1:trop_lev_150(i)) );
end

ld_000 = 2.*pi.*N_mean_000.*trop_z_000./f;
ld_010 = 2.*pi.*N_mean_010.*trop_z_010./f;
ld_025 = 2.*pi.*N_mean_025.*trop_z_025./f;
ld_050 = 2.*pi.*N_mean_050.*trop_z_050./f;
ld_th = 2.*pi.*N_mean_th.*trop_z_th./f;
ld_075 = 2.*pi.*N_mean_075.*trop_z_075./f;
ld_100 = 2.*pi.*N_mean_100.*trop_z_100./f;
ld_125 = 2.*pi.*N_mean_125.*trop_z_125./f;
ld_150 = 2.*pi.*N_mean_125.*trop_z_150./f;

ls_000 = 2.*pi.*N_mean_000.*8000./f;
ls_010 = 2.*pi.*N_mean_010.*8000./f;
ls_025 = 2.*pi.*N_mean_025.*8000./f;
ls_050 = 2.*pi.*N_mean_050.*8000./f;
ls_th = 2.*pi.*N_mean_th.*8000./f;
ls_075 = 2.*pi.*N_mean_075.*8000./f;
ls_100 = 2.*pi.*N_mean_100.*8000./f;
ls_125 = 2.*pi.*N_mean_125.*8000./f;
ls_150 = 2.*pi.*N_mean_150.*8000./f;


points=180;
wavenos = [0:points-1]./points.*180;


kd_000 = 2.*pi.*radius.*cos(yi.*pi./180)./ld_000;
kd_010 = 2.*pi.*radius.*cos(yi.*pi./180)./ld_010;
kd_025 = 2.*pi.*radius.*cos(yi.*pi./180)./ld_025;
kd_050 = 2.*pi.*radius.*cos(yi.*pi./180)./ld_050;
kd_th = 2.*pi.*radius.*cos(yi.*pi./180)./ld_th;
kd_075 = 2.*pi.*radius.*cos(yi.*pi./180)./ld_075;
kd_100 = 2.*pi.*radius.*cos(yi.*pi./180)./ld_100;
kd_125 = 2.*pi.*radius.*cos(yi.*pi./180)./ld_125;
kd_150 = 2.*pi.*radius.*cos(yi.*pi./180)./ld_150;

ks_000 = 2.*pi.*radius.*cos(yi.*pi./180)./ls_000;
ks_010 = 2.*pi.*radius.*cos(yi.*pi./180)./ls_010;
ks_025 = 2.*pi.*radius.*cos(yi.*pi./180)./ls_025;
ks_050 = 2.*pi.*radius.*cos(yi.*pi./180)./ls_050;
ks_th = 2.*pi.*radius.*cos(yi.*pi./180)./ls_th;
ks_075 = 2.*pi.*radius.*cos(yi.*pi./180)./ls_075;
ks_100 = 2.*pi.*radius.*cos(yi.*pi./180)./ls_100;
ks_125 = 2.*pi.*radius.*cos(yi.*pi./180)./ls_125;
ks_150 = 2.*pi.*radius.*cos(yi.*pi./180)./ls_150;

save('/project/rg312/mat_files/chapter2_variables/rossby_scale.mat', 'kd_000', 'kd_010', 'kd_025', 'kd_050', 'kd_th', 'kd_075', 'kd_100', 'kd_125', 'kd_150', 'ks_000', 'ks_010', 'ks_025', 'ks_050', 'ks_th', 'ks_075', 'ks_100', 'ks_125', 'ks_150')
