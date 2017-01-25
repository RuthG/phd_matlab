
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
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
ny=90;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run %%%%%%%%%%%%%%%%

i=0;
for nit = 86400; %259200:86400:432000;
i=i+1

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5year/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i) = dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearh/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_h(:,:,:,i) = dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/run/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_q(:,:,:,i) = dyn(:,:,:,J);

end

%take average and squares
theta_w_mean = mean(theta_w,4);
theta_h_mean = mean(theta_h,4);
theta_q_mean = mean(theta_q,4);

xi=-179:2:180;yi=-89:2:90;
thetall_w=cube2latlon(xc,yc,theta_w_mean,xi,yi);
thetall_h=cube2latlon(xc,yc,theta_h_mean,xi,yi);
thetall_q=cube2latlon(xc,yc,theta_q_mean,xi,yi);
theta_w_zav(:,:) = mean(thetall_w,1);
theta_h_zav(:,:) = mean(thetall_h,1);
theta_q_zav(:,:) = mean(thetall_q,1);
thetasq_w_zav = theta_w_zav.^2;
thetasq_h_zav = theta_h_zav.^2;
thetasq_q_zav = theta_q_zav.^2;

%convert to two hemispheres
theta_w_hem(:,:,1) = theta_w_zav(46:90,:);
theta_h_hem(:,:,1) = theta_h_zav(46:90,:);
theta_q_hem(:,:,1) = theta_q_zav(46:90,:);
thetasq_w_hem(:,:,1) = thetasq_w_zav(46:90,:);
thetasq_h_hem(:,:,1) = thetasq_h_zav(46:90,:);
thetasq_q_hem(:,:,1) = thetasq_q_zav(46:90,:);
for i=1:45
theta_w_hem(i,:,2) = theta_w_zav(46-i,:);
theta_h_hem(i,:,2) = theta_h_zav(46-i,:);
theta_q_hem(i,:,2) = theta_q_zav(46-i,:);
thetasq_w_hem(i,:,2) = thetasq_w_zav(46-i,:);
thetasq_h_hem(i,:,2) = thetasq_h_zav(46-i,:);
thetasq_q_hem(i,:,2) = thetasq_q_zav(46-i,:);
end

%consts
cp = 1004.64;
p0 = 100000;
g = 9.8;
kappa = 2/7;

%take vertical gradient
dthetadp_w = gradient(theta_w_hem,-4000);
dthetadp_h = gradient(theta_h_hem,-4000);
dthetadp_q = gradient(theta_q_hem,-4000);

%load up baroclinic zone
name = ['bc_box_sh.mat'];
load(name)
if mod(barzon_lats_w(1),2) == 0
barzon_reg_w = barzon_lats_w(1)+1:2:barzon_lats_w(2)+1;
else
barzon_reg_w = barzon_lats_w(1):2:barzon_lats_w(2);
end

if mod(barzon_lats_h(1),2) == 0
barzon_reg_h = barzon_lats_h(1)+1:2:barzon_lats_h(2)+1;
else
barzon_reg_h = barzon_lats_h(1):2:barzon_lats_h(2);
end

if mod(barzon_lats_q(1),2) == 0
barzon_reg_q = barzon_lats_q(1)+1:2:barzon_lats_q(2)+1;
else
barzon_reg_q = barzon_lats_q(1):2:barzon_lats_q(2);
end

%set up loop
ylat2=1:2:89;
start_w = find(ylat2 == min(barzon_reg_w))-1;
start_h = find(ylat2 == min(barzon_reg_h))-1;
start_q = find(ylat2 == min(barzon_reg_q))-1;

%integrate over the sphere then divide by total area
for i=1:size(barzon_reg_w,2)
dthetadp_w_weight(i,:,:) = cos(barzon_reg_w(i).*pi./180) .* dthetadp_w(start_w+i,:,:) ;
theta_w_weight(i,:,:) = cos(barzon_reg_w(i).*pi./180) .* theta_w_hem(start_w+i,:,:) ;
thetasq_w_weight(i,:,:) = cos(barzon_reg_w(i).*pi./180) .* thetasq_w_hem(start_w+i,:,:) ;
cosy_w(i) = cos(barzon_reg_w(i).*pi./180);
end

for i=1:size(barzon_reg_h,2)
dthetadp_h_weight(i,:,:) = cos(barzon_reg_h(i).*pi./180) .* dthetadp_h(start_h+i,:,:) ;
theta_h_weight(i,:,:) = cos(barzon_reg_h(i).*pi./180) .* theta_h_hem(start_h+i,:,:) ;
thetasq_h_weight(i,:,:) = cos(barzon_reg_h(i).*pi./180) .* thetasq_h_hem(start_h+i,:,:) ;
cosy_h(i) = cos(barzon_reg_h(i).*pi./180);
end

