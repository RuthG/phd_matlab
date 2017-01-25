% load up v'T' and temperature data to calculate lowest level of the tropopause and the extent of the 'baroclinic zone'

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_p_2014/';


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
ny=90;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run %%%%%%%%%%%%%%%%

i=0;
for nit = 950400:86400:1296000;
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

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp(:,:,j,i)=theta(:,:,j,i).*convthetatoT(j,1);
end

J=find(strcmp(fldList,'VVELTH  '));
vt(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'UVELTH  '));
ut(:,:,:,i) = dyn(:,:,:,J);
[uEt(:,:,:,i),vNt(:,:,:,i)] = rotate_uv2uvEN(ut(:,:,:,i),vt(:,:,:,i),AngleCS,AngleSN,Grid);

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% first find tropopause height %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
temp_tav = mean(temp,4);

for i=1:25
rhoair(:,:,i) = rC(i)./(287.058.*temp_tav(:,:,i));
end

g=9.81;

[junk,junk2,dtempdp] = gradient(temp_tav,-4000.);
dtempdz = -1.*rhoair.*g.*dtempdp.*1000;
[dtempdz_zav,mskzon,ylat,areazon]=calcZonalAvgCube(dtempdz,ny,yc,ar,hc);

for i=1:90
trop(i) = rC(min(find((dtempdz_zav(i,:) >= -2))));
end

sigma_t_max = max(trop);
level = find(rC == sigma_t_max);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%Now use this to calculate latitude where integral of v'theta'cos(lat) from surf to tropopause is max %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[theta_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta,ny,yc,ar,hc);
[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN,ny,yc,ar,hc);
[vNt_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vNt,ny,yc,ar,hc);

vN_zav_t_zav = vN_zav.*theta_zav;
vt_ed_zav = vNt_zav - vN_zav_t_zav;

vt_ed_tzav = mean(vt_ed_zav,3);

dsigma = 4000/101325.0;

for i=1:90
barzon_a(i,:) = vt_ed_zav(i,1:level).*cos(ylat(i).*pi./180);
end

barzon_b = dsigma.*sum(barzon_a,2);

for i=1:45
barzon_c(i) = (barzon_b(91-i) - barzon_b(i))./2;
end

barzon_centre = find(barzon_c == max(barzon_c));
barzon_lats(1) = abs(ylat(barzon_centre)) - 15;
barzon_lats(2) = abs(ylat(barzon_centre)) + 15;

[temp_zav,mskzon,ylat,areazon]=calcZonalAvgCube(temp_tav,ny,yc,ar,hc);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% identify edges of baroclinic zone %%%%%%%%%%%%%%%%%%%%%%%%%

if(mod(barzon_lats(1),2)==0)
plot_min = barzon_lats(1)-1;
plot_max = barzon_lats(2)+1;
else
plot_min = barzon_lats(1);
plot_max = barzon_lats(2);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% plot to check calc makes sens %%%%%%%%%%%%%%%%%%%%%%%%%%%%

v = 180:5:300;
contourf(ylat,rC,temp_zav',v)
colorbar
set(gca,'YDir','reverse')
caxis([180 300])
hold on
plot(ylat,trop,'k','LineWidth',2)
plot([plot_min, plot_min],[98000,0],'k--')
plot([-plot_min, -plot_min],[98000,0],'k--')
plot([plot_max, plot_max],[98000,0],'k--')
plot([-plot_max, -plot_max],[98000,0],'k--')
plot([-89, 89],[sigma_t_max,sigma_t_max],'k--')
name = ['temp_' dir_label '.png'];
print('-dpng',name)
hold off

v=-20:2:20;
contourf(ylat,rC,vt_ed_tzav',v)
colorbar
set(gca,'YDir','reverse')
caxis([-20 20])
hold on
plot(ylat,trop,'k','LineWidth',2)
plot([plot_min, plot_min],[98000,0],'k--')
plot([-plot_min, -plot_min],[98000,0],'k--')
plot([plot_max, plot_max],[98000,0],'k--')
plot([-plot_max, -plot_max],[98000,0],'k--')
plot([-89, 89],[sigma_t_max,sigma_t_max],'k--')
name = ['vt_' dir_label '.png'];
print('-dpng',name)
hold off

[theta_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta,ny,yc,ar,hc);
theta_tzav = mean(theta_zav,3);

v = 250:10:750;
contourf(ylat,rC,theta_tzav',v)
colorbar
set(gca,'YDir','reverse')
caxis([250 750])
hold on
plot(ylat,trop,'k','LineWidth',2)
plot([plot_min, plot_min],[98000,0],'k--')
plot([-plot_min, -plot_min],[98000,0],'k--')
plot([plot_max, plot_max],[98000,0],'k--')
plot([-plot_max, -plot_max],[98000,0],'k--')
plot([-89, 89],[sigma_t_max,sigma_t_max],'k--')
name = ['theta_' dir_label '.png'];
print('-dpng',name)
hold off

name = ['bc_box_' dir_label '.mat'];
save(name,'barzon_lats','level')

return

