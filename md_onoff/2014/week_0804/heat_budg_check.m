%load in heat adv terms and check if this budget is more tightly closed


% choose directory, load grid
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_diag_testing/';
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

%read files
i=0;
for nit = 605040:240:691200;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'ADVx_TH '));
advxth(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'ADVy_TH '));
advyth(:,:,:,i)=dyn(:,:,:,J);
[advEth(:,:,:,i),advNth(:,:,:,i)] = rotate_uv2uvEN(advxth(:,:,:,i),advyth(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'ADVr_TH '));
advrth(:,:,:,i)=dyn(:,:,:,J);


J=find(strcmp(fldList,'UVELTH  '));
uth(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vth(:,:,:,i)=dyn(:,:,:,J);
[uEth(:,:,:,i),vNth(:,:,:,i)] = rotate_uv2uvEN(uth(:,:,:,i),vth(:,:,:,i),AngleCS,AngleSN,Grid);

end

advEth_mean = mean(advEth,4);
advNth_mean = mean(advNth,4);
advrth_mean = mean(advrth,4);
uEth_mean = mean(uEth,4);
vNth_mean = mean(vNth,4);

xi=-179:2:180;yi=-89:2:90;
advEthll=cube2latlon(xc,yc,advEth_mean,xi,yi);
advNthll=cube2latlon(xc,yc,advNth_mean,xi,yi);
advrthll=cube2latlon(xc,yc,advrth_mean,xi,yi);
uEthll=cube2latlon(xc,yc,uEth_mean,xi,yi);
vNthll=cube2latlon(xc,yc,vNth_mean,xi,yi);

advEth_zav(:,:) = mean(advEthll,1);
advNth_zav(:,:) = mean(advNthll,1);
advrth_zav(:,:) = mean(advrthll,1);
uEth_zav(:,:) = mean(uEthll,1);
vNth_zav(:,:) = mean(vNthll,1);


