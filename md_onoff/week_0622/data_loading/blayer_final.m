

rDir='/project/rg312/final_runs/run_000_final/';
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

load(['/project/rg312/mat_files/snapshot_data_final/run_000_ns/zpbl_000_' num2str(year)  '.mat']);
zpbl_000_tav(:,:,year) = mean(zpbl_000,3);

load(['/project/rg312/mat_files/snapshot_data_final/run_010/zpbl_010_' num2str(year)  '.mat']);
zpbl_010_tav(:,:,year) = mean(zpbl_010,3);

load(['/project/rg312/mat_files/snapshot_data_final/run_025/zpbl_025_' num2str(year)  '.mat']);
zpbl_025_tav(:,:,year) = mean(zpbl_025,3);

load(['/project/rg312/mat_files/snapshot_data_final/run_050/zpbl_050_' num2str(year)  '.mat']);
zpbl_050_tav(:,:,year) = mean(zpbl_050,3);

load(['/project/rg312/mat_files/snapshot_data_final/run_075/zpbl_075_' num2str(year)  '.mat']);
zpbl_075_tav(:,:,year) = mean(zpbl_075,3);

load(['/project/rg312/mat_files/snapshot_data_final/run_100/zpbl_100_' num2str(year)  '.mat']);
zpbl_100_tav(:,:,year) = mean(zpbl_100,3);

load(['/project/rg312/mat_files/snapshot_data_final/run_125/zpbl_125_' num2str(year)  '.mat']);
zpbl_125_tav(:,:,year) = mean(zpbl_125,3);

load(['/project/rg312/mat_files/snapshot_data_final/run_150/zpbl_150_' num2str(year)  '.mat']);
zpbl_150_tav(:,:,year) = mean(zpbl_150,3);


