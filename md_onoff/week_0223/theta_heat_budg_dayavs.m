%produce tidy version of the heat budget terms

%calculate advective heat transport terms carefully on the lat-lon grid


% choose directory, load grid
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
yi = -89:2:89;
xi = -179:2:179;

radius = 6371.0e3;

nit = 172800;
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
u_100(:,:,:) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
v_100(:,:,:) = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVEL    '));
w_100(:,:,:) = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_100(:,:,:) = dyn(:,:,:,J);
[uE_100,vN_100] = rotate_uv2uvEN(u_100,v_100,AngleCS,AngleSN,Grid);

theta_100_ll = cube2latlon(xc,yc,theta_100,xi,yi);
uE_100_ll = cube2latlon(xc,yc,uE_100,xi,yi);
vN_100_ll = cube2latlon(xc,yc,vN_100,xi,yi);
w_100_ll_half = zeros(180,90,26); 
w_100_ll_half(:,:,1:25) = cube2latlon(xc,yc,w_100,xi,yi);

rC_half = (100000:-4000:0)';
w_100_ll = shiftdim(interp1(rC_half,shiftdim(w_100_ll_half,2),rC),1);

load('/project/rg312/mat_files/front_diag.mat')

[dthetady_100,dthetadx_100,dthetadp_100] = gradient(theta_100_ll,pi./90,pi./90,-4000);
dthetady_100 = dthetady_100./radius;

for i=1:90
dthetadx_100(:,i,:) = dthetadx_100(:,i,:)./cos(yi(i).*pi./180)./radius;
end

udthetadx_100 = -uE_100_ll.*dthetadx_100.*86400;
vdthetady_100 = -vN_100_ll.*dthetady_100.*86400;
wdthetadp_100 = -w_100_ll.*dthetadp_100.*86400;



figure
v=-15:1:15;
[C,h] = contourf(xi,yi,udthetadx_100(:,:,5)' + vdthetady_100(:,:,5)' + wdthetadp_100(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('Advective term total, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_total/wv_100/advtotal_100_dav.png')



figure
v=-15:1:15;
[C,h] = contourf(xi,yi,udthetadx_100(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('ud\Theta/dx, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_total/wv_100/udthetadx_100_dav.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,vdthetady_100(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('vd\Theta/dy, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_total/wv_100/vdthetady_100_dav.png')

figure
v=-15:1:15;
[C,h] = contourf(xi,yi,wdthetadp_100(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k','LineWidth',2);
caxis([-15 15]);
colorbar
title('wd\Theta/dp, K/day, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','heat_budg_total/wv_100/wdthetadp_100_dav.png')





