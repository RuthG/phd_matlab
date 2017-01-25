%calculate global mean meridional eddy KE for spinup and plot as time series.

%Read in iteration number, directory, MITgcm output and grid details

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_oneyrdaily_wvoffradoff/';

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Load data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=system('find vsquarecl_data.mat');

if a > 0

i=0;
for nit = 605040:240:691200;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE(:,:,:,i),vN(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'UVELSQ  '));
uucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSQ  '));
vvcs(:,:,:,i) = dyn(:,:,:,J);

end

%Total horiz KE should be invariant on the cube sphere (resultant horiz vel shouldn't change)
ke = uucs + vvcs;

%Take zavs of KE, vN, uE
[ke_zav,mskzon,ylat,areazon]=calcZonalAvgCube(ke,ny,yc,ar,hc);
[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN,ny,yc,ar,hc);
[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE,ny,yc,ar,hc);

%<u^2> = <u>^2 + <u^2'>
%We have <u^2 + v^2> = <u>^2 + <v>^2 + <u^2'> + <v^2'> 
%Square zonal averages and sum to get zonal mean KE component
uuvv = vN_zav.^2 + uE_zav.^2;

% ke - uuvv = <u^2'> + <v^2'> 
ke_ed = ke_zav - uuvv;

save('vsquarecl_data.mat')

else

load('vsquarecl_data.mat')

end

a=6371000;

for i=1:90
ke_ed_lon_int(i,:,:) = ke_ed(i,:,:).*2.*pi.*a.*cos(ylat(i).*pi./180);
end

ke_ed_horiz_int = sum(ke_ed_lon_int,1).*pi.*a./90;

ke_ed_int = reshape(sum(ke_ed_horiz_int,2),360,1).*4000;

plot(ke_ed_int)
ylabel('Global integral of eddy KE, Pam^4/s^2')
xlabel('Time, days')
print('-dpng','ke_eddy_cl.png')

