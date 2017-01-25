%evaluate the front diagnostic at level 5 for every day of each run and save

%load in snapshots of temperature and relative vorticity. 
%calculate the magnitiude of the temperature gradient and multiply with vorticity, see if we see fronts..

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat')
load('/project/rg312/mat_files/vorticity_data_best.mat')


%transfer t to ll
xi=-179:2:180;yi=-89:2:90;


t_000_ll = squeeze(cube2latlon(xc,yc,t_000(:,:,1,:),xi,yi));
t_010_ll = squeeze(cube2latlon(xc,yc,t_010(:,:,1,:),xi,yi));
t_025_ll = squeeze(cube2latlon(xc,yc,t_025(:,:,1,:),xi,yi));
t_050_ll = squeeze(cube2latlon(xc,yc,t_050(:,:,1,:),xi,yi));
t_075_ll = squeeze(cube2latlon(xc,yc,t_075(:,:,1,:),xi,yi));
t_100_ll = squeeze(cube2latlon(xc,yc,t_100(:,:,1,:),xi,yi));
t_125_ll = squeeze(cube2latlon(xc,yc,t_125(:,:,1,:),xi,yi));
t_150_ll = squeeze(cube2latlon(xc,yc,t_150(:,:,1,:),xi,yi));
clear('t_000','t_010','t_025','t_050','t_075','t_100','t_125','t_150')

vort_000_ll = cube2latlon(xg,yg,vort_000(:,:,1,:),xi,yi);
vort_010_ll = cube2latlon(xg,yg,vort_010(:,:,1,:),xi,yi);
vort_025_ll = cube2latlon(xg,yg,vort_025(:,:,1,:),xi,yi);
vort_050_ll = cube2latlon(xg,yg,vort_050(:,:,1,:),xi,yi);
vort_075_ll = cube2latlon(xg,yg,vort_075(:,:,1,:),xi,yi);
vort_100_ll = cube2latlon(xg,yg,vort_100(:,:,1,:),xi,yi);
vort_125_ll = cube2latlon(xg,yg,vort_125(:,:,1,:),xi,yi);
vort_150_ll = cube2latlon(xg,yg,vort_150(:,:,1,:),xi,yi);
clear('vort_000','vort_010','vort_025','vort_050','vort_075','vort_100','vort_125','vort_150')

radius = 6371.0e3;
omega = 2.*pi./24./60./60;
f = 10^-4;

[dTdy_000,dTdx_000,moo] = gradient(t_000_ll,pi./90);
dTdy_000 = dTdy_000./radius;
[dTdy_010,dTdx_010,moo] = gradient(t_010_ll,pi./90);
dTdy_010 = dTdy_010./radius;
[dTdy_025,dTdx_025,moo] = gradient(t_025_ll,pi./90);
dTdy_025 = dTdy_025./radius;
[dTdy_050,dTdx_050,moo] = gradient(t_050_ll,pi./90);
dTdy_050 = dTdy_050./radius;
[dTdy_075,dTdx_075,moo] = gradient(t_075_ll,pi./90);
dTdy_075 = dTdy_075./radius;
[dTdy_100,dTdx_100,moo] = gradient(t_100_ll,pi./90);
dTdy_100 = dTdy_100./radius;
[dTdy_125,dTdx_125,moo] = gradient(t_125_ll,pi./90);
dTdy_125 = dTdy_125./radius;
[dTdy_150,dTdx_150,moo] = gradient(t_150_ll,pi./90);
dTdy_150 = dTdy_150./radius;
clear moo

for i=1:90
dTdx_000(:,i,:) = dTdx_000(:,i,:)./cos(yi(i).*pi./180)./radius;
dTdx_010(:,i,:) = dTdx_010(:,i,:)./cos(yi(i).*pi./180)./radius;
dTdx_025(:,i,:) = dTdx_025(:,i,:)./cos(yi(i).*pi./180)./radius;
dTdx_050(:,i,:) = dTdx_050(:,i,:)./cos(yi(i).*pi./180)./radius;
dTdx_075(:,i,:) = dTdx_075(:,i,:)./cos(yi(i).*pi./180)./radius;
dTdx_100(:,i,:) = dTdx_100(:,i,:)./cos(yi(i).*pi./180)./radius;
dTdx_125(:,i,:) = dTdx_125(:,i,:)./cos(yi(i).*pi./180)./radius;
dTdx_150(:,i,:) = dTdx_150(:,i,:)./cos(yi(i).*pi./180)./radius;
end

dTgrad_000 = sqrt(dTdy_000.^2 + dTdx_000.^2);
dTgrad_010 = sqrt(dTdy_010.^2 + dTdx_010.^2);
dTgrad_025 = sqrt(dTdy_025.^2 + dTdx_025.^2);
dTgrad_050 = sqrt(dTdy_050.^2 + dTdx_050.^2);
dTgrad_075 = sqrt(dTdy_075.^2 + dTdx_075.^2);
dTgrad_100 = sqrt(dTdy_100.^2 + dTdx_100.^2);
dTgrad_125 = sqrt(dTdy_125.^2 + dTdx_125.^2);
dTgrad_150 = sqrt(dTdy_150.^2 + dTdx_150.^2);

for i=1:90
if i<=45 
f=-10^-4;
else
f=10^-4;
end

arnaud_diag_000(:,i,:) = dTgrad_000(:,i,:).*vort_000_ll(:,i,:)./(f./100./1000);
arnaud_diag_010(:,i,:) = dTgrad_010(:,i,:).*vort_010_ll(:,i,:)./(f./100./1000);
arnaud_diag_025(:,i,:) = dTgrad_025(:,i,:).*vort_025_ll(:,i,:)./(f./100./1000);
arnaud_diag_050(:,i,:) = dTgrad_050(:,i,:).*vort_050_ll(:,i,:)./(f./100./1000);
arnaud_diag_075(:,i,:) = dTgrad_075(:,i,:).*vort_075_ll(:,i,:)./(f./100./1000);
arnaud_diag_100(:,i,:) = dTgrad_100(:,i,:).*vort_100_ll(:,i,:)./(f./100./1000);
arnaud_diag_125(:,i,:) = dTgrad_125(:,i,:).*vort_125_ll(:,i,:)./(f./100./1000);
arnaud_diag_150(:,i,:) = dTgrad_150(:,i,:).*vort_150_ll(:,i,:)./(f./100./1000);

end

save('/project/rg312/mat_files/front_diag_full_000_best.mat', 'arnaud_diag_000')
save('/project/rg312/mat_files/front_diag_full_010_best.mat', 'arnaud_diag_010')
save('/project/rg312/mat_files/front_diag_full_025_best.mat', 'arnaud_diag_025')
save('/project/rg312/mat_files/front_diag_full_050_best.mat', 'arnaud_diag_050')
save('/project/rg312/mat_files/front_diag_full_075_best.mat', 'arnaud_diag_075')
save('/project/rg312/mat_files/front_diag_full_100_best.mat', 'arnaud_diag_100')
save('/project/rg312/mat_files/front_diag_full_125_best.mat', 'arnaud_diag_125')
save('/project/rg312/mat_files/front_diag_full_150_best.mat', 'arnaud_diag_150')


ad_100_series_thresh = reshape(arnaud_diag_100,[numel(arnaud_diag_100),1]);
[ad_dist_100,ad_val_100] = hist(ad_100_series_thresh,100);
ad_sum_100 = cumsum(ad_dist_100)./sum(ad_dist_100);
ad_thresh_100 = ad_val_100(min(find(ad_sum_100>=0.95)));




