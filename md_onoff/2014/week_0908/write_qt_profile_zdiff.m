%load in q and t from MITgcm output, convert to right units for SBDART and write profiles to use


% choose directory, load grid
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5year/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));
drC=squeeze(rdmds([rDir,'DRC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
ny=90;

%read files
i=0;
for nit = 259200:86400:432000;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'SALT    '));
q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'PHIHYD  '));
gz(:,:,:,i)=dyn(:,:,:,J);

[sur,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'ETAN    '));
eta(:,:,i)=sur(:,:,J);

end

q_mean = mean(q,4);
theta_mean = mean(theta,4);
gz_mean = mean(gz,4);
eta_mean = mean(eta,3);

xi=-179:2:180;yi=-89:2:90;
qll=cube2latlon(xc,yc,q_mean,xi,yi);
thetall=cube2latlon(xc,yc,theta_mean,xi,yi);
gzll=cube2latlon(xc,yc,gz_mean,xi,yi);
etall=cube2latlon(xc,yc,eta_mean,xi,yi);
q_zav(:,:) = mean(qll,1);
theta_zav(:,:) = mean(thetall,1);
gz_zav(:,:) = mean(gzll,1);
eta_zav(:,:) = mean(etall,1);

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:size(rC)
t_zav(:,k)=theta_zav(:,k).*convthetatoT(k,1);
end

% wv mixing ratio w = q/(1-q)
% density of wv = w*density of air
% density of air = p/RaT (or close enough) *1000 to get in g/m3

Ra = 287.04;
g= 9.81;
omega = 2.*pi./24./60./60;

for i=1:25
rho(:,i) = rC(i)./Ra./t_zav(:,i);
end

dz_approx = 4000./rho./g;
%integrating the above (summing) gives us z at 100000, 96000, 92000, etc. Assumes p=100000 at z=0
z_mid_approx = zeros(90,26);
z_mid_approx(:,1) = 0;
z_mid_approx(:,2:26) = cumsum(dz_approx,2);
z_mid_approx = z_mid_approx - 50;
rC_zlevs = 100000:-4000:0;

%interpolate z to get to match with rC levels
z_approx = shiftdim(interp1(rC_zlevs,z_mid_approx(2:89,:)',rC,'cubic','extrap'),1);


%DOUBLE CHECK
w_zav = q_zav./(1-q_zav);
wvdens_zav = w_zav.*rho.*1000.;

%need height, pressure, temperature, water vapour density, ozone density

z_sb = fliplr(z_approx);
p_sb = flipud(rC)./100;
t_sb = fliplr(t_zav);
wvdens_sb = fliplr(wvdens_zav);
ozdens_sb = 1e-15;

atm=zeros(25,5);
nn=size(atm,1);

for i=2:89
i
atm(:,1)=z_sb(i-1,:)./1000.;
atm(:,2)=p_sb;
atm(:,3)=t_sb(i,:);
atm(:,4)=wvdens_sb(i,:);
atm(:,5)=ozdens_sb;

filename=['./atm_profs_zdiffm/atms.dat_' int2str(i)];
dlmwrite(filename, 25)
dlmwrite(filename, atm,'delimiter', '\t','precision', '%.15f','-append')

end

return




