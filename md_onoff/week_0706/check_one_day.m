%load up daily average jets for one day, try to work out what has happened


% choose directory, load grid
rDir='/project/rg312/final_runs/run_000_final_noshallow/';
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
yi=-89:2:89;
xi = -179:2:179;
A=0.06;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run %%%%%%%%%%%%%%%%

nit = 172800

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
u = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
v = dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta = dyn(:,:,:,J);

[dyn,iter,M]=rdmds([rDir,'AtPhDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhdTdt'));
htrt = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
cndht = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTdf'));
difht = dyn(:,:,:,J);


[uE,vN] = rotate_uv2uvEN(u,v,AngleCS,AngleSN,Grid);


u_ll = squeeze(cube2latlon(xc,yc,uE,xi,yi));
v_ll = squeeze(cube2latlon(xc,yc,vN,xi,yi));
q_ll = squeeze(cube2latlon(xc,yc,q,xi,yi));
theta_ll = squeeze(cube2latlon(xc,yc,theta,xi,yi));

htrt_ll = squeeze(cube2latlon(xc,yc,htrt,xi,yi));
cnvht_ll = squeeze(cube2latlon(xc,yc,cnvht,xi,yi));
difht_ll = squeeze(cube2latlon(xc,yc,difht,xi,yi));
cndht_ll = squeeze(cube2latlon(xc,yc,cndht,xi,yi));
radht_ll = squeeze(cube2latlon(xc,yc,radht,xi,yi));
