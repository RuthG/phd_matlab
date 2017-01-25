%Load in data to calculate quasi-geostrophic refractive index. Use control data to test calculation first.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%We need: u, theta, T

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_tropheat3/'; %p_2014/';
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
ny=90;

i=0;
for nit = 691440:240:705600; 
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE(:,:,:,i),vN(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta(:,:,:,i) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp(:,:,j,i)=theta(:,:,j,i).*convthetatoT(j,1);
end

end

for i=1:6
uE_av(:,:,:,i) = mean(uE(:,:,:,10*i-9:10*i),4);
theta_av(:,:,:,i) = mean(theta(:,:,:,10*i-9:10*i),4);
temp_av(:,:,:,i) = mean(temp(:,:,:,10*i-9:10*i),4);
end

[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_av,ny,yc,ar,hc);
[theta_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_av,ny,yc,ar,hc);
[temp_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_av,ny,yc,ar,hc);


%%%%%%%%%%%%%%%%%%%%%%%%% c = 8, k=7 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Constants needed: a, c, k, f/omega, H, R

a = 6371000; % radius of earth
c = 8.0; %phase speed guesstimate for now
k = 7;   %waveno to look at
omeg = 2.*pi./(24.*60.*60);  %rotation rate of earth
f = 2.*omeg.*sin(ylat.*pi./180);
H = 8000 ;   % Density scale height (taken from Isla's thesis)
R = 287.0 ; %gas const for dry air
g=9.81;

ylat_arr = zeros(90,25,6);
rC_arr = zeros(90,25,6);
f_arr = zeros(90,25,6);
for j=1:6
for i=1:25
ylat_arr(:,i,j) = ylat.*pi./180;
f_arr(:,i,j) = f;
end
for i=1:90
rC_arr(i,:,j) = rC;
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Next evaluate dq/dphi. Need du/dp, dtheta/dp

term1 = 2.*omeg.*cos(ylat_arr);

[b,top,moo] = gradient(uE_zav.*cos(ylat_arr),pi./90);
bottom = a.*cos(ylat_arr);

frac = top./bottom;

[b,term2,moo] = gradient(frac,pi./90);

[dudp,b,moo] = gradient(uE_zav,-4000);
[dthetadp,b,moo] = gradient(theta_zav,-4000);

prod = rC_arr.*theta_zav./temp_zav.*dudp./dthetadp;

[diff,b,moo] = gradient(prod,-4000);

term3 = a.*f_arr.^2./R.*diff;

dqdphi = term1 - term2 + term3;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Also evaluate N = sqrt (g/theta dtheta/dz)

Nsq = -(g.^2.*rC_arr)./(R.*temp_zav.*theta_zav) .* dthetadp;
N = sqrt(Nsq);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%qg ref index!

bit1 = dqdphi./(a.*(uE_zav-c));
bit2 = (k./(a.*cos(ylat_arr))).^2 ;
bit3 = (f_arr./(2.*N.*H)).^2 ;

qgref = ( dqdphi./(a.*(uE_zav-c)) -  (k./(a.*cos(ylat_arr))).^2   - (f_arr./(2.*N.*H)).^2 ) .*a.^2;





%%%%%%%%%%%%%%%%%%%%%%%%% c = 8, k=2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Constants needed: a, c, k, f/omega, H, R

c = 8.0; %phase speed guesstimate for now
k = 2;   %waveno to look at


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%qg ref index!

bit1 = dqdphi./(a.*(uE_zav-c));
bit2 = (k./(a.*cos(ylat_arr))).^2 ;
bit3 = (f_arr./(2.*N.*H)).^2 ;

qgref_k2 = ( dqdphi./(a.*(uE_zav-c)) -  (k./(a.*cos(ylat_arr))).^2   - (f_arr./(2.*N.*H)).^2 ) .*a.^2;






%%%%%%%%%%%%%%%%%%%%%%%%% c = 8, k=12 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Constants needed: a, c, k, f/omega, H, R

c = 8.0; %phase speed guesstimate for now
k = 12;   %waveno to look at


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%qg ref index!

bit1 = dqdphi./(a.*(uE_zav-c));
bit2 = (k./(a.*cos(ylat_arr))).^2 ;
bit3 = (f_arr./(2.*N.*H)).^2 ;

qgref_k12 = ( dqdphi./(a.*(uE_zav-c)) -  (k./(a.*cos(ylat_arr))).^2   - (f_arr./(2.*N.*H)).^2 ) .*a.^2;





%%%%%%%%%%%%%%%%%%%%%%%%% c = 2, k=7 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Constants needed: a, c, k, f/omega, H, R

c = 2.0; %phase speed guesstimate for now
k = 7;   %waveno to look at


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%qg ref index!

bit1 = dqdphi./(a.*(uE_zav-c));
bit2 = (k./(a.*cos(ylat_arr))).^2 ;
bit3 = (f_arr./(2.*N.*H)).^2 ;

qgref_c2 = ( dqdphi./(a.*(uE_zav-c)) -  (k./(a.*cos(ylat_arr))).^2   - (f_arr./(2.*N.*H)).^2 ) .*a.^2;





%%%%%%%%%%%%%%%%%%%%%%%%% c = 12, k=7 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Constants needed: a, c, k, f/omega, H, R

c = 12.0; %phase speed guesstimate for now
k = 7;   %waveno to look at


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%qg ref index!

bit1 = dqdphi./(a.*(uE_zav-c));
bit2 = (k./(a.*cos(ylat_arr))).^2 ;
bit3 = (f_arr./(2.*N.*H)).^2 ;

qgref_c12 = ( dqdphi./(a.*(uE_zav-c)) -  (k./(a.*cos(ylat_arr))).^2   - (f_arr./(2.*N.*H)).^2 ) .*a.^2;


save('qg_10days_tropheat3.mat','qgref','qgref_c2','qgref_c12','qgref_k2','qgref_k12','ylat','rC','dqdphi');
