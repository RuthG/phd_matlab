%calculate fv and zetav on cs, ll, and from MITgcm output and compare

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_diag_testing/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
dxc=rdmds([rDir,'DXC']);
dyc=rdmds([rDir,'DYC']);
dxg=rdmds([rDir,'DXG']);
dyg=rdmds([rDir,'DYG']);
drf=rdmds([rDir,'DRF']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
arc=rdmds([rDir,'RAC']);
ars=rdmds([rDir,'RAS']);
arw=rdmds([rDir,'RAW']);
arz=rdmds([rDir,'RAZ']);
rC=squeeze(rdmds([rDir,'RC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
ny=90;
a=6371.0e3;

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

J=find(strcmp(fldList,'momVort3'));
vort3(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'Um_AdvZ3'));
uzcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvZ3'));
vzcs(:,:,:,i) = dyn(:,:,:,J);
[uzE(:,:,:,i),vzN(:,:,:,i)] = rotate_uv2uvEN(uzcs(:,:,:,i),vzcs(:,:,:,i),AngleCS,AngleSN,Grid);

end


%calculate f
omega = 7.292e-5;
f = 2.*omega.*sin(yg.*pi./180);

%Now shift onto lat lon grid
xi=-179:2:180;yi=-89:2:90;
uEll=cube2latlon(xc,yc,uE,xi,yi);
vNll=cube2latlon(xc,yc,vN,xi,yi);

fll=zeros(180,90);
dxll = zeros(180,90);
dyll = zeros(180,90);

dyll(:,:) = a.*pi./90;

for i=1:90
fll(:,i) = 2.*omega.*sin(yi(i).*pi./180);
dxll(:,i) = a.*cos(yi(i).*pi./180).*pi./90;
fvNll(:,i,:,:) = vNll(:,i,:,:).*fll(1,i);
fuEll(:,i,:,:) = uEll(:,i,:,:).*fll(1,i);
end



%calculate area of grid cells
arll = dxll.*dyll;

for k=1:25
for tstep=1:360

dyv(:,:) = dyc.*vcs(:,:,k,tstep)./arz;
dxu(:,:) = dxc.*ucs(:,:,k,tstep)./arz;

dyvll(:,:) = dyll.*vNll(:,:,k,tstep)./arll;
dxull(:,:) = dxll.*uEll(:,:,k,tstep)./arll;

[dyvdy,dyvdx] = gradient(dyv);
[dxudy,dxudx] = gradient(dxu);

[dyvdyll,dyvdxll] = gradient(dyvll);
[dxudyll,dxudxll] = gradient(dxull);

zeta3(:,:,k,tstep) = dyvdx - dxudy;
zeta3ll(:,:,k,tstep) = dyvdxll - dxudyll;

fucs = ucs(:,:,k,tstep).*f;
fvcs = vcs(:,:,k,tstep).*f;

gu_abs_man_cs(:,:,k,tstep) = 1./dxc .* (f + zeta3(:,:,k,tstep)) .* dxg .* vcs(:,:,k,tstep);
gv_abs_man_cs(:,:,k,tstep) = -1./dyc .* (f + zeta3(:,:,k,tstep)) .* dyg .* ucs(:,:,k,tstep);

gu_abs_man_ll(:,:,k,tstep) = 1./dxll .* (fll + zeta3ll(:,:,k,tstep)) .* dxll .* vNll(:,:,k,tstep);
gv_abs_man_ll(:,:,k,tstep) = -1./dyll .* (fll + zeta3ll(:,:,k,tstep)) .* dyll .* uEll(:,:,k,tstep);

gu_abs_mit_cs(:,:,k,tstep) = 1./dxc .* (f + vort3(:,:,k,tstep)) .* dxg .* vcs(:,:,k,tstep);
gv_abs_mit_cs(:,:,k,tstep) = -1./dyc .* (f + vort3(:,:,k,tstep)) .* dyg .* ucs(:,:,k,tstep);

gu_rel_man_cs(:,:,k,tstep) = 1./dxc .* (zeta3(:,:,k,tstep)) .* dxg .* vcs(:,:,k,tstep);
gv_rel_man_cs(:,:,k,tstep) = -1./dyc .* (zeta3(:,:,k,tstep)) .* dyg .* ucs(:,:,k,tstep);

gu_rel_man_ll(:,:,k,tstep) = 1./dxll .* (zeta3ll(:,:,k,tstep)) .* dxll .* vNll(:,:,k,tstep);
gv_rel_man_ll(:,:,k,tstep) = -1./dyll .* (zeta3ll(:,:,k,tstep)) .* dyll .* uEll(:,:,k,tstep);

gu_rel_mit_cs(:,:,k,tstep) = 1./dxc .* (vort3(:,:,k,tstep)) .* dxg .* vcs(:,:,k,tstep);
gv_rel_mit_cs(:,:,k,tstep) = -1./dyc .* (vort3(:,:,k,tstep)) .* dyg .* ucs(:,:,k,tstep);

end
end

gu_abs_man_cs_mean = mean(gu_abs_man_cs,4);
gv_abs_man_cs_mean = mean(gv_abs_man_cs,4);
gu_abs_mit_cs_mean = mean(gu_abs_mit_cs,4);
gv_abs_mit_cs_mean = mean(gv_abs_mit_cs,4);
gu_abs_man_ll_mean = mean(gu_abs_man_ll,4);
gv_abs_man_ll_mean = mean(gv_abs_man_ll,4);

gu_rel_man_cs_mean = mean(gu_rel_man_cs,4);
gv_rel_man_cs_mean = mean(gv_rel_man_cs,4);
gu_rel_mit_cs_mean = mean(gu_rel_mit_cs,4);
gv_rel_mit_cs_mean = mean(gv_rel_mit_cs,4);
gu_rel_man_ll_mean = mean(gu_rel_man_ll,4);
gv_rel_man_ll_mean = mean(gv_rel_man_ll,4);

uzE_mean = mean(uzE,4);

[guE_abs_man_cs_mean,gvN_abs_man_cs_mean] = rotate_uv2uvEN(gu_abs_man_cs_mean,gv_abs_man_cs_mean,AngleCS,AngleSN,Grid);
[guE_abs_mit_cs_mean,gvN_abs_mit_cs_mean] = rotate_uv2uvEN(gu_abs_mit_cs_mean,gv_abs_mit_cs_mean,AngleCS,AngleSN,Grid);
[guE_rel_man_cs_mean,gvN_rel_man_cs_mean] = rotate_uv2uvEN(gu_rel_man_cs_mean,gv_rel_man_cs_mean,AngleCS,AngleSN,Grid);
[guE_rel_mit_cs_mean,gvN_rel_mit_cs_mean] = rotate_uv2uvEN(gu_rel_mit_cs_mean,gv_rel_mit_cs_mean,AngleCS,AngleSN,Grid);

[guE_abs_man_cs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(guE_abs_man_cs_mean,ny,yc,arc,hc);
[gvN_abs_man_cs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(gvN_abs_man_cs_mean,ny,yc,arc,hc);
[guE_abs_mit_cs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(guE_abs_mit_cs_mean,ny,yc,arc,hc);
[gvN_abs_mit_cs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(gvN_abs_mit_cs_mean,ny,yc,arc,hc);
[guE_rel_man_cs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(guE_rel_man_cs_mean,ny,yc,arc,hc);
[gvN_rel_man_cs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(gvN_rel_man_cs_mean,ny,yc,arc,hc);
[guE_rel_mit_cs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(guE_rel_mit_cs_mean,ny,yc,arc,hc);
[gvN_rel_mit_cs_zav,mskzon,ylat,areazon]=calcZonalAvgCube(gvN_rel_mit_cs_mean,ny,yc,arc,hc);

[uzE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uzE_mean,ny,yc,arc,hc);

gu_abs_man_ll_zav(:,:) = mean(gu_abs_man_ll_mean,1);
gv_abs_man_ll_zav(:,:) = mean(gv_abs_man_ll_mean,1);
gu_rel_man_ll_zav(:,:) = mean(gu_rel_man_ll_mean,1);
gv_rel_man_ll_zav(:,:) = mean(gv_rel_man_ll_mean,1);


%Abs vort plots

figure
v=-2e-4:0.2e-4:2e-4;
[C,h] = contourf(ylat,rC,guE_abs_man_cs_zav');
colorbar;
colormap(b2r(-2e-4,2e-4));
xlabel('Latitude')
ylabel('Pressure, Pa')
title('Absolute vorticity accel: cubesphere calc')
set(gca,'YDir','reverse')
print('-dpng','absvortac_cs.png')


figure
v=-2e-4:0.1e-4:2e-4;
[C,h] = contourf(ylat,rC,guE_abs_mit_cs_zav');
colorbar;
colormap(b2r(-2e-4,2e-4));
xlabel('Latitude')
ylabel('Pressure, Pa')
title('Absolute vorticity accel: MITgcm output calc')
set(gca,'YDir','reverse')
print('-dpng','absvortac_mit.png')

figure
v=-2e-4:0.1e-4:2e-4;
[C,h] = contourf(ylat,rC,gu_abs_man_ll_zav');
colorbar;
colormap(b2r(-2e-4,2e-4));
xlabel('Latitude')
ylabel('Pressure, Pa')
title('Absolute vorticity accel: latlon calc')
set(gca,'YDir','reverse')
print('-dpng','absvortac_ll.png')

figure
v=-2e-4:0.1e-4:2e-4;
[C,h] = contourf(ylat,rC,uzE_zav');
colorbar;
colormap(b2r(-2e-4,2e-4));
xlabel('Latitude')
ylabel('Pressure, Pa')
title('Absolute vorticity accel: MITgcm output')
set(gca,'YDir','reverse')
print('-dpng','absvortac_mit.png')


%Rel vort plots

figure
v=-6e-5:0.5e-5:12e-5;
[C,h] = contourf(ylat,rC,guE_rel_man_cs_zav');
colorbar;
colormap(b2r(-6e-5,12e-5));
xlabel('Latitude')
ylabel('Pressure, Pa')
title('Relative vorticity accel: cubesphere calc')
set(gca,'YDir','reverse')
print('-dpng','relvortac_cs.png')

figure
v=-6e-5:0.5e-5:12e-5;
[C,h] = contourf(ylat,rC,guE_rel_mit_cs_zav');
colorbar;
colormap(b2r(-6e-5,12e-5));
xlabel('Latitude')
ylabel('Pressure, Pa')
title('Relative vorticity accel: MITgcm output calc')
set(gca,'YDir','reverse')
print('-dpng','relvortac_mit.png')

figure
v=-6e-5:0.5e-5:12e-5;
[C,h] = contourf(ylat,rC,gu_rel_man_ll_zav');
colorbar;
colormap(b2r(-6e-5,12e-5));
xlabel('Latitude')
ylabel('Pressure, Pa')
title('Relative vorticity accel: latlon calc')
set(gca,'YDir','reverse')
print('-dpng','relvortac_ll.png')
