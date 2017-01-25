%take pressure, time and zonal average v't'  for each run
%also calculate average associated with cold sector only

function [vNt_ed_out ,vNt_ed_warm_out ,vNt_ed_cold_out ,vNt_ed_serr ,vNt_ed_warm_serr ,vNt_ed_cold_serr] = vt_paper_plot_fun_trop_final(run)

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

%load up latitudes of peak v'T'

%load heat rates
t_var = ['t_' run];
vN_var = ['vN_' run];
x_var_n = ['x' run 'n'];
x_var_s = ['x' run 's'];
blev_var = ['b_lev_' run];
tlev_var = ['trop_lev_' run];

dir = run;
if run == '000'
dir = '000_ns';
end

xvals = load('/project/rg312/mat_files/vt_lats_final.mat',x_var_n,x_var_s);
xn = xvals.(x_var_n);
xs = xvals.(x_var_s);


tlev = load('/project/rg312/mat_files/trop_levs_final.mat',tlev_var);
tlev = tlev.(tlev_var);

load(['/project/rg312/mat_files/snapshot_data_final/run_' dir '/vN_' run '_timemean.mat']);
vN_ll_tav_lats(:,1,:,:) = repmat(vN_ll_tav(:,xn,:),[1 1 1 360]);
vN_ll_tav_lats(:,2,:,:) = repmat(vN_ll_tav(:,xs,:),[1 1 1 360]);
clear('vN_ll_tav')

load(['/project/rg312/mat_files/snapshot_data_final/run_' dir '/t_' run '_timemean.mat']);
t_ll_tav_lats(:,1,:,:) = repmat(t_ll_tav(:,xn,:),[1 1 1 360]);
t_ll_tav_lats(:,2,:,:) = repmat(t_ll_tav(:,xs,:),[1 1 1 360]);
clear('t_ll_tav')


for year = 1:10
year 

vN_cs = load(['/project/rg312/mat_files/snapshot_data_final/run_' dir '/vN_' run '_' num2str(year) '.mat'],vN_var);
vN_cs = vN_cs.(vN_var);
vN_ll = squeeze(cube2latlon(xc,yc,vN_cs,xi,yi));
vN_ed(:,1,:,:) = vN_ll(:,xn,:,:) - vN_ll_tav_lats(:,1,:,:);
vN_ed(:,2,:,:) = -(vN_ll(:,xs,:,:) - vN_ll_tav_lats(:,2,:,:));
clear('vN_ll')

t_cs = load(['/project/rg312/mat_files/snapshot_data_final/run_' dir '/t_' run '_' num2str(year) '.mat'],t_var);
t_cs = t_cs.(t_var);
t_ll = squeeze(cube2latlon(xc,yc,t_cs,xi,yi));
t_ed(:,1,:,:) = t_ll(:,xn,:,:) - t_ll_tav_lats(:,1,:,:);
t_ed(:,2,:,:) = t_ll(:,xs,:,:) - t_ll_tav_lats(:,2,:,:);
clear('t_ll')

vNt_ed = vN_ed.*t_ed;

t_mask_pos = +(t_ed > 0);
t_mask_neg = +(t_ed < 0);

vNt_ed_warm = vNt_ed.*t_mask_pos;
vNt_ed_cold = vNt_ed.*t_mask_neg;

vNt_ed_pzav(:,:,year) = squeeze(mean(mean(vNt_ed(:,:,1:tlev(xn),:),1),3));
vNt_ed_warm_pzav(:,:,year) = squeeze(mean(mean(vNt_ed_warm(:,:,1:tlev(xn),:),1),3));
vNt_ed_cold_pzav(:,:,year) = squeeze(mean(mean(vNt_ed_cold(:,:,1:tlev(xn),:),1),3));

end

vNt_ed_out =  mean(mean(mean(vNt_ed_pzav,1),2),3);
vNt_ed_warm_out = mean(mean(mean(vNt_ed_warm_pzav,1),2),3);
vNt_ed_cold_out = mean(mean(mean(vNt_ed_cold_pzav,1),2),3);


vNt_ed_var =  mean(mean(mean( (vNt_ed_pzav - vNt_ed_out).^2 ,1),2),3);
vNt_ed_warm_var =  mean(mean(mean( (vNt_ed_warm_pzav - vNt_ed_warm_out).^2 ,1),2),3);
vNt_ed_cold_var =  mean(mean(mean( (vNt_ed_cold_pzav - vNt_ed_cold_out).^2 ,1),2),3);

vNt_ed_serr = sqrt(vNt_ed_var)./sqrt(360.*2.*10);
vNt_ed_warm_serr = sqrt(vNt_ed_warm_var)./sqrt(360.*2.*10);
vNt_ed_cold_serr = sqrt(vNt_ed_cold_var)./sqrt(360.*2.*10);


