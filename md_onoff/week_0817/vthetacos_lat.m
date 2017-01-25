

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
xi=-179:2:179;
yi=-89:2:89;


load('/project/rg312/mat_files/snapshot_data_final/vNt_ed_mean_data.mat')

convthetatoT=(rC/100000.0).^(2./7.);
convTtotheta=1./convthetatoT;

for k=1:size(rC)
vNth_ed_000(:,k)= vNt_ed_000(:,k).*convTtotheta(k);
vNth_ed_010(:,k)= vNt_ed_010(:,k).*convTtotheta(k);
vNth_ed_025(:,k)= vNt_ed_025(:,k).*convTtotheta(k);
vNth_ed_050(:,k)= vNt_ed_050(:,k).*convTtotheta(k);
vNth_ed_th(:,k) = vNt_ed_th(:,k) .*convTtotheta(k);
vNth_ed_075(:,k)= vNt_ed_075(:,k).*convTtotheta(k);
vNth_ed_100(:,k)= vNt_ed_100(:,k).*convTtotheta(k);
vNth_ed_125(:,k)= vNt_ed_125(:,k).*convTtotheta(k);
vNth_ed_150(:,k)= vNt_ed_150(:,k).*convTtotheta(k);
end

for i=1:90
vNthcos_ed_000(i,:) = vNth_ed_000(i,:).*cos(yi(i).*pi./180);
vNthcos_ed_010(i,:) = vNth_ed_010(i,:).*cos(yi(i).*pi./180);
vNthcos_ed_025(i,:) = vNth_ed_025(i,:).*cos(yi(i).*pi./180);
vNthcos_ed_050(i,:) = vNth_ed_050(i,:).*cos(yi(i).*pi./180);
vNthcos_ed_th(i,:) = vNth_ed_th(i,:).*cos(yi(i).*pi./180);
vNthcos_ed_075(i,:) = vNth_ed_075(i,:).*cos(yi(i).*pi./180);
vNthcos_ed_100(i,:) = vNth_ed_100(i,:).*cos(yi(i).*pi./180);
vNthcos_ed_125(i,:) = vNth_ed_125(i,:).*cos(yi(i).*pi./180);
vNthcos_ed_150(i,:) = vNth_ed_150(i,:).*cos(yi(i).*pi./180);
end

load('/net/spat-nas/project/rg312/mat_files/trop_levs_final_th.mat');

for i=1:44
vNthcos_mean_000(i) = (-mean(vNthcos_ed_000(46-i, 1:min(trop_lev_000)),2) + mean(vNthcos_ed_000(45+i, 1:min(trop_lev_000)),2))./2;
vNthcos_mean_010(i) = (-mean(vNthcos_ed_010(46-i, 1:min(trop_lev_010)),2) + mean(vNthcos_ed_010(45+i, 1:min(trop_lev_010)),2))./2;
vNthcos_mean_025(i) = (-mean(vNthcos_ed_025(46-i, 1:min(trop_lev_025)),2) + mean(vNthcos_ed_025(45+i, 1:min(trop_lev_025)),2))./2;
vNthcos_mean_050(i) = (-mean(vNthcos_ed_050(46-i, 1:min(trop_lev_050)),2) + mean(vNthcos_ed_050(45+i, 1:min(trop_lev_050)),2))./2;
vNthcos_mean_th(i)  = (-mean(vNthcos_ed_th(46-i, 1:min(trop_lev_th)),2)   + mean(vNthcos_ed_th(45+i, 1:min(trop_lev_th)),2))./2;
vNthcos_mean_075(i) = (-mean(vNthcos_ed_075(46-i, 1:min(trop_lev_075)),2) + mean(vNthcos_ed_075(45+i, 1:min(trop_lev_075)),2))./2;
vNthcos_mean_100(i) = (-mean(vNthcos_ed_100(46-i, 1:min(trop_lev_100)),2) + mean(vNthcos_ed_100(45+i, 1:min(trop_lev_100)),2))./2;
vNthcos_mean_125(i) = (-mean(vNthcos_ed_125(46-i, 1:min(trop_lev_125)),2) + mean(vNthcos_ed_125(45+i, 1:min(trop_lev_125)),2))./2;
vNthcos_mean_150(i) = (-mean(vNthcos_ed_150(46-i, 1:min(trop_lev_150)),2) + mean(vNthcos_ed_150(45+i, 1:min(trop_lev_150)),2))./2;
end

x000 = find( vNthcos_mean_000 == max(max(vNthcos_mean_000)) );
x010 = find( vNthcos_mean_010 == max(max(vNthcos_mean_010)) );
x025 = find( vNthcos_mean_025 == max(max(vNthcos_mean_025)) );
x050 = find( vNthcos_mean_050 == max(max(vNthcos_mean_050)) );
xth = find( vNthcos_mean_th == max(max(vNthcos_mean_th)) );
x075 = find( vNthcos_mean_075 == max(max(vNthcos_mean_075)) );
x100 = find( vNthcos_mean_100 == max(max(vNthcos_mean_100)) );
x125 = find( vNthcos_mean_125 == max(max(vNthcos_mean_125)) );
x150 = find( vNthcos_mean_150 == max(max(vNthcos_mean_150)) );

save('/project/rg312/mat_files/vthcos_lats_final.mat', 'x000', 'x010', 'x025', 'x050', 'xth', 'x075', 'x100', 'x125', 'x150')

load('/project/rg312/mat_files/vt_lats_final.mat')

return