for i=1:size(barzon_reg_q,2)
dthetadp_q_weight(i,:,:) = cos(barzon_reg_q(i).*pi./180) .* dthetadp_q(start_q+i,:,:) ;
theta_q_weight(i,:,:) = cos(barzon_reg_q(i).*pi./180) .* theta_q_hem(start_q+i,:,:) ;
thetasq_q_weight(i,:,:) = cos(barzon_reg_q(i).*pi./180) .* thetasq_q_hem(start_q+i,:,:) ;
cosy_q(i) = cos(barzon_reg_q(i).*pi./180);
end


dthetadp_w_bzav(:,:) = sum(dthetadp_w_weight,1)./sum(cosy_w) ;
dthetadp_h_bzav(:,:) = sum(dthetadp_h_weight,1)./sum(cosy_h) ;
dthetadp_q_bzav(:,:) = sum(dthetadp_q_weight,1)./sum(cosy_q) ;
theta_w_bzav(:,:) = sum(theta_w_weight,1)./sum(cosy_w) ;
theta_h_bzav(:,:) = sum(theta_h_weight,1)./sum(cosy_h) ;
theta_q_bzav(:,:) = sum(theta_q_weight,1)./sum(cosy_q) ;
thetasq_w_bzav(:,:) = sum(thetasq_w_weight,1)./sum(cosy_w) ;
thetasq_h_bzav(:,:) = sum(thetasq_h_weight,1)./sum(cosy_h) ;
thetasq_q_bzav(:,:) = sum(thetasq_q_weight,1)./sum(cosy_q) ;

%calculate gamma factor
for k=1:25
gamma_w(k,:) = -kappa./rC(k) .* 1./dthetadp_w_bzav(k,:);
gamma_h(k,:) = -kappa./rC(k) .* 1./dthetadp_h_bzav(k,:);
gamma_q(k,:) = -kappa./rC(k) .* 1./dthetadp_q_bzav(k,:);
end

gamma_w_av = mean(gamma_w,2);
gamma_h_av = mean(gamma_h,2);
gamma_q_av = mean(gamma_q,2);

figure
plot(gamma_w_av,rC,'k')
hold on
plot(gamma_h_av,rC)
plot(gamma_q_av,rC,'r')
set(gca,'YDir','reverse')
print('-dpng','gamma_plotssh.png')

theta_var_w = mean(thetasq_w_bzav - theta_w_bzav.^2,2);
theta_var_h = mean(thetasq_h_bzav - theta_h_bzav.^2,2);
theta_var_q = mean(thetasq_q_bzav - theta_q_bzav.^2,2);

figure
plot(theta_var_w,rC,'k')
hold on
plot(theta_var_h,rC)
plot(theta_var_q,rC,'r')
set(gca,'YDir','reverse')
print('-dpng','theta_varsh.png')

%calculate integrand
for i=1:2
mape_integrand_w(:,i) = (rC./p0).^kappa .*gamma_w(:,i) .* (thetasq_w_bzav(:,i) - theta_w_bzav(:,i).^2) ;
mape_integrand_h(:,i) = (rC./p0).^kappa .*gamma_h(:,i) .* (thetasq_h_bzav(:,i) - theta_h_bzav(:,i).^2) ;
mape_integrand_q(:,i) = (rC./p0).^kappa .*gamma_q(:,i) .* (thetasq_q_bzav(:,i) - theta_q_bzav(:,i).^2) ;
end

mape_integrand_w_av = mean(mape_integrand_w,2);
mape_integrand_h_av = mean(mape_integrand_h,2);
mape_integrand_q_av = mean(mape_integrand_q,2);

figure
plot(mape_integrand_w_av,rC,'k')
hold on
plot(mape_integrand_h_av,rC)
plot(mape_integrand_q_av,rC,'r')
set(gca,'YDir','reverse')
print('-dpng','mape_integrandsh.png')


prefac = cp.*p0./2./g;

%integrate
mape_w = prefac .* sum(mape_integrand_w(3:level_w,:),1) .* 4000./p0;
mape_h = prefac .* sum(mape_integrand_h(3:level_h,:),1) .* 4000./p0;
mape_q = prefac .* sum(mape_integrand_q(3:level_q,:),1) .* 4000./p0;

%take average for 2 hemispheres
mape_out_w = mean(mape_w);
mape_out_h = mean(mape_h);
mape_out_q = mean(mape_q);

%save
name = ['mape_out_sh.mat'];
save(name, 'mape_out_w','mape_out_h','mape_out_q')
