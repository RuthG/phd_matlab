%stats_attempt
%try to get an idea of how to check no of ensemble members needed!

%method:
%load up data from 3 'ensemble' runs
%use to calculate means and variances for each day
%plot up and see if can split into longer periods to av
%compare sigma^2/N with diffs between means, and see what happens.


rDir_m(1,:)='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_accidentalcontrol/';
rDir_m(2,:)='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_tropheat/         ';
rDir_m(3,:)='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_control2/         ';
rDir_m(4,:)='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_tropheat_ens2/    ';
rDir_m(5,:)='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_control3/         ';
rDir_m(6,:)='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_tropheat_ens3/    ';

rDir = '/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_accidentalcontrol/';
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

nitno(:,1) = 691440;
nitend(:,1) = 705600;
nitno(:,2) = 691440;
nitend(:,2) = 705600;
nitno(:,3) = 660240;
nitend(:,3) = 674400;
nitno(:,4) = 660240;
nitend(:,4) = 674400;
nitno(:,5) = 674640;
nitend(:,5) = 688800;
nitno(:,6) = 674640;
nitend(:,6) = 688800;

moo=false; %true;
if moo
load('stats_attempts.mat')
else

for m=1:6

rDir = strtrim(rDir_m(m,:));

i=0;
for nit=nitno(:,m):240:nitend(:,m)
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i,m) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i,m) = dyn(:,:,:,J);
[uE(:,:,:,i,m),vN(:,:,:,i,m)] = rotate_uv2uvEN(ucs(:,:,:,i,m),vcs(:,:,:,i,m),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'WVEL    '));
w(:,:,:,i,m) = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta(:,:,:,i,m) = dyn(:,:,:,J);
convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp(:,:,j,i,m)=theta(:,:,j,i,m).*convthetatoT(j,1);
end
J=find(strcmp(fldList,'UV_VEL_C'));
uv(:,:,:,i,m) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vt_av(:,:,:,i,m) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av(:,:,:,i,m) = dyn(:,:,:,J);
[uEt_av(:,:,:,i,m),vNt_av(:,:,:,i,m)] = rotate_uv2uvEN(ut_av(:,:,:,i,m),vt_av(:,:,:,i,m),AngleCS,AngleSN,Grid);

%take zonal mean eddy fluxes of momentum and heat
[uE_zav(:,:,i,m),mskzon,ylat,areazon]=calcZonalAvgCube(uE(:,:,:,i,m),ny,yc,ar,hc);
[vN_zav(:,:,i,m),mskzon,ylat,areazon]=calcZonalAvgCube(vN(:,:,:,i,m),ny,yc,ar,hc);
[theta_zav(:,:,i,m),mskzon,ylat,areazon]=calcZonalAvgCube(theta(:,:,:,i,m),ny,yc,ar,hc);
[w_zav(:,:,i,m),mskzon,ylat,areazon]=calcZonalAvgCube(w(:,:,:,i,m),ny,yc,ar,hc);
[uv_zav(:,:,i,m),mskzon,ylat,areazon]=calcZonalAvgCube(uv(:,:,:,i,m),ny,yc,ar,hc);
[vt_zav(:,:,i,m),mskzon,ylat,areazon]=calcZonalAvgCube(vNt_av(:,:,:,i,m),ny,yc,ar,hc);
[temp_zav(:,:,i,m),mskzon,ylat,areazon]=calcZonalAvgCube(temp(:,:,:,i,m),ny,yc,ar,hc);

end

end

save('stats_attempts.mat')

end





%calculate mean of 3 controls and 3 ensembles

uE_zav_mean = (uE_zav(:,:,:,2) + uE_zav(:,:,:,4) + uE_zav(:,:,:,6))./3;
vN_zav_mean = (vN_zav(:,:,:,2) + vN_zav(:,:,:,4) + vN_zav(:,:,:,6))./3;
temp_zav_mean = (temp_zav(:,:,:,2) + temp_zav(:,:,:,4) + temp_zav(:,:,:,6))./3;

uE_zav_mean_c = (uE_zav(:,:,:,1) + uE_zav(:,:,:,3) + uE_zav(:,:,:,5))./3;
vN_zav_mean_c = (vN_zav(:,:,:,1) + vN_zav(:,:,:,3) + vN_zav(:,:,:,5))./3;
temp_zav_mean_c = (temp_zav(:,:,:,1) + temp_zav(:,:,:,3) + temp_zav(:,:,:,5))./3;

