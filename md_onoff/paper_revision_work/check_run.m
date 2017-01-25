%is transmittance actually loading and not printing, or is it loading zeros?

% choose directory, load grid
rDir = '/project/rg312/final_runs/run_100_rad_on_sens/';
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
xi=-179:2:180;yi=-89:2:90;


i=0
for nit = 259200;
i=i+1
[dyn,iter,M]=rdmds([rDir,'radDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhTrLW'));
trans_lw(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhTrWI'));
trans_wi(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhTrSW'));
trans_sw(:,:,:,i) = dyn(:,:,:,J);


u=rdmds([rDir,'uVeltave'],nit);
v=rdmds([rDir,'vVeltave'],nit);
w=rdmds([rDir,'wVeltave'],nit);
t=rdmds([rDir,'Ttave'],nit);
q=rdmds([rDir,'Stave'],nit);

end


[uE,vN] = rotate_uv2uvEN(u,v,AngleCS,AngleSN,Grid);

trans_lw_ll = squeeze(cube2latlon(xc,yc,trans_lw,xi,yi));
trans_sw_ll = squeeze(cube2latlon(xc,yc,trans_sw,xi,yi));
trans_wi_ll = squeeze(cube2latlon(xc,yc,trans_wi,xi,yi));

q_ll = squeeze(cube2latlon(xc,yc,q,xi,yi));
theta_ll = squeeze(cube2latlon(xc,yc,t,xi,yi));
u_ll = squeeze(cube2latlon(xc,yc,uE,xi,yi));
v_ll = squeeze(cube2latlon(xc,yc,vN,xi,yi));
w_ll = squeeze(cube2latlon(xc,yc,w,xi,yi));




