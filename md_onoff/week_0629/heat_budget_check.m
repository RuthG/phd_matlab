%take years worth of heat budget data and check eq-pole imbalance between runs

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

load('/project/rg312/mat_files/snapshot_data_final/run_000/toa_surf_heat_000_1.mat')
sens_000_zav = squeeze(mean(mean(cube2latlon(xc,yc,sens_000,xi,yi),1),3));
evap_000_zav = squeeze(mean(mean(cube2latlon(xc,yc,evap_000,xi,yi),1),3)).*2.5e6;
nssr_000_zav = squeeze(mean(mean(cube2latlon(xc,yc,nssr_000,xi,yi),1),3));
dslr_000_zav = squeeze(mean(mean(cube2latlon(xc,yc,dslr_000,xi,yi),1),3));
uslr_000_zav = squeeze(mean(mean(cube2latlon(xc,yc,uslr_000,xi,yi),1),3));
olr_000_zav = squeeze(mean(mean(cube2latlon(xc,yc,olr_000,xi,yi),1),3));
insr_000_zav = squeeze(mean(mean(cube2latlon(xc,yc,insr_000,xi,yi),1),3));
toa_000_zav = insr_000_zav - olr_000_zav - A*nssr_000_zav/(1-A);
surf_000_zav = nssr_000_zav + dslr_000_zav - uslr_000_zav - sens_000_zav - evap_000_zav;


load('/project/rg312/mat_files/snapshot_data_final/run_010/toa_surf_heat_010_1.mat')
sens_010_zav = squeeze(mean(mean(cube2latlon(xc,yc,sens_010,xi,yi),1),3));
evap_010_zav = squeeze(mean(mean(cube2latlon(xc,yc,evap_010,xi,yi),1),3)).*2.5e6;
nssr_010_zav = squeeze(mean(mean(cube2latlon(xc,yc,nssr_010,xi,yi),1),3));
dslr_010_zav = squeeze(mean(mean(cube2latlon(xc,yc,dslr_010,xi,yi),1),3));
uslr_010_zav = squeeze(mean(mean(cube2latlon(xc,yc,uslr_010,xi,yi),1),3));
olr_010_zav = squeeze(mean(mean(cube2latlon(xc,yc,olr_010,xi,yi),1),3));
insr_010_zav = squeeze(mean(mean(cube2latlon(xc,yc,insr_010,xi,yi),1),3));
toa_010_zav = insr_010_zav - olr_010_zav - A*nssr_010_zav/(1-A);
surf_010_zav = nssr_010_zav + dslr_010_zav - uslr_010_zav - sens_010_zav - evap_010_zav;


load('/project/rg312/mat_files/snapshot_data_final/run_025/toa_surf_heat_025_1.mat')
sens_025_zav = squeeze(mean(mean(cube2latlon(xc,yc,sens_025,xi,yi),1),3));
evap_025_zav = squeeze(mean(mean(cube2latlon(xc,yc,evap_025,xi,yi),1),3)).*2.5e6;
nssr_025_zav = squeeze(mean(mean(cube2latlon(xc,yc,nssr_025,xi,yi),1),3));
dslr_025_zav = squeeze(mean(mean(cube2latlon(xc,yc,dslr_025,xi,yi),1),3));
uslr_025_zav = squeeze(mean(mean(cube2latlon(xc,yc,uslr_025,xi,yi),1),3));
olr_025_zav = squeeze(mean(mean(cube2latlon(xc,yc,olr_025,xi,yi),1),3));
insr_025_zav = squeeze(mean(mean(cube2latlon(xc,yc,insr_025,xi,yi),1),3));
toa_025_zav = insr_025_zav - olr_025_zav - A*nssr_025_zav/(1-A);
surf_025_zav = nssr_025_zav + dslr_025_zav - uslr_025_zav - sens_025_zav - evap_025_zav;


load('/project/rg312/mat_files/snapshot_data_final/run_050/toa_surf_heat_050_1.mat')
sens_050_zav = squeeze(mean(mean(cube2latlon(xc,yc,sens_050,xi,yi),1),3));
evap_050_zav = squeeze(mean(mean(cube2latlon(xc,yc,evap_050,xi,yi),1),3)).*2.5e6;
nssr_050_zav = squeeze(mean(mean(cube2latlon(xc,yc,nssr_050,xi,yi),1),3));
dslr_050_zav = squeeze(mean(mean(cube2latlon(xc,yc,dslr_050,xi,yi),1),3));
uslr_050_zav = squeeze(mean(mean(cube2latlon(xc,yc,uslr_050,xi,yi),1),3));
olr_050_zav = squeeze(mean(mean(cube2latlon(xc,yc,olr_050,xi,yi),1),3));
insr_050_zav = squeeze(mean(mean(cube2latlon(xc,yc,insr_050,xi,yi),1),3));
toa_050_zav = insr_050_zav - olr_050_zav - A*nssr_050_zav/(1-A);
surf_050_zav = nssr_050_zav + dslr_050_zav - uslr_050_zav - sens_050_zav - evap_050_zav;


