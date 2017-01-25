%load up heat rates from MITgcm to check matlab version of radmod is doing what we want

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5year/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));
drC=squeeze(rdmds([rDir,'DRC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
ny=90;

i=0;
for nit = 259200:86400:432000;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhdTrd'));
radht_th(:,:,:,i)=dyn(:,:,:,J);

end

    convthetatoT=(rC/101325.0).^(2./7.);
    for k=1:size(rC)
      radht(:,:,k,:)=radht_th(:,:,k,:).*convthetatoT(k,1);
    end

radht_mean = mean(radht,4);

xi=-179:2:180;yi=-89:2:90;
radhtll=cube2latlon(xc,yc,radht_mean,xi,yi);

radht_zav(:,:) = mean(radhtll,1);

radht_check = flipdim(radht_zav,2);

load('radmod_lw.mat')
load('radmod_sw.mat')


