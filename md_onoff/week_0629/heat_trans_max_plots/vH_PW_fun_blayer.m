%take pressure, time and zonal average v't'  for each run
%also calculate average associated with cold sector only

function [vNH_ed_out ,vNH_ed_warm_out ,vNH_ed_cold_out ,vND_ed_out ,vND_ed_warm_out ,vND_ed_cold_out] = vH_PW_fun_blayer(run)

% choose directory, load grid
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
ny=90;
xi=-179:2:179;yi=-89:2:90;
L = 2.500e6;
cp = 287.04./(2./7.);
a=6371.0e3;
g=9.8;

%load up latitudes of peak v'T'

%load heat rates
t_var = ['t_' run];
q_var = ['q_' run];
vN_var = ['vN_' run];
x_var_n = ['x' run 'n'];
x_var_s = ['x' run 's'];
blev_var = ['b_lev_' run];

xvals = load('/project/rg312/mat_files/PW_lats.mat',x_var_n,x_var_s);
xn = xvals.(x_var_n);
xs = xvals.(x_var_s);

blev = load('/project/rg312/mat_files/blayer_levs_final.mat',blev_var);
blev = blev.(blev_var);

load(['/project/rg312/mat_files/snapshot_data_final/run_' run '/vN_' run '_timemean.mat']);
vN_ll_tav_lats(:,1,:,:) = repmat(vN_ll_tav(:,xn,:),[1 1 1 360]);
vN_ll_tav_lats(:,2,:,:) = repmat(vN_ll_tav(:,xs,:),[1 1 1 360]);
clear('vN_ll_tav')

load(['/project/rg312/mat_files/snapshot_data_final/run_' run '/t_' run '_timemean.mat']);
t_ll_tav_lats(:,1,:,:) = repmat(t_ll_tav(:,xn,:),[1 1 1 360]);
t_ll_tav_lats(:,2,:,:) = repmat(t_ll_tav(:,xs,:),[1 1 1 360]);
clear('t_ll_tav')

load(['/project/rg312/mat_files/snapshot_data_final/run_' run '/q_' run '_timemean.mat']);
q_ll_tav_lats(:,1,:,:) = repmat(q_ll_tav(:,xn,:),[1 1 1 360]);
q_ll_tav_lats(:,2,:,:) = repmat(q_ll_tav(:,xs,:),[1 1 1 360]);
clear('q_ll_tav')

%for year = 1
year =1;

vN_cs = load(['/project/rg312/mat_files/snapshot_data_final/run_' run '/vN_' run '_' num2str(year) '.mat'],vN_var);
vN_cs = vN_cs.(vN_var);
vN_ll = squeeze(cube2latlon(xc,yc,vN_cs,xi,yi));
vN_ed(:,1,:,:) = vN_ll(:,xn,:,:) - vN_ll_tav_lats(:,1,:,:);
vN_ed(:,2,:,:) = -(vN_ll(:,xs,:,:) - vN_ll_tav_lats(:,2,:,:));
clear('vN_ll')

t_cs = load(['/project/rg312/mat_files/snapshot_data_final/run_' run '/t_' run '_' num2str(year) '.mat'],t_var);
t_cs = t_cs.(t_var);
t_ll = squeeze(cube2latlon(xc,yc,t_cs,xi,yi));
t_ed(:,1,:,:) = t_ll(:,xn,:,:) - t_ll_tav_lats(:,1,:,:);
t_ed(:,2,:,:) = t_ll(:,xs,:,:) - t_ll_tav_lats(:,2,:,:);
clear('t_ll')

q_cs = load(['/project/rg312/mat_files/snapshot_data_final/run_' run '/q_' run '_' num2str(year) '.mat'],q_var);
q_cs = q_cs.(q_var);
q_ll = squeeze(cube2latlon(xc,yc,q_cs,xi,yi));
q_ed(:,1,:,:) = q_ll(:,xn,:,:) - q_ll_tav_lats(:,1,:,:);
q_ed(:,2,:,:) = q_ll(:,xs,:,:) - q_ll_tav_lats(:,2,:,:);
clear('q_ll')

