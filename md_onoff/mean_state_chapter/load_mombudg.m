%load up u, v theta, and q for the rad on run and save time means somewhere obvious!

% choose directory, load grid
rDir='/project/rg312/final_runs/run_100_final/';
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
yi = -89:2:89;

%terms used in mom budget: 
%Um_Advec = Um_AdvZ3 + Um_AdvRe
%Um_dPHdx zonal av is zero
%Um_Ext Tendency from physics
%Um_Cori included in Um_Advec so zero
%Um_Diss no dissipation
%gradient of sea surface pressure: 0 in zonal mean


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run %%%%%%%%%%%%%%%%


for j=1:10
i=0
uz = zeros(192,32,25,360);
vz = zeros(192,32,25,360);
ur = zeros(192,32,25,360);
vr = zeros(192,32,25,360);
uadv = zeros(192,32,25,360);
vadv = zeros(192,32,25,360);
uext = zeros(192,32,25,360);
vext = zeros(192,32,25,360);
vort3 = zeros(192,32,25,360);
taux = zeros(192,32,360);
tauy = zeros(192,32,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]


[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

%vort3u term = (f + zeta3)v
J=find(strcmp(fldList,'Um_AdvZ3'));
uz(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvZ3'));
vz(:,:,:,i) = dyn(:,:,:,J);

%shear term = - zeta2w
J=find(strcmp(fldList,'Um_AdvRe'));
ur(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvRe'));
vr(:,:,:,i) = dyn(:,:,:,J);

%total = vort3+shear term
J=find(strcmp(fldList,'Um_Advec'));
uadv(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_Advec'));
vadv(:,:,:,i) = dyn(:,:,:,J);

%Physics package
J=find(strcmp(fldList,'Um_Ext  '));
uext(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_Ext  '));
vext(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'momVort3'));
vort3(:,:,:,i) = dyn(:,:,:,J);

[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhTauX'));
taux(:,:,i)=surf(:,:,J);
J=find(strcmp(fldList,'AtPhTauY'));
tauy(:,:,i)=surf(:,:,J);

end

uz_tava(:,:,:,j) = mean(uz,4);
vz_tava(:,:,:,j) = mean(vz,4);
ur_tava(:,:,:,j) = mean(ur,4);
vr_tava(:,:,:,j) = mean(vr,4);
uadv_tava(:,:,:,j) = mean(uadv,4);
vadv_tava(:,:,:,j) = mean(vadv,4);
uext_tava(:,:,:,j) = mean(uext,4);
vext_tava(:,:,:,j) = mean(vext,4);
vort3_tava(:,:,:,j) = mean(vort3,4);
taux_tava(:,:,j) = mean(taux,3);
tauy_tava(:,:,j) = mean(tauy,3);

end

uz_tav = mean(uz_tava,4);
vz_tav = mean(vz_tava,4);
ur_tav = mean(ur_tava,4);
vr_tav = mean(vr_tava,4);
uadv_tav = mean(uadv_tava,4);
vadv_tav = mean(vadv_tava,4);
uext_tav = mean(uext_tava,4);
vext_tav = mean(vext_tava,4);
vort3_tav = mean(vort3_tava,4);
taux_tav = mean(taux_tava,3);
tauy_tav = mean(tauy_tava,3);

[uzE,vzN] = rotate_uv2uvEN(uz_tav,vz_tav,AngleCS,AngleSN,Grid);
[urE,vrN] = rotate_uv2uvEN(ur_tav,vr_tav,AngleCS,AngleSN,Grid);
[uadvE,vadvN] = rotate_uv2uvEN(uadv_tav,vadv_tav,AngleCS,AngleSN,Grid);
[uextE,vextN] = rotate_uv2uvEN(uext_tav,vext_tav,AngleCS,AngleSN,Grid);
[tauE,tauN] = rotate_uv2uvEN(taux_tav,tauy_tav,AngleCS,AngleSN,Grid);

save('/project/rg312/mat_files/chapter2_variables/mombudg_tav_100.mat','uzE','vzN', 'urE','vrN','uadvE', 'vadvN', 'uextE', 'vextN', 'tauE', 'tauN', 'vort3_tav')

load_mombudg_125
load_mombudg_150
