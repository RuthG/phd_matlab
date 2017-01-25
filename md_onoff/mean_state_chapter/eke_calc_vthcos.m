% choose directory, load grid
rDir='/project/rg312/final_runs/run_000_final_noshallow/';
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
yi = -89:2:89;
xi = -179:2:179;

load('/net/spat-nas/project/rg312/mat_files/vthcos_lats_final.mat');
load('/net/spat-nas/project/rg312/mat_files/trop_levs_final_th.mat');
x000n = x000+45; x000s = 46-x000;
x010n = x010+45; x010s = 46-x010;
x025n = x025+45; x025s = 46-x025;
x050n = x050+45; x050s = 46-x050;
xthn = xth+45; xths = 46-xth;
x075n = x075+45; x075s = 46-x075;
x100n = x100+45; x100s = 46-x100;
x125n = x125+45; x125s = 46-x125;
x150n = x150+45; x150s = 46-x150;

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_000.mat','uE_tav','vN_tav')
load('/project/rg312/mat_files/chapter2_variables/epvars_tav_000.mat','usq_tav','vsq_tav')
tke_tav = (usq_tav + vsq_tav)./2;
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
tkell=cube2latlon(xc,yc,tke_tav,xi,yi);
uE_zav(:,:) = mean(uEll,1);
vN_zav(:,:) = mean(vNll,1);
tke_zav(:,:) = mean(tkell,1);
zke_zav = (uE_zav.^2 + vN_zav.^2)./2;
eke_000 =  tke_zav - zke_zav;

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_010.mat','uE_tav','vN_tav')
load('/project/rg312/mat_files/chapter2_variables/epvars_tav_010.mat','usq_tav','vsq_tav')
tke_tav = (usq_tav + vsq_tav)./2;
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
tkell=cube2latlon(xc,yc,tke_tav,xi,yi);
uE_zav(:,:) = mean(uEll,1);
vN_zav(:,:) = mean(vNll,1);
tke_zav(:,:) = mean(tkell,1);
zke_zav = (uE_zav.^2 + vN_zav.^2)./2;
eke_010 =  tke_zav - zke_zav;

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_025.mat','uE_tav','vN_tav')
load('/project/rg312/mat_files/chapter2_variables/epvars_tav_025.mat','usq_tav','vsq_tav')
tke_tav = (usq_tav + vsq_tav)./2;
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
tkell=cube2latlon(xc,yc,tke_tav,xi,yi);
uE_zav(:,:) = mean(uEll,1);
vN_zav(:,:) = mean(vNll,1);
tke_zav(:,:) = mean(tkell,1);
zke_zav = (uE_zav.^2 + vN_zav.^2)./2;
eke_025 =  tke_zav - zke_zav;

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_050.mat','uE_tav','vN_tav')
load('/project/rg312/mat_files/chapter2_variables/epvars_tav_050.mat','usq_tav','vsq_tav')
tke_tav = (usq_tav + vsq_tav)./2;
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
tkell=cube2latlon(xc,yc,tke_tav,xi,yi);
uE_zav(:,:) = mean(uEll,1);
vN_zav(:,:) = mean(vNll,1);
tke_zav(:,:) = mean(tkell,1);
zke_zav = (uE_zav.^2 + vN_zav.^2)./2;
eke_050 =  tke_zav - zke_zav;


