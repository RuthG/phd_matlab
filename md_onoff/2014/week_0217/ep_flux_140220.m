%ep_flux.m
%Calculate ep_fluxes from v'Th' and u'v'

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_quarterwv/';

slashes = findstr(rDir,'/');
point1 = slashes(max(size(slashes))-2);
dir_label = rDir(point1+1:max(size(rDir))-1);
dir_label = strrep(dir_label,'/','_');

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
ny=72;

%%%%%%%%%%%%%%%%%%%%%Control %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load save file from best_plots.m which contains time mean fields

i=0;
for nit=259200:86400:604800
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE(:,:,:,i),vN(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'UV_VEL_C'));
uv(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVELTH  '));
vt_av(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut_av(:,:,:,i) = dyn(:,:,:,J);
[uEt_av(:,:,:,i),vNt_av(:,:,:,i)] = rotate_uv2uvEN(ut_av(:,:,:,i),vt_av(:,:,:,i),AngleCS,AngleSN,Grid);

end

uE_mean = mean(uE,4);
vN_mean = mean(vN,4);
theta_mean = mean(theta,4);
uv_mean = mean(uv,4);
vt_mean = mean(vNt_av,4);


%take zonal mean eddy fluxes of momentum and heat
[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_mean,ny,yc,ar,hc);
[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_mean,ny,yc,ar,hc);
[uv_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uv_mean,ny,yc,ar,hc);
[vt_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vt_mean,ny,yc,ar,hc);
[theta_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_mean,ny,yc,ar,hc);

uv_ed_zav = uv_zav - uE_zav.*vN_zav;
vt_ed_zav = vt_zav - vN_zav.*theta_zav;
dthetadp = gradient(theta_zav,-4000.);

ylat_radians = ylat.*pi./180;

a = 6371.0e3;		%radius of the earth
costhi = cos(ylat_radians);
omega = 2*pi/(24*60*60);
f = 2*omega*sin(ylat_radians);
g=9.81;

prefactor = costhi.*2.*pi.*a.^2./g;

%Calculate fluxes and scaled fluxes (Edmon 1980)
for i=1:72%90
Fphi(i,:) = -1.*a.*costhi(i).*uv_ed_zav(i,:);
Fp(i,:)   = a.*f(i).*costhi(i).*vt_ed_zav(i,:)./dthetadp(i,:);
Fphi_scaled(i,:) = Fphi(i,:).*prefactor(i)./a;
Fp_scaled(i,:) = Fp(i,:).*prefactor(i); 
end

fluxdiv_p = gradient(Fp_scaled,-4000);
fluxdiv_phi = shiftdim(gradient(Fphi_scaled',2.5*pi./180.),1);

fluxdiv = fluxdiv_p + fluxdiv_phi;


%figure
%[C,h] = contourf(Fphi_scaled(:,2:25)');

%figure
%v=-5e20:1e20:5e20;
%[C,h] = contourf(Fp_scaled(:,2:25)');

figure
v=-5e16:0.2e16:5e16;
[C,h] = contourf(ylat,rC,fluxdiv',v);
colorbar
colormap(b2r(-5e16,5e16));
%caxis([-5e16 5e16])
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, Pa')
title('Total E-P Flux Divergence (Control)')
name = ['ep_flux_div' dir_label '.png'];
print('-dpng',name)

figure
labelling = num2str(shiftdim([0:10000:100000],1));
quiver(ylat,rC./10^3,1e-14.*Fphi_scaled',1.6e-20.*Fp_scaled','k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
title('E-P Flux Control')
hold on
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E15 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '5E20 M3(PA)');
name = ['ep_flux' dir_label '.png'];
print('-dpng',name)

name = ['ep_fluxes' dir_label '.mat'];
save(name)

return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%Differences %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
labelling = num2str(shiftdim([0:10000:100000],1));
quiver(ylat,rC./10^3,1e-13.*(Fphi_scaled_p-Fphi_scaled_c)',8e-19.*(Fp_scaled_p-Fp_scaled_c)','k','AutoScale','off');
set(gca,'YDir','reverse')
xlim([-90 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude')
ylabel('Pressure, Pa')
title('E-P Flux (pert-ctrl)')
hold on
quiver(-85, 16, 10, 0,'b');
text(-85, 20, '1E14 M3(RAD)');
quiver(-85, 12, 0, -8,'b');
text(-84, 12, '1E19 M3(PA)');
print('-dpng','EP_flux_diff_onoff.png')
