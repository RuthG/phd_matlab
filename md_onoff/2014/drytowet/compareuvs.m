%For same pickup file and set up, load up 1 month of data with a daily mean and 1 month with a monthly mean and compare the u'v' calculated using the two different means with
%a) daily <uv> - daily <u><v>
%b) daily <uv> - monthly <u><v>
%c) monthly <uv> - monthly <u><v>


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% do c) first %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


rDir='/disk1/MITgcm/verification/atm_gray_ruth/run/';

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
nit = 784800;

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs = dyn(:,:,:,J);
[uE,vN] = rotate_uv2uvEN(ucs,vcs,AngleCS,AngleSN,Grid);
uEvN_mm=uE.*vN;
J=find(strcmp(fldList,'UV_VEL_C'));
uv_mm = dyn(:,:,:,J);
uv_ed_mm = uv_mm - uEvN_mm;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% now load daily data for a and b %%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_month13/';

%read fields
i=0;
for nit = 777840:240:784800;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE(:,:,:,i),vN(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);
uEvN_dd(:,:,:,i)=uE(:,:,:,i).*vN(:,:,:,i);

J=find(strcmp(fldList,'UV_VEL_C'));
uv_dd(:,:,:,i) = dyn(:,:,:,J);
uv_ed_dd(:,:,:,i) = uv_dd(:,:,:,i) - uEvN_dd(:,:,:,i);

end

uv_dm = mean(uv_dd,4);
uEvN_dm = mean(uEvN_dd,4);

for i=1:30
uv_ed_dmdd(:,:,:,i)  = uv_dm - uEvN_dd(:,:,:,i);
end

uv_ed_dmdd_av = mean(uv_ed_dmdd,4);

uv_ed_dm = uv_dm - uEvN_dm;

uv_ed_dd_av = mean(uv_ed_dd,4);

[uv_ed_mm_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_ed_mm,ny,yc,ar,hc);
[uv_ed_dd_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_ed_dd_av,ny,yc,ar,hc);
[uv_ed_dm_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_ed_dm,ny,yc,ar,hc);
[uv_ed_dmdd_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_ed_dmdd_av,ny,yc,ar,hc);

[uEvN_dm_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uEvN_dm,ny,yc,ar,hc);
[uEvN_mm_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uEvN_mm,ny,yc,ar,hc);

[uv_dm_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_dm,ny,yc,ar,hc);
[uv_mm_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_mm,ny,yc,ar,hc);


figure
contourf(ylat,rC,uv_ed_mm_zav');
colorbar;
title('month-month av');
set(gca,'YDir','reverse');

figure
contourf(ylat,rC,uv_ed_dd_zav');
colorbar;
title('day-day av');
set(gca,'YDir','reverse');

figure
contourf(ylat,rC,uv_ed_dm_zav');
colorbar;
title('daily aved month - daily aved month av');
set(gca,'YDir','reverse');

figure
contourf(ylat,rC,uv_ed_dmdd_zav');
colorbar;
title('daily aved month - day av')
set(gca,'YDir','reverse');



