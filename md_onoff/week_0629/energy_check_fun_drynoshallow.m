

rDir='/net/spatstorage/disk1/rg312/run_first2years_wvoffradoff/';
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
nit=172800;


[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);
eval(M);

J=find(strcmp(fldList,'AtPhNSSR'));
s_sw_dwn=surf(:,:,J);
mean_surface_sw = sum(sum(s_sw_dwn.*ar))/sum(sum(ar))  %mean(mean(s_sw_dwn))

J=find(strcmp(fldList,'AtPhInSR'));
swin=surf(:,:,J);
mean_swin = sum(sum(swin.*ar))/sum(sum(ar))  %mean(mean(swin))

J=find(strcmp(fldList,'AtPhOLR '));
lwout=surf(:,:,J);
mean_toa_lw=sum(sum(lwout.*ar))/sum(sum(ar))

J=find(strcmp(fldList,'AtPhDSLR'));
s_lw_dwn=surf(:,:,J);
mean_surface_lw_down=sum(sum(s_lw_dwn.*ar))/sum(sum(ar))

J=find(strcmp(fldList,'AtPhUSLR'));
flux_r=surf(:,:,J);
mean_surface_lw_up=sum(sum(flux_r.*ar))/sum(sum(ar))

J=find(strcmp(fldList,'AtPhSens'));
sens=surf(:,:,J);
mean_sensible_heating=sum(sum(sens.*ar))/sum(sum(ar))

J=find(strcmp(fldList,'AtPhEvap'));
evap=surf(:,:,J)*2.5e6;
mean_evap_heating=sum(sum(evap.*ar))/sum(sum(ar))

A=0.06;
unaccounted_sw_energy=mean_swin-mean_surface_sw/(1-A);

unaccounted_lw_energy=mean_toa_lw-(mean_surface_lw_up-mean_surface_lw_down)-mean_sensible_heating-mean_evap_heating;

total_unaccounted_energy=unaccounted_sw_energy-unaccounted_lw_energy;

surface_budget = mean_surface_sw + mean_surface_lw_down - mean_surface_lw_up -mean_sensible_heating -mean_evap_heating

toa_budget = mean_swin - mean_toa_lw - A*mean_surface_sw/(1-A)

imbalance = toa_budget - surface_budget


return


load('/project/rg312/mat_files/snapshot_data_final/run_000/toa_surf_heat_000_9.mat')

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
