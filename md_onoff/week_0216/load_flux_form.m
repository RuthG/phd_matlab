%load up flux form heat budget terms



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


vth_000 = zeros(192,32,25,720);
vth_010 = zeros(192,32,25,720);
vth_025 = zeros(192,32,25,720);
vth_050 = zeros(192,32,25,720);
vth_075 = zeros(192,32,25,720);
vth_100 = zeros(192,32,25,720);
uth_000 = zeros(192,32,25,720);
uth_010 = zeros(192,32,25,720);
uth_025 = zeros(192,32,25,720);
uth_050 = zeros(192,32,25,720);
uth_075 = zeros(192,32,25,720);
uth_100 = zeros(192,32,25,720);
wth_000 = zeros(192,32,25,720);
wth_010 = zeros(192,32,25,720);
wth_025 = zeros(192,32,25,720);
wth_050 = zeros(192,32,25,720);
wth_075 = zeros(192,32,25,720);
wth_100 = zeros(192,32,25,720);

i=0
for nit = 86640:240:259200;
i=i+1

rDir = '/project/rg312/wv_on_rad_off/run_doshallower00/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVELTH  '));
uth_000(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vth_000(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVELTH  '));
wth_000(:,:,:,i) = dyn(:,:,:,J);


rDir = '/project/rg312/wv_on_rad_off/run_doshallower01/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVELTH  '));
uth_010(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vth_010(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVELTH  '));
wth_010(:,:,:,i) = dyn(:,:,:,J);


rDir = '/project/rg312/wv_on_rad_off/run_doshallower025/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVELTH  '));
uth_025(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vth_025(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVELTH  '));
wth_025(:,:,:,i) = dyn(:,:,:,J);


rDir = '/project/rg312/wv_on_rad_off/run_doshallower05/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVELTH  '));
uth_050(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vth_050(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVELTH  '));
wth_050(:,:,:,i) = dyn(:,:,:,J);


rDir = '/project/rg312/wv_on_rad_off/run_doshallower75/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVELTH  '));
uth_075(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vth_075(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVELTH  '));
wth_075(:,:,:,i) = dyn(:,:,:,J);


rDir = '/project/rg312/wv_on_rad_off/run_doshallower10/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVELTH  '));
uth_100(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vth_100(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVELTH  '));
wth_100(:,:,:,i) = dyn(:,:,:,J);

end



'rotate to n-e'

vNth_000 = zeros(192,32,25,720);
vNth_010 = zeros(192,32,25,720);
vNth_025 = zeros(192,32,25,720);
vNth_050 = zeros(192,32,25,720);
vNth_075 = zeros(192,32,25,720);
vNth_100 = zeros(192,32,25,720);
uEth_000 = zeros(192,32,25,720);
uEth_010 = zeros(192,32,25,720);
uEth_025 = zeros(192,32,25,720);
uEth_050 = zeros(192,32,25,720);
uEth_075 = zeros(192,32,25,720);
uEth_100 = zeros(192,32,25,720);

xi=-179:2:179;
yi=-89:2:89;

[uEth_000,vNth_000] = rotate_uv2uvEN(uth_000,vth_000,AngleCS,AngleSN,Grid);
[uEth_010,vNth_010] = rotate_uv2uvEN(uth_010,vth_010,AngleCS,AngleSN,Grid);
[uEth_025,vNth_025] = rotate_uv2uvEN(uth_025,vth_025,AngleCS,AngleSN,Grid);
[uEth_050,vNth_050] = rotate_uv2uvEN(uth_050,vth_050,AngleCS,AngleSN,Grid);
[uEth_075,vNth_075] = rotate_uv2uvEN(uth_075,vth_075,AngleCS,AngleSN,Grid);
[uEth_100,vNth_100] = rotate_uv2uvEN(uth_100,vth_100,AngleCS,AngleSN,Grid);


'rotate to ll'

%vNth_000_ll = zeros(192,32,25,720);
%vNth_010_ll = zeros(192,32,25,720);
%vNth_025_ll = zeros(192,32,25,720);
%vNth_050_ll = zeros(192,32,25,720);
%vNth_075_ll = zeros(192,32,25,720);
%vNth_100_ll = zeros(192,32,25,720);
%uEth_000_ll = zeros(192,32,25,720);
%uEth_010_ll = zeros(192,32,25,720);
%uEth_025_ll = zeros(192,32,25,720);
%uEth_050_ll = zeros(192,32,25,720);
%uEth_075_ll = zeros(192,32,25,720);
%uEth_100_ll = zeros(192,32,25,720);
%wth_000_ll = zeros(192,32,25,720);
%wth_010_ll = zeros(192,32,25,720);
%wth_025_ll = zeros(192,32,25,720);
%wth_050_ll = zeros(192,32,25,720);
%wth_075_ll = zeros(192,32,25,720);
%wth_100_ll = zeros(192,32,25,720);


%uEth_000_ll = cube2latlon(xc,yc,uEth_000,xi,yi);
%vNth_000_ll = cube2latlon(xc,yc,vNth_000,xi,yi);
%wth_000_ll = cube2latlon(xc,yc,wth_000,xi,yi);

%uEth_010_ll = cube2latlon(xc,yc,uEth_010,xi,yi);
%vNth_010_ll = cube2latlon(xc,yc,vNth_010,xi,yi);
%wth_010_ll = cube2latlon(xc,yc,wth_010,xi,yi);

%uEth_025_ll = cube2latlon(xc,yc,uEth_025,xi,yi);
%vNth_025_ll = cube2latlon(xc,yc,vNth_025,xi,yi);
%wth_025_ll = cube2latlon(xc,yc,wth_025,xi,yi);

%uEth_050_ll = cube2latlon(xc,yc,uEth_050,xi,yi);
%vNth_050_ll = cube2latlon(xc,yc,vNth_050,xi,yi);
%wth_050_ll = cube2latlon(xc,yc,wth_050,xi,yi);

%uEth_075_ll = cube2latlon(xc,yc,uEth_075,xi,yi);
%vNth_075_ll = cube2latlon(xc,yc,vNth_075,xi,yi);
%wth_075_ll = cube2latlon(xc,yc,wth_075,xi,yi);

%uEth_100_ll = cube2latlon(xc,yc,uEth_100,xi,yi);
%vNth_100_ll = cube2latlon(xc,yc,vNth_100,xi,yi);
%wth_100_ll = cube2latlon(xc,yc,wth_100,xi,yi);


'save all'

save('/project/rg312/mat_files/heat_budg_uEth.mat','uEth_000','uEth_010','uEth_025','uEth_050','uEth_075','uEth_100')

save('/project/rg312/mat_files/heat_budg_vNth.mat','vNth_000','vNth_010','vNth_025','vNth_050','vNth_075','vNth_100')

save('/project/rg312/mat_files/heat_budg_wth.mat','wth_000','wth_010','wth_025','wth_050','wth_075','wth_100')
