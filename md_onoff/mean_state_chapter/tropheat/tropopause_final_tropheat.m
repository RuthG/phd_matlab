

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

convthetatoT=(rC/100000.0).^(2./7.);

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_000.mat','theta_tav');
theta_tav=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav(:,:) = mean(theta_tav,1);
for k=1:size(rC)
t_000_tav(:,k)=theta_zav(:,k).*convthetatoT(k,1);
end

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_010.mat','theta_tav');
theta_tav=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav(:,:) = mean(theta_tav,1);
for k=1:size(rC)
t_010_tav(:,k)=theta_zav(:,k).*convthetatoT(k,1);
end

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_025.mat','theta_tav');
theta_tav=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav(:,:) = mean(theta_tav,1);
for k=1:size(rC)
t_025_tav(:,k)=theta_zav(:,k).*convthetatoT(k,1);
end

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_050.mat','theta_tav');
theta_tav=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav(:,:) = mean(theta_tav,1);
for k=1:size(rC)
t_050_tav(:,k)=theta_zav(:,k).*convthetatoT(k,1);
end

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_050_tropheat.mat','theta_tav');
theta_tav=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav(:,:) = mean(theta_tav,1);
for k=1:size(rC)
t_th_tav(:,k)=theta_zav(:,k).*convthetatoT(k,1);
end

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_075.mat','theta_tav');
theta_tav=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav(:,:) = mean(theta_tav,1);
for k=1:size(rC)
t_075_tav(:,k)=theta_zav(:,k).*convthetatoT(k,1);
end

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_100.mat','theta_tav');
theta_tav=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav(:,:) = mean(theta_tav,1);
for k=1:size(rC)
t_100_tav(:,k)=theta_zav(:,k).*convthetatoT(k,1);
end

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_125.mat','theta_tav');
theta_tav=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav(:,:) = mean(theta_tav,1);
for k=1:size(rC)
t_125_tav(:,k)=theta_zav(:,k).*convthetatoT(k,1);
end

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_150.mat','theta_tav');
theta_tav=cube2latlon(xc,yc,theta_tav,xi,yi);
theta_zav(:,:) = mean(theta_tav,1);
for k=1:size(rC)
t_150_tav(:,k)=theta_zav(:,k).*convthetatoT(k,1);
end




Rd = 287.04;
for i=1:25
rho_000(:,i) = rC(i)./Rd./t_000_tav(:,i);
rho_010(:,i) = rC(i)./Rd./t_010_tav(:,i);
rho_025(:,i) = rC(i)./Rd./t_025_tav(:,i);
rho_050(:,i) = rC(i)./Rd./t_050_tav(:,i);
rho_th(:,i) = rC(i)./Rd./t_th_tav(:,i);
rho_075(:,i) = rC(i)./Rd./t_075_tav(:,i);
rho_100(:,i) = rC(i)./Rd./t_100_tav(:,i);
rho_125(:,i) = rC(i)./Rd./t_125_tav(:,i);
rho_150(:,i) = rC(i)./Rd./t_150_tav(:,i);
end


dtdp_000 = gradient(t_000_tav,4000);
dtdp_010 = gradient(t_010_tav,4000);
dtdp_025 = gradient(t_025_tav,4000);
dtdp_050 = gradient(t_050_tav,4000);
dtdp_th = gradient(t_th_tav,4000);
dtdp_075 = gradient(t_075_tav,4000);
dtdp_100 = gradient(t_100_tav,4000);
dtdp_125 = gradient(t_125_tav,4000);
dtdp_150 = gradient(t_150_tav,4000);

clear('a','b')

