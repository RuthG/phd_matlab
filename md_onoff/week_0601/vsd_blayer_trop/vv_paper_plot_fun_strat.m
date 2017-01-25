%take pressure, time and zonal average v't'  for each run
%also calculate average associated with cold sector only

function [vv_ed_tzav,vv_ed_tzav_neg,vv_ed_tzav_pos,vv_ed_sdev,vv_ed_sdev_neg,vv_ed_sdev_pos] = vv_paper_plot_fun_strat(run)

% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_000_best/';
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
xi=-179:2:160;yi=-89:2:90;

%load up latitudes of peak v'T'

%load heat rates
t_var = ['t_' run];
vN_var = ['vN_' run];
x_var_n = ['x' run 'n'];
x_var_s = ['x' run 's'];
blev_var = ['b_lev_' run];
tlev_var = ['trop_lev_' run];

xvals = load('/project/rg312/mat_files/vt_lats_best.mat',x_var_n,x_var_s);
xn = xvals.(x_var_n);
xs = xvals.(x_var_s);

blev = load('/project/rg312/mat_files/blayer_trop_levs.mat',blev_var);
blev = blev.(blev_var);

tlev = load('/project/rg312/mat_files/blayer_trop_levs.mat',tlev_var);
tlev = tlev.(tlev_var);

vN_cs = load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat',vN_var);
vN_cs = vN_cs.(vN_var);
vN_ll = squeeze(cube2latlon(xc,yc,vN_cs,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_cs','vN_ll','vN_ll_tav')

t_cs = load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat',t_var);
t_cs = t_cs.(t_var);
t_ll = squeeze(cube2latlon(xc,yc,t_cs,xi,yi));
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_cs','t_ll','t_ll_tav')

vNvN_ed_ll = vN_ed_ll.*vN_ed_ll;

clear('vN_ed_ll')

%take pressure average
vNvN_ed_pav = mean(vNvN_ed_ll(:,:,tlev(xn)+1:25,:),3);

%calculate the zonal integral of the latitude to look at
%(look at all lats first to check the cos weighting doesn't change our result)

t_ed_mask_neg = +(t_ed_ll < 0);
t_ed_mask_pos = +(t_ed_ll > 0);

vNvN_ll_tneg = vNvN_ed_ll.*t_ed_mask_neg;
vNvN_ll_tpos = vNvN_ed_ll.*t_ed_mask_pos;

vNvN_ed_pav_tneg = squeeze(mean(vNvN_ll_tneg(:,:,tlev(xn)+1:25,:) ,3));
vNvN_ed_pav_tpos = squeeze(mean(vNvN_ll_tpos(:,:,tlev(xn)+1:25,:) ,3));

for i=1:90

vNvN_ed_pzint(i,:) = squeeze(mean(vNvN_ed_pav(:,i,:),1));
vNvN_ed_pzint_tneg(i,:) = squeeze(mean(vNvN_ed_pav_tneg(:,i,:),1));
vNvN_ed_pzint_tpos(i,:) = squeeze(mean(vNvN_ed_pav_tpos(:,i,:),1));

end

vNvN_ed_pzint_tzav = repmat(mean(vNvN_ed_pzint,2),[1,720]);
vNvN_ed_pzint_tzav_tneg = repmat(mean(vNvN_ed_pzint_tneg,2),[1,720]);
vNvN_ed_pzint_tzav_tpos = repmat(mean(vNvN_ed_pzint_tpos,2),[1,720]);

vNvN_ed_pzint_var = mean( (vNvN_ed_pzint - vNvN_ed_pzint_tzav).^2 ,2 );
vNvN_ed_pzint_var_tneg = mean( (vNvN_ed_pzint_tneg - vNvN_ed_pzint_tzav_tneg).^2 ,2 );
vNvN_ed_pzint_var_tpos = mean( (vNvN_ed_pzint_tpos - vNvN_ed_pzint_tzav_tpos).^2 ,2 );

vNvN_ed_pzint_sdev = sqrt(vNvN_ed_pzint_var);
vNvN_ed_pzint_sdev_tneg = sqrt(vNvN_ed_pzint_var_tneg);
vNvN_ed_pzint_sdev_tpos = sqrt(vNvN_ed_pzint_var_tpos);

vv_ed_tzav = (vNvN_ed_pzint_tzav(xn,1) + vNvN_ed_pzint_tzav(xs,1))./2;
vv_ed_tzav_neg = (vNvN_ed_pzint_tzav_tneg(xn,1) + vNvN_ed_pzint_tzav_tneg(xs,1))./2;
vv_ed_tzav_pos = (vNvN_ed_pzint_tzav_tpos(xn,1) + vNvN_ed_pzint_tzav_tpos(xs,1))./2;

vv_ed_sdev = sqrt((vNvN_ed_pzint_var(xn,1) + vNvN_ed_pzint_var(xs,1))./2)./sqrt(1440) ;
vv_ed_sdev_neg = sqrt((vNvN_ed_pzint_var_tneg(xn,1) + vNvN_ed_pzint_var_tneg(xs,1))./2)./sqrt(1440) ;
vv_ed_sdev_pos = sqrt((vNvN_ed_pzint_var_tpos(xn,1) + vNvN_ed_pzint_var_tpos(xs,1))./2)./sqrt(1440) ;


return






