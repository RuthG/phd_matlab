%load in w data in cs form, check grid isn't screwing things up


% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_doshallower_5year/';
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


%niti = 86640;
%nits = 240;
%nitt = 259200;

niti = 259200;
nits = 86400;
nitt = 604800;

%rDir = '/project/rg312/wv_on_rad_off/run_doshallower10/'
rDir = '/project/rg312/wv_on_rad_off/run_5year_c/'

i=0;

for nit = niti:nits:nitt

i=i+1

%w(:,:,:,i) = rdmds([rDir,'W'],nit);


  [dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
  eval(M);
      J=find(strcmp(fldList,'WVEL    '));
w_diag(:,:,:,i) = dyn(:,:,:,J);
      J=find(strcmp(fldList,'WVELSQ  '));
wsq_diag(:,:,:,i) = dyn(:,:,:,J);

      J=find(strcmp(fldList,'SALT    '));
q_diag(:,:,:,i) = dyn(:,:,:,J);


      J=find(strcmp(fldList,'UVEL    '));
u_diag(:,:,:,i) = dyn(:,:,:,J);

      J=find(strcmp(fldList,'VVEL    '));
v_diag(:,:,:,i) = dyn(:,:,:,J);

end

mean_w_diag = mean(w_diag,4);
mean_wsq_diag = mean(wsq_diag,4);
mean_q_diag = mean(q_diag,4);
mean_u_diag = mean(u_diag,4);
mean_v_diag = mean(v_diag,4);

[uE,vN] = rotate_uv2uvEN(mean_u_diag,mean_v_diag,AngleCS,AngleSN,Grid);

wsq_ed = mean_wsq_diag -mean_w_diag.^2;

xi = -179:2:179; yi = -89:2:89;
mean_w_diagll=cube2latlon(xc,yc,mean_w_diag,xi,yi);
w_diagll=cube2latlon(xc,yc,w_diag(:,:,:,5),xi,yi);


k=8;
figure(1);clf;
ccB=[0 0];
AxBx=[-180 180 -90 90];
kEnv=0; shift=-1; cbV=1;
grph_CS(mean_w_diag(:,:,10),xc,yc,xg,yg,ccB(1),ccB(2),shift,cbV,AxBx,kEnv);
print('-dpdf','mean_w10dp_gcs.pdf')

k=8;
figure(1);clf;
ccB=[0 0];
AxBx=[-180 180 -90 90];
kEnv=0; shift=-1; cbV=1;
grph_CS(wsq_ed(:,:,10),xc,yc,xg,yg,ccB(1),ccB(2),shift,cbV,AxBx,kEnv);
print('-dpdf','mean_w10sq_gcs.pdf')
return
figure
contourf(mean_w_diag(:,:,10)')
print('-dpdf','mean_w10dp.pdf')

figure
contourf(xi,yi,mean_w_diagll(:,:,10)')
xlabel('Longitude')
ylabel('Latitude')
print('-dpdf','mean_wll10dp.pdf')

figure
contourf(xi,yi,w_diagll(:,:,10)')
xlabel('Longitude')
ylabel('Latitude')
print('-dpdf','wll_snapshot10dp.pdf')
