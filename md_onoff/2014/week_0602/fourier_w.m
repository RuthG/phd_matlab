%load in w data and fourier decompose at level of peak shear accel

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

%start reading files: w
i=0;
for nit = 605040:240:691200;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'WVEL    '));
w(:,:,:,i) = dyn(:,:,:,J);

end

%convert to lat lon grid
xi=-179:2:180;yi=-89:2:90;
wll=cube2latlon(xc,yc,w,xi,yi);

wll_peak(:,:,:) = wll(:,:,20,:);

sinwave = sin(20*xi.*pi./180);
sinwave_ft = fft(sinwave);

wll_ft = fft(wll_peak);
wll_ft_av = mean(wll_ft,3);




