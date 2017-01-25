%plot uvwzeta


% choose directory, load grid
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_diag_testing/';
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


%start reading files: u, v, w
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

J=find(strcmp(fldList,'WVEL    '));
w(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'momVort3'));
vort3(:,:,:,i) = dyn(:,:,:,J);

end

uE_mean = mean(uE,4);
vN_mean = mean(vN,4);
w_mean = mean(w,4);
vort3_mean = mean(vort3,4);

[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_mean,ny,yc,ar,hc);
[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_mean,ny,yc,ar,hc);
[w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(w_mean,ny,yc,ar,hc);
[vort3_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vort3_mean,ny,yc,ar,hc);

v=-20:5:40;
figure
contourf(ylat,rC,uE_zav',v);
colorbar;
colormap(b2r(-20,40));
set(gca,'YDir','reverse')
ylabel('Pressure, Pa')
xlabel('Latitude')
title('U, m/s')
print('-dpng','uE.png')

v=-6:0.5:6;
figure
contourf(ylat,rC,vN_zav',v);
colorbar;
colormap(b2r(-6,6));
set(gca,'YDir','reverse')
ylabel('Pressure, Pa')
xlabel('Latitude')
title('V, m/s')
print('-dpng','vN.png')

v=-0.1:0.01:0.02;
figure
contourf(ylat,rC,w_zav',v);
colorbar;
colormap(b2r(-0.1,0.02));
set(gca,'YDir','reverse')
ylabel('Pressure, Pa')
xlabel('Latitude')
title('W, Pa/s')
print('-dpng','w.png')

v=-5e-5:0.5e-5:5e-5;
figure
contourf(ylat,rC,vort3_zav',v);
colorbar;
colormap(b2r(-5e-5,5e-5));
set(gca,'YDir','reverse')
ylabel('Pressure, Pa')
xlabel('Latitude')
title('Relative vorticity')
print('-dpng','vort3.png')
