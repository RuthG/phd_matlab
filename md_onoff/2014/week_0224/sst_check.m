%try to check the ssts have changed in the way expected!

rDir='/disk1/MITgcm/verification/atm_gray_ruth/run/';

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

nit=691440;

[dyn,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPh_SST'));
sst = dyn(:,:,J);

[sst_zav,mskzon,ylat,areazon]=calcZonalAvgCube(sst,ny,yc,ar,hc);

yy=ylat*90/60*pi/180;
sinyy=sin(yy);
sst_c=27*(1-sinyy.*sinyy);
sst_c(find(abs(ylat)>=60))=0;
sst_c=sst_c+273.15;

plot(ylat,sst_zav)
hold on
plot(ylat,sst_c,'r')
hold off

return

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_accidentalcontrol/';
nit=691440;

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'THETA   '));
theta_c = dyn(:,:,:,J);

[theta_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(theta_c,ny,yc,ar,hc);