load(['/project/rg312/mat_files/snapshot_data_final/run_000_ns/ph_000_' num2str(year)  '.mat']);
ph_000_tav(:,:,:,year) = mean(ph_000,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_010/ph_010_' num2str(year)  '.mat']);
ph_010_tav(:,:,:,year) = mean(ph_010,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_025/ph_025_' num2str(year)  '.mat']);
ph_025_tav(:,:,:,year) = mean(ph_025,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_050/ph_050_' num2str(year)  '.mat']);
ph_050_tav(:,:,:,year) = mean(ph_050,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_075/ph_075_' num2str(year)  '.mat']);
ph_075_tav(:,:,:,year) = mean(ph_075,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_100/ph_100_' num2str(year)  '.mat']);
ph_100_tav(:,:,:,year) = mean(ph_100,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_125/ph_125_' num2str(year)  '.mat']);
ph_125_tav(:,:,:,year) = mean(ph_125,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_150/ph_150_' num2str(year)  '.mat']);
ph_150_tav(:,:,:,year) = mean(ph_150,4);

end

clear('zpbl_000','zpbl_010','zpbl_025','zpbl_050','zpbl_075','zpbl_100','zpbl_125','zpbl_150')
clear('ph_000','ph_010','ph_025','ph_050','ph_075','ph_100','ph_125','ph_150')

zpbl_000_tav = squeeze(mean(zpbl_000_tav,3));
zpbl_010_tav = squeeze(mean(zpbl_010_tav,3));
zpbl_025_tav = squeeze(mean(zpbl_025_tav,3));
zpbl_050_tav = squeeze(mean(zpbl_050_tav,3));
zpbl_075_tav = squeeze(mean(zpbl_075_tav,3));
zpbl_100_tav = squeeze(mean(zpbl_100_tav,3));
zpbl_125_tav = squeeze(mean(zpbl_125_tav,3));
zpbl_150_tav = squeeze(mean(zpbl_150_tav,3));

ph_000_tav = squeeze(mean(ph_000_tav,4));
ph_010_tav = squeeze(mean(ph_010_tav,4));
ph_025_tav = squeeze(mean(ph_025_tav,4));
ph_050_tav = squeeze(mean(ph_050_tav,4));
ph_075_tav = squeeze(mean(ph_075_tav,4));
ph_100_tav = squeeze(mean(ph_100_tav,4));
ph_125_tav = squeeze(mean(ph_125_tav,4));
ph_150_tav = squeeze(mean(ph_150_tav,4));


zpbl_000_zav = squeeze(mean(cube2latlon(xc,yc,zpbl_000_tav,xi,yi),1));
zpbl_010_zav = squeeze(mean(cube2latlon(xc,yc,zpbl_010_tav,xi,yi),1));
zpbl_025_zav = squeeze(mean(cube2latlon(xc,yc,zpbl_025_tav,xi,yi),1));
zpbl_050_zav = squeeze(mean(cube2latlon(xc,yc,zpbl_050_tav,xi,yi),1));
zpbl_075_zav = squeeze(mean(cube2latlon(xc,yc,zpbl_075_tav,xi,yi),1));
zpbl_100_zav = squeeze(mean(cube2latlon(xc,yc,zpbl_100_tav,xi,yi),1));
zpbl_125_zav = squeeze(mean(cube2latlon(xc,yc,zpbl_125_tav,xi,yi),1));
zpbl_150_zav = squeeze(mean(cube2latlon(xc,yc,zpbl_150_tav,xi,yi),1));

ph_000_zav = squeeze(mean(cube2latlon(xc,yc,ph_000_tav,xi,yi),1));
ph_010_zav = squeeze(mean(cube2latlon(xc,yc,ph_010_tav,xi,yi),1));
ph_025_zav = squeeze(mean(cube2latlon(xc,yc,ph_025_tav,xi,yi),1));
ph_050_zav = squeeze(mean(cube2latlon(xc,yc,ph_050_tav,xi,yi),1));
ph_075_zav = squeeze(mean(cube2latlon(xc,yc,ph_075_tav,xi,yi),1));
ph_100_zav = squeeze(mean(cube2latlon(xc,yc,ph_100_tav,xi,yi),1));
ph_125_zav = squeeze(mean(cube2latlon(xc,yc,ph_125_tav,xi,yi),1));
ph_150_zav = squeeze(mean(cube2latlon(xc,yc,ph_150_tav,xi,yi),1));


for i=1:90

zpbl_000_hzav(i) = (zpbl_000_zav(i) + zpbl_000_zav(91-i))./2;
zpbl_010_hzav(i) = (zpbl_010_zav(i) + zpbl_010_zav(91-i))./2;
zpbl_025_hzav(i) = (zpbl_025_zav(i) + zpbl_025_zav(91-i))./2;
zpbl_050_hzav(i) = (zpbl_050_zav(i) + zpbl_050_zav(91-i))./2;
zpbl_075_hzav(i) = (zpbl_075_zav(i) + zpbl_075_zav(91-i))./2;
zpbl_100_hzav(i) = (zpbl_100_zav(i) + zpbl_100_zav(91-i))./2;
zpbl_125_hzav(i) = (zpbl_125_zav(i) + zpbl_125_zav(91-i))./2;
zpbl_150_hzav(i) = (zpbl_150_zav(i) + zpbl_150_zav(91-i))./2;

ph_000_hzav(i,:) = (ph_000_zav(i,:) + ph_000_zav(91-i,:))./2;
ph_010_hzav(i,:) = (ph_010_zav(i,:) + ph_010_zav(91-i,:))./2;
ph_025_hzav(i,:) = (ph_025_zav(i,:) + ph_025_zav(91-i,:))./2;
ph_050_hzav(i,:) = (ph_050_zav(i,:) + ph_050_zav(91-i,:))./2;
ph_075_hzav(i,:) = (ph_075_zav(i,:) + ph_075_zav(91-i,:))./2;
ph_100_hzav(i,:) = (ph_100_zav(i,:) + ph_100_zav(91-i,:))./2;
ph_125_hzav(i,:) = (ph_125_zav(i,:) + ph_125_zav(91-i,:))./2;
ph_150_hzav(i,:) = (ph_150_zav(i,:) + ph_150_zav(91-i,:))./2;

end


for i=2:89

b_lev_000(i) = min(find (zpbl_000_hzav(i) <= ph_000_hzav(i,:)./9.81) );
b_lev_010(i) = min(find (zpbl_010_hzav(i) <= ph_010_hzav(i,:)./9.81) );
b_lev_025(i) = min(find (zpbl_025_hzav(i) <= ph_025_hzav(i,:)./9.81) );
b_lev_050(i) = min(find (zpbl_050_hzav(i) <= ph_050_hzav(i,:)./9.81) );
b_lev_075(i) = min(find (zpbl_075_hzav(i) <= ph_075_hzav(i,:)./9.81) );
b_lev_100(i) = min(find (zpbl_100_hzav(i) <= ph_100_hzav(i,:)./9.81) );
b_lev_125(i) = min(find (zpbl_125_hzav(i) <= ph_125_hzav(i,:)./9.81) );
b_lev_150(i) = min(find (zpbl_150_hzav(i) <= ph_150_hzav(i,:)./9.81) );

end


b_lev_000(1) = NaN; b_lev_000(90)=NaN;
b_lev_010(1) = NaN; b_lev_010(90)=NaN;
b_lev_025(1) = NaN; b_lev_025(90)=NaN;
b_lev_050(1) = NaN; b_lev_050(90)=NaN;
b_lev_075(1) = NaN; b_lev_075(90)=NaN;
b_lev_100(1) = NaN; b_lev_100(90)=NaN;
b_lev_125(1) = NaN; b_lev_125(90)=NaN;
b_lev_150(1) = NaN; b_lev_150(90)=NaN;

save('/project/rg312/mat_files/blayer_levs_final.mat', 'b_lev_000', 'b_lev_010', 'b_lev_025', 'b_lev_050', 'b_lev_075', 'b_lev_100', 'b_lev_125', 'b_lev_150')

