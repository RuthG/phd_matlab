%Plot rel vort advection, planetary vort advection, shear term, surface friction


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

J=find(strcmp(fldList,'Um_AdvRe'));
urcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvRe'));
vrcs(:,:,:,i) = dyn(:,:,:,J);
[urE(:,:,:,i),vrN(:,:,:,i)] = rotate_uv2uvEN(urcs(:,:,:,i),vrcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'Um_AdvZ3'));
uzcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvZ3'));
vzcs(:,:,:,i) = dyn(:,:,:,J);
[uzE(:,:,:,i),vzN(:,:,:,i)] = rotate_uv2uvEN(uzcs(:,:,:,i),vzcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'AtPhdUdt'));
dudtcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdVdt'));
dvdtcs(:,:,:,i) = dyn(:,:,:,J);
[dudtE(:,:,:,i),dvdtN(:,:,:,i)] = rotate_uv2uvEN(dudtcs(:,:,:,i),dvdtcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'momVort3'));
vort3(:,:,:,i) = dyn(:,:,:,J);

end

vN_mean = mean(vN,4);
urE_mean = mean(urE,4);
uzE_mean = mean(uzE,4);
dudtE_mean = mean(dudtE,4);
vort3_mean = mean(vort3,4);

[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_mean,ny,yc,ar,hc);
[urE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(urE_mean,ny,yc,ar,hc);
[uzE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uzE_mean,ny,yc,ar,hc);
[dudtE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(dudtE_mean,ny,yc,ar,hc);
[vort3_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vort3_mean,ny,yc,ar,hc);

%calculate f
omega = 7.292e-5;
f = zeros(90,25);
for i=1:25
f(:,i) = 2.*omega.*sin(ylat.*pi./180);
end

fvN_zav = f.*vN_zav;

relvort_adv = uzE_zav - fvN_zav;
relvort_adv_ed = relvort_adv - vN_zav.*vort3_zav;
relvort_adv_mean = vN_zav.*vort3_zav;

v=-2e-4:0.2e-4:2e-4;
figure
contourf(ylat,rC,uzE_zav',v);
colorbar;
colormap(b2r(-2e-4,2e-4));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title('gU: Abs vort advection term')
print('-dpng','gu_shear.png')

figure
contourf(ylat,rC,urE_zav',v);
colorbar;
colormap(b2r(-2e-4,2e-4));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title('gU: Shear term')
print('-dpng','gu_absvort.png')

figure
contourf(ylat,rC,fvN_zav',v);
colorbar;
colormap(b2r(-2e-4,2e-4));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title('gU: Plan vort advection term')
print('-dpng','gu_planvort.png')

figure
contourf(ylat,rC,dudtE_zav',v);
colorbar;
colormap(b2r(-2e-4,2e-4));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title('gU: Friction term');
print('-dpng','gu_friction.png')

figure
contourf(ylat,rC,relvort_adv',v);
colorbar;
colormap(b2r(-2e-4,2e-4));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title('gU: Rel vort advection term')
print('-dpng','gu_relvort.png')

figure
contourf(ylat,rC,relvort_adv_ed',v);
colorbar;
colormap(b2r(-2e-4,2e-4));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title('gU: Rel vort advection: eddy term')
print('-dpng','gu_relvorted.png')

figure
contourf(ylat,rC,relvort_adv_mean',v);
colorbar;
colormap(b2r(-2e-4,2e-4));
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title('gU: Rel vort advection: zonal mean term')
print('-dpng','gu_relvortz.png')
