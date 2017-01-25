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


load('/net/spat-nas/project/rg312/mat_files/vthcos_lats_final.mat');
load('/net/spat-nas/project/rg312/mat_files/trop_levs_final_th.mat');
x000n = x000+45; x000s = 46-x000;
x010n = x010+45; x010s = 46-x010;
x025n = x025+45; x025s = 46-x025;
x050n = x050+45; x050s = 46-x050;
xthn = xth+45; xths = 46-xth;
x075n = x075+45; x075s = 46-x075;
x100n = x100+45; x100s = 46-x100;
x125n = x125+45; x125s = 46-x125;
x150n = x150+45; x150s = 46-x150;

load('/project/rg312/mat_files/blayer_levs_final_th.mat');
load('/project/rg312/mat_files/blayer_levs_final.mat');

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_000.mat','theta_tav')
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav(:,:) = mean(thetall,1);
thetasq_zav = theta_zav.^2;
dthetadp = gradient(theta_zav,-4000);
for i=1:90
dthetadp_weight(i,:) = cos(yi(i).*pi./180) .* dthetadp(i,:) ;
theta_weight(i,:) = cos(yi(i).*pi./180) .* theta_zav(i,:) ;
thetasq_weight(i,:) = cos(yi(i).*pi./180) .* thetasq_zav(i,:) ;
end

dthetadp_mean_n = sum(dthetadp_weight(x000n-7:x000n+7,:),1)./sum(cos(yi(x000n-7:x000n+7).*pi./180));
dthetadp_mean_s = sum(dthetadp_weight(x000s-7:x000s+7,:),1)./sum(cos(yi(x000s-7:x000s+7).*pi./180));
dthetadp_mean = (dthetadp_mean_n+dthetadp_mean_s)./2;

theta_mean_n = sum(theta_weight(x000n-7:x000n+7,:),1)./sum(cos(yi(x000n-7:x000n+7).*pi./180));
theta_mean_s = sum(theta_weight(x000s-7:x000s+7,:),1)./sum(cos(yi(x000s-7:x000s+7).*pi./180));
theta_mean = (theta_mean_n + theta_mean_s)./2;

thetasq_mean_n = sum(thetasq_weight(x000n-7:x000n+7,:),1)./sum(cos(yi(x000n-7:x000n+7).*pi./180));
thetasq_mean_s = sum(thetasq_weight(x000s-7:x000s+7,:),1)./sum(cos(yi(x000s-7:x000s+7).*pi./180));
thetasq_mean = (thetasq_mean_n + thetasq_mean_s)./2;

