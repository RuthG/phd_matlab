%load in fields so can calculate rossby radius with lat. Need buoyancy freq, tropopause height, f

load('/project/rg312/mat_files/climatology_vars.mat')
load('/project/rg312/mat_files/climatology_vars_th.mat')
load('/project/rg312/mat_files/toulouse_poster/fft_poster.mat')

Ra = 287.04;
g= 9.81;
omega = 2.*pi./24./60./60;
yi = -89:2:90;
radius=6371.0e3;

for i=1:25
rho_000(:,i) = rC(i)./Ra./t_000_zav(:,i);
rho_010(:,i) = rC(i)./Ra./t_010_zav(:,i);
rho_025(:,i) = rC(i)./Ra./t_025_zav(:,i);
rho_050(:,i) = rC(i)./Ra./t_050_zav(:,i);
rho_075(:,i) = rC(i)./Ra./t_075_zav(:,i);
rho_100(:,i) = rC(i)./Ra./t_100_zav(:,i);
rho_th(:,i) = rC(i)./Ra./t_th_zav(:,i);
end

[dthetadp_000,a] = gradient(theta_000_zav,-4000);
[dthetadp_010,a] = gradient(theta_010_zav,-4000);
[dthetadp_025,a] = gradient(theta_025_zav,-4000);
[dthetadp_050,a] = gradient(theta_050_zav,-4000);
[dthetadp_075,a] = gradient(theta_075_zav,-4000);
[dthetadp_100,a] = gradient(theta_100_zav,-4000);
[dthetadp_th,a] = gradient(theta_th_zav,-4000);

[dtdp_000,a] = gradient(t_000_zav,-4000);
[dtdp_010,a] = gradient(t_010_zav,-4000);
[dtdp_025,a] = gradient(t_025_zav,-4000);
[dtdp_050,a] = gradient(t_050_zav,-4000);
[dtdp_075,a] = gradient(t_075_zav,-4000);
[dtdp_100,a] = gradient(t_100_zav,-4000);
[dtdp_th,a] = gradient(t_th_zav,-4000);

[dudp_000,a] = gradient(uE_000_zav,-4000);
[dudp_010,a] = gradient(uE_010_zav,-4000);
[dudp_025,a] = gradient(uE_025_zav,-4000);
[dudp_050,a] = gradient(uE_050_zav,-4000);
[dudp_075,a] = gradient(uE_075_zav,-4000);
[dudp_100,a] = gradient(uE_100_zav,-4000);
[dudp_th,a] = gradient(uE_th_zav,-4000);

dudz_000 = -g.*rho_000.*dudp_000;
dudz_010 = -g.*rho_010.*dudp_010;
dudz_025 = -g.*rho_025.*dudp_025;
dudz_050 = -g.*rho_050.*dudp_050;
dudz_075 = -g.*rho_075.*dudp_075;
dudz_100 = -g.*rho_100.*dudp_100;
dudz_th = -g.*rho_th.*dudp_th;

dtdz_000 = -g.*rho_000.*dtdp_000.*1000;
dtdz_010 = -g.*rho_010.*dtdp_010.*1000;
dtdz_025 = -g.*rho_025.*dtdp_025.*1000;
dtdz_050 = -g.*rho_050.*dtdp_050.*1000;
dtdz_075 = -g.*rho_075.*dtdp_075.*1000;
dtdz_100 = -g.*rho_100.*dtdp_100.*1000;
dtdz_th = -g.*rho_th.*dtdp_th.*1000;

Nsq_000 = - g.^2 .* rho_000 .* dthetadp_000 ./theta_000_zav;
Nsq_010 = - g.^2 .* rho_010 .* dthetadp_010 ./theta_010_zav;
Nsq_025 = - g.^2 .* rho_025 .* dthetadp_025 ./theta_025_zav;
Nsq_050 = - g.^2 .* rho_050 .* dthetadp_050 ./theta_050_zav;
Nsq_075 = - g.^2 .* rho_075 .* dthetadp_075 ./theta_075_zav;
Nsq_100 = - g.^2 .* rho_100 .* dthetadp_100 ./theta_100_zav;
Nsq_th = - g.^2 .* rho_th .* dthetadp_th ./theta_th_zav;

