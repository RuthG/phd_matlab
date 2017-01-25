%plot V year by year

rDir_control='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';
rDir_perturbed='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_p/';

wet = true;

%Create reference label to identify run plot is for!
directory = pwd;
lastslash = max(findstr(directory,'/'));
dir_label = directory(lastslash:max(size(directory)));
dir_label = strrep(dir_label,'_','-');

%read in tropopause of control run
%load('/disk1/rg312/run_daily_swwv/tropopause.mat')

rDir=rDir_control;
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

%read fields
i=0;
for nit = 259200:86400:604800;
i=i+1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Control Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir = rDir_control;

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'WVEL    '));
w_ctrl(:,:,:,i)=dyn(:,:,:,J);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Perturbed Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rDir = rDir_perturbed;

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit + 691200);  
eval(M);

J=find(strcmp(fldList,'WVEL    '));
w_pert(:,:,:,i)=dyn(:,:,:,J);

end


[w_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(w_ctrl,ny,yc,ar,hc);
[w_zav_p,mskzon,ylat,areazon]=calcZonalAvgCube(w_pert,ny,yc,ar,hc);


contourf(w_zav_c(:,:,1)',20);
colorbar

v=-8e-3: 7e-4: 6e-3
contourf(ylat,rC,w_zav_c(:,:,1)'-mean(w_zav_c,3)',v);
colorbar
colormap(b2r(-8e-3,6e-3));
set(gca,'YDir','reverse')
figure
contourf(ylat,rC,w_zav_c(:,:,2)'-mean(w_zav_c,3)',v);
colorbar
colormap(b2r(-8e-3,6e-3));
set(gca,'YDir','reverse')
figure
contourf(ylat,rC,w_zav_c(:,:,3)'-mean(w_zav_c,3)',v);
colorbar
colormap(b2r(-8e-3,6e-3));
set(gca,'YDir','reverse')
figure
contourf(ylat,rC,w_zav_c(:,:,4)'-mean(w_zav_c,3)',v);
colorbar
colormap(b2r(-8e-3,6e-3));
set(gca,'YDir','reverse')
figure
contourf(ylat,rC,w_zav_c(:,:,5)'-mean(w_zav_c,3)',v);
colorbar
colormap(b2r(-8e-3,6e-3));
set(gca,'YDir','reverse')



v=-8e-3: 7e-4: 6e-3
contourf(ylat,rC,w_zav_p(:,:,1)'-mean(w_zav_c,3)',v);
colorbar
colormap(b2r(-8e-3,6e-3));
set(gca,'YDir','reverse')
figure
contourf(ylat,rC,w_zav_p(:,:,2)'-mean(w_zav_c,3)',v);
colorbar
colormap(b2r(-8e-3,6e-3));
set(gca,'YDir','reverse')
figure
contourf(ylat,rC,w_zav_p(:,:,3)'-mean(w_zav_c,3)',v);
colorbar
colormap(b2r(-8e-3,6e-3));
set(gca,'YDir','reverse')
figure
contourf(ylat,rC,w_zav_p(:,:,4)'-mean(w_zav_c,3)',v);
colorbar
colormap(b2r(-8e-3,6e-3));
set(gca,'YDir','reverse')
figure
contourf(ylat,rC,w_zav_p(:,:,5)'-mean(w_zav_c,3)',v);
colorbar
colormap(b2r(-8e-3,6e-3));
set(gca,'YDir','reverse')