load('/project/rg312/mat_files/snapshot_data_final/run_075/toa_surf_heat_075_1.mat')
sens_075_zav = squeeze(mean(mean(cube2latlon(xc,yc,sens_075,xi,yi),1),3));
evap_075_zav = squeeze(mean(mean(cube2latlon(xc,yc,evap_075,xi,yi),1),3)).*2.5e6;
nssr_075_zav = squeeze(mean(mean(cube2latlon(xc,yc,nssr_075,xi,yi),1),3));
dslr_075_zav = squeeze(mean(mean(cube2latlon(xc,yc,dslr_075,xi,yi),1),3));
uslr_075_zav = squeeze(mean(mean(cube2latlon(xc,yc,uslr_075,xi,yi),1),3));
olr_075_zav = squeeze(mean(mean(cube2latlon(xc,yc,olr_075,xi,yi),1),3));
insr_075_zav = squeeze(mean(mean(cube2latlon(xc,yc,insr_075,xi,yi),1),3));
toa_075_zav = insr_075_zav - olr_075_zav - A*nssr_075_zav/(1-A);
surf_075_zav = nssr_075_zav + dslr_075_zav - uslr_075_zav - sens_075_zav - evap_075_zav;


load('/project/rg312/mat_files/snapshot_data_final/run_100/toa_surf_heat_100_1.mat')
sens_100_zav = squeeze(mean(mean(cube2latlon(xc,yc,sens_100,xi,yi),1),3));
evap_100_zav = squeeze(mean(mean(cube2latlon(xc,yc,evap_100,xi,yi),1),3)).*2.5e6;
nssr_100_zav = squeeze(mean(mean(cube2latlon(xc,yc,nssr_100,xi,yi),1),3));
dslr_100_zav = squeeze(mean(mean(cube2latlon(xc,yc,dslr_100,xi,yi),1),3));
uslr_100_zav = squeeze(mean(mean(cube2latlon(xc,yc,uslr_100,xi,yi),1),3));
olr_100_zav = squeeze(mean(mean(cube2latlon(xc,yc,olr_100,xi,yi),1),3));
insr_100_zav = squeeze(mean(mean(cube2latlon(xc,yc,insr_100,xi,yi),1),3));
toa_100_zav = insr_100_zav - olr_100_zav - A*nssr_100_zav/(1-A);
surf_100_zav = nssr_100_zav + dslr_100_zav - uslr_100_zav - sens_100_zav - evap_100_zav;


load('/project/rg312/mat_files/snapshot_data_final/run_125/toa_surf_heat_125_1.mat')
sens_125_zav = squeeze(mean(mean(cube2latlon(xc,yc,sens_125,xi,yi),1),3));
evap_125_zav = squeeze(mean(mean(cube2latlon(xc,yc,evap_125,xi,yi),1),3)).*2.5e6;
nssr_125_zav = squeeze(mean(mean(cube2latlon(xc,yc,nssr_125,xi,yi),1),3));
dslr_125_zav = squeeze(mean(mean(cube2latlon(xc,yc,dslr_125,xi,yi),1),3));
uslr_125_zav = squeeze(mean(mean(cube2latlon(xc,yc,uslr_125,xi,yi),1),3));
olr_125_zav = squeeze(mean(mean(cube2latlon(xc,yc,olr_125,xi,yi),1),3));
insr_125_zav = squeeze(mean(mean(cube2latlon(xc,yc,insr_125,xi,yi),1),3));
toa_125_zav = insr_125_zav - olr_125_zav - A*nssr_125_zav/(1-A);
surf_125_zav = nssr_125_zav + dslr_125_zav - uslr_125_zav - sens_125_zav - evap_125_zav;


load('/project/rg312/mat_files/snapshot_data_final/run_150/toa_surf_heat_150_1.mat')
sens_150_zav = squeeze(mean(mean(cube2latlon(xc,yc,sens_150,xi,yi),1),3));
evap_150_zav = squeeze(mean(mean(cube2latlon(xc,yc,evap_150,xi,yi),1),3)).*2.5e6;
nssr_150_zav = squeeze(mean(mean(cube2latlon(xc,yc,nssr_150,xi,yi),1),3));
dslr_150_zav = squeeze(mean(mean(cube2latlon(xc,yc,dslr_150,xi,yi),1),3));
uslr_150_zav = squeeze(mean(mean(cube2latlon(xc,yc,uslr_150,xi,yi),1),3));
olr_150_zav = squeeze(mean(mean(cube2latlon(xc,yc,olr_150,xi,yi),1),3));
insr_150_zav = squeeze(mean(mean(cube2latlon(xc,yc,insr_150,xi,yi),1),3));
toa_150_zav = insr_150_zav - olr_150_zav - A*nssr_150_zav/(1-A);
surf_150_zav = nssr_150_zav + dslr_150_zav - uslr_150_zav - sens_150_zav - evap_150_zav;


plot(yi,toa_000_zav-surf_000_zav,'r')
hold on
plot(yi,toa_010_zav-surf_010_zav,'r--')
plot(yi,toa_025_zav-surf_025_zav,'g')
plot(yi,toa_050_zav-surf_050_zav,'g--')
plot(yi,toa_075_zav-surf_075_zav,'b')
plot(yi,toa_100_zav-surf_100_zav,'b--')
plot(yi,toa_125_zav-surf_125_zav,'k')
plot(yi,toa_150_zav-surf_150_zav,'k--')
plot(yi,zeros(90,1),'k','LineWeight',2)
legend('0','0.1','0.25','0.5','0.75','1.0','1.25','1.5')
xlabel('Latitude')
ylabel('Energy flux into atmosphere, W/m^2')
print('-dpng','energy_fluxes_check.png')