dtdz_000 = dtdp_000.*rho_000.*9.8.*1000;
dtdz_010 = dtdp_010.*rho_010.*9.8.*1000;
dtdz_025 = dtdp_025.*rho_025.*9.8.*1000;
dtdz_050 = dtdp_050.*rho_050.*9.8.*1000;
dtdz_th = dtdp_th.*rho_th.*9.8.*1000;
dtdz_075 = dtdp_075.*rho_075.*9.8.*1000;
dtdz_100 = dtdp_100.*rho_100.*9.8.*1000;
dtdz_125 = dtdp_125.*rho_125.*9.8.*1000;
dtdz_150 = dtdp_150.*rho_150.*9.8.*1000;

for i=2:89
trop_p_000(i) = rC(min(find(dtdz_000(i,:) >= -2) )) ;
trop_p_010(i) = rC(min(find(dtdz_010(i,:) >= -2) )) ;
trop_p_025(i) = rC(min(find(dtdz_025(i,:) >= -2) )) ;
trop_p_050(i) = rC(min(find(dtdz_050(i,:) >= -2) )) ;
trop_p_th(i) = rC(min(find(dtdz_th(i,:) >= -2) )) ;
trop_p_075(i) = rC(min(find(dtdz_075(i,:) >= -2) )) ;
trop_p_100(i) = rC(min(find(dtdz_100(i,:) >= -2) )) ;
trop_p_125(i) = rC(min(find(dtdz_125(i,:) >= -2) )) ;
trop_p_150(i) = rC(min(find(dtdz_150(i,:) >= -2) )) ;
end


trop_p_000(1) = NaN; trop_p_000(90)=NaN;
trop_p_010(1) = NaN; trop_p_010(90)=NaN;
trop_p_025(1) = NaN; trop_p_025(90)=NaN;
trop_p_050(1) = NaN; trop_p_050(90)=NaN;
trop_p_th(1) = NaN; trop_p_th(90)=NaN;
trop_p_075(1) = NaN; trop_p_075(90)=NaN;
trop_p_100(1) = NaN; trop_p_100(90)=NaN;
trop_p_125(1) = NaN; trop_p_125(90)=NaN;
trop_p_150(1) = NaN; trop_p_150(90)=NaN;

for i=1:90

trop_p_000_hav(i) = (trop_p_000(i) + trop_p_000(91-i))./2;
trop_p_010_hav(i) = (trop_p_010(i) + trop_p_010(91-i))./2;
trop_p_025_hav(i) = (trop_p_025(i) + trop_p_025(91-i))./2;
trop_p_050_hav(i) = (trop_p_050(i) + trop_p_050(91-i))./2;
trop_p_th_hav(i) = (trop_p_th(i) + trop_p_th(91-i))./2;
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
trop_lev_th(i) = max(find(rC >= trop_p_th_hav(i)));
trop_lev_075(i) = max(find(rC >= trop_p_075_hav(i)));
trop_lev_100(i) = max(find(rC >= trop_p_100_hav(i)));
trop_lev_125(i) = max(find(rC >= trop_p_125_hav(i)));
trop_lev_150(i) = max(find(rC >= trop_p_150_hav(i)));

end

trop_lev_000(1) = NaN; trop_lev_000(90)=NaN;
trop_lev_010(1) = NaN; trop_lev_010(90)=NaN;
trop_lev_025(1) = NaN; trop_lev_025(90)=NaN;
trop_lev_050(1) = NaN; trop_lev_050(90)=NaN;
trop_lev_th(1) = NaN; trop_lev_th(90)=NaN;
trop_lev_075(1) = NaN; trop_lev_075(90)=NaN;
trop_lev_100(1) = NaN; trop_lev_100(90)=NaN;
trop_lev_125(1) = NaN; trop_lev_125(90)=NaN;
trop_lev_150(1) = NaN; trop_lev_150(90)=NaN;

save('/project/rg312/mat_files/trop_levs_final_th.mat', 'trop_lev_000', 'trop_lev_010', 'trop_lev_025', 'trop_lev_050', 'trop_lev_th', 'trop_lev_075', 'trop_lev_100', 'trop_lev_125', 'trop_lev_150' )