N_000 = sqrt(Nsq_000);
N_010 = sqrt(Nsq_010);
N_025 = sqrt(Nsq_025);
N_050 = sqrt(Nsq_050);
N_075 = sqrt(Nsq_075);
N_100 = sqrt(Nsq_100);
N_th = sqrt(Nsq_th);

trop_000 = zeros(1,90);
trop_010 = zeros(1,90);
trop_025 = zeros(1,90);
trop_050 = zeros(1,90);
trop_075 = zeros(1,90);
trop_100 = zeros(1,90);
trop_th = zeros(1,90);
z_000 = zeros(90,25);
z_010 = zeros(90,25);
z_025 = zeros(90,25);
z_050 = zeros(90,25);
z_075 = zeros(90,25);
z_100 = zeros(90,25);
z_th = zeros(90,25);
N_mean_000 = zeros(1,90);
N_mean_010 = zeros(1,90);
N_mean_025 = zeros(1,90);
N_mean_050 = zeros(1,90);
N_mean_075 = zeros(1,90);
N_mean_100 = zeros(1,90);
N_mean_th = zeros(1,90);

for k=1:25
integrand_000(:,k) = Ra.*t_000_zav(:,k)./g./rC(k);
integrand_010(:,k) = Ra.*t_010_zav(:,k)./g./rC(k);
integrand_025(:,k) = Ra.*t_025_zav(:,k)./g./rC(k);
integrand_050(:,k) = Ra.*t_050_zav(:,k)./g./rC(k);
integrand_075(:,k) = Ra.*t_075_zav(:,k)./g./rC(k);
integrand_100(:,k) = Ra.*t_100_zav(:,k)./g./rC(k);
integrand_th(:,k) = Ra.*t_th_zav(:,k)./g./rC(k);
end

height_000(:,2:26) = cumsum(integrand_000,2).*4000;
height_010(:,2:26) = cumsum(integrand_010,2).*4000;
height_025(:,2:26) = cumsum(integrand_025,2).*4000;
height_050(:,2:26) = cumsum(integrand_050,2).*4000;
height_075(:,2:26) = cumsum(integrand_075,2).*4000;
height_100(:,2:26) = cumsum(integrand_100,2).*4000;
height_th(:,2:26) = cumsum(integrand_th,2).*4000;

