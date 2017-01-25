
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_quarterwv/';


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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run %%%%%%%%%%%%%%%%

i=0;
for nit = 259200:86400:604800;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta(:,:,:,i) = dyn(:,:,:,J);

end

%take average and squares
theta_mean = mean(theta,4);
[theta_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_mean,ny,yc,ar,hc);
thetasq_zav = theta_zav.^2;

%convert to two hemispheres
theta_hem(:,:,1) = theta_zav(46:90,:);
thetasq_hem(:,:,1) = thetasq_zav(46:90,:);
for i=1:45
theta_hem(i,:,2) = theta_zav(46-i,:);
thetasq_hem(i,:,2) = thetasq_zav(46-i,:);
end

%consts
cp = 1004.64;
p0 = 100000;
g = 9.8;
kappa = 2/7;

%take vertical gradient
dthetadp = gradient(theta_hem,-4000);

%load up baroclinic zone
name = ['bc_box_' dir_label '.mat'];
load(name)
if mod(barzon_lats(1),2) == 0
barzon_reg = barzon_lats(1)+1:2:barzon_lats(2)+1;
else
barzon_reg = barzon_lats(1):2:barzon_lats(2);
end

%set up loop
ylat2=1:2:89;
start = find(ylat2 == min(barzon_reg))-1;

%integrate over the sphere then divide by total area
for i=1:size(barzon_reg,2)
dthetadp_weight(i,:,:) = cos(barzon_reg(i).*pi./180) .* dthetadp(start+i,:,:) ;
theta_weight(i,:,:) = cos(barzon_reg(i).*pi./180) .* theta_hem(start+i,:,:) ;
thetasq_weight(i,:,:) = cos(barzon_reg(i).*pi./180) .* thetasq_hem(start+i,:,:) ;
cosy(i) = cos(barzon_reg(i).*pi./180);
end

%take straight average to compare
dthetadp_av = mean(dthetadp(13:28,:,:),1);
theta_av = mean(theta_hem(13:28,:,:),1);
thetasq_av = mean(thetasq_hem(13:28,:,:),1);

dthetadp_bzav(:,:) = sum(dthetadp_weight,1)./sum(cosy) ;
theta_bzav(:,:) = sum(theta_weight,1)./sum(cosy) ;
thetasq_bzav(:,:) = sum(thetasq_weight,1)./sum(cosy) ;

%calculate gamma factor
for k=1:25
gamma(k,:) = -kappa./rC(k) .* 1./dthetadp_bzav(k,:);
end

%calculate integrand
for i=1:2
mape_integrand(:,i) = (rC./p0).^kappa .*gamma(:,i) .* (thetasq_bzav(:,i) - theta_bzav(:,i).^2) ;
end

prefac = cp.*p0./2./g;

%integrate
mape = prefac .* sum(mape_integrand(3:level,:),1) .* 4000./p0;

%take average for 2 hemispheres
mape_out = mean(mape);

%save
name = ['mape_' dir_label '.mat'];
save(name, 'mape_out')
