%plot pictures of the jet stream in lat-lon

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


[dyn,iter,M]=rdmds([rDir,'dynDiag'],691200);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_ctrl(:,:,:) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_ctrl(:,:,:) = dyn(:,:,:,J);
[uE_ctrl(:,:,:),vN_ctrl(:,:,:)] = rotate_uv2uvEN(ucs_ctrl(:,:,:),vcs_ctrl(:,:,:),AngleCS,AngleSN,Grid);
uEvN_ctrl(:,:,:)=uE_ctrl(:,:,:).*vN_ctrl(:,:,:);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_in=dyn(:,:,:,J);
cndht_theta_ctrl(:,:,:)=cndht_in*86400.;
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_in=dyn(:,:,:,J);
cnvht_theta_ctrl(:,:,:)=cnvht_in*86400.;
J=find(strcmp(fldList,'WVEL    '));
w_ctrl(:,:,:)=dyn(:,:,:,J);

J=find(strcmp(fldList,'THETA   '));
theta_ctrl(:,:,:) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp_ctrl(:,:,j)=theta_ctrl(:,:,j).*convthetatoT(j,1);
end

xi=-179:2:180;yi=-89:2:90;

uEll_ctrl(:,:,:)=single(cube2latlon(xc,yc,uE_ctrl,xi,yi));
uEvNll_ctrl(:,:,:)=single(cube2latlon(xc,yc,uEvN_ctrl,xi,yi));
contourf(xi,yi,uEll_ctrl(:,:,20)');
colorbar

cndhtll_ctrl(:,:,:)=single(cube2latlon(xc,yc,cndht_theta_ctrl,xi,yi));
cnvhtll_ctrl(:,:,:)=single(cube2latlon(xc,yc,cnvht_theta_ctrl,xi,yi));
wll_ctrl(:,:,:)=single(cube2latlon(xc,yc,w_ctrl,xi,yi));
templl_ctrl(:,:,:)=single(cube2latlon(xc,yc,temp_ctrl,xi,yi));

figure
contourf(xi,yi,uEvNll_ctrl(:,:,20)');
colorbar

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';

[dyn,iter,M]=rdmds([rDir,'dynDiag'],604800);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_ctrl(:,:,:) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_ctrl(:,:,:) = dyn(:,:,:,J);
[uE_ctrl(:,:,:),vN_ctrl(:,:,:)] = rotate_uv2uvEN(ucs_ctrl(:,:,:),vcs_ctrl(:,:,:),AngleCS,AngleSN,Grid);
uEvN_ctrl(:,:,:)=uE_ctrl(:,:,:).*vN_ctrl(:,:,:);

xi=-179:2:180;yi=-89:2:90;

figure
uEll_ctrl(:,:,:)=single(cube2latlon(xc,yc,uE_ctrl,xi,yi));
uEvNll_ctrl(:,:,:)=single(cube2latlon(xc,yc,uEvN_ctrl,xi,yi));

contourf(xi,yi,uEvNll_ctrl(:,:,20)');
colorbar
figure
contourf(xi,yi,uEll_ctrl(:,:,20)');
colorbar
