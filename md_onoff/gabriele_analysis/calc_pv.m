%Load up vorticity and theta, evaluate gradients of theta and calculate vertical component of PV...


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
yi=-89:2:89;
xi = -179:2:179;yi=-89:2:90;
radius = 6371.0e3;
f = 2.*7.292e-5*sin(yi.*pi./180.);
g=9.8;

f_array = repmat(f,[180,1,25]);

load(['/project/rg312/mat_files/snapshot_data_final/run_100_ro/uE_100_ro_3.mat'])
load(['/project/rg312/mat_files/snapshot_data_final/run_100_ro/vN_100_ro_3.mat'])
load(['/project/rg312/mat_files/snapshot_data_final/run_100_ro/theta_100_ro_3.mat'])
load(['/project/rg312/mat_files/snapshot_data_final/run_100_ro/vort_100_ro_3.mat'])

theta_ll = cube2latlon(xc,yc,theta_100(:,:,:,81),xi,yi);
vort_ll = cube2latlon(xg,yg,vort_100(:,:,:,81),xi,yi);
u_ll = cube2latlon(xc,yc,uE_100(:,:,:,81),xi,yi);
v_ll= cube2latlon(xc,yc,vN_100(:,:,:,81),xi,yi);

[dthetady,dthetadx,dthetadp] = gradient(theta_ll,pi./90,pi./90,-4000.);
dthetady = dthetady./radius;

for i=1:90
    dthetadx(:,i,:) = dthetadx(:,i,:)./cos(yi(i).*pi./180)./radius;
end

dudp = gradient(shiftdim(u_ll,1),-4000.);
dvdp = gradient(shiftdim(v_ll,1),-4000.);
dudp = shiftdim(dudp,2);
dvdp = shiftdim(dvdp,2);

ertel_x = -g .* (-1.*dvdp.*dthetadx);
ertel_y = -g .* (dudp.*dthetady);
ertel_p = -g .* dthetadp.*(vort_ll + f_array);

ertel_pv = ertel_x + ertel_y + ertel_p;

%ertel_pv(isnan(ertel_pv)) = 0.;
%theta_ll(isnan(theta_ll)) = 0.;

pv_theta = x_on_theta(theta_ll(:,3:88,:), ertel_pv(:,3:88,:));



figure
v=-1.5e-5:1.1e-6:1.5e-5;
[C,h] = contourf(xi,yi(3:88),pv_theta(:,:,9)',v);
colormap(b2r(-1e-5,1e-5));
colorbar;
set(h,'LineColor','none');
set(gca,'FontSize',12);
colorbar('FontSize',15);
title('PV, 330K','FontSize',15);
ylabel('Latitude','FontSize',15);
xlabel('Longitude','FontSize',15);
print('-dpng','pv_330.png')


figure
v=-1.5e-5:1.e-6:1.5e-5;
[C,h] = contourf(xi,yi(3:88),pv_theta(:,:,6)',v);
colormap(b2r(-1e-5,1e-5));
colorbar;
set(h,'LineColor','none');
set(gca,'FontSize',12);
colorbar('FontSize',15);
title('PV, 315K','FontSize',15);
ylabel('Latitude','FontSize',15);
xlabel('Longitude','FontSize',15);
print('-dpng','pv_315.png')


figure
v=-1.5e-5:1.1e-6:1.5e-5;
[C,h] = contourf(xi,yi(3:88),pv_theta(:,:,3)',v);
colormap(b2r(-1e-5,1e-5));
colorbar;
set(h,'LineColor','none');
set(gca,'FontSize',12);
colorbar('FontSize',15);
title('PV, 300K','FontSize',15);
ylabel('Latitude','FontSize',15);
xlabel('Longitude','FontSize',15);
print('-dpng','pv_300.png')