rC_half = 100000:-4000:0;
z_000(2:89,:) = shiftdim(interp1(rC_half,height_000(2:89,:)',rC,'cubic','extrap'),1);
z_010(2:89,:) = shiftdim(interp1(rC_half,height_010(2:89,:)',rC,'cubic','extrap'),1);
z_025(2:89,:) = shiftdim(interp1(rC_half,height_025(2:89,:)',rC,'cubic','extrap'),1);
z_050(2:89,:) = shiftdim(interp1(rC_half,height_050(2:89,:)',rC,'cubic','extrap'),1);
z_075(2:89,:) = shiftdim(interp1(rC_half,height_075(2:89,:)',rC,'cubic','extrap'),1);
z_100(2:89,:) = shiftdim(interp1(rC_half,height_100(2:89,:)',rC,'cubic','extrap'),1);
z_th(2:89,:) = shiftdim(interp1(rC_half,height_th(2:89,:)',rC,'cubic','extrap'),1);

for i=2:89
trop_ind_000(i) = max(find(dtdz_000(i,:) <= -2));
trop_ind_010(i) = max(find(dtdz_010(i,:) <= -2));
trop_ind_025(i) = max(find(dtdz_025(i,:) <= -2));
trop_ind_050(i) = max(find(dtdz_050(i,:) <= -2));
trop_ind_075(i) = max(find(dtdz_075(i,:) <= -2));
trop_ind_100(i) = max(find(dtdz_100(i,:) <= -2));
trop_ind_th(i) = max(find(dtdz_th(i,:) <= -2));
trop_000(i) = z_000(i,max(find(dtdz_000(i,:) <= -2)));
trop_010(i) = z_010(i,max(find(dtdz_010(i,:) <= -2)));
trop_025(i) = z_025(i,max(find(dtdz_025(i,:) <= -2)));
trop_050(i) = z_050(i,max(find(dtdz_050(i,:) <= -2)));
trop_075(i) = z_075(i,max(find(dtdz_075(i,:) <= -2)));
trop_100(i) = z_100(i,max(find(dtdz_100(i,:) <= -2)));
trop_th(i) = z_th(i,max(find(dtdz_th(i,:) <= -2)));
end

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
  N_mask_075(i,j) = +isreal(N_075(i,j));
  if N_mask_075(i,j) < 1
   N_mask_075(i,j) = NaN;
  end
  N_mask_100(i,j) = +isreal(N_100(i,j));
  if N_mask_100(i,j) < 1
   N_mask_100(i,j) = NaN;
  end
  N_mask_th(i,j) = +isreal(N_th(i,j));
  if N_mask_th(i,j) < 1
   N_mask_th(i,j) = NaN;
  end
end
end


for i=2:89
N_mean_000(i) = nanmean( N_mask_000(i,1:trop_ind_000(i)).*N_000(i,1:trop_ind_000(i)) );
N_mean_010(i) = nanmean( N_mask_010(i,1:trop_ind_010(i)).*N_010(i,1:trop_ind_010(i)) );
N_mean_025(i) = nanmean( N_mask_025(i,1:trop_ind_025(i)).*N_025(i,1:trop_ind_025(i)) );
N_mean_050(i) = nanmean( N_mask_050(i,1:trop_ind_050(i)).*N_050(i,1:trop_ind_050(i)) );
N_mean_075(i) = nanmean( N_mask_075(i,1:trop_ind_075(i)).*N_075(i,1:trop_ind_075(i)) );
N_mean_100(i) = nanmean( N_mask_100(i,1:trop_ind_100(i)).*N_100(i,1:trop_ind_100(i)) );
N_mean_th(i) = nanmean( N_mask_th(i,1:trop_ind_th(i)).*N_th(i,1:trop_ind_th(i)) );
end

ld_000 = 2.*pi.*N_mean_000.*trop_000./f;
ld_010 = 2.*pi.*N_mean_010.*trop_010./f;
ld_025 = 2.*pi.*N_mean_025.*trop_025./f;
ld_050 = 2.*pi.*N_mean_050.*trop_050./f;
ld_075 = 2.*pi.*N_mean_075.*trop_075./f;
ld_100 = 2.*pi.*N_mean_100.*trop_100./f;
ld_th = 2.*pi.*N_mean_th.*trop_th./f;

for i=1:90
ld_td_000(i,:) = 2.*pi.*N_000(i,:).*N_mask_000(i,:).*trop_000(i)./f(i);
ld_td_010(i,:) = 2.*pi.*N_010(i,:).*N_mask_010(i,:).*trop_010(i)./f(i);
ld_td_025(i,:) = 2.*pi.*N_025(i,:).*N_mask_025(i,:).*trop_025(i)./f(i);
ld_td_050(i,:) = 2.*pi.*N_050(i,:).*N_mask_050(i,:).*trop_050(i)./f(i);
ld_td_075(i,:) = 2.*pi.*N_075(i,:).*N_mask_075(i,:).*trop_075(i)./f(i);
ld_td_100(i,:) = 2.*pi.*N_100(i,:).*N_mask_100(i,:).*trop_100(i)./f(i);
ld_td_th(i,:) = 2.*pi.*N_th(i,:).*N_mask_th(i,:).*trop_th(i)./f(i);

kd_td_000(i,:) = 2.*pi.*radius.*cos(yi(i).*pi./180)./ld_td_000(i,:);
kd_td_010(i,:) = 2.*pi.*radius.*cos(yi(i).*pi./180)./ld_td_010(i,:);
kd_td_025(i,:) = 2.*pi.*radius.*cos(yi(i).*pi./180)./ld_td_025(i,:);
kd_td_050(i,:) = 2.*pi.*radius.*cos(yi(i).*pi./180)./ld_td_050(i,:);
kd_td_075(i,:) = 2.*pi.*radius.*cos(yi(i).*pi./180)./ld_td_075(i,:);
kd_td_100(i,:) = 2.*pi.*radius.*cos(yi(i).*pi./180)./ld_td_100(i,:);
kd_td_th(i,:) = 2.*pi.*radius.*cos(yi(i).*pi./180)./ld_td_th(i,:);

end

ls_000 = 2.*pi.*N_mean_000.*8000./f;
ls_010 = 2.*pi.*N_mean_010.*8000./f;
ls_025 = 2.*pi.*N_mean_025.*8000./f;
ls_050 = 2.*pi.*N_mean_050.*8000./f;
ls_075 = 2.*pi.*N_mean_075.*8000./f;
ls_100 = 2.*pi.*N_mean_100.*8000./f;
ls_th = 2.*pi.*N_mean_th.*8000./f;

ekdk_000 = sum(fftx_000_ss_hzav.^2,1);
ekdk_010 = sum(fftx_010_ss_hzav.^2,1);
ekdk_025 = sum(fftx_025_ss_hzav.^2,1);
ekdk_050 = sum(fftx_050_ss_hzav.^2,1);
ekdk_075 = sum(fftx_075_ss_hzav.^2,1);
ekdk_100 = sum(fftx_100_ss_hzav.^2,1);
ekdk_th = sum(fftx_th_ss_hzav.^2,1);

akdk_000 = sum(fftx_000_ss_hzav,1);
akdk_010 = sum(fftx_010_ss_hzav,1);
akdk_025 = sum(fftx_025_ss_hzav,1);
akdk_050 = sum(fftx_050_ss_hzav,1);
akdk_075 = sum(fftx_075_ss_hzav,1);
akdk_100 = sum(fftx_100_ss_hzav,1);
akdk_th = sum(fftx_th_ss_hzav,1);

points=180;
wavenos = [0:points-1]./points.*180;

for i=1:91

kek_000(i,:) = fftx_000_ss_hzav(i,:).^2.*wavenos(i);
kek_010(i,:) = fftx_010_ss_hzav(i,:).^2.*wavenos(i);
kek_025(i,:) = fftx_025_ss_hzav(i,:).^2.*wavenos(i);
kek_050(i,:) = fftx_050_ss_hzav(i,:).^2.*wavenos(i);
kek_075(i,:) = fftx_075_ss_hzav(i,:).^2.*wavenos(i);
kek_100(i,:) = fftx_100_ss_hzav(i,:).^2.*wavenos(i);
kek_th(i,:) = fftx_th_ss_hzav(i,:).^2.*wavenos(i);

kak_000(i,:) = fftx_000_ss_hzav(i,:).*wavenos(i);
kak_010(i,:) = fftx_010_ss_hzav(i,:).*wavenos(i);
kak_025(i,:) = fftx_025_ss_hzav(i,:).*wavenos(i);
kak_050(i,:) = fftx_050_ss_hzav(i,:).*wavenos(i);
kak_075(i,:) = fftx_075_ss_hzav(i,:).*wavenos(i);
kak_100(i,:) = fftx_100_ss_hzav(i,:).*wavenos(i);
kak_th(i,:) = fftx_th_ss_hzav(i,:).*wavenos(i);


end

kekdk_000 = sum(kek_000,1);
kekdk_010 = sum(kek_010,1);
kekdk_025 = sum(kek_025,1);
kekdk_050 = sum(kek_050,1);
kekdk_075 = sum(kek_075,1);
kekdk_100 = sum(kek_100,1);
kekdk_th = sum(kek_th,1);

kakdk_000 = sum(kak_000,1);
kakdk_010 = sum(kak_010,1);
kakdk_025 = sum(kak_025,1);
kakdk_050 = sum(kak_050,1);
kakdk_075 = sum(kak_075,1);
kakdk_100 = sum(kak_100,1);
kakdk_th = sum(kak_th,1);

k_av_000 = kekdk_000./ekdk_000;
k_av_010 = kekdk_010./ekdk_010;
k_av_025 = kekdk_025./ekdk_025;
k_av_050 = kekdk_050./ekdk_050;
k_av_075 = kekdk_075./ekdk_075;
k_av_100 = kekdk_100./ekdk_100;
k_av_th = kekdk_th./ekdk_th;

ka_av_000 = kakdk_000./akdk_000;
ka_av_010 = kakdk_010./akdk_010;
ka_av_025 = kakdk_025./akdk_025;
ka_av_050 = kakdk_050./akdk_050;
ka_av_075 = kakdk_075./akdk_075;
ka_av_100 = kakdk_100./akdk_100;
ka_av_th = kakdk_th./akdk_th;

for i=1:45
[a,b] = max(fftx_000_ss_hzav(:,i));
k_mode_000(i) = wavenos(b);

[a,b] = max(fftx_010_ss_hzav(:,i));
k_mode_010(i) = wavenos(b);
[a,b] = max(fftx_025_ss_hzav(:,i));
k_mode_025(i) = wavenos(b);
[a,b] = max(fftx_050_ss_hzav(:,i));
k_mode_050(i) = wavenos(b);
[a,b] = max(fftx_075_ss_hzav(:,i));
k_mode_075(i) = wavenos(b);
[a,b] = max(fftx_100_ss_hzav(:,i));
k_mode_100(i) = wavenos(b);
[a,b] = max(fftx_th_ss_hzav(:,i));
k_mode_th(i) = wavenos(b);

end

lk_000 = 2.*pi.*radius.*cos(yi(46:90).*pi./180)./k_av_000;
lk_010 = 2.*pi.*radius.*cos(yi(46:90).*pi./180)./k_av_010;
lk_025 = 2.*pi.*radius.*cos(yi(46:90).*pi./180)./k_av_025;
lk_050 = 2.*pi.*radius.*cos(yi(46:90).*pi./180)./k_av_050;
lk_075 = 2.*pi.*radius.*cos(yi(46:90).*pi./180)./k_av_075;
lk_100 = 2.*pi.*radius.*cos(yi(46:90).*pi./180)./k_av_100;
lk_th = 2.*pi.*radius.*cos(yi(46:90).*pi./180)./k_av_th;


kd_000 = 2.*pi.*radius.*cos(yi.*pi./180)./ld_000;
kd_010 = 2.*pi.*radius.*cos(yi.*pi./180)./ld_010;
kd_025 = 2.*pi.*radius.*cos(yi.*pi./180)./ld_025;
kd_050 = 2.*pi.*radius.*cos(yi.*pi./180)./ld_050;
kd_075 = 2.*pi.*radius.*cos(yi.*pi./180)./ld_075;
kd_100 = 2.*pi.*radius.*cos(yi.*pi./180)./ld_100;
kd_th = 2.*pi.*radius.*cos(yi.*pi./180)./ld_th;

ks_000 = 2.*pi.*radius.*cos(yi.*pi./180)./ls_000;
ks_010 = 2.*pi.*radius.*cos(yi.*pi./180)./ls_010;
ks_025 = 2.*pi.*radius.*cos(yi.*pi./180)./ls_025;
ks_050 = 2.*pi.*radius.*cos(yi.*pi./180)./ls_050;
ks_075 = 2.*pi.*radius.*cos(yi.*pi./180)./ls_075;
ks_100 = 2.*pi.*radius.*cos(yi.*pi./180)./ls_100;
ks_th = 2.*pi.*radius.*cos(yi.*pi./180)./ls_th;

figure
plot(yi(46:90),k_av_000)
hold on
plot(yi(46:90),k_av_010,'g')
plot(yi(46:90),k_av_025,'r')
plot(yi(46:90),k_av_050,'m')
plot(yi(46:90),k_av_075,'c')
plot(yi(46:90),k_av_100,'k')
legend('0es0','0.1es0','0.25es0','0.5es0','0.75es0','1.0es0')
xlabel('Latitude')
ylabel('Wavenumber')
title('Mean Wavenumber')
print('-dpng','lamda_mean.png')


figure
plot(yi(46:90),ka_av_000)
hold on
plot(yi(46:90),ka_av_010,'g')
plot(yi(46:90),ka_av_025,'r')
plot(yi(46:90),ka_av_050,'m')
plot(yi(46:90),ka_av_075,'c')
plot(yi(46:90),ka_av_100,'k')
legend('0es0','0.1es0','0.25es0','0.5es0','0.75es0','1.0es0')
xlabel('Latitude')
ylabel('Wavenumber')
title('Mean Wavenumber')
print('-dpng','lamda_ampmean.png')


figure
plot(yi(46:90),k_mode_000)
hold on
plot(yi(46:90),k_mode_010,'g')
plot(yi(46:90),k_mode_025,'r')
plot(yi(46:90),k_mode_050,'m')
plot(yi(46:90),k_mode_075,'c')
plot(yi(46:90),k_mode_100,'k')
legend('0es0','0.1es0','0.25es0','0.5es0','0.75es0','1.0es0')
xlabel('Latitude')
ylabel('Wavenumber')
title('Mode Wavenumber')
print('-dpng','lamda_mode.png')


figure
plot(yi(46:90),kd_000(46:90))
hold on
plot(yi(46:90),kd_010(46:90),'g')
plot(yi(46:90),kd_025(46:90),'r')
plot(yi(46:90),kd_050(46:90),'m')
plot(yi(46:90),kd_075(46:90),'c')
plot(yi(46:90),kd_100(46:90),'k')
legend('0es0','0.1es0','0.25es0','0.5es0','0.75es0','1.0es0')
xlabel('Latitude')
ylabel('Wavenumber')
title('Rossby Wavenumber')
print('-dpng','lamda_rossby.png')


figure
plot(yi(46:90),ks_000(46:90))
hold on
plot(yi(46:90),ks_010(46:90),'g')
plot(yi(46:90),ks_025(46:90),'r')
plot(yi(46:90),ks_050(46:90),'m')
plot(yi(46:90),ks_075(46:90),'c')
plot(yi(46:90),ks_100(46:90),'k')
legend('0es0','0.1es0','0.25es0','0.5es0','0.75es0','1.0es0')
xlabel('Latitude')
ylabel('Wavenumber')
title('Rossby Wavenumber (scale height)')
print('-dpng','lamda_scale.png')




[a,b]=max(mean(uE_000_zav(46:90,:),2));
y_000 = yi(b+45);
[a,b]=max(mean(uE_010_zav(46:90,:),2));
y_010 = yi(b+45);
[a,b]=max(mean(uE_025_zav(46:90,:),2));
y_025 = yi(b+45);
[a,b]=max(mean(uE_050_zav(46:90,:),2));
y_050 = yi(b+45);
[a,b]=max(mean(uE_075_zav(46:90,:),2));
y_075 = yi(b+45);
[a,b]=max(mean(uE_100_zav(46:90,:),2));
y_100 = yi(b+45);
[a,b]=max(mean(uE_th_zav(46:90,:),2));
y_th = yi(b+45);

figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:7; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_000_ss_hzav(1:21,:)',v);
hold on
plot(ks_000(46:90),yi(46:90),'Color',[1 1 1])
plot([0 20],[y_000 y_000],'--','Color',[1 1 1])
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 7])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 0.0 Pa')
print('-dpng','fft_000_pavs.png')

figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:7; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_010_ss_hzav(1:21,:)',v);
hold on
plot(ks_010(46:90),yi(46:90),'Color',[1 1 1])
plot([0 20],[y_010 y_010],'--','Color',[1 1 1])
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 7])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 61.078 Pa')
print('-dpng','fft_010_pavs.png')

figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:7; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_025_ss_hzav(1:21,:)',v);
hold on
plot(ks_025(46:90),yi(46:90),'Color',[1 1 1])
plot([0 20],[y_025 y_025],'--','Color',[1 1 1])
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 7])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 152.695 Pa')
print('-dpng','fft_025_pavs.png')

figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:7; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_050_ss_hzav(1:21,:)',v);
hold on
plot(ks_050(46:90),yi(46:90),'Color',[1 1 1])
plot([0 20],[y_050 y_050],'--','Color',[1 1 1])
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 7])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 305.39 Pa')
print('-dpng','fft_050_pavs.png')

figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:7; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_075_ss_hzav(1:21,:)',v);
hold on
plot(ks_075(46:90),yi(46:90),'Color',[1 1 1])
plot([0 20],[y_075 y_075],'--','Color',[1 1 1])
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 7])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 458.085 Pa')
print('-dpng','fft_075_pavs.png')


figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:7; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_100_ss_hzav(1:21,:)',v);
hold on
plot(ks_100(46:90),yi(46:90),'Color',[1 1 1])
plot([0 20],[y_100 y_100],'--','Color',[1 1 1])
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 7])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 610.78 Pa')
print('-dpng','fft_100_pavs.png')


figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:7; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_th_ss_hzav(1:21,:)',v);
hold on
plot(ks_th(46:90),yi(46:90),'Color',[1 1 1])
plot([0 20],[y_th y_th],'--','Color',[1 1 1])
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 7])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 305.39 Pa + tropheat')
print('-dpng','fft_th_pavs.png')



