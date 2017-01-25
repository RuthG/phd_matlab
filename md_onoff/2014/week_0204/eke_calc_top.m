%calculate the EKE integrated over the storm track as defined in O'Gorman and Schneider 2008

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_on/run_10yearradon/';

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
for nit = 259200:86400:604800;
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

%calculate local |v^2|
ke = uucs + vvcs;

%calculate zonal average of u, v, and |v^2|
[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE,ny,yc,ar,hc);
[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN,ny,yc,ar,hc);
[ke_zav,mskzon,ylat,areazon]=calcZonalAvgCube(ke,ny,yc,ar,hc);

%calculate <v'^2> = <|v^2|> - <|v|>^2 (<> zon av)

eke_zav = ke_zav - uE_zav.^2 - vN_zav.^2;

%take time mean
eke_tzav = mean(eke_zav,3);
for i=1:90
eke_wt(i,:) = eke_tzav(i,:).*cos(ylat(i).*pi./180);
end

%%%%Following O'Gorman 2008 we define baroclinic zones as within 15 degrees of max of v'T', and as extending to the tropopause. Therefore we need to get these values!
name = ['bc_box_' dir_label '.mat'];
load(name);

%To find in units of J/m2 calculate integral over dp/g
eke_jm2 = 0.5.*4000/9.81 .* sum(eke_tzav,2);
plot(ylat,eke_jm2)
xlabel('Latitude')
ylabel('EKE, J/m^2')
name = ['eke_horiz_' dir_label '.png'];
print('-dpng',name)
                 
%Weight with cos(lat) for averaging over lats
eke_jm2 = eke_jm2.*cos(ylat'.*pi./180);

if(mod(barzon_lats(1),2)==0)
min_no = find(abs(ylat) == barzon_lats(1)-1);
max_no = find(abs(ylat) == barzon_lats(2)+1);
else
min_no = find(abs(ylat) == barzon_lats(1)-1);
max_no = find(abs(ylat) == barzon_lats(2)+1);
end

%eke_diag = (mean(eke_jm2(max_no(1):min_no(1))) + mean(eke_jm2(min_no(2):max_no(2))))./2;

eke_bzav = (sum(eke_wt(max_no(1):min_no(1),:))./sum(cos(ylat(max_no(1):min_no(1)).*pi./180)) + sum(eke_wt(min_no(2):max_no(2),:))./sum(cos(ylat(min_no(2):max_no(2)).*pi./180)))./2;

eke_vert_check = 0.5.*4000/9.81 .* eke_bzav;
plot(eke_vert_check,rC)
set(gca,'YDir','reverse')
xlabel('EKE, J/m^2')
ylabel('Pressure, Pa')
name = ['eke_vert_' dir_label '.png'];
print('-dpng',name)
                       
eke_diag = (sum(eke_jm2(max_no(1):min_no(1)))./sum(cos(ylat(max_no(1):min_no(1)).*pi./180)) + sum(eke_jm2(min_no(2):max_no(2)))./sum(cos(ylat(min_no(2):max_no(2)).*pi./180)))./2;

name = ['eke_top_' dir_label '.mat'];
save(name)
