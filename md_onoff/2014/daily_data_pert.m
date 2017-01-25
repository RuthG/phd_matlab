%read in daily MITgcm output and save to .mat files

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_2yeardaily_pert/';

'Set up arrays to read to. Use single to keep size small.'
k=240;
theta=single(zeros(192,32,25,k));
thetall=single(zeros(180,90,25,k));
xi=-179:2:180;yi=-89:2:90;

'Use arbitrary nit to find location of V, U and theta in dyndiag and to get gridding coords'
nit=691440;
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);
JV=find(strcmp(fldList,'VVEL    '));
JU=find(strcmp(fldList,'UVEL    '));
JT=find(strcmp(fldList,'THETA   '));

xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));
AngleCS=single(rdmds([rDir,'AngleCS']));
AngleSN=single(rdmds([rDir,'AngleSN']));

%read in data files
%l acts as counter
l=0

'first read theta files and transfer onto latlon grid'
for nit=777840:240:864000
  [dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
  eval(M);
  l=l+1
  theta(:,:,:,l)=single(dyn(:,:,:,JT));
  thetall_pert(:,:,:,l)=cube2latlon(xc,yc,theta(:,:,:,l),xi,yi);
  thetall_pert=single(thetall_pert);
end

'save and clear to save matlab space'
save('daily_data_T_pert.mat','thetall_pert')
clear theta
clear thetall

'now read velocity files and transfer onto latlon grid. Forget uE to save space'
vN=single(zeros(192,32,25,k));
vNll=single(zeros(180,90,25,k));

l=0
for nit=777840:240:864000
  [dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
  eval(M);
  l=l+1
  vvel=single(dyn(:,:,:,JV));
  uvel=single(dyn(:,:,:,JU));
  Grid='C';
  [uE,vN] = rotate_uv2uvEN(uvel,vvel,AngleCS,AngleSN,Grid);
  clear uE
  vNll_pert(:,:,:,l)=single(cube2latlon(xc,yc,vN,xi,yi));
  clear vN
end

'save and clear'
save('daily_data_V_pert.mat','vNll_pert')
clear vNll
