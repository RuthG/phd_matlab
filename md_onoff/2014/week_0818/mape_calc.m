
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
for nit = 259200:86400:432000;
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

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearq/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_q(:,:,:,i) = dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yeard/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_d(:,:,:,i) = dyn(:,:,:,J);

end

%take average and squares
theta_w_mean = mean(theta_w,4);
theta_h_mean = mean(theta_h,4);
theta_q_mean = mean(theta_q,4);
theta_d_mean = mean(theta_d,4);

xi=-179:2:180;yi=-89:2:90;
thetall_w=cube2latlon(xc,yc,theta_w_mean,xi,yi);
thetall_h=cube2latlon(xc,yc,theta_h_mean,xi,yi);
thetall_q=cube2latlon(xc,yc,theta_q_mean,xi,yi);
thetall_d=cube2latlon(xc,yc,theta_d_mean,xi,yi);
theta_w_zav(:,:) = mean(thetall_w,1);
theta_h_zav(:,:) = mean(thetall_h,1);
theta_q_zav(:,:) = mean(thetall_q,1);
theta_d_zav(:,:) = mean(thetall_d,1);
thetasq_w_zav = theta_w_zav.^2;
thetasq_h_zav = theta_h_zav.^2;
thetasq_q_zav = theta_q_zav.^2;
thetasq_d_zav = theta_d_zav.^2;

%convert to two hemispheres
theta_w_hem(:,:,1) = theta_w_zav(46:90,:);
theta_h_hem(:,:,1) = theta_h_zav(46:90,:);
theta_q_hem(:,:,1) = theta_q_zav(46:90,:);
theta_d_hem(:,:,1) = theta_d_zav(46:90,:);
thetasq_w_hem(:,:,1) = thetasq_w_zav(46:90,:);
thetasq_h_hem(:,:,1) = thetasq_h_zav(46:90,:);
thetasq_q_hem(:,:,1) = thetasq_q_zav(46:90,:);
thetasq_d_hem(:,:,1) = thetasq_d_zav(46:90,:);
for i=1:45
theta_w_hem(i,:,2) = theta_w_zav(46-i,:);
theta_h_hem(i,:,2) = theta_h_zav(46-i,:);
theta_q_hem(i,:,2) = theta_q_zav(46-i,:);
theta_d_hem(i,:,2) = theta_d_zav(46-i,:);
thetasq_w_hem(i,:,2) = thetasq_w_zav(46-i,:);
thetasq_h_hem(i,:,2) = thetasq_h_zav(46-i,:);
thetasq_q_hem(i,:,2) = thetasq_q_zav(46-i,:);
thetasq_d_hem(i,:,2) = thetasq_d_zav(46-i,:);
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
dthetadp_d = gradient(theta_d_hem,-4000);

%load up baroclinic zone
name = ['bc_box_w.mat'];
load(name)
if mod(barzon_lats_w(1),2) == 0
barzon_reg_w = barzon_lats_w(1)+1:2:barzon_lats_w(2)+1;
else
barzon_reg_w = barzon_lats_w(1):2:barzon_lats_w(2);
end
name = ['bc_box_h.mat'];
load(name)
if mod(barzon_lats_h(1),2) == 0
barzon_reg_h = barzon_lats_h(1)+1:2:barzon_lats_h(2)+1;
else
barzon_reg_h = barzon_lats_h(1):2:barzon_lats_h(2);
end
name = ['bc_box_q.mat'];
load(name)
if mod(barzon_lats_q(1),2) == 0
barzon_reg_q = barzon_lats_q(1)+1:2:barzon_lats_q(2)+1;
else
barzon_reg_q = barzon_lats_q(1):2:barzon_lats_q(2);
end
name = ['bc_box_d.mat'];
load(name)
if mod(barzon_lats_d(1),2) == 0
barzon_reg_d = barzon_lats_d(1)+1:2:barzon_lats_d(2)+1;
else
barzon_reg_d = barzon_lats_d(1):2:barzon_lats_d(2);
end

%set up loop
ylat2=1:2:89;
start_w = find(ylat2 == min(barzon_reg_w))-1;
start_h = find(ylat2 == min(barzon_reg_h))-1;
start_q = find(ylat2 == min(barzon_reg_q))-1;
start_d = find(ylat2 == min(barzon_reg_d))-1;

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
for i=1:size(barzon_reg_d,2)
dthetadp_d_weight(i,:,:) = cos(barzon_reg_d(i).*pi./180) .* dthetadp_d(start_d+i,:,:) ;
theta_d_weight(i,:,:) = cos(barzon_reg_d(i).*pi./180) .* theta_d_hem(start_d+i,:,:) ;
thetasq_d_weight(i,:,:) = cos(barzon_reg_d(i).*pi./180) .* thetasq_d_hem(start_d+i,:,:) ;
cosy_d(i) = cos(barzon_reg_d(i).*pi./180);
end



%take straight average to compare
dthetadp_w_av = mean(dthetadp_w(13:28,:,:),1);
theta_w_av = mean(theta_w_hem(13:28,:,:),1);
thetasq_w_av = mean(thetasq_w_hem(13:28,:,:),1);
dthetadp_h_av = mean(dthetadp_h(13:28,:,:),1);
theta_h_av = mean(theta_h_hem(13:28,:,:),1);
thetasq_h_av = mean(thetasq_h_hem(13:28,:,:),1);
dthetadp_q_av = mean(dthetadp_q(13:28,:,:),1);
theta_q_av = mean(theta_q_hem(13:28,:,:),1);
thetasq_q_av = mean(thetasq_q_hem(13:28,:,:),1);
dthetadp_d_av = mean(dthetadp_d(13:28,:,:),1);
theta_d_av = mean(theta_d_hem(13:28,:,:),1);
thetasq_d_av = mean(thetasq_d_hem(13:28,:,:),1);

