%load in model mom budg terms and remember what you were doing before!

rDir='/disk1/MITgcm/verification/atm_gray_ruth/run/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
dxc=rdmds([rDir,'DXC']);
dyc=rdmds([rDir,'DYC']);
dxg=rdmds([rDir,'DXG']);
dyg=rdmds([rDir,'DYG']);
drf=rdmds([rDir,'DRF']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
arc=rdmds([rDir,'RAC']);
ars=rdmds([rDir,'RAS']);
arw=rdmds([rDir,'RAW']);
arz=rdmds([rDir,'RAZ']);
rC=squeeze(rdmds([rDir,'RC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
ny=90;
a=6371.0e3;

%start reading files: u, v, w, momentum budget terms
i=0;
for nit = 259200:86400:432000;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVEL    '));
w(:,:,:,i) = dyn(:,:,:,J);
[uE(:,:,:,i),vN(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'WVEL    '));
w(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'Um_AdvZ3'));
uzcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvZ3'));
vzcs(:,:,:,i) = dyn(:,:,:,J);
[uzE(:,:,:,i),vzN(:,:,:,i)] = rotate_uv2uvEN(uzcs(:,:,:,i),vzcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'Um_AdvRe'));
urcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_AdvRe'));
vrcs(:,:,:,i) = dyn(:,:,:,J);
[urE(:,:,:,i),vrN(:,:,:,i)] = rotate_uv2uvEN(urcs(:,:,:,i),vrcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'Um_Advec'));
uadvcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'Vm_Advec'));
vadvcs(:,:,:,i) = dyn(:,:,:,J);
[uadvE(:,:,:,i),vadvN(:,:,:,i)] = rotate_uv2uvEN(uadvcs(:,:,:,i),vadvcs(:,:,:,i),AngleCS,AngleSN,Grid);

[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhTauX'));
tauxcs(:,:,i)=surf(:,:,J);
J=find(strcmp(fldList,'AtPhTauY'));
tauycs(:,:,i)=surf(:,:,J);
[tauE(:,:,i),tauW(:,:,i)] = rotate_uv2uvEN(tauxcs(:,:,i),tauycs(:,:,i),AngleCS,AngleSN,Grid);

end

uE_mean = mean(uE,4);
uzE_mean = mean(uzE,4);
urE_mean = mean(urE,4);
uadvE_mean = mean(uadvE,4);
tauE_mean = mean(tauE,3);
w_mean = mean(w,4);

xi=-179:2:180;yi=-89:2:90;

uEll=cube2latlon(xc,yc,uE_mean,xi,yi);
uzEll=cube2latlon(xc,yc,uzE_mean,xi,yi);
urEll=cube2latlon(xc,yc,urE_mean,xi,yi);
uadvEll=cube2latlon(xc,yc,uadvE_mean,xi,yi);
tauEll=cube2latlon(xc,yc,tauE_mean,xi,yi);
wll=cube2latlon(xc,yc,w_mean,xi,yi);

uE_zav(:,:) = mean(uEll,1);
uzE_zav(:,:) = mean(uzEll,1);
urE_zav(:,:) = mean(urEll,1);
uadvE_zav(:,:) = mean(uadvEll,1);
tauE_zav = mean(tauEll,1);
w_zav(:,:) = mean(wll,1);

dudp = gradient(uE_zav,-4000);

urE_zav_vint = sum(urE_zav,2).*4000./9.81;
uzE_zav_vint = sum(uzE_zav,2).*4000./9.81;
uadvE_zav_vint = sum(uadvE_zav,2).*4000./9.81;
ududp_vint = sum(w_zav.*dudp,2).*4000./9.81;

plot(yi,tauE_zav);
hold on
plot(yi,-uzE_zav_vint,'g');
plot(yi,-urE_zav_vint,'k');
plot(yi,-uadvE_zav_vint,'r');
plot(yi,tauE_zav+uadvE_zav_vint,'c');
