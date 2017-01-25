%load in already written transmittances and compare with average of ones loaded up this time

load('/project/rg312/MITgcm_updated/verification/atm_gray_ruth/run/fixed_rad_input_corrected.mat')


% choose directory, load grid
rDir='/project/rg312/MITgcm_updated/verification/atm_gray_ruth/run/';
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
nit = 240;
i=i+1
[dyn,iter,M]=rdmds([rDir,'AtPhDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhTrLW'));
trans_lw(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhTrWI'));
trans_wi(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhTrSW'));
trans_sw(:,:,:,i) = dyn(:,:,:,J);



dtrans_in_ll = cube2latlon(xc,yc,dtrans_in,xi,yi);
dtrans_sol_in_ll = cube2latlon(xc,yc,dtrans_sol_in,xi,yi);
dtrans_win_in_ll = cube2latlon(xc,yc,dtrans_win_in,xi,yi);

trans_lw_ll = squeeze(cube2latlon(xc,yc,trans_lw,xi,yi));
trans_sw_ll = squeeze(cube2latlon(xc,yc,trans_sw,xi,yi));
trans_wi_ll = squeeze(cube2latlon(xc,yc,trans_wi,xi,yi));


return
load('/project/rg312/mat_files/transmittances_final.mat')

% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_000_best/';
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


dtrans_orig_ll = squeeze(cube2latlon(xc,yc,dtrans_orig,xi,yi));
trans_lw_ll = squeeze(cube2latlon(xc,yc,trans_lw,xi,yi));

dtrans_sol_orig_ll = squeeze(cube2latlon(xc,yc,dtrans_sol_orig,xi,yi));
trans_sw_ll = squeeze(cube2latlon(xc,yc,trans_sw,xi,yi));

dtrans_win_orig_ll = squeeze(cube2latlon(xc,yc,dtrans_win_orig,xi,yi));
trans_wi_ll = squeeze(cube2latlon(xc,yc,trans_wi,xi,yi));
