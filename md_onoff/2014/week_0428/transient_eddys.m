%Play with trying to split up v and u into 4 eddy fluxes instead of 2 using daily data.


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

%read fields
i=0;
for nit = 605040:240:691200;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_ctrl(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_ctrl(:,:,:,i) = dyn(:,:,:,J);
[uE_ctrl(:,:,:,i),vN_ctrl(:,:,:,i)] = rotate_uv2uvEN(ucs_ctrl(:,:,:,i),vcs_ctrl(:,:,:,i),AngleCS,AngleSN,Grid);
uEvN_ctrl(:,:,:,i)=uE_ctrl(:,:,:,i).*vN_ctrl(:,:,:,i);

J=find(strcmp(fldList,'UV_VEL_C'));
uv_ctrl(:,:,:,i) = dyn(:,:,:,J);
uv_ed_ctrl(:,:,:,i) = uv_ctrl(:,:,:,i) - uEvN_ctrl(:,:,:,i);

end

xi=-179:2:179;
yi=-89:2:89;
uE_ctrl_ll=cube2latlon(xc,yc,uE_ctrl,xi,yi);
vN_ctrl_ll=cube2latlon(xc,yc,vN_ctrl,xi,yi);


uE_tav_ll = mean(uE_ctrl_ll,4);
vN_tav_ll = mean(vN_ctrl_ll,4);

uE_zav(:,:,:) = mean(uE_ctrl_ll,1);
uE_tzav(:,:) = mean(uE_tav_ll,1);

for i=1:180
uE_tzav_ll(i,:,:) = uE_tzav(:,:);
uE_zav_ll(i,:,:,:) = uE_zav(:,:,:);
end

u_ed_stat = uE_tav_ll - uE_tzav_ll;

for i=1:360
uE_time_var_ll(:,:,:,i) = uE_ctrl_ll(:,:,:,i) - uE_tav_ll;
end

uE_trans_mean(:,:,:) = mean(uE_time_var_ll,1);

for i=1:180
uE_trans_mean_ll(i,:,:,:) = uE_trans_mean(:,:,:);
end

uE_ed_trans = uE_time_var_ll - uE_trans_mean_ll;


return

[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_ctrl,ny,yc,ar,hc);
[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_ctrl,ny,yc,ar,hc);

[uE_tzav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_tav,ny,yc,ar,hc);
[vN_tzav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_tav,ny,yc,ar,hc);

check_uE = mean(uE_zav,3);
check_vN = mean(vN_zav,3);

xi=-179:2:179;
yi=-89:2:89;

uE_tav_ll=cube2latlon(xc,yc,uE_tav,xi,yi);
vN_tav_ll=cube2latlon(xc,yc,vN_tav,xi,yi);
uE_ctrl_ll=cube2latlon(xc,yc,uE_ctrl,xi,yi);
vN_ctrl_ll=cube2latlon(xc,yc,vN_ctrl,xi,yi);

for i=1:180
uE_tzav_ll(i,:,:) = uE_tzav(:,:);
uE_zav_ll(i,:,:,:) = uE_zav(:,:,:);
end

u_ed_stat = uE_tav_ll - uE_tzav_ll;

for i=1:360
uE_time_var_ll(:,:,:,i) = uE_ctrl_ll(:,:,:,i) - uE_tav_ll;
end

uE_trans_mean(:,:,:) = mean(uE_time_var_ll,2);