uE_zav_var = ((uE_zav(:,:,:,2) - uE_zav_mean).^2 + (uE_zav(:,:,:,4) - uE_zav_mean).^2 + (uE_zav(:,:,:,6) - uE_zav_mean).^2)./3;
vN_zav_var = ((vN_zav(:,:,:,2) - vN_zav_mean).^2 + (vN_zav(:,:,:,4) - vN_zav_mean).^2 + (vN_zav(:,:,:,6) - vN_zav_mean).^2)./3;
temp_zav_var = ((temp_zav(:,:,:,2) - temp_zav_mean).^2 + (temp_zav(:,:,:,4) - temp_zav_mean).^2 + (temp_zav(:,:,:,6) - temp_zav_mean).^2)./3;

uE_zav_var_c = ((uE_zav(:,:,:,1) - uE_zav_mean_c).^2 + (uE_zav(:,:,:,3) - uE_zav_mean_c).^2 + (uE_zav(:,:,:,5) - uE_zav_mean_c).^2)./3;
vN_zav_var_c = ((vN_zav(:,:,:,1) - vN_zav_mean_c).^2 + (vN_zav(:,:,:,3) - vN_zav_mean_c).^2 + (vN_zav(:,:,:,5) - vN_zav_mean_c).^2)./3;
temp_zav_var_c = ((temp_zav(:,:,:,1) - temp_zav_mean_c).^2 + (temp_zav(:,:,:,3) - temp_zav_mean_c).^2 + (temp_zav(:,:,:,5) - temp_zav_mean_c).^2)./3;

uE_zav_mean_diff = uE_zav_mean - uE_zav_mean_c;
uE_zav_var_mean = sqrt((uE_zav_var./3 + uE_zav_var_c./3));

vN_zav_mean_diff = vN_zav_mean - vN_zav_mean_c;
vN_zav_var_mean = sqrt((vN_zav_var./3 + vN_zav_var_c./3));

temp_zav_mean_diff = temp_zav_mean - temp_zav_mean_c;
temp_zav_var_mean = sqrt((temp_zav_var./3 + temp_zav_var_c./3));


%have a look at taking 10 day averages

for i=1:6
temp_zav_meant(:,:,i) = mean(temp_zav_mean(:,:, 10*i-9:10*i),3);
uE_zav_meant(:,:,i) = mean(uE_zav_mean(:,:,10*i-9:10*i),3);
vN_zav_meant(:,:,i) = mean(vN_zav_mean(:,:,10*i-9:10*i),3);

temp_zav_mean_ct(:,:,i) = mean(temp_zav_mean_c(:,:, 10*i-9:10*i),3);
uE_zav_mean_ct(:,:,i) = mean(uE_zav_mean_c(:,:,10*i-9:10*i),3);
vN_zav_mean_ct(:,:,i) = mean(vN_zav_mean_c(:,:,10*i-9:10*i),3);

temp_zav_vart(:,:,i,:) = mean(temp_zav_var(:,:,10*i-9:10*i,:),3);
uE_zav_vart(:,:,i,:) = mean(uE_zav_var(:,:,10*i-9:10*i,:),3);
vN_zav_vart(:,:,i,:) = mean(vN_zav_var(:,:,10*i-9:10*i,:),3);

temp_zav_var_ct(:,:,i,:) = mean(temp_zav_var_c(:,:,10*i-9:10*i,:),3);
uE_zav_var_ct(:,:,i,:) = mean(uE_zav_var_c(:,:,10*i-9:10*i,:),3);
vN_zav_var_ct(:,:,i,:) = mean(vN_zav_var_c(:,:,10*i-9:10*i,:),3);

end

uE_zav_mean_difft = uE_zav_meant - uE_zav_mean_ct;
uE_zav_var_meant = sqrt((uE_zav_vart./30 + uE_zav_var_ct./30));

vN_zav_mean_difft = vN_zav_meant - vN_zav_mean_ct;
vN_zav_var_meant = sqrt((vN_zav_vart./30 + vN_zav_var_ct./30));

temp_zav_mean_difft = temp_zav_meant - temp_zav_mean_ct;
temp_zav_var_meant = sqrt((temp_zav_vart./30 + temp_zav_var_ct./30));