save('/project/rg312/mat_files/rossby_rad.mat','kd_000','kd_010','kd_025','kd_050','kd_075','kd_100','kd_th')


save('/project/rg312/mat_files/rossby_td_rad.mat','kd_td_000','kd_td_010','kd_td_025','kd_td_050','kd_td_075','kd_td_100', 'kd_td_th')

return

[a,b]=max(mean(uE_000_zav(46:90,:),2));
y_000 = yi(b+45);
[a,b]=max(mean(uE_010_zav(46:90,:),2));
y_010 = yi(b+45);
[a,b]=max(mean(uE_025_zav(46:90,:),2));
y_025 = yi(b+45);
[a,b]=max(mean(uE_050_zav(46:90,:),2));
y_050 = yi(b+45);
[a,b]=max(mean(uE_075_zav(46:90,:),2));
y_075 = yi(b+45);
[a,b]=max(mean(uE_100_zav(46:90,:),2));
y_100 = yi(b+45);

figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:7; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_000_ss_hzav(1:21,:)',v);
hold on
plot(kd_000(46:90),yi(46:90),'Color',[1 1 1])
plot([0 20],[y_000 y_000],'--','Color',[1 1 1])
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 7])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 0.0 Pa')
print('-dpng','fft_000_pav.png')

figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:7; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_010_ss_hzav(1:21,:)',v);
hold on
plot(kd_010(46:90),yi(46:90),'Color',[1 1 1])
plot([0 20],[y_010 y_010],'--','Color',[1 1 1])
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 7])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 61.078 Pa')
print('-dpng','fft_010_pav.png')

figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:7; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_025_ss_hzav(1:21,:)',v);
hold on
plot(kd_025(46:90),yi(46:90),'Color',[1 1 1])
plot([0 20],[y_025 y_025],'--','Color',[1 1 1])
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 7])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 152.695 Pa')
print('-dpng','fft_025_pav.png')

figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:7; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_050_ss_hzav(1:21,:)',v);
hold on
plot(kd_050(46:90),yi(46:90),'Color',[1 1 1])
plot([0 20],[y_050 y_050],'--','Color',[1 1 1])
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 7])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 305.39 Pa')
print('-dpng','fft_050_pav.png')

figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:7; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_075_ss_hzav(1:21,:)',v);
hold on
plot(kd_075(46:90),yi(46:90),'Color',[1 1 1])
plot([0 20],[y_075 y_075],'--','Color',[1 1 1])
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 7])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 458.085 Pa')
print('-dpng','fft_075_pav.png')


figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:7; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_100_ss_hzav(1:21,:)',v);
hold on
plot(kd_100(46:90),yi(46:90),'Color',[1 1 1])
plot([0 20],[y_100 y_100],'--','Color',[1 1 1])
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 7])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 610.78 Pa')
print('-dpng','fft_100_pav.png')


figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:7; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_th_ss_hzav(1:21,:)',v);
hold on
plot(kd_th(46:90),yi(46:90),'Color',[1 1 1])
plot([0 20],[y_th y_th],'--','Color',[1 1 1])
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 7])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 305.39 Pa + tropheat')
print('-dpng','fft_th_pav.png')

