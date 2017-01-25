%load up data again and play with low pass filtering

% choose directory, load grid
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_1yeardaily_c/';
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
for nit = 605040:240:691200;
i=i+1

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_1yeardaily_c/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
ucs_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_w(:,:,:,i)=dyn(:,:,:,J);
[uE_w(:,:,:,i),vN_w(:,:,:,i)] = rotate_uv2uvEN(ucs_w(:,:,:,i),vcs_w(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'UVELTH  '));
utcs_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vtcs_w(:,:,:,i)=dyn(:,:,:,J);
[uEth_w(:,:,:,i),vNth_w(:,:,:,i)] = rotate_uv2uvEN(utcs_w(:,:,:,i),vtcs_w(:,:,:,i),AngleCS,AngleSN,Grid);

end


%transform to latlon grid

xi=-179:2:180;yi=-89:2:90;
vNthll_w=cube2latlon(xc,yc,vNth_w,xi,yi);
uEll_w=cube2latlon(xc,yc,uE_w,xi,yi);
vNll_w=cube2latlon(xc,yc,vN_w,xi,yi);
thetall_w=cube2latlon(xc,yc,theta_w,xi,yi);

thetall_w_zav(:,:,:) = mean(thetall_w,1);
vNll_w_zav(:,:,:) = mean(vNll_w,1);
vNthll_w_zav(:,:,:) = mean(vNthll_w,1);

thetall_w_tzav(:,:) = mean(thetall_w_zav,3);
vNll_w_tzav(:,:) = mean(vNll_w_zav,3);
vNthll_w_tzav(:,:) = mean(vNthll_w_zav,3);
vNthll_w_ed_tzav = vNthll_w_tzav - thetall_w_tzav.*vNll_w_tzav;


for i=1:351
vNthll_w_rm(:,:,i) = mean(vNthll_w_zav(:,:,i:i+9),3);

vNthll_w_lowpass(:,:,i) = vNthll_w_zav(:,:,i+4) - vNthll_w_rm(:,:,i);

end

vN_a = zeros(1,360);
vN_b = zeros(1,351);
vN_c = zeros(1,351);
vN_a(:) = vNthll_w_zav(66,6,:);
vN_b(:) = vNthll_w_rm(66,6,:);
vN_c(:) = vNthll_w_lowpass(66,6,:);


