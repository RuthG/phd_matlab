%load in temperature data and plot meridional gradient


% choose directory, load grid
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';
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

%read files
i=0;
for nit = 259200:86400:604800;
i=i+1

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i)=dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_h(:,:,:,i)=dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_quarterwv/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_q(:,:,:,i)=dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_5year_c/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_d(:,:,:,i)=dyn(:,:,:,J);

end


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


a=6371.0e3;
cosphi = zeros(90,25);
for k=1:25
cosphi(:,k) = cos(yi.*pi./180);
end

[b,dthetady_w] = gradient(theta_w_zav(2:89,:)./a,pi./90);
[b,dthetady_h] = gradient(theta_h_zav(2:89,:)./a,pi./90);
[b,dthetady_q] = gradient(theta_q_zav(2:89,:)./a,pi./90);
[b,dthetady_d] = gradient(theta_d_zav(2:89,:)./a,pi./90);