vNH_ed = cp.*vN_ed.*t_ed + L.*vN_ed.*q_ed;
vND_ed = cp.*vN_ed.*t_ed;

t_mask_pos = +(t_ed > 0);
t_mask_neg = +(t_ed < 0);

vNH_ed_warm = vNH_ed.*t_mask_pos;
vNH_ed_cold = vNH_ed.*t_mask_neg;
vND_ed_warm = vND_ed.*t_mask_pos;
vND_ed_cold = vND_ed.*t_mask_neg;


vNH_ed_pzint(:,:,year) = 2.*pi.*a.*cos(yi(xn).*pi./180).*squeeze(mean(mean(vNH_ed(:,:,1:blev(xn),:),1),3))./g;
vNH_ed_warm_pzint(:,:,year) = 2.*pi.*a.*cos(yi(xn).*pi./180).*squeeze(mean(mean(vNH_ed_warm(:,:,1:blev(xn),:),1),3))./g;
vNH_ed_cold_pzint(:,:,year) = 2.*pi.*a.*cos(yi(xn).*pi./180).*squeeze(mean(mean(vNH_ed_cold(:,:,1:blev(xn),:),1),3))./g;

vND_ed_pzint(:,:,year) = 2.*pi.*a.*cos(yi(xn).*pi./180).*squeeze(mean(mean(vND_ed(:,:,1:blev(xn),:),1),3))./g;
vND_ed_warm_pzint(:,:,year) = 2.*pi.*a.*cos(yi(xn).*pi./180).*squeeze(mean(mean(vND_ed_warm(:,:,1:blev(xn),:),1),3))./g;
vND_ed_cold_pzint(:,:,year) = 2.*pi.*a.*cos(yi(xn).*pi./180).*squeeze(mean(mean(vND_ed_cold(:,:,1:blev(xn),:),1),3))./g;
%end


vNH_ed_out(1) =  mean(mean(mean(vNH_ed_pzint,1),2),3);
vNH_ed_warm_out(1) = mean(mean(mean(vNH_ed_warm_pzint,1),2),3);
vNH_ed_cold_out(1) = mean(mean(mean(vNH_ed_cold_pzint,1),2),3);

vNH_ed_var =  mean(mean(mean( (vNH_ed_pzint - vNH_ed_out).^2 ,1),2),3);
vNH_ed_warm_var =  mean(mean(mean( (vNH_ed_warm_pzint - vNH_ed_warm_out).^2 ,1),2),3);
vNH_ed_cold_var =  mean(mean(mean( (vNH_ed_cold_pzint - vNH_ed_cold_out).^2 ,1),2),3);

vNH_ed_out(2) = sqrt(vNH_ed_var)./sqrt(360.*2.*year);
vNH_ed_warm_out(2) = sqrt(vNH_ed_warm_var)./sqrt(360.*2.*year);
vNH_ed_cold_out(2) = sqrt(vNH_ed_cold_var)./sqrt(360.*2.*year);


vND_ed_out(1) =  mean(mean(mean(vND_ed_pzint,1),2),3);
vND_ed_warm_out(1) = mean(mean(mean(vND_ed_warm_pzint,1),2),3);
vND_ed_cold_out(1) = mean(mean(mean(vND_ed_cold_pzint,1),2),3);

vND_ed_var =  mean(mean(mean( (vND_ed_pzint - vND_ed_out).^2 ,1),2),3);
vND_ed_warm_var =  mean(mean(mean( (vND_ed_warm_pzint - vND_ed_warm_out).^2 ,1),2),3);
vND_ed_cold_var =  mean(mean(mean( (vND_ed_cold_pzint - vND_ed_cold_out).^2 ,1),2),3);

vND_ed_out(2) = sqrt(vND_ed_var)./sqrt(360.*2.*year);
vND_ed_warm_out(2) = sqrt(vND_ed_warm_var)./sqrt(360.*2.*year);
vND_ed_cold_out(2) = sqrt(vND_ed_cold_var)./sqrt(360.*2.*year);

