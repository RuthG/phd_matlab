%Look at covariance of uq vq wq v'T'u'v'


rDir_control='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_1yeardaily_c/';
rDir=rDir_control;
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

i=0;

for nit=605040:240:691200

i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_ctrl(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_ctrl(:,:,:,i) = dyn(:,:,:,J);
[uE_ctrl(:,:,:,i),vN_ctrl(:,:,:,i)] = rotate_uv2uvEN(ucs_ctrl(:,:,:,i),vcs_ctrl(:,:,:,i),AngleCS,AngleSN,Grid);
uEvN_ctrl(:,:,:,i)=uE_ctrl(:,:,:,i).*vN_ctrl(:,:,:,i);

J=find(strcmp(fldList,'THETA   '));
theta_ctrl(:,:,:,i) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp_ctrl(:,:,j,i)=theta_ctrl(:,:,j,i).*convthetatoT(j,1);
end

J=find(strcmp(fldList,'UV_VEL_C'));
uv_ctrl(:,:,:,i) = dyn(:,:,:,J);
uv_ed_ctrl(:,:,:,i) = uv_ctrl(:,:,:,i) - uEvN_ctrl(:,:,:,i);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_ctrl(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_ctrl(:,:,:,i) = dyn(:,:,:,J);
[uEt_av_ctrl(:,:,:,i),vNt_av_ctrl(:,:,:,i)] = rotate_uv2uvEN(ut_av_ctrl(:,:,:,i),vt_av_ctrl(:,:,:,i),AngleCS,AngleSN,Grid);

vt_ctrl(:,:,:,i) = vN_ctrl(:,:,:,i).*theta_ctrl(:,:,:,i);
vt_ed_ctrl(:,:,:,i) = vNt_av_ctrl(:,:,:,i) - vt_ctrl(:,:,:,i);

J=find(strcmp(fldList,'WVEL    '));
w_ctrl(:,:,:,i)=dyn(:,:,:,J);

J=find(strcmp(fldList,'SALT    '));
q_ctrl(:,:,:,i)=dyn(:,:,:,J);

end

uv_ed_mean = mean(uv_ed_ctrl,4);
vt_ed_mean = mean(vt_ed_ctrl,4);
w_mean = mean(w_ctrl,4);
uE_mean = mean(uE_ctrl,4);
vN_mean = mean(vN_ctrl,4);
q_mean = mean(q_ctrl,4);

for i=1:360
uv_ed_diff(:,:,:,i) = uv_ed_ctrl(:,:,:,i) - uv_ed_mean;
vt_ed_diff(:,:,:,i) = vt_ed_ctrl(:,:,:,i) - vt_ed_mean;
w_diff(:,:,:,i) = w_ctrl(:,:,:,i) - w_mean;
uE_diff(:,:,:,i) = uE_ctrl(:,:,:,i) - uE_mean;
vN_diff(:,:,:,i) = vN_ctrl(:,:,:,i) - vN_mean;
q_diff(:,:,:,i) = q_ctrl(:,:,:,i) - q_mean;
end

uq_var = mean(q_diff.*uE_diff,4);
vq_var = mean(q_diff.*vN_diff,4);
wq_var = mean(q_diff.*w_diff,4);
uvvt_var = mean(uv_ed_diff.*vt_ed_diff,4);

xi=-179:2:180;yi=-89:2:90;

uqll_ctrl(:,:,:)=single(cube2latlon(xc,yc,uq_var,xi,yi));
vqll_ctrl(:,:,:)=single(cube2latlon(xc,yc,vq_var,xi,yi));
wqll_ctrl(:,:,:)=single(cube2latlon(xc,yc,wq_var,xi,yi));
uvvtll_ctrl(:,:,:)=single(cube2latlon(xc,yc,uvvt_var,xi,yi));
