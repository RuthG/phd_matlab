
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv_tropheat3eq/';


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
for nit = 950400:86400:1123200;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE(:,:,:,i),vN(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'UVELSQ  '));
usqcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSQ  '));
vsqcs(:,:,:,i) = dyn(:,:,:,J);

end

p0 = 100000;
tke = (usqcs + vsqcs)./2;
tke_mean = mean(tke,4);
[tke_zav,mskzon,ylat,areazon]=calcZonalAvgCube(tke_mean,ny,yc,ar,hc);
uE_mean = mean(uE,4);
[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_mean,ny,yc,ar,hc);
vN_mean = mean(vN,4);
[vN_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_mean,ny,yc,ar,hc);

zke_zav = (uE_zav.^2 + vN_zav.^2)./2;

eke =  tke_zav - zke_zav;

%convert to two hemispheres
eke_hem(:,:,1) = eke(46:90,:);
for i=1:45
eke_hem(i,:,2) = eke(46-i,:);
end


name = ['bc_box_' dir_label '.mat'];
load(name)

if mod(barzon_lats(1),2) == 0
barzon_reg = barzon_lats(1)+1:2:barzon_lats(2)+1;
else
barzon_reg = barzon_lats(1):2:barzon_lats(2);
end

%set up loop
ylat2=1:2:89;
start = find(ylat2 == min(barzon_reg))-1;


for i=1:size(barzon_reg,2)
eke_weight(i,:,:) = cos(barzon_reg(i).*pi./180) .* eke_hem(start+i,:,:) ;
cosy(i) = cos(barzon_reg(i).*pi./180);
end

eke_bzav(:,:) = sum(eke_weight,1)./sum(cosy) ;

%integrating over dp/g is rho dz

eke_int = sum(eke_bzav(1:level,:),1) .* 4000./9.81;

eke_out = mean(eke_int);

%save
name = ['eke_' dir_label '.mat'];
save(name, 'eke_out')
