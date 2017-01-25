%load up the toa fluxes for the 10xco2 run and see if we're near eqm yet

%what went wrong in the coupled ocean run? :o
%load up temperature and wind fields, see how they look..

rDir='/project/rg312/final_runs/run_qflux_albedo_10co2/';
rDir='/project/rg312/final_runs/run_qflux_albedo/';
rDir='/project/rg312/final_runs/run_qflux_albedo_5yr/';
%rDir='/project/rg312/final_runs/run_qflux_albedo_5yr_2co2/';
rDir='/project/rg312/final_runs/run_010_final/';
rDir='/project/MITgcm/MITgcm_150518/verification/atm_gray_ruth/run/';

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
xi = -179:2:179;
A=0.3333;
%A=0.06;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run %%%%%%%%%%%%%%%%

i=0;

nit = 864000;
[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhInSR'));
insr = surf(:,:,J);
J=find(strcmp(fldList,'AtPhOLR '));
olr = surf(:,:,J);
J=find(strcmp(fldList,'AtPhNSSR'));
nssr = surf(:,:,J);
J=find(strcmp(fldList,'AtPhDSLR'));
dslr = surf(:,:,J);
J=find(strcmp(fldList,'AtPhUSLR'));
uslr = surf(:,:,J);
J=find(strcmp(fldList,'AtPhSens'));
sens = surf(:,:,J);
J=find(strcmp(fldList,'AtPhEvap'));
evap = 2.5e6.*surf(:,:,J);


nssr_mean = sum(sum(nssr.*ar))/sum(sum(ar));
olr_mean = sum(sum(olr.*ar))/sum(sum(ar));
insr_mean = sum(sum(insr.*ar))/sum(sum(ar));
dslr_mean = sum(sum(dslr.*ar))/sum(sum(ar));
uslr_mean = sum(sum(uslr.*ar))/sum(sum(ar));
sens_mean = sum(sum(sens.*ar))/sum(sum(ar));
evap_mean = sum(sum(evap.*ar))/sum(sum(ar));
toa_budg_mean = insr_mean - olr_mean - A*nssr_mean/(1-A);
surface_budget = nssr_mean + dslr_mean - uslr_mean - sens_mean - evap_mean;

insr_zav = squeeze(mean(cube2latlon(xc,yc,insr,xi,yi),1));
olr_zav = squeeze(mean(cube2latlon(xc,yc,olr,xi,yi),1));
nssr_zav = squeeze(mean(cube2latlon(xc,yc,nssr,xi,yi),1));
dslr_zav = squeeze(mean(cube2latlon(xc,yc,dslr,xi,yi),1));
uslr_zav = squeeze(mean(cube2latlon(xc,yc,uslr,xi,yi),1));
sens_zav = squeeze(mean(cube2latlon(xc,yc,sens,xi,yi),1));
evap_zav = squeeze(mean(cube2latlon(xc,yc,evap,xi,yi),1));

toa_budg_zav = insr_zav - olr_zav - A*nssr_zav/(1-A);
surface_budget_zav = nssr_zav + dslr_zav - uslr_zav - sens_zav - evap_zav;



