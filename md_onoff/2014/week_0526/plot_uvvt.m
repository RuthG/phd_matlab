%load up uv vt data from tropheat/wv runs and make nice plots!


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


i=0;
for nit = 432000:86400:604800;
i=i+1


%%%%%%%%%%%%%%%%%%%%%%%% Tropheat run%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nit_q = nit + 518400;
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv_tropheat3eq/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit_q);
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_th(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_th(:,:,:,i) = dyn(:,:,:,J);
[uE_th(:,:,:,i),vN_th(:,:,:,i)] = rotate_uv2uvEN(ucs_th(:,:,:,i),vcs_th(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_th(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'UV_VEL_C'));
uv_th(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_th(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_th(:,:,:,i) = dyn(:,:,:,J);
[uEt_av_th(:,:,:,i),vNt_av_th(:,:,:,i)] = rotate_uv2uvEN(ut_av_th(:,:,:,i),vt_av_th(:,:,:,i),AngleCS,AngleSN,Grid);


%%%%%%%%%%%%%%%%%%%%%%%% Control run%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv/';

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_c(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_c(:,:,:,i) = dyn(:,:,:,J);
[uE_c(:,:,:,i),vN_c(:,:,:,i)] = rotate_uv2uvEN(ucs_c(:,:,:,i),vcs_c(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_c(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'UV_VEL_C'));
uv_c(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_c(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_c(:,:,:,i) = dyn(:,:,:,J);
[uEt_av_c(:,:,:,i),vNt_av_c(:,:,:,i)] = rotate_uv2uvEN(ut_av_c(:,:,:,i),vt_av_c(:,:,:,i),AngleCS,AngleSN,Grid);


%%%%%%%%%%%%%%%%%%%%%%%% Wet run%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';


[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_w(:,:,:,i) = dyn(:,:,:,J);
[uE_w(:,:,:,i),vN_w(:,:,:,i)] = rotate_uv2uvEN(ucs_w(:,:,:,i),vcs_w(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'UV_VEL_C'));
uv_w(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av_w(:,:,:,i) = dyn(:,:,:,J);
[uEt_av_w(:,:,:,i),vNt_av_w(:,:,:,i)] = rotate_uv2uvEN(ut_av_w(:,:,:,i),vt_av_w(:,:,:,i),AngleCS,AngleSN,Grid);

end



vNt_w_tav = mean(vNt_av_w,4);
vNt_th_tav = mean(vNt_av_th,4);
vNt_c_tav = mean(vNt_av_c,4);

uv_w_tav = mean(uv_w,4);
uv_th_tav = mean(uv_th,4);
uv_c_tav = mean(uv_c,4);

uE_w_tav = mean(uE_w,4);
uE_th_tav = mean(uE_th,4);
uE_c_tav = mean(uE_c,4);

vN_w_tav = mean(vN_w,4);
vN_th_tav = mean(vN_th,4);
vN_c_tav = mean(vN_c,4);

theta_w_tav = mean(theta_w,4);
theta_th_tav = mean(theta_th,4);
theta_c_tav = mean(theta_c,4);

[vNt_w_tzav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_w_tav,ny,yc,ar,hc);
[uv_w_tzav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_w_tav,ny,yc,ar,hc);
[uE_w_tzav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_w_tav,ny,yc,ar,hc);
[vN_w_tzav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_w_tav,ny,yc,ar,hc);
[theta_w_tzav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_w_tav,ny,yc,ar,hc);

vNt_w_ed = vNt_w_tzav - vN_w_tzav.*theta_w_tzav;
uv_w_ed = uv_w_tzav - uE_w_tzav.*vN_w_tzav;

[vNt_th_tzav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_th_tav,ny,yc,ar,hc);
[uv_th_tzav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_th_tav,ny,yc,ar,hc);
[uE_th_tzav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_th_tav,ny,yc,ar,hc);
[vN_th_tzav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_th_tav,ny,yc,ar,hc);
[theta_th_tzav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_th_tav,ny,yc,ar,hc);

vNt_th_ed = vNt_th_tzav - vN_th_tzav.*theta_th_tzav;
uv_th_ed = uv_th_tzav - uE_th_tzav.*vN_th_tzav;

[vNt_c_tzav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt_c_tav,ny,yc,ar,hc);
[uv_c_tzav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_c_tav,ny,yc,ar,hc);
[uE_c_tzav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_c_tav,ny,yc,ar,hc);
[vN_c_tzav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_c_tav,ny,yc,ar,hc);
[theta_c_tzav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_c_tav,ny,yc,ar,hc);

vNt_c_ed = vNt_c_tzav - vN_c_tzav.*theta_c_tzav;
uv_c_ed = uv_c_tzav - uE_c_tzav.*vN_c_tzav;

for i=1:45

vNt_c_ed_hzav(46-i,:) = (-1.*vNt_c_ed(i,:) + vNt_c_ed(91-i,:))./2;
uv_c_ed_hzav(46-i,:) = (-1.*uv_c_ed(i,:) + uv_c_ed(91-i,:))./2;

vNt_th_ed_hzav(46-i,:) = (-1.*vNt_th_ed(i,:) + vNt_th_ed(91-i,:))./2;
uv_th_ed_hzav(46-i,:) = (-1.*uv_th_ed(i,:) + uv_th_ed(91-i,:))./2;

vNt_w_ed_hzav(46-i,:) = (-1.*vNt_w_ed(i,:) + vNt_w_ed(91-i,:))./2;
uv_w_ed_hzav(46-i,:) = (-1.*uv_w_ed(i,:) + uv_w_ed(91-i,:))./2;

end



figure
v=-40:5:40;
[C,h]=contour(ylat(46:90),rC./100.,uv_th_ed_hzav'-uv_c_ed_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','uv_thmc.png')

figure
v=-40:5:40;
[C,h]=contour(ylat(46:90),rC./100.,uv_w_ed_hzav'-uv_c_ed_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','uv_wmc.png')

figure
v=-10:2:10;
[C,h]=contour(ylat(46:90),rC./100.,vNt_th_ed_hzav'-vNt_c_ed_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','vt_thmc.png')

figure
v=-10:2:10;
[C,h]=contour(ylat(46:90),rC./100.,vNt_w_ed_hzav'-vNt_c_ed_hzav',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','vt_wmc.png')


return