for k=1:25
gamma_000(k) = -kappa./rC(k) .* 1./dthetadp_mean(k);
end
theta_var_000 = thetasq_mean - theta_mean.^2;
mape_integrand_000 = (rC'./p0).^kappa .*gamma_000 .* theta_var_000 ;
mape_000 = prefac .* sum(mape_integrand_000(3:trop_lev_000(x000n))) .* 4000./p0;
%mape_000 = prefac .* sum(mape_integrand_000(b_lev_000(x000n) :trop_lev_000(x000n))) .* 4000./p0./(trop_lev_000(x000n)- b_lev_000(x000n) +1);





load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_010.mat','theta_tav')
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav(:,:) = mean(thetall,1);
thetasq_zav = theta_zav.^2;
dthetadp = gradient(theta_zav,-4000);
for i=1:90
dthetadp_weight(i,:) = cos(yi(i).*pi./180) .* dthetadp(i,:) ;
theta_weight(i,:) = cos(yi(i).*pi./180) .* theta_zav(i,:) ;
thetasq_weight(i,:) = cos(yi(i).*pi./180) .* thetasq_zav(i,:) ;
end

dthetadp_mean_n = sum(dthetadp_weight(x010n-7:x010n+7,:),1)./sum(cos(yi(x010n-7:x010n+7).*pi./180));
dthetadp_mean_s = sum(dthetadp_weight(x010s-7:x010s+7,:),1)./sum(cos(yi(x010s-7:x010s+7).*pi./180));
dthetadp_mean = (dthetadp_mean_n+dthetadp_mean_s)./2;

theta_mean_n = sum(theta_weight(x010n-7:x010n+7,:),1)./sum(cos(yi(x010n-7:x010n+7).*pi./180));
theta_mean_s = sum(theta_weight(x010s-7:x010s+7,:),1)./sum(cos(yi(x010s-7:x010s+7).*pi./180));
theta_mean = (theta_mean_n + theta_mean_s)./2;

thetasq_mean_n = sum(thetasq_weight(x010n-7:x010n+7,:),1)./sum(cos(yi(x010n-7:x010n+7).*pi./180));
thetasq_mean_s = sum(thetasq_weight(x010s-7:x010s+7,:),1)./sum(cos(yi(x010s-7:x010s+7).*pi./180));
thetasq_mean = (thetasq_mean_n + thetasq_mean_s)./2;

for k=1:25
gamma_010(k) = -kappa./rC(k) .* 1./dthetadp_mean(k);
end
theta_var_010 = thetasq_mean - theta_mean.^2;
mape_integrand_010 = (rC'./p0).^kappa .*gamma_010 .* theta_var_010 ;
mape_010 = prefac .* sum(mape_integrand_010(3:trop_lev_010(x010n))) .* 4000./p0;
%mape_010 = prefac .* sum(mape_integrand_000(b_lev_010(x010n) :trop_lev_010(x010n))) .* 4000./p0./(trop_lev_010(x010n)- b_lev_010(x010n) +1);






load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_025.mat','theta_tav')
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav(:,:) = mean(thetall,1);
thetasq_zav = theta_zav.^2;
dthetadp = gradient(theta_zav,-4000);
for i=1:90
dthetadp_weight(i,:) = cos(yi(i).*pi./180) .* dthetadp(i,:) ;
theta_weight(i,:) = cos(yi(i).*pi./180) .* theta_zav(i,:) ;
thetasq_weight(i,:) = cos(yi(i).*pi./180) .* thetasq_zav(i,:) ;
end

dthetadp_mean_n = sum(dthetadp_weight(x025n-7:x025n+7,:),1)./sum(cos(yi(x025n-7:x025n+7).*pi./180));
dthetadp_mean_s = sum(dthetadp_weight(x025s-7:x025s+7,:),1)./sum(cos(yi(x025s-7:x025s+7).*pi./180));
dthetadp_mean = (dthetadp_mean_n+dthetadp_mean_s)./2;

theta_mean_n = sum(theta_weight(x025n-7:x025n+7,:),1)./sum(cos(yi(x025n-7:x025n+7).*pi./180));
theta_mean_s = sum(theta_weight(x025s-7:x025s+7,:),1)./sum(cos(yi(x025s-7:x025s+7).*pi./180));
theta_mean = (theta_mean_n + theta_mean_s)./2;

thetasq_mean_n = sum(thetasq_weight(x025n-7:x025n+7,:),1)./sum(cos(yi(x025n-7:x025n+7).*pi./180));
thetasq_mean_s = sum(thetasq_weight(x025s-7:x025s+7,:),1)./sum(cos(yi(x025s-7:x025s+7).*pi./180));
thetasq_mean = (thetasq_mean_n + thetasq_mean_s)./2;

for k=1:25
gamma_025(k) = -kappa./rC(k) .* 1./dthetadp_mean(k);
end
theta_var_025 = thetasq_mean - theta_mean.^2;
mape_integrand_025 = (rC'./p0).^kappa .*gamma_025 .* theta_var_025 ;
mape_025 = prefac .* sum(mape_integrand_025(3:trop_lev_025(x025n))) .* 4000./p0;
%mape_025 = prefac .* sum(mape_integrand_000(b_lev_025(x025n) :trop_lev_025(x025n))) .* 4000./p0./(trop_lev_025(x025n)- b_lev_025(x025n) +1);






load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_050.mat','theta_tav')
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav(:,:) = mean(thetall,1);
thetasq_zav = theta_zav.^2;
dthetadp = gradient(theta_zav,-4000);
for i=1:90
dthetadp_weight(i,:) = cos(yi(i).*pi./180) .* dthetadp(i,:) ;
theta_weight(i,:) = cos(yi(i).*pi./180) .* theta_zav(i,:) ;
thetasq_weight(i,:) = cos(yi(i).*pi./180) .* thetasq_zav(i,:) ;
end

dthetadp_mean_n = sum(dthetadp_weight(x050n-7:x050n+7,:),1)./sum(cos(yi(x050n-7:x050n+7).*pi./180));
dthetadp_mean_s = sum(dthetadp_weight(x050s-7:x050s+7,:),1)./sum(cos(yi(x050s-7:x050s+7).*pi./180));
dthetadp_mean = (dthetadp_mean_n+dthetadp_mean_s)./2;

theta_mean_n = sum(theta_weight(x050n-7:x050n+7,:),1)./sum(cos(yi(x050n-7:x050n+7).*pi./180));
theta_mean_s = sum(theta_weight(x050s-7:x050s+7,:),1)./sum(cos(yi(x050s-7:x050s+7).*pi./180));
theta_mean = (theta_mean_n + theta_mean_s)./2;

thetasq_mean_n = sum(thetasq_weight(x050n-7:x050n+7,:),1)./sum(cos(yi(x050n-7:x050n+7).*pi./180));
thetasq_mean_s = sum(thetasq_weight(x050s-7:x050s+7,:),1)./sum(cos(yi(x050s-7:x050s+7).*pi./180));
thetasq_mean = (thetasq_mean_n + thetasq_mean_s)./2;

for k=1:25
gamma_050(k) = -kappa./rC(k) .* 1./dthetadp_mean(k);
end
theta_var_050 = thetasq_mean - theta_mean.^2;
mape_integrand_050 = (rC'./p0).^kappa .*gamma_050 .* theta_var_050 ;
mape_050 = prefac .* sum(mape_integrand_050(3:trop_lev_050(x050n))) .* 4000./p0;
%mape_050 = prefac .* sum(mape_integrand_050(b_lev_050(x050n) :trop_lev_050(x050n))) .* 4000./p0./(trop_lev_050(x050n)- b_lev_050(x050n) +1);






load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_050_tropheat.mat','theta_tav')
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav(:,:) = mean(thetall,1);
thetasq_zav = theta_zav.^2;
dthetadp = gradient(theta_zav,-4000);
for i=1:90
dthetadp_weight(i,:) = cos(yi(i).*pi./180) .* dthetadp(i,:) ;
theta_weight(i,:) = cos(yi(i).*pi./180) .* theta_zav(i,:) ;
thetasq_weight(i,:) = cos(yi(i).*pi./180) .* thetasq_zav(i,:) ;
end

dthetadp_mean_n = sum(dthetadp_weight(xthn-7:xthn+7,:),1)./sum(cos(yi(xthn-7:xthn+7).*pi./180));
dthetadp_mean_s = sum(dthetadp_weight(xths-7:xths+7,:),1)./sum(cos(yi(xths-7:xths+7).*pi./180));
dthetadp_mean = (dthetadp_mean_n+dthetadp_mean_s)./2;

theta_mean_n = sum(theta_weight(xthn-7:xthn+7,:),1)./sum(cos(yi(xthn-7:xthn+7).*pi./180));
theta_mean_s = sum(theta_weight(xths-7:xths+7,:),1)./sum(cos(yi(xths-7:xths+7).*pi./180));
theta_mean = (theta_mean_n + theta_mean_s)./2;

thetasq_mean_n = sum(thetasq_weight(xthn-7:xthn+7,:),1)./sum(cos(yi(xthn-7:xthn+7).*pi./180));
thetasq_mean_s = sum(thetasq_weight(xths-7:xths+7,:),1)./sum(cos(yi(xths-7:xths+7).*pi./180));
thetasq_mean = (thetasq_mean_n + thetasq_mean_s)./2;

for k=1:25
gamma_th(k) = -kappa./rC(k) .* 1./dthetadp_mean(k);
end
theta_var_th = thetasq_mean - theta_mean.^2;
mape_integrand_th = (rC'./p0).^kappa .*gamma_th .* theta_var_th ;
mape_th = prefac .* sum(mape_integrand_th(3:trop_lev_th(xthn))) .* 4000./p0;
%mape_th = prefac .* sum(mape_integrand_th(b_lev_th(xthn) :trop_lev_th(xthn))) .* 4000./p0./(trop_lev_th(xthn)- b_lev_th(xthn) +1);







load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_075.mat','theta_tav')
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav(:,:) = mean(thetall,1);
thetasq_zav = theta_zav.^2;
dthetadp = gradient(theta_zav,-4000);
for i=1:90
dthetadp_weight(i,:) = cos(yi(i).*pi./180) .* dthetadp(i,:) ;
theta_weight(i,:) = cos(yi(i).*pi./180) .* theta_zav(i,:) ;
thetasq_weight(i,:) = cos(yi(i).*pi./180) .* thetasq_zav(i,:) ;
end

dthetadp_mean_n = sum(dthetadp_weight(x075n-7:x075n+7,:),1)./sum(cos(yi(x075n-7:x075n+7).*pi./180));
dthetadp_mean_s = sum(dthetadp_weight(x075s-7:x075s+7,:),1)./sum(cos(yi(x075s-7:x075s+7).*pi./180));
dthetadp_mean = (dthetadp_mean_n+dthetadp_mean_s)./2;

theta_mean_n = sum(theta_weight(x075n-7:x075n+7,:),1)./sum(cos(yi(x075n-7:x075n+7).*pi./180));
theta_mean_s = sum(theta_weight(x075s-7:x075s+7,:),1)./sum(cos(yi(x075s-7:x075s+7).*pi./180));
theta_mean = (theta_mean_n + theta_mean_s)./2;

thetasq_mean_n = sum(thetasq_weight(x075n-7:x075n+7,:),1)./sum(cos(yi(x075n-7:x075n+7).*pi./180));
thetasq_mean_s = sum(thetasq_weight(x075s-7:x075s+7,:),1)./sum(cos(yi(x075s-7:x075s+7).*pi./180));
thetasq_mean = (thetasq_mean_n + thetasq_mean_s)./2;

for k=1:25
gamma_075(k) = -kappa./rC(k) .* 1./dthetadp_mean(k);
end
theta_var_075 = thetasq_mean - theta_mean.^2;
mape_integrand_075 = (rC'./p0).^kappa .*gamma_075 .* theta_var_075 ;
mape_075 = prefac .* sum(mape_integrand_075(3:trop_lev_075(x075n))) .* 4000./p0;
%mape_075 = prefac .* sum(mape_integrand_075(b_lev_000(x075n) :trop_lev_075(x075n))) .* 4000./p0./(trop_lev_075(x075n)- b_lev_075(x075n) +1);










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
%mape_100 = prefac .* sum(mape_integrand_100(b_lev_100(x100n) :trop_lev_100(x100n))) .* 4000./p0./(trop_lev_100(x100n)- b_lev_100(x100n) +1);










load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_125.mat','theta_tav')
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav(:,:) = mean(thetall,1);
thetasq_zav = theta_zav.^2;
dthetadp = gradient(theta_zav,-4000);
for i=1:90
dthetadp_weight(i,:) = cos(yi(i).*pi./180) .* dthetadp(i,:) ;
theta_weight(i,:) = cos(yi(i).*pi./180) .* theta_zav(i,:) ;
thetasq_weight(i,:) = cos(yi(i).*pi./180) .* thetasq_zav(i,:) ;
end

dthetadp_mean_n = sum(dthetadp_weight(x125n-7:x125n+7,:),1)./sum(cos(yi(x125n-7:x125n+7).*pi./180));
dthetadp_mean_s = sum(dthetadp_weight(x125s-7:x125s+7,:),1)./sum(cos(yi(x125s-7:x125s+7).*pi./180));
dthetadp_mean = (dthetadp_mean_n+dthetadp_mean_s)./2;

theta_mean_n = sum(theta_weight(x125n-7:x125n+7,:),1)./sum(cos(yi(x125n-7:x125n+7).*pi./180));
theta_mean_s = sum(theta_weight(x125s-7:x125s+7,:),1)./sum(cos(yi(x125s-7:x125s+7).*pi./180));
theta_mean = (theta_mean_n + theta_mean_s)./2;

thetasq_mean_n = sum(thetasq_weight(x125n-7:x125n+7,:),1)./sum(cos(yi(x125n-7:x125n+7).*pi./180));
thetasq_mean_s = sum(thetasq_weight(x125s-7:x125s+7,:),1)./sum(cos(yi(x125s-7:x125s+7).*pi./180));
thetasq_mean = (thetasq_mean_n + thetasq_mean_s)./2;

for k=1:25
gamma_125(k) = -kappa./rC(k) .* 1./dthetadp_mean(k);
end
theta_var_125 = thetasq_mean - theta_mean.^2;
mape_integrand_125 = (rC'./p0).^kappa .*gamma_125 .* theta_var_125 ;
mape_125 = prefac .* sum(mape_integrand_125(3:trop_lev_125(x125n))) .* 4000./p0;
%mape_125 = prefac .* sum(mape_integrand_125(b_lev_125(x125n) :trop_lev_125(x125n))) .* 4000./p0./(trop_lev_125(x125n)- b_lev_125(x125n) +1);









load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_150.mat','theta_tav')
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav(:,:) = mean(thetall,1);
thetasq_zav = theta_zav.^2;
dthetadp = gradient(theta_zav,-4000);
for i=1:90
dthetadp_weight(i,:) = cos(yi(i).*pi./180) .* dthetadp(i,:) ;
theta_weight(i,:) = cos(yi(i).*pi./180) .* theta_zav(i,:) ;
thetasq_weight(i,:) = cos(yi(i).*pi./180) .* thetasq_zav(i,:) ;
end

dthetadp_mean_n = sum(dthetadp_weight(x150n-7:x150n+7,:),1)./sum(cos(yi(x150n-7:x150n+7).*pi./180));
dthetadp_mean_s = sum(dthetadp_weight(x150s-7:x150s+7,:),1)./sum(cos(yi(x150s-7:x150s+7).*pi./180));
dthetadp_mean = (dthetadp_mean_n+dthetadp_mean_s)./2;

theta_mean_n = sum(theta_weight(x150n-7:x150n+7,:),1)./sum(cos(yi(x150n-7:x150n+7).*pi./180));
theta_mean_s = sum(theta_weight(x150s-7:x150s+7,:),1)./sum(cos(yi(x150s-7:x150s+7).*pi./180));
theta_mean = (theta_mean_n + theta_mean_s)./2;

thetasq_mean_n = sum(thetasq_weight(x150n-7:x150n+7,:),1)./sum(cos(yi(x150n-7:x150n+7).*pi./180));
thetasq_mean_s = sum(thetasq_weight(x150s-7:x150s+7,:),1)./sum(cos(yi(x150s-7:x150s+7).*pi./180));
thetasq_mean = (thetasq_mean_n + thetasq_mean_s)./2;

for k=1:25
gamma_150(k) = -kappa./rC(k) .* 1./dthetadp_mean(k);
end
theta_var_150 = thetasq_mean - theta_mean.^2;
mape_integrand_150 = (rC'./p0).^kappa .*gamma_150 .* theta_var_150 ;
mape_150 = prefac .* sum(mape_integrand_150(3:trop_lev_150(x150n))) .* 4000./p0;
%mape_150 = prefac .* sum(mape_integrand_150(b_lev_150(x150n) :trop_lev_150(x150n))) .* 4000./p0 ./(trop_lev_150(x150n)- b_lev_150(x150n) +1);



save('/project/rg312/mat_files/chapter2_variables/mape_baroclinic_zone_vthcos.mat', 'mape_000', 'mape_010', 'mape_025', 'mape_050', 'mape_th', 'mape_075', 'mape_100', 'mape_125', 'mape_150')
