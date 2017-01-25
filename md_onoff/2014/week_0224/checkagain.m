%Has anything happened with the sst pert yet?!?!?!?!

%load 1st days file and check

rDir = '/disk1/MITgcm/verification/atm_gray_ruth/run/';

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

nit=691440;
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta(:,:,:) = dyn(:,:,:,J);
convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp(:,:,j)=theta(:,:,j).*convthetatoT(j,1);
end

rDir = '/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_newgrad/';

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

nit=691440;
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_o(:,:,:) = dyn(:,:,:,J);
convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp_o(:,:,j)=theta_o(:,:,j).*convthetatoT(j,1);
end

[temp_zav_o(:,:),mskzon,ylat,areazon]=calcZonalAvgCube(temp_o(:,:,:),ny,yc,ar,hc);
[temp_zav(:,:),mskzon,ylat,areazon]=calcZonalAvgCube(temp(:,:,:),ny,yc,ar,hc);