load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_050_tropheat.mat','uE_tav','vN_tav')
load('/project/rg312/mat_files/chapter2_variables/epvars_tav_050_tropheat.mat','usq_tav','vsq_tav')
tke_tav = (usq_tav + vsq_tav)./2;
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
tkell=cube2latlon(xc,yc,tke_tav,xi,yi);
uE_zav(:,:) = mean(uEll,1);
vN_zav(:,:) = mean(vNll,1);
tke_zav(:,:) = mean(tkell,1);
zke_zav = (uE_zav.^2 + vN_zav.^2)./2;
eke_th =  tke_zav - zke_zav;

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_075.mat','uE_tav','vN_tav')
load('/project/rg312/mat_files/chapter2_variables/epvars_tav_075.mat','usq_tav','vsq_tav')
tke_tav = (usq_tav + vsq_tav)./2;
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
tkell=cube2latlon(xc,yc,tke_tav,xi,yi);
uE_zav(:,:) = mean(uEll,1);
vN_zav(:,:) = mean(vNll,1);
tke_zav(:,:) = mean(tkell,1);
zke_zav = (uE_zav.^2 + vN_zav.^2)./2;
eke_075 =  tke_zav - zke_zav;

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_100.mat','uE_tav','vN_tav')
load('/project/rg312/mat_files/chapter2_variables/epvars_tav_100.mat','usq_tav','vsq_tav')
tke_tav = (usq_tav + vsq_tav)./2;
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
tkell=cube2latlon(xc,yc,tke_tav,xi,yi);
uE_zav(:,:) = mean(uEll,1);
vN_zav(:,:) = mean(vNll,1);
tke_zav(:,:) = mean(tkell,1);
zke_zav = (uE_zav.^2 + vN_zav.^2)./2;
eke_100 =  tke_zav - zke_zav;

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_125.mat','uE_tav','vN_tav')
load('/project/rg312/mat_files/chapter2_variables/epvars_tav_125.mat','usq_tav','vsq_tav')
tke_tav = (usq_tav + vsq_tav)./2;
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
tkell=cube2latlon(xc,yc,tke_tav,xi,yi);
uE_zav(:,:) = mean(uEll,1);
vN_zav(:,:) = mean(vNll,1);
tke_zav(:,:) = mean(tkell,1);
zke_zav = (uE_zav.^2 + vN_zav.^2)./2;
eke_125 =  tke_zav - zke_zav;

load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_150.mat','uE_tav','vN_tav')
load('/project/rg312/mat_files/chapter2_variables/epvars_tav_150.mat','usq_tav','vsq_tav')
tke_tav = (usq_tav + vsq_tav)./2;
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
tkell=cube2latlon(xc,yc,tke_tav,xi,yi);
uE_zav(:,:) = mean(uEll,1);
vN_zav(:,:) = mean(vNll,1);
tke_zav(:,:) = mean(tkell,1);
zke_zav = (uE_zav.^2 + vN_zav.^2)./2;
eke_150 =  tke_zav - zke_zav;

eke_pint_000 = sum(eke_000(:,1:trop_lev_000(x000n)),2) .* 4000./9.81;
for i=1:90
eke_weight_000(i) = eke_pint_000(i).*cos(yi(i).*pi./180);
end
eke_north_000 = sum(eke_weight_000(x000n-7:x000n+7))./sum(cos(yi(x000n-7:x000n+7).*pi./180));
eke_south_000 = sum(eke_weight_000(x000s-7:x000s+7))./sum(cos(yi(x000s-7:x000s+7).*pi./180));
eke_out_000 = (eke_north_000 + eke_south_000)./2;


eke_pint_010 = sum(eke_010(:,1:trop_lev_010(x010n)),2) .* 4000./9.81;
for i=1:90
eke_weight_010(i) = eke_pint_010(i).*cos(yi(i).*pi./180);
end
eke_north_010 = sum(eke_weight_010(x010n-7:x010n+7))./sum(cos(yi(x010n-7:x010n+7).*pi./180));
eke_south_010 = sum(eke_weight_010(x010s-7:x010s+7))./sum(cos(yi(x010s-7:x010s+7).*pi./180));
eke_out_010 = (eke_north_010 + eke_south_010)./2;



eke_pint_025 = sum(eke_025(:,1:trop_lev_025(x025n)),2) .* 4000./9.81;
for i=1:90
eke_weight_025(i) = eke_pint_025(i).*cos(yi(i).*pi./180);
end
eke_north_025 = sum(eke_weight_025(x025n-7:x025n+7))./sum(cos(yi(x025n-7:x025n+7).*pi./180));
eke_south_025 = sum(eke_weight_025(x025s-7:x025s+7))./sum(cos(yi(x025s-7:x025s+7).*pi./180));
eke_out_025 = (eke_north_025 + eke_south_025)./2;



