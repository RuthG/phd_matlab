%load in snapshots of temperature and relative vorticity. 
%calculate the magnitiude of the temperature gradient and multiply with vorticity, see if we see fronts..

load('/project/rg312/mat_files/snapshot_data/t_snapshots_th.mat')
load('/project/rg312/mat_files/snapshot_data/uE_snapshots_th.mat')
load('/project/rg312/mat_files/snapshot_data/vN_snapshots_th.mat')
load('/project/rg312/mat_files/snapshot_data/w_snapshots_th.mat')
load('/project/rg312/mat_files/vorticity_data.mat')

%transfer t to ll
xi=-179:2:180;yi=-89:2:90;
w_th_ll = cube2latlon(xc,yc,w_th(:,:,:,360),xi,yi);
w_ed_th_ll = cube2latlon(xc,yc,w_th(:,:,:,360),xi,yi) - cube2latlon(xc,yc,mean(w_th,4),xi,yi);

t_th_ll = cube2latlon(xc,yc,t_th(:,:,:,360),xi,yi);
t_ed_th_ll = cube2latlon(xc,yc,t_th(:,:,:,360),xi,yi) - cube2latlon(xc,yc,mean(t_th,4),xi,yi);

uE_th_ll = cube2latlon(xc,yc,uE_th(:,:,:,360),xi,yi);
uE_ed_th_ll = cube2latlon(xc,yc,uE_th(:,:,:,360),xi,yi) - cube2latlon(xc,yc,mean(uE_th,4),xi,yi);

vN_th_ll = cube2latlon(xc,yc,vN_th(:,:,:,360),xi,yi);
vN_ed_th_ll = cube2latlon(xc,yc,vN_th(:,:,:,360),xi,yi) - cube2latlon(xc,yc,mean(vN_th,4),xi,yi);

vort_th_ll = cube2latlon(xg,yg,vort_th(:,:,:,360),xi,yi);
clear('vort_000','vort_010','vort_025','vort_050','vort_075','vort_100','vort_th')

uEt_ed_th_ll = uE_ed_th_ll.*t_ed_th_ll;

vNt_ed_th_ll = vN_ed_th_ll.*t_ed_th_ll;

wt_ed_th_ll = w_ed_th_ll.*t_ed_th_ll;

load('/project/rg312/mat_files/heat_rates_th.mat')
htrt_th_ll = cube2latlon(xc,yc,htrt_th(:,:,:,360),xi,yi).*86400;
radht_th_ll = cube2latlon(xc,yc,radht_th(:,:,:,360),xi,yi).*86400;
difht_th_ll = cube2latlon(xc,yc,difht_th(:,:,:,360),xi,yi).*86400;
cndht_th_ll = cube2latlon(xc,yc,cndht_th(:,:,:,360),xi,yi).*86400;
cnvht_th_ll = cube2latlon(xc,yc,cnvht_th(:,:,:,360),xi,yi).*86400;

radius = 6371.0e3;
omega = 2.*pi./24./60./60;
%f = 2.*omega.*sin(yi.*pi./180);

[dTdy_th,dTdx_th] = gradient(t_th_ll,pi./90);
dTdy_th = dTdy_th./radius;
for i=1:90
dTdx_th(:,i,:) = dTdx_th(:,i,:)./cos(yi(i).*pi./180)./radius;
u_cos_th(:,i,:) = uE_th_ll(:,i,:).*cos(yi(i).*pi./180);
end

[a,dvdx_th] = gradient(vN_th_ll,pi./90);
dudy_cos_th = gradient(u_cos_th,pi./90);

dTgrad_th = sqrt(dTdy_th.^2 + dTdx_th.^2);

for i=1:90
if i<=45 
f=-10^-4;
else
f=10^-4;
end
dudy_th(:,i,:) = dudy_cos_th(:,i,:)./cos(yi(i).*pi./180);
arnaud_diag_th(:,i,:) = dTgrad_th(:,i,:).*vort_th_ll(:,i,:)./(f./100./1000);

end

figure
v=-12:2:12;
[C,h] = contourf(xi,yi,htrt_th_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_th(:,:,1)',v,'k');
caxis([-12 12]);
colorbar
title('Front diag, 0.5es0 + Tropical Heating')
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','htrtfrontdiag_th.png')

figure
v=-4:1:14;
[C,h] = contourf(xi,yi,cndht_th_ll(:,:,5)'+cnvht_th_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_th(:,:,1)',v,'k');
caxis([-4 14]);
colorbar
title('Front diag, 0.5es0 + Tropical Heating')
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','lathtfrontdiag_th.png')

figure
v=-4:1:14
[C,h] = contourf(xi,yi,cnvht_th_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_th(:,:,1)',v,'k');
caxis([-4 14]);
colorbar
title('Front diag, 0.5es0 + Tropical Heating')
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cnvhtfrontdiag_th.png')

figure
v=-4:1:14;
[C,h] = contourf(xi,yi,cndht_th_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_th(:,:,1)',v,'k');
caxis([-4 14]);
colorbar
title('Front diag, 0.5es0 + Tropical Heating')
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cndhtfrontdiag_th.png')

figure
v=-4:0.5:4;
[C,h] = contourf(xi,yi,radht_th_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_th(:,:,1)',v,'k');
caxis([-4 4]);
colorbar
title('Front diag, 0.5es0 + Tropical Heating')
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','radhtfrontdiag_th.png')

figure
v=-15:2.5:5;
[C,h] = contourf(xi,yi,difht_th_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_th(:,:,1)',v,'k');
caxis([-15 5]);
colorbar
title('Front diag, 0.5es0 + Tropical Heating')
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','difhtfrontdiag_th.png')

figure
v = -1:0.1:1;
[C,h] = contourf(xi,yi,arnaud_diag_th(:,:,1)',v,'k');
caxis([-1 1]);
colorbar
title('Front diag, 0.5es0 + Tropical Heating')
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','frontdiag_th.png')

figure
v=-1.2:0.2:1.2;
[C,h] = contourf(xi,yi,w_th_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_th(:,:,1)',v,'k');
caxis([-1 1]);
colorbar
title('Front diag, 0.5es0 + Tropical Heating')
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','wfrontdiag_th.png')

figure
v=-150:25:150;
[C,h] = contourf(xi,yi,vNt_ed_th_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_th(:,:,1)',v,'k');
caxis([-150 150]);
colorbar
title('Front diag, 0.5es0 + Tropical Heating')
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vtfrontdiag_th.png')

figure
v=-30:5:30;
[C,h] = contourf(xi,yi,vN_ed_th_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_th(:,:,1)',v,'k');
caxis([-30 30]);
colorbar
title('Front diag, 0.5es0 + Tropical Heating')
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vfrontdiag_th.png')

figure
v=-10:1:10;
[C,h] = contourf(xi,yi,t_ed_th_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_th(:,:,1)',v,'k');
caxis([-10 10]);
colorbar
title('Front diag, 0.5es0 + Tropical Heating')
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','tfrontdiag_th.png')

return
dudy_th = dudy_th./radius;
dvdx_th = dvdx_th./radius;
vort_th_snap = dvdx_th - dudy_th;

