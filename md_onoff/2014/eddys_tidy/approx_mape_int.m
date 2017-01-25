%calculate the approximate MAPE integrated over the storm track as defined in O'Gorman and Schneider 2008

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';

slashes = findstr(rDir,'/');
point1 = slashes(max(size(slashes))-2);
dir_label = rDir(point1+1:max(size(rDir))-1);
dir_label = strrep(dir_label,'/','_');

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
for nit = 259200:86400:604800;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta(:,:,:,i) = dyn(:,:,:,J);

end

%%% Take zonal average theta to calculate dTdy, dthetadp
[theta_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta,ny,yc,ar,hc);

%time mean of zon av theta 
theta_tzav = mean(theta_zav,3);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp_tzav(:,j)=theta_tzav(:,j).*convthetatoT(j,1);
end

name = ['bc_box_' dir_label '.mat'];
load(name);

% identify edges of baroclinic zone
if(mod(barzon_lats(1),2)==0)
min_no = find(abs(ylat) == barzon_lats(1)-1);
max_no = find(abs(ylat) == barzon_lats(2)+1);
else
min_no = find(abs(ylat) == barzon_lats(1));
max_no = find(abs(ylat) == barzon_lats(2));
end

% differentiate theta w r t p
[dthetadp,junk] = gradient(theta_tzav,-4000.);

% average this over baroclinic zone too
dthetadp_bzav = (mean(dthetadp(max_no(1):min_no(1),:),1) + mean(dthetadp(min_no(2):max_no(2),:),1))./2;

% use to calculate gamma factor, see O'Gorman 2008
gamma = -2./(7.*rC.*dthetadp_bzav');

%calculate constants for MAPE calculation
cp = 1004;
g = 9.81;
a = 6371.0e3;
prefac = cp./(24.*g);
sigma_diff = 0.9 - rC(level)./101325.0;


%calc meridional width of baroclinic region in km
merid_width = a.*((ylat(min_no(1)) - ylat(max_no(1))).*pi./180);

[junk,dtempdy] = gradient(temp_tzav,a.*pi./90);

dtempdy_bzav = (mean(-dtempdy(max_no(1):min_no(1),:),1) + mean(dtempdy(min_no(2):max_no(2),:),1))./2;

integrand = prefac.*merid_width.^2.*gamma(1:18).*dtempdy_bzav(1:18)'.^2;
integral = sum(integrand).*4000;

integrand_av = prefac.*merid_width.^2.*mean(gamma(3:18)).*mean(dtempdy_bzav(3:18))'.^2;
integral_av = sum(integrand_av).*4000.*16;

name = ['approxmapeint_' dir_label '.mat'];
save(name)
