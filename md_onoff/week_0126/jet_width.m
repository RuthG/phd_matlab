%load u data and estimate jet width (width at half max of surface winds)

%NB Conclusion: jet width less than both length scales

load('/project/rg312/mat_files/climatology_vars.mat')
load('/project/rg312/mat_files/climatology_vars_th.mat')

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

[max_val_000,b]=max(uE_000_zav(46:90,1));
y_surf_000 = yi(b+45);
[max_val_010,b]=max(uE_010_zav(46:90,1));
y_surf_010 = yi(b+45);
[max_val_025,b]=max(uE_025_zav(46:90,1));
y_surf_025 = yi(b+45);
[max_val_050,b]=max(uE_050_zav(46:90,1));
y_surf_050 = yi(b+45);
[max_val_075,b]=max(uE_075_zav(46:90,1));
y_surf_075 = yi(b+45);
[max_val_100,b]=max(uE_100_zav(46:90,1));
y_surf_100 = yi(b+45);
[max_val_th,b]=max(uE_th_zav(46:90,1));
y_surf_th = yi(b+45);


%take maximum, half it, find positions where next value is greater, previous smaller

half_val_000 = max_val_000./2;
half_val_010 = max_val_010./2;
half_val_025 = max_val_025./2;
half_val_050 = max_val_050./2;
half_val_075 = max_val_075./2;
half_val_100 = max_val_100./2;
half_val_th = max_val_th./2;

uE_half_000 = uE_000_zav(46:90,1) - half_val_000;
uE_half_010 = uE_010_zav(46:90,1) - half_val_010;
uE_half_025 = uE_025_zav(46:90,1) - half_val_025;
uE_half_050 = uE_050_zav(46:90,1) - half_val_050;
uE_half_075 = uE_075_zav(46:90,1) - half_val_075;
uE_half_100 = uE_100_zav(46:90,1) - half_val_100;
uE_half_th = uE_th_zav(46:90,1) - half_val_th;

pos_000 = +(uE_half_000 > 0);
pos_010 = +(uE_half_010 > 0);
pos_025 = +(uE_half_025 > 0);
pos_050 = +(uE_half_050 > 0);
pos_075 = +(uE_half_075 > 0);
pos_100 = +(uE_half_100 > 0);
pos_th = +(uE_half_th > 0);

radius=6371.0e3;

uE_width_000 = pi.*radius.*diff(yi(find(abs(diff(pos_000))>0)))./180;
uE_width_010 = pi.*radius.*diff(yi(find(abs(diff(pos_010))>0)))./180;
uE_width_025 = pi.*radius.*diff(yi(find(abs(diff(pos_025))>0)))./180;
uE_width_050 = pi.*radius.*diff(yi(find(abs(diff(pos_050))>0)))./180;
uE_width_075 = pi.*radius.*diff(yi(find(abs(diff(pos_075))>0)))./180;
uE_width_100 = pi.*radius.*diff(yi(find(abs(diff(pos_100))>0)))./180;
uE_width_th = pi.*radius.*diff(yi(find(abs(diff(pos_th))>0)))./180;


plot(y_surf_000,uE_width_000,'x')
hold on
plot(y_surf_010,uE_width_010,'x')
plot(y_surf_025,uE_width_025,'x')
plot(y_surf_050,uE_width_050,'x')
plot(y_surf_075,uE_width_075,'x')
plot(y_surf_100,uE_width_100,'x')
plot(y_surf_th,uE_width_th,'x')

load('/project/rg312/mat_files/rhines_scale.mat')
load('/project/rg312/mat_files/rossby_rad.mat')

l_beta_000 = 2.*pi.*radius.*cos(yi.*pi./180)./kbeta_000;
l_beta_010 = 2.*pi.*radius.*cos(yi.*pi./180)./kbeta_010;
l_beta_025 = 2.*pi.*radius.*cos(yi.*pi./180)./kbeta_025;
l_beta_050 = 2.*pi.*radius.*cos(yi.*pi./180)./kbeta_050;
l_beta_075 = 2.*pi.*radius.*cos(yi.*pi./180)./kbeta_075;
l_beta_100 = 2.*pi.*radius.*cos(yi.*pi./180)./kbeta_100;
l_beta_th = 2.*pi.*radius.*cos(yi.*pi./180)./kbeta_th;

l_d_000 = 2.*pi.*radius.*cos(yi.*pi./180)./kd_000;
l_d_010 = 2.*pi.*radius.*cos(yi.*pi./180)./kd_010;
l_d_025 = 2.*pi.*radius.*cos(yi.*pi./180)./kd_025;
l_d_050 = 2.*pi.*radius.*cos(yi.*pi./180)./kd_050;
l_d_075 = 2.*pi.*radius.*cos(yi.*pi./180)./kd_075;
l_d_100 = 2.*pi.*radius.*cos(yi.*pi./180)./kd_100;
l_d_th = 2.*pi.*radius.*cos(yi.*pi./180)./kd_th;
