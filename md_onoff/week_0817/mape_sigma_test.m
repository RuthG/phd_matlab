%load up 1 yr of theta snapshots for 100 run and reevaluate means for mape using these.

rDir='/project/rg312/final_runs/run_100_final/';
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
xi=-179:2:180;
yi=-89:2:90;

load('/net/spat-nas/project/rg312/mat_files/vt_lats_final.mat');
load('/net/spat-nas/project/rg312/mat_files/trop_levs_final.mat');

load('/project/rg312/mat_files/snapshot_data_final/run_100/eta_100_1.mat')
load('/project/rg312/mat_files/snapshot_data_final/run_100/theta_100_1.mat')

eta_100_ll = cube2latlon(xc,yc,eta_100,xi,yi);
theta_100_ll = cube2latlon(xc,yc,theta_100,xi,yi);
[a,b,dthetadp,c] = gradient(theta_100_ll,-4000);
clear('a','b','c')

p0=100000.0;
ps=p0+eta_100_ll;

for j=1:360
j
for i=1:25
theta_sigma(:,:,i,j) = theta_100_ll(:,:,i,j).*ps(:,:,j);
dthetadp_sigma(:,:,i,j) = dthetadp(:,:,i,j).*ps(:,:,j);
end
end

ps_tzav = mean(mean(ps,1),3);

for i=1:90
theta_sigma(:,i,:,:) = theta_sigma(:,i,:,:)./ps_tzav(i);
dthetadp_sigma(:,i,:,:) = dthetadp_sigma(:,i,:,:)./ps_tzav(i);
end

theta_zav(:,:) = mean(mean(theta_sigma,1),4);
thetasq_zav = theta_zav.^2;
dthetadp_zav(:,:) = mean(mean(dthetadp_sigma,1),4);

for i=1:90
dthetadp_weight(i,:) = cos(yi(i).*pi./180) .* dthetadp_zav(i,:) .*ps_tzav(i)./p0 ;
theta_weight(i,:) = cos(yi(i).*pi./180) .* theta_zav(i,:) .*ps_tzav(i)./p0;
thetasq_weight(i,:) = cos(yi(i).*pi./180) .* thetasq_zav(i,:) .*ps_tzav(i)./p0;
end


dthetadp_mean_n = sum(dthetadp_weight(x100n-7:x100n+7,:),1)./sum(cos(yi(x100n-7:x100n+7).*pi./180));
dthetadp_mean_s = sum(dthetadp_weight(x100s-7:x100s+7,:),1)./sum(cos(yi(x100s-7:x100s+7).*pi./180));
dthetadp_mean = (dthetadp_mean_n+dthetadp_mean_s)./2;

theta_mean_n = sum(theta_weight(x100n-7:x100n+7,:),1)./sum(cos(yi(x100n-7:x100n+7).*pi./180));
theta_mean_s = sum(theta_weight(x100s-7:x100s+7,:),1)./sum(cos(yi(x100s-7:x100s+7).*pi./180));
theta_mean = (theta_mean_n + theta_mean_s)./2;

thetasq_mean_n = sum(thetasq_weight(x100n-7:x100n+7,:),1)./sum(cos(yi(x100n-7:x100n+7).*pi./180));
thetasq_mean_s = sum(thetasq_weight(x100s-7:x100s+7,:),1)./sum(cos(yi(x100s-7:x100s+7).*pi./180));
thetasq_mean = (thetasq_mean_n + thetasq_mean_s)./2;

%consts
cp = 1004.64;
p0 = 100000;
g = 9.8;
kappa = 2/7;
prefac = cp.*p0./2./g;


for k=1:25
gamma_100(k) = -kappa./rC(k) .* 1./dthetadp_mean(k);
end
theta_var_100 = thetasq_mean - theta_mean.^2;
mape_integrand_100 = (rC'./p0).^kappa .*gamma_100 .* theta_var_100 ;
mape_100 = prefac .* sum(mape_integrand_100(3:trop_lev_100(x100n))) .* 4000./p0;

