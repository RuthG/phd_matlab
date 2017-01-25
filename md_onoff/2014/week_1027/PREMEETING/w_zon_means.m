%load up w and take zonal means to define subsidence region for averaging.


% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_doshallower10/';
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run %%%%%%%%%%%%%%%%


niti = 86640;
nits = 240;
nitt = 259200;

w_000 = zeros(192,32,25,720);
w_010 = zeros(192,32,25,720);
w_025 = zeros(192,32,25,720);
w_050 = zeros(192,32,25,720);
w_075 = zeros(192,32,25,720);
w_100 = zeros(192,32,25,720);

i=0
for nit = 86640:240:259200;
i=i+1

rDir = '/project/rg312/wv_on_rad_off/run_doshallower00/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'WVEL    '));
w_000(:,:,:,i) = dyn(:,:,:,J);

rDir = '/project/rg312/wv_on_rad_off/run_doshallower01/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'WVEL    '));
w_010(:,:,:,i) = dyn(:,:,:,J);

rDir = '/project/rg312/wv_on_rad_off/run_doshallower025/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'WVEL    '));
w_025(:,:,:,i) = dyn(:,:,:,J);

rDir = '/project/rg312/wv_on_rad_off/run_doshallower05/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'WVEL    '));
w_050(:,:,:,i) = dyn(:,:,:,J);

rDir = '/project/rg312/wv_on_rad_off/run_doshallower75/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'WVEL    '));
w_075(:,:,:,i) = dyn(:,:,:,J);

rDir = '/project/rg312/wv_on_rad_off/run_doshallower10/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'WVEL    '));
w_100(:,:,:,i) = dyn(:,:,:,J);

end


xi=-179:2:180;yi=-89:2:90;
w_000_ll = cube2latlon(xc,yc,w_000,xi,yi);
w_010_ll = cube2latlon(xc,yc,w_010,xi,yi);
w_025_ll = cube2latlon(xc,yc,w_025,xi,yi);
w_050_ll = cube2latlon(xc,yc,w_050,xi,yi);
w_075_ll = cube2latlon(xc,yc,w_075,xi,yi);
w_100_ll = cube2latlon(xc,yc,w_100,xi,yi);

w_000_tzav = squeeze(mean(mean(w_000_ll,1),4));
w_010_tzav = squeeze(mean(mean(w_010_ll,1),4));
w_025_tzav = squeeze(mean(mean(w_025_ll,1),4));
w_050_tzav = squeeze(mean(mean(w_050_ll,1),4));
w_075_tzav = squeeze(mean(mean(w_075_ll,1),4));
w_100_tzav = squeeze(mean(mean(w_100_ll,1),4));


save('w_tzavs.mat','w_000_tzav','w_010_tzav','w_025_tzav','w_050_tzav','w_075_tzav','w_100_tzav')

%save('w_lls.mat','w_000_ll','w_010_ll','w_025_ll','w_050_ll','w_075_ll','w_100_ll')

find_sc = abs(diff((w_000_tzav(:,11) > 0)));
w_sc_000 = (yi(1:89)'+yi(2:90)').*find_sc./2;
w_sc_000(w_sc_000 == 0) = [];

find_sc = abs(diff((w_010_tzav(:,11) > 0)));
w_sc_010 = (yi(1:89)'+yi(2:90)').*find_sc./2;
w_sc_010(w_sc_010 == 0) = [];

find_sc = abs(diff((w_025_tzav(:,11) > 0)));
w_sc_025 = (yi(1:89)'+yi(2:90)').*find_sc./2;
w_sc_025(w_sc_025 == 0) = [];

find_sc = abs(diff((w_050_tzav(:,11) > 0)));
w_sc_050 = (yi(1:89)'+yi(2:90)').*find_sc./2;
w_sc_050(w_sc_050 == 0) = [];

find_sc = abs(diff((w_075_tzav(:,11) > 0)));
w_sc_075 = (yi(1:89)'+yi(2:90)').*find_sc./2;
w_sc_075(w_sc_075 == 0) = [];

find_sc = abs(diff((w_100_tzav(:,11) > 0)));
w_sc_100 = (yi(1:89)'+yi(2:90)').*find_sc./2;
w_sc_100(w_sc_100 == 0) = [];

save('w_sc.mat','w_sc_000','w_sc_010','w_sc_025','w_sc_050','w_sc_075','w_sc_100');
