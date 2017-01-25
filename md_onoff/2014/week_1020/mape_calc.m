
rDir='/project/rg312/wv_on_rad_off/run_doshallower_5year/';

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

niti = 173040;
nits = 240;
nitt = 259200;

var(1,:) = 'THETA   ';

%varv = zeros(size(var));
varv(1,:) = '       ';

loaded = true;

if loaded

load('mapecalcvars.mat')
else

rDir='/project/rg312/run_delsol02/';
theta_02 = mit_zavs(rDir,var,niti,nitt,nits);

'tzav_02 loaded'

rDir='/project/rg312/wv_on_rad_off/run_doshallower_5year/';
theta_14 = mit_zavs(rDir,var,259200,'varv',varv);

'tzav_14 loaded'

rDir='/project/rg312/run_delsol18/';
theta_18 = mit_zavs(rDir,var,niti,nitt,nits,'varv',varv);

'tzav_18 loaded'
end

thetasq_02 = theta_02.^2;
thetasq_14 = theta_14.^2;
thetasq_18 = theta_18.^2;

%convert to two hemispheres
theta_02_hem(:,:,1) = theta_02(46:90,:);
theta_14_hem(:,:,1) = theta_14(46:90,:);
theta_18_hem(:,:,1) = theta_18(46:90,:);

thetasq_02_hem(:,:,1) = thetasq_02(46:90,:);
thetasq_14_hem(:,:,1) = thetasq_14(46:90,:);
thetasq_18_hem(:,:,1) = thetasq_18(46:90,:);

for i=1:45
theta_02_hem(i,:,2) = theta_02(46-i,:);
theta_14_hem(i,:,2) = theta_14(46-i,:);
theta_18_hem(i,:,2) = theta_18(46-i,:);

thetasq_02_hem(i,:,2) = thetasq_02(46-i,:);
thetasq_14_hem(i,:,2) = thetasq_14(46-i,:);
thetasq_18_hem(i,:,2) = thetasq_18(46-i,:);
end

%consts
cp = 1004.64;
p0 = 100000;
g = 9.8;
kappa = 2/7;

%take vertical gradient
dthetadp_02 = gradient(theta_02_hem,-4000);
dthetadp_14 = gradient(theta_14_hem,-4000);
dthetadp_18 = gradient(theta_18_hem,-4000);

%load up baroclinic zone
name = ['bc_box_02.mat'];
load(name)
if mod(barzon_lats_02(1),2) == 0
barzon_reg_02 = barzon_lats_02(1)+1:2:barzon_lats_02(2)+1;
else
barzon_reg_02 = barzon_lats_02(1):2:barzon_lats_02(2);
end
name = ['bc_box_14.mat'];
load(name)
if mod(barzon_lats_14(1),2) == 0
barzon_reg_14 = barzon_lats_14(1)+1:2:barzon_lats_14(2)+1;
else
barzon_reg_14 = barzon_lats_14(1):2:barzon_lats_14(2);
end
name = ['bc_box_18.mat'];
load(name)
if mod(barzon_lats_18(1),2) == 0
barzon_reg_18 = barzon_lats_18(1)+1:2:barzon_lats_18(2)+1;
else
barzon_reg_18 = barzon_lats_18(1):2:barzon_lats_18(2);
end

%set up loop
ylat2=1:2:89;
start_02 = find(ylat2 == min(barzon_reg_02))-1;
start_14 = find(ylat2 == min(barzon_reg_14))-1;
start_18 = find(ylat2 == min(barzon_reg_18))-1;

%integrate over the sphere then divide by total area
for i=1:size(barzon_reg_02,2)
dthetadp_02_weight(i,:,:) = cos(barzon_reg_02(i).*pi./180) .* dthetadp_02(start_02+i,:,:) ;
theta_02_weight(i,:,:) = cos(barzon_reg_02(i).*pi./180) .* theta_02_hem(start_02+i,:,:) ;
thetasq_02_weight(i,:,:) = cos(barzon_reg_02(i).*pi./180) .* thetasq_02_hem(start_02+i,:,:) ;
cosy_02(i) = cos(barzon_reg_02(i).*pi./180);
end
for i=1:size(barzon_reg_14,2)
dthetadp_14_weight(i,:,:) = cos(barzon_reg_14(i).*pi./180) .* dthetadp_14(start_14+i,:,:) ;
theta_14_weight(i,:,:) = cos(barzon_reg_14(i).*pi./180) .* theta_14_hem(start_14+i,:,:) ;
thetasq_14_weight(i,:,:) = cos(barzon_reg_14(i).*pi./180) .* thetasq_14_hem(start_14+i,:,:) ;
cosy_14(i) = cos(barzon_reg_14(i).*pi./180);
end
for i=1:size(barzon_reg_18,2)
dthetadp_18_weight(i,:,:) = cos(barzon_reg_18(i).*pi./180) .* dthetadp_18(start_18+i,:,:) ;
theta_18_weight(i,:,:) = cos(barzon_reg_18(i).*pi./180) .* theta_18_hem(start_18+i,:,:) ;
thetasq_18_weight(i,:,:) = cos(barzon_reg_18(i).*pi./180) .* thetasq_18_hem(start_18+i,:,:) ;
cosy_18(i) = cos(barzon_reg_18(i).*pi./180);
end


