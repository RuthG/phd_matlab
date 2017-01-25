%take pressure, time and zonal average v't'  for each run
%also calculate average associated with cold sector only

function [tt_ed_tzav,tt_ed_tzav_neg,tt_ed_tzav_pos,tt_ed_sdev,tt_ed_sdev_neg,tt_ed_sdev_pos] = tt_paper_plot_fun_blayer(run)

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


t_cs = load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat',t_var);
t_cs = t_cs.(t_var);
t_ll = squeeze(cube2latlon(xc,yc,t_cs,xi,yi));
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_cs','t_ll','t_ll_tav')

tt_ed_ll = t_ed_ll.*t_ed_ll;


%take pressure average
tt_ed_pav = mean(tt_ed_ll(:,:,tlev(xn)+1:25,:),3);

%calculate the zonal integral of the latitude to look at
%(look at all lats first to check the cos weighting doesn't change our result)

t_ed_mask_neg = +(t_ed_ll < 0);
t_ed_mask_pos = +(t_ed_ll > 0);

tt_ll_tneg = tt_ed_ll.*t_ed_mask_neg;
tt_ll_tpos = tt_ed_ll.*t_ed_mask_pos;

tt_ed_pav_tneg = squeeze(mean(tt_ll_tneg(:,:,tlev(xn)+1:25,:) ,3));
tt_ed_pav_tpos = squeeze(mean(tt_ll_tpos(:,:,tlev(xn)+1:25,:) ,3));

for i=1:90

tt_ed_pzint(i,:) = squeeze(mean(tt_ed_pav(:,i,:),1));
tt_ed_pzint_tneg(i,:) = squeeze(mean(tt_ed_pav_tneg(:,i,:),1));
tt_ed_pzint_tpos(i,:) = squeeze(mean(tt_ed_pav_tpos(:,i,:),1));

end

tt_ed_pzint_tzav = repmat(mean(tt_ed_pzint,2),[1,720]);
tt_ed_pzint_tzav_tneg = repmat(mean(tt_ed_pzint_tneg,2),[1,720]);
tt_ed_pzint_tzav_tpos = repmat(mean(tt_ed_pzint_tpos,2),[1,720]);

tt_ed_pzint_var = mean( (tt_ed_pzint - tt_ed_pzint_tzav).^2 ,2 );
tt_ed_pzint_var_tneg = mean( (tt_ed_pzint_tneg - tt_ed_pzint_tzav_tneg).^2 ,2 );
tt_ed_pzint_var_tpos = mean( (tt_ed_pzint_tpos - tt_ed_pzint_tzav_tpos).^2 ,2 );

tt_ed_pzint_sdev = sqrt(tt_ed_pzint_var);
tt_ed_pzint_sdev_tneg = sqrt(tt_ed_pzint_var_tneg);
tt_ed_pzint_sdev_tpos = sqrt(tt_ed_pzint_var_tpos);

tt_ed_tzav = (tt_ed_pzint_tzav(xn,1) + tt_ed_pzint_tzav(xs,1))./2;
tt_ed_tzav_neg = (tt_ed_pzint_tzav_tneg(xn,1) + tt_ed_pzint_tzav_tneg(xs,1))./2;
tt_ed_tzav_pos = (tt_ed_pzint_tzav_tpos(xn,1) + tt_ed_pzint_tzav_tpos(xs,1))./2;

tt_ed_sdev = sqrt((tt_ed_pzint_var(xn,1) + tt_ed_pzint_var(xs,1))./2)./sqrt(1440) ;
tt_ed_sdev_neg = sqrt((tt_ed_pzint_var_tneg(xn,1) + tt_ed_pzint_var_tneg(xs,1))./2)./sqrt(1440) ;
tt_ed_sdev_pos = sqrt((tt_ed_pzint_var_tpos(xn,1) + tt_ed_pzint_var_tpos(xs,1))./2)./sqrt(1440) ;


return






