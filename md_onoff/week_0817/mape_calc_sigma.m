% choose directory, load grid
rDir='/project/rg312/final_runs/run_000_final_noshallow/';
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

%consts
cp = 1004.64;
p0 = 100000;
g = 9.8;
kappa = 2/7;
prefac = cp.*p0./2./g;


load('/net/spat-nas/project/rg312/mat_files/vt_lats_final.mat');
load('/net/spat-nas/project/rg312/mat_files/trop_levs_final.mat');


load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_100.mat','theta_tav')
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav(:,:) = mean(thetall,1);
thetasq_zav = theta_zav.^2;
dthetadp = gradient(theta_zav,-4000);
for i=1:90
dthetadp_weight(i,:) = cos(yi(i).*pi./180) .* dthetadp(i,:) ;
theta_weight(i,:) = cos(yi(i).*pi./180) .* theta_zav(i,:) ;
thetasq_weight(i,:) = cos(yi(i).*pi./180) .* thetasq_zav(i,:) ;
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

for k=1:25
gamma_100(k) = -kappa./rC(k) .* 1./dthetadp_mean(k);
end
theta_var_100 = thetasq_mean - theta_mean.^2;
mape_integrand_100 = (rC'./p0).^kappa .*gamma_100 .* theta_var_100 ;
mape_100 = prefac .* sum(mape_integrand_100(3:trop_lev_100(x100n))) .* 4000./p0;




return

save('/project/rg312/mat_files/chapter2_variables/mape_baroclinic_zone_sigma.mat','mape_100')