%take straight average to compare
dthetadp_02_av = mean(dthetadp_02(13:28,:,:),1);
theta_02_av = mean(theta_02_hem(13:28,:,:),1);
thetasq_02_av = mean(thetasq_02_hem(13:28,:,:),1);
dthetadp_14_av = mean(dthetadp_14(13:28,:,:),1);
theta_14_av = mean(theta_14_hem(13:28,:,:),1);
thetasq_14_av = mean(thetasq_14_hem(13:28,:,:),1);
dthetadp_18_av = mean(dthetadp_18(13:28,:,:),1);
theta_18_av = mean(theta_18_hem(13:28,:,:),1);
thetasq_18_av = mean(thetasq_18_hem(13:28,:,:),1);


dthetadp_18_bzav(:,:) = sum(dthetadp_18_weight,1)./sum(cosy_18) ;
theta_18_bzav(:,:) = sum(theta_18_weight,1)./sum(cosy_18) ;
thetasq_18_bzav(:,:) = sum(thetasq_18_weight,1)./sum(cosy_18) ;
dthetadp_14_bzav(:,:) = sum(dthetadp_14_weight,1)./sum(cosy_14) ;
theta_14_bzav(:,:) = sum(theta_14_weight,1)./sum(cosy_14) ;
thetasq_14_bzav(:,:) = sum(thetasq_14_weight,1)./sum(cosy_14) ;
dthetadp_02_bzav(:,:) = sum(dthetadp_02_weight,1)./sum(cosy_02) ;
theta_02_bzav(:,:) = sum(theta_02_weight,1)./sum(cosy_02) ;
thetasq_02_bzav(:,:) = sum(thetasq_02_weight,1)./sum(cosy_02) ;

%calculate gamma factor
for k=1:25

gamma_14(k,:) = -kappa./rC(k) .* 1./dthetadp_14_bzav(k,:);
gamma_18(k,:) = -kappa./rC(k) .* 1./dthetadp_18_bzav(k,:);
gamma_02(k,:) = -kappa./rC(k) .* 1./dthetadp_02_bzav(k,:);
end

gamma_18_av = mean(gamma_18,2);
gamma_14_av = mean(gamma_14,2);
gamma_02_av = mean(gamma_02,2);

figure
plot(gamma_02_av,rC,'r')
set(gca,'YDir','reverse')
hold on
plot(gamma_14_av,rC,'k')
plot(gamma_18_av,rC,'b')
print('-dpng','gamma_plots.png')

theta_var_18 = mean(thetasq_18_bzav - theta_18_bzav.^2,2);
theta_var_14 = mean(thetasq_14_bzav - theta_14_bzav.^2,2);
theta_var_02 = mean(thetasq_02_bzav - theta_02_bzav.^2,2);

figure
plot(theta_var_02,rC,'r')
set(gca,'YDir','reverse')
hold on
plot(theta_var_14,rC,'k')
plot(theta_var_18,rC,'b')
print('-dpng','theta_var.png')

%calculate integrand
for i=1:2
mape_integrand_18(:,i) = (rC./p0).^kappa .*gamma_18(:,i) .* (thetasq_18_bzav(:,i) - theta_18_bzav(:,i).^2) ;
mape_integrand_14(:,i) = (rC./p0).^kappa .*gamma_14(:,i) .* (thetasq_14_bzav(:,i) - theta_14_bzav(:,i).^2) ;
mape_integrand_02(:,i) = (rC./p0).^kappa .*gamma_02(:,i) .* (thetasq_02_bzav(:,i) - theta_02_bzav(:,i).^2) ;
end

mape_integrand_18_av = mean(mape_integrand_18,2);
mape_integrand_14_av = mean(mape_integrand_14,2);
mape_integrand_02_av = mean(mape_integrand_02,2);

figure
plot(mape_integrand_02_av,rC,'r')
set(gca,'YDir','reverse')
hold on
plot(mape_integrand_14_av,rC,'k')
plot(mape_integrand_18_av,rC,'b')
print('-dpng','mape_integrand.png')


prefac = cp.*p0./2./g;

%integrate
mape_18 = prefac .* sum(mape_integrand_18(3:level_18,:),1) .* 4000./p0;
mape_14 = prefac .* sum(mape_integrand_14(3:level_14,:),1) .* 4000./p0;
mape_02 = prefac .* sum(mape_integrand_02(3:level_02,:),1) .* 4000./p0;

%take average for 2 hemispheres
mape_out_18 = mean(mape_18);
mape_out_14 = mean(mape_14);
mape_out_02 = mean(mape_02);

%save
name = ['mape_out.mat'];
save(name, 'mape_out_18','mape_out_14','mape_out_02')
