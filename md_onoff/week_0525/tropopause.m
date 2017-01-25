

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

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat');

t_000_tav = mean(t_000,4);
t_010_tav = mean(t_010,4);
t_025_tav = mean(t_025,4);
t_050_tav = mean(t_050,4);
t_075_tav = mean(t_075,4);
t_100_tav = mean(t_100,4);

clear('t_000','t_010','t_025','t_050','t_075','t_100')

Rd = 287.04;
for i=1:25
rho_000(:,:,i) = rC(i)./Rd./t_000_tav(:,:,i);
rho_010(:,:,i) = rC(i)./Rd./t_010_tav(:,:,i);
rho_025(:,:,i) = rC(i)./Rd./t_025_tav(:,:,i);
rho_050(:,:,i) = rC(i)./Rd./t_050_tav(:,:,i);
rho_075(:,:,i) = rC(i)./Rd./t_075_tav(:,:,i);
rho_100(:,:,i) = rC(i)./Rd./t_100_tav(:,:,i);
end


[a,b,dtdp_000] = gradient(t_000_tav,4000);
[a,b,dtdp_010] = gradient(t_010_tav,4000);
[a,b,dtdp_025] = gradient(t_025_tav,4000);
[a,b,dtdp_050] = gradient(t_050_tav,4000);
[a,b,dtdp_075] = gradient(t_075_tav,4000);
[a,b,dtdp_100] = gradient(t_100_tav,4000);

clear('a','b')

dtdz_000 = dtdp_000.*rho_000.*9.8.*1000;
dtdz_010 = dtdp_010.*rho_010.*9.8.*1000;
dtdz_025 = dtdp_025.*rho_025.*9.8.*1000;
dtdz_050 = dtdp_050.*rho_050.*9.8.*1000;
dtdz_075 = dtdp_075.*rho_075.*9.8.*1000;
dtdz_100 = dtdp_100.*rho_100.*9.8.*1000;

dtdz_000_ll = cube2latlon(xc,yc,dtdz_000,xi,yi);
dtdz_010_ll = cube2latlon(xc,yc,dtdz_010,xi,yi);
dtdz_025_ll = cube2latlon(xc,yc,dtdz_025,xi,yi);
dtdz_050_ll = cube2latlon(xc,yc,dtdz_050,xi,yi);
dtdz_075_ll = cube2latlon(xc,yc,dtdz_075,xi,yi);
dtdz_100_ll = cube2latlon(xc,yc,dtdz_100,xi,yi);

dtdz_000_zav = squeeze(mean(dtdz_000_ll,1));
dtdz_010_zav = squeeze(mean(dtdz_010_ll,1));
dtdz_025_zav = squeeze(mean(dtdz_025_ll,1));
dtdz_050_zav = squeeze(mean(dtdz_050_ll,1));
dtdz_075_zav = squeeze(mean(dtdz_075_ll,1));
dtdz_100_zav = squeeze(mean(dtdz_100_ll,1));


for i=2:89
trop_p_000(i) = rC(min(find(dtdz_000_zav(i,:) >= -2) )) ;
trop_p_010(i) = rC(min(find(dtdz_010_zav(i,:) >= -2) )) ;
trop_p_025(i) = rC(min(find(dtdz_025_zav(i,:) >= -2) )) ;
trop_p_050(i) = rC(min(find(dtdz_050_zav(i,:) >= -2) )) ;
trop_p_075(i) = rC(min(find(dtdz_075_zav(i,:) >= -2) )) ;
trop_p_100(i) = rC(min(find(dtdz_100_zav(i,:) >= -2) )) ;
end


save('/project/rg312/mat_files/tropopause_offline.mat')


