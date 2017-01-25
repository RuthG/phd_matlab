

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

load(['/project/rg312/mat_files/snapshot_data_final/run_000_ns/t_000_' num2str(year)  '.mat']);
t_000_tav(:,:,:,year) = mean(t_000,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_010/t_010_' num2str(year)  '.mat']);
t_010_tav(:,:,:,year) = mean(t_010,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_025/t_025_' num2str(year)  '.mat']);
t_025_tav(:,:,:,year) = mean(t_025,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_050/t_050_' num2str(year)  '.mat']);
t_050_tav(:,:,:,year) = mean(t_050,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_075/t_075_' num2str(year)  '.mat']);
t_075_tav(:,:,:,year) = mean(t_075,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_100/t_100_' num2str(year)  '.mat']);
t_100_tav(:,:,:,year) = mean(t_100,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_125/t_125_' num2str(year)  '.mat']);
t_125_tav(:,:,:,year) = mean(t_125,4);

load(['/project/rg312/mat_files/snapshot_data_final/run_150/t_150_' num2str(year)  '.mat']);
t_150_tav(:,:,:,year) = mean(t_150,4);
end

clear('t_000','t_010','t_025','t_050','t_075','t_100','t_125','t_150')

t_000_tav = squeeze(mean(t_000_tav,4));
t_010_tav = squeeze(mean(t_010_tav,4));
t_025_tav = squeeze(mean(t_025_tav,4));
t_050_tav = squeeze(mean(t_050_tav,4));
t_075_tav = squeeze(mean(t_075_tav,4));
t_100_tav = squeeze(mean(t_100_tav,4));
t_125_tav = squeeze(mean(t_125_tav,4));
t_150_tav = squeeze(mean(t_150_tav,4));




Rd = 287.04;
for i=1:25
rho_000(:,:,i) = rC(i)./Rd./t_000_tav(:,:,i);
rho_010(:,:,i) = rC(i)./Rd./t_010_tav(:,:,i);
rho_025(:,:,i) = rC(i)./Rd./t_025_tav(:,:,i);
rho_050(:,:,i) = rC(i)./Rd./t_050_tav(:,:,i);
rho_075(:,:,i) = rC(i)./Rd./t_075_tav(:,:,i);
rho_100(:,:,i) = rC(i)./Rd./t_100_tav(:,:,i);
rho_125(:,:,i) = rC(i)./Rd./t_125_tav(:,:,i);
rho_150(:,:,i) = rC(i)./Rd./t_150_tav(:,:,i);
end


[a,b,dtdp_000] = gradient(t_000_tav,4000);
[a,b,dtdp_010] = gradient(t_010_tav,4000);
[a,b,dtdp_025] = gradient(t_025_tav,4000);
[a,b,dtdp_050] = gradient(t_050_tav,4000);
[a,b,dtdp_075] = gradient(t_075_tav,4000);
[a,b,dtdp_100] = gradient(t_100_tav,4000);
[a,b,dtdp_125] = gradient(t_125_tav,4000);
[a,b,dtdp_150] = gradient(t_150_tav,4000);

clear('a','b')

dtdz_000 = dtdp_000.*rho_000.*9.8.*1000;
dtdz_010 = dtdp_010.*rho_010.*9.8.*1000;
dtdz_025 = dtdp_025.*rho_025.*9.8.*1000;
dtdz_050 = dtdp_050.*rho_050.*9.8.*1000;
dtdz_075 = dtdp_075.*rho_075.*9.8.*1000;
dtdz_100 = dtdp_100.*rho_100.*9.8.*1000;
dtdz_125 = dtdp_125.*rho_125.*9.8.*1000;
dtdz_150 = dtdp_150.*rho_150.*9.8.*1000;

dtdz_000_ll = cube2latlon(xc,yc,dtdz_000,xi,yi);
dtdz_010_ll = cube2latlon(xc,yc,dtdz_010,xi,yi);
dtdz_025_ll = cube2latlon(xc,yc,dtdz_025,xi,yi);
dtdz_050_ll = cube2latlon(xc,yc,dtdz_050,xi,yi);
dtdz_075_ll = cube2latlon(xc,yc,dtdz_075,xi,yi);
dtdz_100_ll = cube2latlon(xc,yc,dtdz_100,xi,yi);
dtdz_125_ll = cube2latlon(xc,yc,dtdz_125,xi,yi);
dtdz_150_ll = cube2latlon(xc,yc,dtdz_150,xi,yi);

dtdz_000_zav = squeeze(mean(dtdz_000_ll,1));
dtdz_010_zav = squeeze(mean(dtdz_010_ll,1));
dtdz_025_zav = squeeze(mean(dtdz_025_ll,1));
dtdz_050_zav = squeeze(mean(dtdz_050_ll,1));
dtdz_075_zav = squeeze(mean(dtdz_075_ll,1));
dtdz_100_zav = squeeze(mean(dtdz_100_ll,1));
dtdz_125_zav = squeeze(mean(dtdz_125_ll,1));
dtdz_150_zav = squeeze(mean(dtdz_150_ll,1));


for i=2:89
trop_p_000(i) = rC(min(find(dtdz_000_zav(i,:) >= -2) )) ;
trop_p_010(i) = rC(min(find(dtdz_010_zav(i,:) >= -2) )) ;
trop_p_025(i) = rC(min(find(dtdz_025_zav(i,:) >= -2) )) ;
trop_p_050(i) = rC(min(find(dtdz_050_zav(i,:) >= -2) )) ;
trop_p_075(i) = rC(min(find(dtdz_075_zav(i,:) >= -2) )) ;
trop_p_100(i) = rC(min(find(dtdz_100_zav(i,:) >= -2) )) ;
trop_p_125(i) = rC(min(find(dtdz_125_zav(i,:) >= -2) )) ;
trop_p_150(i) = rC(min(find(dtdz_150_zav(i,:) >= -2) )) ;
end


trop_p_000(1) = NaN; trop_p_000(90)=NaN;
trop_p_010(1) = NaN; trop_p_010(90)=NaN;
trop_p_025(1) = NaN; trop_p_025(90)=NaN;
trop_p_050(1) = NaN; trop_p_050(90)=NaN;
trop_p_075(1) = NaN; trop_p_075(90)=NaN;
trop_p_100(1) = NaN; trop_p_100(90)=NaN;
trop_p_125(1) = NaN; trop_p_125(90)=NaN;
trop_p_150(1) = NaN; trop_p_150(90)=NaN;

for i=1:90

trop_p_000_hav(i) = (trop_p_000(i) + trop_p_000(91-i))./2;
trop_p_010_hav(i) = (trop_p_010(i) + trop_p_010(91-i))./2;
trop_p_025_hav(i) = (trop_p_025(i) + trop_p_025(91-i))./2;
trop_p_050_hav(i) = (trop_p_050(i) + trop_p_050(91-i))./2;
trop_p_075_hav(i) = (trop_p_075(i) + trop_p_075(91-i))./2;
trop_p_100_hav(i) = (trop_p_100(i) + trop_p_100(91-i))./2;
trop_p_125_hav(i) = (trop_p_125(i) + trop_p_125(91-i))./2;
trop_p_150_hav(i) = (trop_p_150(i) + trop_p_150(91-i))./2;

end

for i=2:89

trop_lev_000(i) = max(find(rC >= trop_p_000_hav(i)));
trop_lev_010(i) = max(find(rC >= trop_p_010_hav(i)));
trop_lev_025(i) = max(find(rC >= trop_p_025_hav(i)));
trop_lev_050(i) = max(find(rC >= trop_p_050_hav(i)));
trop_lev_075(i) = max(find(rC >= trop_p_075_hav(i)));
trop_lev_100(i) = max(find(rC >= trop_p_100_hav(i)));
trop_lev_125(i) = max(find(rC >= trop_p_125_hav(i)));
trop_lev_150(i) = max(find(rC >= trop_p_150_hav(i)));

end

trop_lev_000(1) = NaN; trop_lev_000(90)=NaN;
trop_lev_010(1) = NaN; trop_lev_010(90)=NaN;
trop_lev_025(1) = NaN; trop_lev_025(90)=NaN;
trop_lev_050(1) = NaN; trop_lev_050(90)=NaN;
trop_lev_075(1) = NaN; trop_lev_075(90)=NaN;
trop_lev_100(1) = NaN; trop_lev_100(90)=NaN;
trop_lev_125(1) = NaN; trop_lev_125(90)=NaN;
trop_lev_150(1) = NaN; trop_lev_150(90)=NaN;

save('/project/rg312/mat_files/trop_levs_final.mat', 'trop_lev_000', 'trop_lev_010', 'trop_lev_025', 'trop_lev_050', 'trop_lev_075', 'trop_lev_100', 'trop_lev_125', 'trop_lev_150' )

