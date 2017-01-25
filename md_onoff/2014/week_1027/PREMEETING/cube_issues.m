%load in w time avs to look at corners
%also look at upper level u and v here


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

%niti = 259200;
%nits = 86400;
%nitt = 604800;


rDir = '/project/rg312/wv_on_rad_off/run_doshallower10/'
%rDir = '/project/rg312/wv_on_rad_off/run_5year_c/'

i=0;

for nit = niti:nits:nitt

i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'WVEL    '));
w_diag(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'UVEL    '));
u_diag(:,:,:,i) = dyn(:,:,:,J);

J=find(strcmp(fldList,'VVEL    '));
v_diag(:,:,:,i) = dyn(:,:,:,J);

end

mean_w_diag = mean(w_diag,4);
mean_u_diag = mean(u_diag,4);
mean_v_diag = mean(v_diag,4);

[uE_day,vN_day] = rotate_uv2uvEN(u_diag,v_diag,AngleCS,AngleSN,Grid);

save('grid_checks.mat','uE','vN','mean_w_diag')
return
k=8;
figure(1);clf;
ccB=[0 0];
AxBx=[-180 180 -90 90];
kEnv=0; shift=-1; cbV=1;
grph_CS(mean_w_diag(:,:,5),xc,yc,xg,yg,ccB(1),ccB(2),shift,cbV,AxBx,kEnv);
caxis([-0.09 0.09])
print('-dpng','mean_w5_gcs.png')
grph_CS(mean_w_diag(:,:,10),xc,yc,xg,yg,ccB(1),ccB(2),shift,cbV,AxBx,kEnv);
caxis([-0.09 0.09])
print('-dpng','mean_w10_gcs.png')
grph_CS(mean_w_diag(:,:,15),xc,yc,xg,yg,ccB(1),ccB(2),shift,cbV,AxBx,kEnv);
caxis([-0.09 0.09])
print('-dpng','mean_w15_gcs.png')
grph_CS(mean_w_diag(:,:,20),xc,yc,xg,yg,ccB(1),ccB(2),shift,cbV,AxBx,kEnv);
caxis([-0.09 0.09])
print('-dpng','mean_w20_gcs.png')
grph_CS(mean_w_diag(:,:,25),xc,yc,xg,yg,ccB(1),ccB(2),shift,cbV,AxBx,kEnv);
caxis([-0.09 0.09])
print('-dpng','mean_w25_gcs.png')

k=8;
figure(1);clf;
ccB=[0 0];
AxBx=[-180 180 -90 90];
kEnv=0; shift=-1; cbV=1;
grph_CS(uE(:,:,5),xc,yc,xg,yg,ccB(1),ccB(2),shift,cbV,AxBx,kEnv);
caxis([-35 35])
print('-dpng','mean_u5_gcs.png')
grph_CS(uE(:,:,10),xc,yc,xg,yg,ccB(1),ccB(2),shift,cbV,AxBx,kEnv);
caxis([-35 35])
print('-dpng','mean_u10_gcs.png')
grph_CS(uE(:,:,15),xc,yc,xg,yg,ccB(1),ccB(2),shift,cbV,AxBx,kEnv);
caxis([-35 35])
print('-dpng','mean_u15_gcs.png')
grph_CS(uE(:,:,20),xc,yc,xg,yg,ccB(1),ccB(2),shift,cbV,AxBx,kEnv);
caxis([-35 35])
print('-dpng','mean_u20_gcs.png')
grph_CS(uE(:,:,25),xc,yc,xg,yg,ccB(1),ccB(2),shift,cbV,AxBx,kEnv);
caxis([-35 35])
print('-dpng','mean_u25_gcs.png')


k=8;
figure(1);clf;
ccB=[0 0];
AxBx=[-180 180 -90 90];
kEnv=0; shift=-1; cbV=1;
grph_CS(vN(:,:,5),xc,yc,xg,yg,ccB(1),ccB(2),shift,cbV,AxBx,kEnv);
caxis([-4 4])
print('-dpng','mean_v5_gcs.png')
grph_CS(vN(:,:,10),xc,yc,xg,yg,ccB(1),ccB(2),shift,cbV,AxBx,kEnv);
caxis([-4 4])
print('-dpng','mean_v10_gcs.png')
grph_CS(vN(:,:,15),xc,yc,xg,yg,ccB(1),ccB(2),shift,cbV,AxBx,kEnv);
caxis([-4 4])
print('-dpng','mean_v15_gcs.png')
grph_CS(vN(:,:,20),xc,yc,xg,yg,ccB(1),ccB(2),shift,cbV,AxBx,kEnv);
caxis([-4 4])
print('-dpng','mean_v20_gcs.png')
grph_CS(vN(:,:,25),xc,yc,xg,yg,ccB(1),ccB(2),shift,cbV,AxBx,kEnv);
caxis([-4 4])
print('-dpng','mean_v25_gcs.png')