eke_pint_050 = sum(eke_050(:,1:trop_lev_050(x050n)),2) .* 4000./9.81;
for i=1:90
eke_weight_050(i) = eke_pint_050(i).*cos(yi(i).*pi./180);
end
eke_north_050 = sum(eke_weight_050(x050n-7:x050n+7))./sum(cos(yi(x050n-7:x050n+7).*pi./180));
eke_south_050 = sum(eke_weight_050(x050s-7:x050s+7))./sum(cos(yi(x050s-7:x050s+7).*pi./180));
eke_out_050 = (eke_north_050 + eke_south_050)./2;




eke_pint_th = sum(eke_th(:,1:trop_lev_th(xthn)),2) .* 4000./9.81;
for i=1:90
eke_weight_th(i) = eke_pint_th(i).*cos(yi(i).*pi./180);
end
eke_north_th = sum(eke_weight_th(xthn-7:xthn+7))./sum(cos(yi(xthn-7:xthn+7).*pi./180));
eke_south_th = sum(eke_weight_th(xths-7:xths+7))./sum(cos(yi(xths-7:xths+7).*pi./180));
eke_out_th = (eke_north_th + eke_south_th)./2;



eke_pint_075 = sum(eke_075(:,1:trop_lev_075(x075n)),2) .* 4000./9.81;
for i=1:90
eke_weight_075(i) = eke_pint_075(i).*cos(yi(i).*pi./180);
end
eke_north_075 = sum(eke_weight_075(x075n-7:x075n+7))./sum(cos(yi(x075n-7:x075n+7).*pi./180));
eke_south_075 = sum(eke_weight_075(x075s-7:x075s+7))./sum(cos(yi(x075s-7:x075s+7).*pi./180));
eke_out_075 = (eke_north_075 + eke_south_075)./2;



eke_pint_100 = sum(eke_100(:,1:trop_lev_100(x100n)),2) .* 4000./9.81;
for i=1:90
eke_weight_100(i) = eke_pint_100(i).*cos(yi(i).*pi./180);
end
eke_north_100 = sum(eke_weight_100(x100n-7:x100n+7))./sum(cos(yi(x100n-7:x100n+7).*pi./180));
eke_south_100 = sum(eke_weight_100(x100s-7:x100s+7))./sum(cos(yi(x100s-7:x100s+7).*pi./180));
eke_out_100 = (eke_north_100 + eke_south_100)./2;



eke_pint_125 = sum(eke_125(:,1:trop_lev_125(x125n)),2) .* 4000./9.81;
for i=1:90
eke_weight_125(i) = eke_pint_125(i).*cos(yi(i).*pi./180);
end
eke_north_125 = sum(eke_weight_125(x125n-7:x125n+7))./sum(cos(yi(x125n-7:x125n+7).*pi./180));
eke_south_125 = sum(eke_weight_125(x125s-7:x125s+7))./sum(cos(yi(x125s-7:x125s+7).*pi./180));
eke_out_125 = (eke_north_125 + eke_south_125)./2;



eke_pint_150 = sum(eke_150(:,1:trop_lev_150(x150n)),2) .* 4000./9.81;
for i=1:90
eke_weight_150(i) = eke_pint_150(i).*cos(yi(i).*pi./180);
end
eke_north_150 = sum(eke_weight_150(x150n-7:x150n+7))./sum(cos(yi(x150n-7:x150n+7).*pi./180));
eke_south_150 = sum(eke_weight_150(x150s-7:x150s+7))./sum(cos(yi(x150s-7:x150s+7).*pi./180));
eke_out_150 = (eke_north_150 + eke_south_150)./2;

save('/project/rg312/mat_files/chapter2_variables/eke_baroclinic_zone_vthcos.mat', 'eke_out_000', 'eke_out_010', 'eke_out_025', 'eke_out_050', 'eke_out_th', 'eke_out_075', 'eke_out_100', 'eke_out_125', 'eke_out_150')
