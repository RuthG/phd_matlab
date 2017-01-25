%Load in theta field for dry to wet spin up and look at changes in lower levels to get idea of perts for expts

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_wvspinup/'; 
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


i=0;
for nit = 691440:240:705600; 
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'THETA   '));
theta(:,:,:,i) = dyn(:,:,:,J);

end

for i=1:6
theta_av(:,:,:,i) = mean(theta(:,:,:,10*i-9:10*i),4);
end

[theta_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_av,ny,yc,ar,hc);

theta_surfish(:,:) = theta_zav(:,1,:);
