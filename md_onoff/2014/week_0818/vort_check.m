%load in vort3 from model and compare with -dudy


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

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVEL    '));
w(:,:,:,i) = dyn(:,:,:,J);
[uE(:,:,:,i),vN(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'momVort3'));
vort3(:,:,:,i) = dyn(:,:,:,J);

end

uE_mean = mean(uE,4);
vort3_mean = mean(vort3,4);

xi=-179:2:180;yi=-89:2:90;
uEll=cube2latlon(xc,yc,uE_mean,xi,yi);
vort3ll=cube2latlon(xc,yc,vort3_mean,xi,yi);

uE_zav(:,:) = mean(uEll,1);
vort3_zav(:,:) = mean(vort3ll,1);

cosphi = zeros(90,25);
for i=1:25
cosphi(:,i) = cos(yi.*pi./180)';
end

a=6371.0e3;
uE_weight = uE_zav.*cosphi;
[b,duEdy_s] = gradient(uE_weight,pi./90);
duEdy = duEdy_s./cosphi./a;



