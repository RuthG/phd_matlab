%try using the advective tendencies to check the heat budget closure

% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_doshallower00/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
drf=rdmds([rDir,'DRF']);
dyg=rdmds([rDir,'DYG']);
dxg=rdmds([rDir,'DXG']);
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

for i=1:25
CellVol(:,:,i) = ar(:,:) .* drf(i) .* hc(:,:,i);
end

radius = 6371.0e3;
g = 9.81;
Ra = 287.04;


convtheta(1,1,:,1)=(rC/101325.0).^(2./7.);
convthetatoT = repmat(convtheta,[192,32,1]);


nit=172800;

rDir = '/project/rg312/wv_on_rad_off/run_doshallower00/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'THETA   '));
theta_000 = dyn(:,:,:,J);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_000 = dyn(:,:,:,J);

t_000 = theta_000.*convthetatoT;
t_000_ll = cube2latlon(xc,yc,t_000,xi,yi);

J=find(strcmp(fldList,'UVEL    '));
u_000 = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
v_000 = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVEL    '));
w_000 = dyn(:,:,:,J);
[uE_000,vN_000] = rotate_uv2uvEN(u_000,v_000,AngleCS,AngleSN,Grid);
uE_000_ll = cube2latlon(xc,yc,uE_000,xi,yi);
vN_000_ll = cube2latlon(xc,yc,vN_000,xi,yi);
w_000_ll = cube2latlon(xc,yc,w_000,xi,yi);

for i=1:25
rho_000_ll(:,:,i) = rC(i)./Ra./t_000_ll(:,:,i);
end


J=find(strcmp(fldList,'ADVr_TH '));
theta_advr_000 = dyn(:,:,:,J); 
J=find(strcmp(fldList,'ADVx_TH '));
theta_advx_000 = dyn(:,:,:,J);
J=find(strcmp(fldList,'ADVy_TH '));
theta_advy_000 = dyn(:,:,:,J);

[theta_advE_000,theta_advN_000] = rotate_uv2uvEN(theta_advx_000,theta_advy_000,AngleCS,AngleSN,Grid);

CellVol_ll = cube2latlon(xc,yc,CellVol,xi,yi);
theta_000_ll = cube2latlon(xc,yc,theta_000,xi,yi);
htrt_000_ll = cube2latlon(xc,yc,htrt_000,xi,yi);

theta_advr_000_ll = cube2latlon(xc,yc,theta_advr_000,xi,yi)./CellVol_ll;
theta_advE_000_ll = cube2latlon(xc,yc,theta_advE_000,xi,yi)./CellVol_ll;
theta_advN_000_ll = cube2latlon(xc,yc,theta_advN_000,xi,yi)./CellVol_ll;

[a,b,theta_advr_grad] = gradient(theta_advr_000_ll);
[a,theta_advE_grad,b] = gradient(theta_advE_000_ll);
[theta_advN_grad,a,b] = gradient(theta_advN_000_ll);


return

cellar_w_ll = zeros(180,90,25);
cellar_u_ll = zeros(180,90,25);
cellar_v_ll = zeros(180,90,25);

for i=1:90

cellar_w_ll(:,i,:) = radius.^2.*cos(yi(i).*pi./180).*(2.*pi./180).^2;
cellar_u_ll(:,i,:) = 4000.*radius.*2.*pi./180;
cellar_v_ll(:,i,:) = 4000.*radius.*cos(yi(i).*pi./180).*2.*pi./180;

end

figure
contourf(theta_000_ll(:,:,5)'.*vN_000_ll(:,:,5)')

figure
contourf(theta_advN_000_ll(:,:,5)')

figure
contourf(theta_000_ll(:,:,5)'.*uE_000_ll(:,:,5)')

figure
contourf(theta_advE_000_ll(:,:,5)')

figure
contourf(theta_000_ll(:,:,5)'.*w_000_ll(:,:,5)')

figure
contourf(theta_advr_000_ll(:,:,5)')

[a,uE_grad,c] = gradient(uE_000_ll);
[a,theta_grad,c] = gradient(theta_000_ll);

[a,b,w_grad] = gradient(w_000_ll);
[a,b,theta_grad] = gradient(theta_000_ll);

return

cellvol_ll = zeros(180,90,25);
for i=1:90
cellvol_ll(:,i,:) = 4000./(rho_000_ll(:,i,:).*g)    .*radius.^2.*cos(yi(i).*pi./180).*(2.*pi./180).^2;
end

cellvol_ll = zeros(180,90,25);
for i=1:90
cellvol_ll(:,i,:) = 4000.*radius.^2.*cos(yi(i).*pi./180).*(2.*pi./180).^2;
end



theta_advN_grad = gradient(theta_advN_000_ll);
[a,theta_advE_grad,c] = gradient(theta_advE_000_ll);
[a,b,theta_advr_grad] = gradient(theta_advr_000_ll);