dthetadp_d_bzav(:,:) = sum(dthetadp_d_weight,1)./sum(cosy_d) ;
theta_d_bzav(:,:) = sum(theta_d_weight,1)./sum(cosy_d) ;
thetasq_d_bzav(:,:) = sum(thetasq_d_weight,1)./sum(cosy_d) ;
dthetadp_q_bzav(:,:) = sum(dthetadp_q_weight,1)./sum(cosy_q) ;
theta_q_bzav(:,:) = sum(theta_q_weight,1)./sum(cosy_q) ;
thetasq_q_bzav(:,:) = sum(thetasq_q_weight,1)./sum(cosy_q) ;
dthetadp_h_bzav(:,:) = sum(dthetadp_h_weight,1)./sum(cosy_h) ;
theta_h_bzav(:,:) = sum(theta_h_weight,1)./sum(cosy_h) ;
thetasq_h_bzav(:,:) = sum(thetasq_h_weight,1)./sum(cosy_h) ;
dthetadp_w_bzav(:,:) = sum(dthetadp_w_weight,1)./sum(cosy_w) ;
theta_w_bzav(:,:) = sum(theta_w_weight,1)./sum(cosy_w) ;
thetasq_w_bzav(:,:) = sum(thetasq_w_weight,1)./sum(cosy_w) ;

%calculate gamma factor
for k=1:25
gamma_d(k,:) = -kappa./rC(k) .* 1./dthetadp_d_bzav(k,:);
gamma_h(k,:) = -kappa./rC(k) .* 1./dthetadp_h_bzav(k,:);
gamma_q(k,:) = -kappa./rC(k) .* 1./dthetadp_q_bzav(k,:);
gamma_w(k,:) = -kappa./rC(k) .* 1./dthetadp_w_bzav(k,:);
end

gamma_d_av = mean(gamma_d,2);
gamma_q_av = mean(gamma_q,2);
gamma_h_av = mean(gamma_h,2);
gamma_w_av = mean(gamma_w,2);

figure
plot(gamma_d_av,rC,'k')
set(gca,'YDir','reverse')
hold on
plot(gamma_q_av,rC,'r')
plot(gamma_h_av,rC,'g')
plot(gamma_w_av,rC,'b')
print('-dpng','gamma_plots.png')

theta_var_d = mean(thetasq_d_bzav - theta_d_bzav.^2,2);
theta_var_q = mean(thetasq_q_bzav - theta_q_bzav.^2,2);
theta_var_h = mean(thetasq_h_bzav - theta_h_bzav.^2,2);
theta_var_w = mean(thetasq_w_bzav - theta_w_bzav.^2,2);

figure
plot(theta_var_d,rC,'k')
set(gca,'YDir','reverse')
hold on
plot(theta_var_q,rC,'r')
plot(theta_var_h,rC,'g')
plot(theta_var_w,rC,'b')
print('-dpng','theta_var.png')

%calculate integrand
for i=1:2
mape_integrand_d(:,i) = (rC./p0).^kappa .*gamma_d(:,i) .* (thetasq_d_bzav(:,i) - theta_d_bzav(:,i).^2) ;
mape_integrand_q(:,i) = (rC./p0).^kappa .*gamma_q(:,i) .* (thetasq_q_bzav(:,i) - theta_q_bzav(:,i).^2) ;
mape_integrand_h(:,i) = (rC./p0).^kappa .*gamma_h(:,i) .* (thetasq_h_bzav(:,i) - theta_h_bzav(:,i).^2) ;
mape_integrand_w(:,i) = (rC./p0).^kappa .*gamma_w(:,i) .* (thetasq_w_bzav(:,i) - theta_w_bzav(:,i).^2) ;
end

mape_integrand_d_av = mean(mape_integrand_d,2);
mape_integrand_q_av = mean(mape_integrand_q,2);
mape_integrand_h_av = mean(mape_integrand_h,2);
mape_integrand_w_av = mean(mape_integrand_w,2);

figure
plot(mape_integrand_d_av,rC,'k')
set(gca,'YDir','reverse')
hold on
plot(mape_integrand_q_av,rC,'r')
plot(mape_integrand_h_av,rC,'g')
plot(mape_integrand_w_av,rC,'b')
print('-dpng','mape_integrand.png')


prefac = cp.*p0./2./g;

%integrate
mape_d = prefac .* sum(mape_integrand_d(3:level_d,:),1) .* 4000./p0;
mape_q = prefac .* sum(mape_integrand_q(3:level_q,:),1) .* 4000./p0;
mape_h = prefac .* sum(mape_integrand_h(3:level_h,:),1) .* 4000./p0;
mape_w = prefac .* sum(mape_integrand_w(3:level_w,:),1) .* 4000./p0;

%take average for 2 hemispheres
mape_out_d = mean(mape_d);
mape_out_q = mean(mape_q);
mape_out_h = mean(mape_h);
mape_out_w = mean(mape_w);

%save
name = ['mape_out.mat'];
save(name, 'mape_out_d','mape_out_q','mape_out_h','mape_out_w')
