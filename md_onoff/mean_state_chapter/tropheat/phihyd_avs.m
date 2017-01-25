rDir='/project/rg312/final_runs/run_050_final_tropheat/';
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
xi=-179:2:180;
yi=-89:2:90;



for year = 1:10

year
load(['/project/rg312/mat_files/snapshot_data_final/run_000_ns/ph_000_' num2str(year)  '.mat']);
ph_000_tav(:,:,:,year) = mean(ph_000,4);
load(['/project/rg312/mat_files/snapshot_data_final/run_010/ph_010_' num2str(year)  '.mat']);
ph_010_tav(:,:,:,year) = mean(ph_010,4);
load(['/project/rg312/mat_files/snapshot_data_final/run_025/ph_025_' num2str(year)  '.mat']);
ph_025_tav(:,:,:,year) = mean(ph_025,4);
load(['/project/rg312/mat_files/snapshot_data_final/run_050/ph_050_' num2str(year)  '.mat']);
ph_050_tav(:,:,:,year) = mean(ph_050,4);
load(['/project/rg312/mat_files/snapshot_data_final/run_th/ph_th_' num2str(year)  '.mat']);
ph_th_tav(:,:,:,year) = mean(ph_th,4);
load(['/project/rg312/mat_files/snapshot_data_final/run_075/ph_075_' num2str(year)  '.mat']);
ph_075_tav(:,:,:,year) = mean(ph_075,4);
load(['/project/rg312/mat_files/snapshot_data_final/run_100/ph_100_' num2str(year)  '.mat']);
ph_100_tav(:,:,:,year) = mean(ph_100,4);
load(['/project/rg312/mat_files/snapshot_data_final/run_125/ph_125_' num2str(year)  '.mat']);
ph_125_tav(:,:,:,year) = mean(ph_125,4);
load(['/project/rg312/mat_files/snapshot_data_final/run_150/ph_150_' num2str(year)  '.mat']);
ph_150_tav(:,:,:,year) = mean(ph_150,4);

end

clear('ph_000','ph_010','ph_025','ph_050','ph_th','ph_075','ph_100','ph_125','ph_150')

ph_000_tav = squeeze(mean(ph_000_tav,4));
ph_010_tav = squeeze(mean(ph_010_tav,4));
ph_025_tav = squeeze(mean(ph_025_tav,4));
ph_050_tav = squeeze(mean(ph_050_tav,4));
ph_th_tav = squeeze(mean(ph_th_tav,4));
ph_075_tav = squeeze(mean(ph_075_tav,4));
ph_100_tav = squeeze(mean(ph_100_tav,4));
ph_125_tav = squeeze(mean(ph_125_tav,4));
ph_150_tav = squeeze(mean(ph_150_tav,4));

ph_000_zav = squeeze(mean(cube2latlon(xc,yc,ph_000_tav,xi,yi),1));
ph_010_zav = squeeze(mean(cube2latlon(xc,yc,ph_010_tav,xi,yi),1));
ph_025_zav = squeeze(mean(cube2latlon(xc,yc,ph_025_tav,xi,yi),1));
ph_050_zav = squeeze(mean(cube2latlon(xc,yc,ph_050_tav,xi,yi),1));
ph_th_zav = squeeze(mean(cube2latlon(xc,yc,ph_th_tav,xi,yi),1));
ph_075_zav = squeeze(mean(cube2latlon(xc,yc,ph_075_tav,xi,yi),1));
ph_100_zav = squeeze(mean(cube2latlon(xc,yc,ph_100_tav,xi,yi),1));
ph_125_zav = squeeze(mean(cube2latlon(xc,yc,ph_125_tav,xi,yi),1));
ph_150_zav = squeeze(mean(cube2latlon(xc,yc,ph_150_tav,xi,yi),1));

for i=1:90
ph_000_hzav(i,:) = (ph_000_zav(i,:) + ph_000_zav(91-i,:))./2;
ph_010_hzav(i,:) = (ph_010_zav(i,:) + ph_010_zav(91-i,:))./2;
ph_025_hzav(i,:) = (ph_025_zav(i,:) + ph_025_zav(91-i,:))./2;
ph_050_hzav(i,:) = (ph_050_zav(i,:) + ph_050_zav(91-i,:))./2;
ph_th_hzav(i,:) = (ph_th_zav(i,:) + ph_th_zav(91-i,:))./2;
ph_075_hzav(i,:) = (ph_075_zav(i,:) + ph_075_zav(91-i,:))./2;
ph_100_hzav(i,:) = (ph_100_zav(i,:) + ph_100_zav(91-i,:))./2;
ph_125_hzav(i,:) = (ph_125_zav(i,:) + ph_125_zav(91-i,:))./2;
ph_150_hzav(i,:) = (ph_150_zav(i,:) + ph_150_zav(91-i,:))./2;
end

load('/project/rg312/mat_files/trop_levs_final_th.mat')

for i=2:89;
trop_z_000(i) = ph_000_hzav(i,trop_lev_000(i))./9.8;
trop_z_010(i) = ph_010_hzav(i,trop_lev_010(i))./9.8;
trop_z_025(i) = ph_025_hzav(i,trop_lev_025(i))./9.8;
trop_z_050(i) = ph_050_hzav(i,trop_lev_050(i))./9.8;
trop_z_th(i) = ph_th_hzav(i,trop_lev_th(i))./9.8;
trop_z_075(i) = ph_075_hzav(i,trop_lev_075(i))./9.8;
trop_z_100(i) = ph_100_hzav(i,trop_lev_100(i))./9.8;
trop_z_125(i) = ph_125_hzav(i,trop_lev_125(i))./9.8;
trop_z_150(i) = ph_150_hzav(i,trop_lev_150(i))./9.8;
end

save('/project/rg312/mat_files/snapshot_data_final/phihyd_timemean.mat', 'ph_000_tav' ,'ph_010_tav', 'ph_025_tav' ,'ph_050_tav','ph_th_tav' ,'ph_075_tav' ,'ph_100_tav' ,'ph_125_tav' ,'ph_150_tav');

save('/project/rg312/mat_files/trop_levs_final_z.mat', 'trop_z_000', 'trop_z_010', 'trop_z_025', 'trop_z_050',  'trop_z_th', 'trop_z_075', 'trop_z_100', 'trop_z_125', 'trop_z_150')


