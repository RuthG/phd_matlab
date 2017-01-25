%load up a daily data file from each run (wv on, half, quarter, off, tropheat eq) and compare how total heat rate looks as a map, plus look at what this is made up of!


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_1yeardaily_c/';
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

nit = 619200;


[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhdTdt'));
ucs(:,:,:) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
vcs(:,:,:) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
t(:,:,:) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
q(:,:,:) = dyn(:,:,:,J);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv_daily/';

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhdTdt'));
ucs_h(:,:,:) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcd'));
vcs_h(:,:,:) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTcv'));
t_h(:,:,:) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
q_h(:,:,:) = dyn(:,:,:,J);

xi=-179:2:180;yi=-89:2:90;

htrt_w(:,:,:)=single(cube2latlon(xc,yc,ucs,xi,yi));
cndt_w(:,:,:)=single(cube2latlon(xc,yc,vcs,xi,yi));
cnvt_w(:,:,:)=single(cube2latlon(xc,yc,t,xi,yi));
rdht_w(:,:,:)=single(cube2latlon(xc,yc,q,xi,yi));


htrt_h(:,:,:)=single(cube2latlon(xc,yc,ucs_h,xi,yi));
cndt_h(:,:,:)=single(cube2latlon(xc,yc,vcs_h,xi,yi));
cnvt_h(:,:,:)=single(cube2latlon(xc,yc,t_h,xi,yi));
rdht_h(:,:,:)=single(cube2latlon(xc,yc,q_h,xi,yi));

htrt_w = htrt_w.*86400;
cndt_w = cndt_w.*86400;
cnvt_w = cnvt_w.*86400;
rdht_w = rdht_w.*86400;

htrt_h = htrt_h.*86400;
cndt_h = cndt_h.*86400;
cnvt_h = cnvt_h.*86400;
rdht_h = rdht_h.*86400;

v=-4:0.1:4;