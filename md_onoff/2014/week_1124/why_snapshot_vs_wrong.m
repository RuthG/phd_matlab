%WHY ARE THE SNAPSHOT SPEEDS WRONG?



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
xi=-179:2:179;

nit = 86640;
rDir = '/project/rg312/wv_on_rad_off/run_doshallower10/';
u_100(:,:,:)=rdmds([rDir,'U'],nit);
v_100(:,:,:)=rdmds([rDir,'V'],nit);

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
u_100_day = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
v_100_day = dyn(:,:,:,J);


[uE_100,vN_100] = rotate_uv2uvEN(u_100,v_100,AngleCS,AngleSN,Grid);

[uE_100_day,vN_100_day] = rotate_uv2uvEN(u_100_day,v_100_day,AngleCS,AngleSN,Grid);

uE_100_zav = squeeze(mean(cube2latlon(xc,yc,uE_100,xi,yi),1));
uE_100_zav_day = squeeze(mean(cube2latlon(xc,yc,uE_100_day,xi,yi),1));

u_100_zav = squeeze(mean(cube2latlon(xc,yc,u_100,xi,yi),1));
u_100_zav_day = squeeze(mean(cube2latlon(xc,yc,u_100_day,xi,yi),1));

[uE_100_db,vN_100_db] = rotate_uv2uvEN(uE_100_day,vN_100_day,AngleCS,AngleSN,Grid);
uE_100_zav_db = squeeze(mean(cube2latlon(xc,yc,uE_100_db,xi,yi),1));
