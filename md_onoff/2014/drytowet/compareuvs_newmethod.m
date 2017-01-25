%For same pickup file and set up, load up 1 month of data with a daily mean and 1 month with a monthly mean and compare the u'v' calculated using the two different means with
%a) daily <uv> - daily <u><v>
%b) daily <uv> - monthly <u><v>
%c) monthly <uv> - monthly <u><v>


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% do c) first %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';

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
nit = 604800;

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs = dyn(:,:,:,J);
[uE,vN] = rotate_uv2uvEN(ucs,vcs,AngleCS,AngleSN,Grid);
[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE,ny,yc,ar,hc);
[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN,ny,yc,ar,hc);


uEvN_mm_zav=uE_zav.*vN_zav;

J=find(strcmp(fldList,'UV_VEL_C'));
uv_mm = dyn(:,:,:,J);
[uv_mm_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_mm,ny,yc,ar,hc);
uv_ed_mm_zav = uv_mm_zav - uEvN_mm_zav;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% now load daily data for a and b %%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_1yeardaily_c/';

%read fields
i=0;
for nit = 605040:240:607200;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE_dd(:,:,:,i),vN_dd(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);
[uE_dd_zav(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(uE_dd(:,:,:,i),ny,yc,ar,hc);
[vN_dd_zav(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(vN_dd(:,:,:,i),ny,yc,ar,hc);

uEvN_dd_zav(:,:,i)=uE_dd_zav(:,:,i).*vN_dd_zav(:,:,i);

J=find(strcmp(fldList,'UV_VEL_C'));
uv_dd(:,:,:,i) = dyn(:,:,:,J);
[uv_dd_zav(:,:,i),mskzon,ylat,areazon]=calcZonalAvgCube(uv_dd(:,:,:,i),ny,yc,ar,hc);

uv_ed_dd_zav(:,:,i) = uv_dd_zav(:,:,i) - uEvN_dd_zav(:,:,i);

end


uE_ddm_zav = mean(uE_dd_zav,3);
vN_ddm_zav = mean(vN_dd_zav,3);
uEvN_ddm_zav = uE_ddm_zav.*vN_ddm_zav;
uv_ddm_zav = mean(uv_dd_zav,3);

uv_ed_ddm_zav = uv_ddm_zav - uEvN_ddm_zav;
uv_ed_dm_zav = mean(uv_ed_dd_zav,3);

figure
v = -80:8:80;
contourf(ylat,rC,uv_ed_mm_zav',v);
colorbar;
colormap(b2r(-80,80));
title('year-year av');
set(gca,'YDir','reverse');
print('-dpng','uv_ed_mm.png')

figure
contourf(ylat,rC,uv_ed_dm_zav',v);
colorbar;
colormap(b2r(-80,80));
title('day-day 10 day av');
set(gca,'YDir','reverse');
print('-dpng','uv_ed_dm.png')

figure
contourf(ylat,rC,uv_ed_dd_zav(:,:,5)',v);
colorbar;
colormap(b2r(-80,80));
title('day-day av, day 5');
set(gca,'YDir','reverse');
print('-dpng','uv_ed_dd.png')

figure
contourf(ylat,rC,uv_ed_ddm_zav',v);
colorbar;
colormap(b2r(-80,80));
title('10 day - 10 day av');
set(gca,'YDir','reverse');
print('-dpng','uv_ed_ddm.png')

return



