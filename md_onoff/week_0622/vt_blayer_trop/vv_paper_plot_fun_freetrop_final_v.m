%take pressure, time and zonal average v't'  for each run
%also calculate average associated with cold sector only

function [vv_ed_out ,vv_ed_warm_out ,vv_ed_cold_out ,vv_ed_serr ,vv_ed_warm_serr ,vv_ed_cold_serr] = vv_paper_plot_fun_blayer_final_v(run)

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

%load up latitudes of peak T'T'

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

blev = load('/project/rg312/mat_files/blayer_levs_final.mat',blev_var);
blev = blev.(blev_var);

tlev = load('/project/rg312/mat_files/trop_levs_final.mat',tlev_var);
tlev = tlev.(tlev_var);

load(['/project/rg312/mat_files/snapshot_data_final/run_' dir '/vN_' run '_timemean.mat']);

vN_ll_tav_lats(:,1,:,:) = repmat(vN_ll_tav(:,xn,:),[1 1 1 360]);
vN_ll_tav_lats(:,2,:,:) = repmat(vN_ll_tav(:,xs,:),[1 1 1 360]);
clear('vN_ll_tav')

for year = 1:10
year 

vN_cs = load(['/project/rg312/mat_files/snapshot_data_final/run_' dir '/vN_' run '_' num2str(year) '.mat'],vN_var);
vN_cs = vN_cs.(vN_var);
vN_ll = squeeze(cube2latlon(xc,yc,vN_cs,xi,yi));
vN_ed(:,1,:,:) = vN_ll(:,xn,:,:) - vN_ll_tav_lats(:,1,:,:);
vN_ed(:,2,:,:) = -(vN_ll(:,xs,:,:) - vN_ll_tav_lats(:,2,:,:));
clear('vN_ll')

vv_ed = vN_ed.*vN_ed;

v_mask_pos = +(vN_ed > 0);
v_mask_neg = +(vN_ed < 0);

vv_ed_warm = vv_ed.*v_mask_pos;
vv_ed_cold = vv_ed.*v_mask_neg;

vv_ed_pzav(:,:,year) = squeeze(mean(mean(vv_ed(:,:,blev(xn)+1:tlev(xn),:),1),3));
vv_ed_warm_pzav(:,:,year) = squeeze(mean(mean(vv_ed_warm(:,:,blev(xn)+1:tlev(xn),:),1),3));
vv_ed_cold_pzav(:,:,year) = squeeze(mean(mean(vv_ed_cold(:,:,blev(xn)+1:tlev(xn),:),1),3));

end

vv_ed_out =  mean(mean(mean(vv_ed_pzav,1),2),3);
vv_ed_warm_out = mean(mean(mean(vv_ed_warm_pzav,1),2),3);
vv_ed_cold_out = mean(mean(mean(vv_ed_cold_pzav,1),2),3);


vv_ed_var =  mean(mean(mean( (vv_ed_pzav - vv_ed_out).^2 ,1),2),3);
vv_ed_warm_var =  mean(mean(mean( (vv_ed_warm_pzav - vv_ed_warm_out).^2 ,1),2),3);
vv_ed_cold_var =  mean(mean(mean( (vv_ed_cold_pzav - vv_ed_cold_out).^2 ,1),2),3);

vv_ed_serr = sqrt(vv_ed_var)./sqrt(360.*2.*10);
vv_ed_warm_serr = sqrt(vv_ed_warm_var)./sqrt(360.*2.*10);
vv_ed_cold_serr = sqrt(vv_ed_cold_var)./sqrt(360.*2.*10);


