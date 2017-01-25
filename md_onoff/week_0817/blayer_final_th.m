

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
load(['/project/rg312/mat_files/snapshot_data_final/run_th/zpbl_th_' num2str(year)  '.mat']);
zpbl_th_tav(:,:,year) = mean(zpbl_th,3);

load(['/project/rg312/mat_files/snapshot_data_final/run_th/ph_th_' num2str(year)  '.mat']);
ph_th_tav(:,:,:,year) = mean(ph_th,4);
end

clear('zpbl_th')
clear('ph_th')

zpbl_th_tav = squeeze(mean(zpbl_th_tav,3));
ph_th_tav = squeeze(mean(ph_th_tav,4));

zpbl_th_zav = squeeze(mean(cube2latlon(xc,yc,zpbl_th_tav,xi,yi),1));
ph_th_zav = squeeze(mean(cube2latlon(xc,yc,ph_th_tav,xi,yi),1));

for i=1:90
zpbl_th_hzav(i) = (zpbl_th_zav(i) + zpbl_th_zav(91-i))./2;
ph_th_hzav(i,:) = (ph_th_zav(i,:) + ph_th_zav(91-i,:))./2;
end

for i=2:89
b_lev_th(i) = min(find (zpbl_th_hzav(i) <= ph_th_hzav(i,:)./9.81) );
end

b_lev_th(1) = NaN; b_lev_th(90)=NaN;


save('/project/rg312/mat_files/blayer_levs_final_th.mat', 'b_lev_th')

