
rDir='/project/rg312/final_runs/run_100_final/';
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

load('/project/rg312/mat_files/snapshot_data_final/run_000_ns/toa_surf_heat.mat')

sens_mean = sum(sum(mean(sens_000,3).*ar))/sum(sum(ar));
evap_mean = 2.5e6.*sum(sum(mean(evap_000,3).*ar))/sum(sum(ar));
nssr_mean = sum(sum(mean(nssr_000,3).*ar))/sum(sum(ar));
dslr_mean = sum(sum(mean(dslr_000,3).*ar))/sum(sum(ar));
uslr_mean = sum(sum(mean(uslr_000,3).*ar))/sum(sum(ar));
olr_mean = sum(sum(mean(olr_000,3).*ar))/sum(sum(ar));
insr_mean = sum(sum(mean(insr_000,3).*ar))/sum(sum(ar));


surface_budget = nssr_mean + dslr_mean - uslr_mean - sens_mean - evap_mean

toa_budget = insr_mean - olr_mean - A*nssr_mean/(1-A)

imbalance = toa_budget - surface_budget

unaccounted_sw_energy=insr_mean - nssr_mean/(1-A);
unaccounted_lw_energy=olr_mean-(uslr_mean-dslr_mean)-sens_mean-evap_mean;
