%load up and plot data from all SST expts

rDir_m(1,:)='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_accidentalcontrol/';
rDir_m(2,:)='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_tropheat/         ';
rDir_m(3,:)='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_tropheat2/        ';
rDir_m(4,:)='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_tropheat3/        ';
rDir_m(5,:)='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_newgrad/          ';
rDir_m(6,:)='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_newgrad2/         ';

%slashes = findstr(rDir,'/');
%point1 = slashes(max(size(slashes))-2);
%dir_label = rDir(point1+1:max(size(rDir))-1);
%dir_label = strrep(dir_label,'/','_');

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

for m=1:6

rDir = strtrim(rDir_m(m,:));

i=0;
for nit=691440:240:705600
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



uv_ed_zav = uv_zav - uE_zav.*vN_zav;
vt_ed_zav = vt_zav - vN_zav.*theta_zav;
[dthetadp,b,c,d] = gradient(theta_zav,-4000.);

ylat_radians = ylat.*pi./180;

a = 6371.0e3;		%radius of the earth
costhi = cos(ylat_radians);
omega = 2*pi/(24*60*60);
f = 2*omega*sin(ylat_radians);
g=9.81;

prefactor = costhi.*2.*pi.*a.^2./g;

%Calculate fluxes and scaled fluxes (Edmon 1980)
for i=1:90
Fphi(i,:,:,:) = -1.*a.*costhi(i).*uv_ed_zav(i,:,:,:);
Fp(i,:,:,:)   = a.*f(i).*costhi(i).*vt_ed_zav(i,:,:,:)./dthetadp(i,:,:,:);
Fphi_scaled(i,:,:,:) = Fphi(i,:,:,:).*prefactor(i)./a;
Fp_scaled(i,:,:,:) = Fp(i,:,:,:).*prefactor(i); 
end


theta_tav(:,:,1,:) = mean(theta_zav(:,:,41:60,:),3);
temp_tav(:,:,1,:) = mean(temp_zav(:,:,41:60,:),3);
uE_tav(:,:,1,:) = mean(uE_zav(:,:,41:60,:),3);
vN_tav(:,:,1,:) = mean(vN_zav(:,:,41:60,:),3);
w_tav(:,:,1,:) = mean(w_zav(:,:,41:60,:),3);
Fphi_scaled_tav(:,:,1,:) = mean(Fphi_scaled(:,:,41:60,:),3);
Fp_scaled_tav(:,:,1,:) = mean(Fp_scaled(:,:,41:60,:),3);

save('show_runs.mat')

for i=2:6

v=-4:0.5:10;
[C,h] = contourf(ylat,rC/100,temp_tav(:,:,1,i)'-temp_tav(:,:,1,1)',v);
colorbar;
colormap(b2r(-4,10));
set(gca,'YDir','reverse')
xlabel('Latitude');
ylabel('Pressure, hPa');
title(['Temperature, K, Av Days 41-60'])
name=['temp_run' num2str(i-1) '.png'];
print('-dpng',name)

v=-10:1:10.;
[C,h] = contourf(ylat,rC/100,uE_tav(:,:,1,i)'-uE_tav(:,:,1,1)',v);
colorbar;
colormap(b2r(-10,10.5));
set(gca,'YDir','reverse')
xlabel('Latitude');
ylabel('Pressure, hPa');
title(['Zonal wind, m/s, Av Days 41-60'])
name=['uE_run' num2str(i-1) '.png'];
print('-dpng',name)

v=-3:0.3:3;
[C,h] = contourf(ylat,rC/100,vN_tav(:,:,1,i)'-vN_tav(:,:,1,1)',v);
colorbar;
colormap(b2r(-3,3));
set(gca,'YDir','reverse')
xlabel('Latitude');
ylabel('Pressure, hPa');
title(['Meridional wind, m/s, Av Days 41-60'])
name=['vN_run' num2str(i-1) '.png'];
print('-dpng',name)

v=-0.1:0.01:0.1;
[C,h] = contourf(ylat,rC/100,w_tav(:,:,1,i)'-w_tav(:,:,1,1)',v);
colorbar;
colormap(b2r(-0.1,0.1));
set(gca,'YDir','reverse')
xlabel('Latitude');
ylabel('Pressure, hPa');
title(['Vertical wind, Pa/s, Av Days 41-60'])
name=['w_run' num2str(i-1) '.png'];
print('-dpng',name)

labelling = num2str(shiftdim([10000:10000:100000],1));
quiver(ylat,rC./10^3,1e-14.*(Fphi_scaled_tav(:,:,1,i)' - Fphi_scaled_tav(:,:,1,1)') ,1.6e-20.*(Fp_scaled_tav(:,:,1,i)' -  Fp_scaled_tav(:,:,1,1)') ,'k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
title(['EP Flux diff, Av Days 41-60'])
hold on
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');
hold off
name=['ep_run' num2str(i-1) '.png'];
print('-dpng',name)

end
