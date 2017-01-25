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


end

q_mean = mean(q,4);
theta_mean = mean(theta,4);


xi=-179:2:180;yi=-89:2:90;
qll=cube2latlon(xc,yc,q_mean,xi,yi);
thetall=cube2latlon(xc,yc,theta_mean,xi,yi);

q_zav(:,:) = mean(qll,1);
theta_zav(:,:) = mean(thetall,1);

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
z_approx = zeros(90,26);
z_approx(:,1) = 0;
z_approx(:,2:26) = cumsum(dz_approx,2);
rC_zlevs = 100000:-4000:0;
rC_zlevs_o = rC_zlevs;
rC_zlevs(26) = 0.1;

q_zlevs = zeros(90,26);
t_zlevs = zeros(90,26);
rho_zlevs = zeros(90,26);

%interpolate q and T to get to match with z levels
q_zlevs(2:89,:) = shiftdim(interp1(rC,q_zav(2:89,:)',rC_zlevs,'cubic','extrap'),1);
t_zlevs(2:89,:) = shiftdim(interp1(rC,t_zav(2:89,:)',rC_zlevs,'cubic','extrap'),1);
z_zlevs(2:89,:) = shiftdim(interp1(rC_zlevs_o,z_approx(2:89,:)',rC_zlevs,'cubic','extrap'),1);

for i=1:26
rho_zlevs(2:89,i) = rC_zlevs(i)./Ra./t_zlevs(2:89,i);
end

%DOUBLE CHECK
w_zlevs = q_zlevs./(1-q_zlevs);
wvdens_zlevs = w_zlevs.*rho_zlevs.*1000.;

%need height, pressure, temperature, water vapour density, ozone density

z_sb = fliplr(z_zlevs);
p_sb = fliplr(rC_zlevs)./100;
t_sb = fliplr(t_zlevs);
wvdens_sb = fliplr(wvdens_zlevs);
ozdens_sb = 1e-15;

atm=zeros(26,5);
nn=size(atm,1);

for i=2:89
i
atm(:,1)=z_sb(i,:)./1000.;
atm(:,2)=p_sb(:);
atm(:,3)=t_sb(i,:);
atm(:,4)=wvdens_sb(i,:);
atm(:,5)=ozdens_sb;

filename=['./atm_profs/atms.dat_' int2str(i)];
dlmwrite(filename, 26)
dlmwrite(filename, atm,'delimiter', '\t','precision', '%.15f','-append')

end

return




