%plot up eady growth rate

%need vertical theta and u gradients.


%Read in iteration number, directory, MITgcm output and grid details

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

%read fields
i=0;
for nit = 259200:86400:432000;
i=i+1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Wet Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5year/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_w(:,:,:,i) = dyn(:,:,:,J);
[uE_w(:,:,:,i),vN_w(:,:,:,i)] = rotate_uv2uvEN(ucs_w(:,:,:,i),vcs_w(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i) = dyn(:,:,:,J);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Half WV Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearh/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_h(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_h(:,:,:,i) = dyn(:,:,:,J);
[uE_h(:,:,:,i),vN_h(:,:,:,i)] = rotate_uv2uvEN(ucs_h(:,:,:,i),vcs_h(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'THETA   '));
theta_h(:,:,:,i) = dyn(:,:,:,J);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Quarter WV Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearq/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_q(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_q(:,:,:,i) = dyn(:,:,:,J);
[uE_q(:,:,:,i),vN_q(:,:,:,i)] = rotate_uv2uvEN(ucs_q(:,:,:,i),vcs_q(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'THETA   '));
theta_q(:,:,:,i) = dyn(:,:,:,J);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Dry Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yeard/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_d(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_d(:,:,:,i) = dyn(:,:,:,J);
[uE_d(:,:,:,i),vN_d(:,:,:,i)] = rotate_uv2uvEN(ucs_d(:,:,:,i),vcs_d(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'THETA   '));
theta_d(:,:,:,i) = dyn(:,:,:,J);

end

uE_w_mean = mean(uE_w,4);
vN_w_mean = mean(vN_w,4);
theta_w_mean = mean(theta_w,4);
uE_h_mean = mean(uE_h,4);
vN_h_mean = mean(vN_h,4);
theta_h_mean = mean(theta_h,4);
uE_q_mean = mean(uE_q,4);
vN_q_mean = mean(vN_q,4);
theta_q_mean = mean(theta_q,4);
uE_d_mean = mean(uE_d,4);
vN_d_mean = mean(vN_d,4);
theta_d_mean = mean(theta_d,4);

xi=-179:2:180;yi=-89:2:90;
uEll_w=cube2latlon(xc,yc,uE_w_mean,xi,yi);
vNll_w=cube2latlon(xc,yc,vN_w_mean,xi,yi);
thetall_w=cube2latlon(xc,yc,theta_w_mean,xi,yi);
uEll_h=cube2latlon(xc,yc,uE_h_mean,xi,yi);
vNll_h=cube2latlon(xc,yc,vN_h_mean,xi,yi);
thetall_h=cube2latlon(xc,yc,theta_h_mean,xi,yi);
uEll_q=cube2latlon(xc,yc,uE_q_mean,xi,yi);
vNll_q=cube2latlon(xc,yc,vN_q_mean,xi,yi);
thetall_q=cube2latlon(xc,yc,theta_q_mean,xi,yi);
uEll_d=cube2latlon(xc,yc,uE_d_mean,xi,yi);
vNll_d=cube2latlon(xc,yc,vN_d_mean,xi,yi);
thetall_d=cube2latlon(xc,yc,theta_d_mean,xi,yi);

uE_w_zav(:,:) = mean(uEll_w,1);
vN_w_zav(:,:) = mean(vNll_w,1);
theta_w_zav(:,:) = mean(thetall_w,1);
uE_h_zav(:,:) = mean(uEll_h,1);
vN_h_zav(:,:) = mean(vNll_h,1);
theta_h_zav(:,:) = mean(thetall_h,1);
uE_q_zav(:,:) = mean(uEll_q,1);
vN_q_zav(:,:) = mean(vNll_q,1);
theta_q_zav(:,:) = mean(thetall_q,1);
uE_d_zav(:,:) = mean(uEll_d,1);
vN_d_zav(:,:) = mean(vNll_d,1);
theta_d_zav(:,:) = mean(thetall_d,1);

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:size(rC)
T_w_zav(:,k)=theta_w_zav(:,k).*convthetatoT(k,1);
T_h_zav(:,k)=theta_h_zav(:,k).*convthetatoT(k,1);
T_q_zav(:,k)=theta_q_zav(:,k).*convthetatoT(k,1);
T_d_zav(:,k)=theta_d_zav(:,k).*convthetatoT(k,1);
end

Ra = 287.04;
g= 9.81;
omega = 2.*pi./24./60./60;

for i=1:25
rho_w(:,i) = rC(i)./Ra./T_w_zav(:,i);
rho_h(:,i) = rC(i)./Ra./T_h_zav(:,i);
rho_q(:,i) = rC(i)./Ra./T_q_zav(:,i);
rho_d(:,i) = rC(i)./Ra./T_d_zav(:,i);
end

dthetadp_w = gradient(theta_w_zav,-4000);
dthetadp_h = gradient(theta_h_zav,-4000);
dthetadp_q = gradient(theta_q_zav,-4000);
dthetadp_d = gradient(theta_d_zav,-4000);

dudp_w = gradient(uE_w_zav,-4000);
dudp_h = gradient(uE_h_zav,-4000);
dudp_q = gradient(uE_q_zav,-4000);
dudp_d = gradient(uE_d_zav,-4000);

dudz_w = -g.*rho_w.*dudp_w;
dudz_h = -g.*rho_w.*dudp_h;
dudz_q = -g.*rho_w.*dudp_q;
dudz_d = -g.*rho_w.*dudp_d;

Nsq_w = - g.^2 .* rho_w .* dthetadp_w ./theta_w_zav;
Nsq_h = - g.^2 .* rho_h .* dthetadp_h ./theta_h_zav;
Nsq_q = - g.^2 .* rho_q .* dthetadp_q ./theta_q_zav;
Nsq_d = - g.^2 .* rho_d .* dthetadp_d ./theta_d_zav;


f = zeros(90,25);
for i=1:25
f(:,i) = 2.*omega.*sin(yi.*pi./180);
end

eady_w = 0.31.*f./sqrt(Nsq_w) .*dudz_w; 
eady_h = 0.31.*f./sqrt(Nsq_h) .*dudz_h; 
eady_q = 0.31.*f./sqrt(Nsq_q) .*dudz_q; 
eady_d = 0.31.*f./sqrt(Nsq_d) .*dudz_d; 

%Brayshaw averages through trop: 925-250 and near surf: 925-775
%use 900-260 and 900-780 = 3-19 3-6

eady_w_full = mean(eady_w(:,3:19),2);
eady_h_full = mean(eady_h(:,3:19),2);
eady_q_full = mean(eady_q(:,3:19),2);
eady_d_full = mean(eady_d(:,3:19),2);

eady_w_low = mean(eady_w(:,3:6),2);
eady_h_low = mean(eady_h(:,3:6),2);
eady_q_low = mean(eady_q(:,3:6),2);
eady_d_low = mean(eady_d(:,3:6),2);


