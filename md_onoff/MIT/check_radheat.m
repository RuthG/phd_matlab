%check if radiative heating is being output properly...


% choose directory, load grid
%rDir='/project/rg312/final_runs/run_100_rad_on/';
rDir='/project/rg312/final_runs/run_radon_short/';
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
xi=-179:2:180;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run %%%%%%%%%%%%%%%%


nit = 172800;

[atph,iter,M]=rdmds([rDir,'AtPhDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhdTrd'));
radht = atph(:,:,:,J);

radht_ll = cube2latlon(xc,yc,radht,xi,yi);



