%load up etan and phihyd files, try to finally figure out contents...

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


nit = 259200;
Ra=287.04;
cp = Ra./(2./7);

rDir = '/project/rg312/wv_on_rad_off/run_doshallower10/';

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'PHIHYD  '));
phihyd(:,:,:) = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVEL    '));
wvel(:,:,:) = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta(:,:,:) = dyn(:,:,:,J);

[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'ETAN    '));
etan = surf(:,:,J);

phihyd_ll = cube2latlon(xc,yc,phihyd,xi,yi);
wvel_ll = cube2latlon(xc,yc,wvel,xi,yi);
etan_ll = cube2latlon(xc,yc,etan,xi,yi);
theta_ll = cube2latlon(xc,yc,theta,xi,yi);


convtheta=(rC/1e5).^(2./7.);
t_ref = [295.2, 295.5, 295.9, 296.3, 296.7, 297.1, 297.6, 298.1, 298.7, 299.3, ...
      300.0, 300.7, 301.9, 304.1, 308.0, 312.0, 316.0, 320.,   324., 329., ...
      338.,  339., 362.3, 419.2, 573.8];

alpha_0 = convtheta.*Ra.*t_ref'./rC;
phi_ref = cumsum(alpha_0).*4000;

for i=1:25
phi_ll(:,:,i) = phihyd_ll(:,:,i) + phi_ref(i);
end


