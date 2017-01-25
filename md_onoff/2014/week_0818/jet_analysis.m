%load in zonal wind fields and find jet max latitudes at peak and surface

% choose directory, load grid
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

%read files
i=0;
for nit = 259200:86400:432000;
i=i+1

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5year/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
ucs_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_w(:,:,:,i) = dyn(:,:,:,J);
[uE_w(:,:,:,i),vN_w(:,:,:,i)] = rotate_uv2uvEN(ucs_w(:,:,:,i),vcs_w(:,:,:,i),AngleCS,AngleSN,Grid);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearh/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
ucs_h(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_h(:,:,:,i) = dyn(:,:,:,J);
[uE_h(:,:,:,i),vN_h(:,:,:,i)] = rotate_uv2uvEN(ucs_h(:,:,:,i),vcs_h(:,:,:,i),AngleCS,AngleSN,Grid);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearq/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
ucs_q(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_q(:,:,:,i) = dyn(:,:,:,J);
[uE_q(:,:,:,i),vN_q(:,:,:,i)] = rotate_uv2uvEN(ucs_q(:,:,:,i),vcs_q(:,:,:,i),AngleCS,AngleSN,Grid);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yeard/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
ucs_d(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_d(:,:,:,i) = dyn(:,:,:,J);
[uE_d(:,:,:,i),vN_d(:,:,:,i)] = rotate_uv2uvEN(ucs_d(:,:,:,i),vcs_d(:,:,:,i),AngleCS,AngleSN,Grid);

end

uE_w_mean = mean(uE_w,4);
vN_w_mean = mean(vN_w,4);
uE_h_mean = mean(uE_h,4);
vN_h_mean = mean(vN_h,4);
uE_q_mean = mean(uE_q,4);
vN_q_mean = mean(vN_q,4);
uE_d_mean = mean(uE_d,4);
vN_d_mean = mean(vN_d,4);

xi=-179:2:180;yi=-89:2:90;
uEll_w=cube2latlon(xc,yc,uE_w_mean,xi,yi);
vNll_w=cube2latlon(xc,yc,vN_w_mean,xi,yi);
uEll_h=cube2latlon(xc,yc,uE_h_mean,xi,yi);
vNll_h=cube2latlon(xc,yc,vN_h_mean,xi,yi);
uEll_q=cube2latlon(xc,yc,uE_q_mean,xi,yi);
vNll_q=cube2latlon(xc,yc,vN_q_mean,xi,yi);
uEll_d=cube2latlon(xc,yc,uE_d_mean,xi,yi);
vNll_d=cube2latlon(xc,yc,vN_d_mean,xi,yi);

uE_w_zav(:,:) = mean(uEll_w,1);
vN_w_zav(:,:) = mean(vNll_w,1);
uE_h_zav(:,:) = mean(uEll_h,1);
vN_h_zav(:,:) = mean(vNll_h,1);
uE_q_zav(:,:) = mean(uEll_q,1);
vN_q_zav(:,:) = mean(vNll_q,1);
uE_d_zav(:,:) = mean(uEll_d,1);
vN_d_zav(:,:) = mean(vNll_d,1);


for i=1:45

uE_w_hzav(i,:) = (uE_w_zav(45+i,:) + uE_w_zav(46-i,:))./2;
uE_h_hzav(i,:) = (uE_h_zav(45+i,:) + uE_h_zav(46-i,:))./2;
uE_q_hzav(i,:) = (uE_q_zav(45+i,:) + uE_q_zav(46-i,:))./2;
uE_d_hzav(i,:) = (uE_d_zav(45+i,:) + uE_d_zav(46-i,:))./2;

end

jet_surf_max_w = max(uE_w_hzav(:,1));
jet_surf_max_h = max(uE_h_hzav(:,1));
jet_surf_max_q = max(uE_q_hzav(:,1));
jet_surf_max_d = max(uE_d_hzav(:,1));

jet_max_w = max(max(uE_w_hzav(:,1:23)));
jet_max_h = max(max(uE_h_hzav(:,1:23)));
jet_max_q = max(max(uE_q_hzav(:,1:23)));
jet_max_d = max(max(uE_d_hzav(:,1:23)));

jsm_lat_w = yi(45 + find(uE_w_hzav(:,1) == max(uE_w_hzav(:,1))));
jsm_lat_h = yi(45 + find(uE_h_hzav(:,1) == max(uE_h_hzav(:,1))));
jsm_lat_q = yi(45 + find(uE_q_hzav(:,1) == max(uE_q_hzav(:,1))));
jsm_lat_d = yi(45 + find(uE_d_hzav(:,1) == max(uE_d_hzav(:,1))));

[suba_w,subb_w] = ind2sub( size(uE_w_hzav(:,1:23)) , find( uE_w_hzav(:,1:23) == max(max(uE_w_hzav(:,1:23))) ) );
[suba_h,subb_h] = ind2sub( size(uE_h_hzav(:,1:23)) , find( uE_h_hzav(:,1:23) == max(max(uE_h_hzav(:,1:23))) ) );
[suba_q,subb_q] = ind2sub( size(uE_q_hzav(:,1:23)) , find( uE_q_hzav(:,1:23) == max(max(uE_q_hzav(:,1:23))) ) );
[suba_d,subb_d] = ind2sub( size(uE_d_hzav(:,1:23)) , find( uE_d_hzav(:,1:23) == max(max(uE_d_hzav(:,1:23))) ) );

jm_lat_w = yi(45+suba_w);
jm_lat_h = yi(45+suba_h);
jm_lat_q = yi(45+suba_q);
jm_lat_d = yi(45+suba_d);

jm_p_w = rC(subb_w);
jm_p_h = rC(subb_h);
jm_p_q = rC(subb_q);
jm_p_d = rC(subb_d);


