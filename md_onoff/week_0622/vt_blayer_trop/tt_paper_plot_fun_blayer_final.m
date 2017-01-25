%take pressure, time and zonal average v't'  for each run
%also calculate average associated with cold sector only

function [tt_ed_out ,tt_ed_warm_out ,tt_ed_cold_out ,tt_ed_serr ,tt_ed_warm_serr ,tt_ed_cold_serr] = tt_paper_plot_fun_blayer_final(run)

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

dir = run;
if run == '000'
dir = '000_ns';
end

xvals = load('/project/rg312/mat_files/vt_lats_final.mat',x_var_n,x_var_s);
xn = xvals.(x_var_n);
xs = xvals.(x_var_s);

blev = load('/project/rg312/mat_files/blayer_levs_final.mat',blev_var);
blev = blev.(blev_var);

load(['/project/rg312/mat_files/snapshot_data_final/run_' dir '/t_' run '_timemean.mat']);
t_ll_tav_lats(:,1,:,:) = repmat(t_ll_tav(:,xn,:),[1 1 1 360]);
t_ll_tav_lats(:,2,:,:) = repmat(t_ll_tav(:,xs,:),[1 1 1 360]);
clear('t_ll_tav')


for year = 1:10
year 

t_cs = load(['/project/rg312/mat_files/snapshot_data_final/run_' dir '/t_' run '_' num2str(year) '.mat'],t_var);
t_cs = t_cs.(t_var);
t_ll = squeeze(cube2latlon(xc,yc,t_cs,xi,yi));
t_ed(:,1,:,:) = t_ll(:,xn,:,:) - t_ll_tav_lats(:,1,:,:);
t_ed(:,2,:,:) = t_ll(:,xs,:,:) - t_ll_tav_lats(:,2,:,:);
clear('t_ll')

tt_ed = t_ed.*t_ed;

t_mask_pos = +(t_ed > 0);
t_mask_neg = +(t_ed < 0);

tt_ed_warm = tt_ed.*t_mask_pos;
tt_ed_cold = tt_ed.*t_mask_neg;

tt_ed_pzav(:,:,year) = squeeze(mean(mean(tt_ed(:,:,1:blev(xn),:),1),3));
tt_ed_warm_pzav(:,:,year) = squeeze(mean(mean(tt_ed_warm(:,:,1:blev(xn),:),1),3));
tt_ed_cold_pzav(:,:,year) = squeeze(mean(mean(tt_ed_cold(:,:,1:blev(xn),:),1),3));

end

tt_ed_out =  mean(mean(mean(tt_ed_pzav,1),2),3);
tt_ed_warm_out = mean(mean(mean(tt_ed_warm_pzav,1),2),3);
tt_ed_cold_out = mean(mean(mean(tt_ed_cold_pzav,1),2),3);


tt_ed_var =  mean(mean(mean( (tt_ed_pzav - tt_ed_out).^2 ,1),2),3);
tt_ed_warm_var =  mean(mean(mean( (tt_ed_warm_pzav - tt_ed_warm_out).^2 ,1),2),3);
tt_ed_cold_var =  mean(mean(mean( (tt_ed_cold_pzav - tt_ed_cold_out).^2 ,1),2),3);

tt_ed_serr = sqrt(tt_ed_var)./sqrt(360.*2.*10);
tt_ed_warm_serr = sqrt(tt_ed_warm_var)./sqrt(360.*2.*10);
tt_ed_cold_serr = sqrt(tt_ed_cold_var)./sqrt(360.*2.*10);


