%take pressure, time and zonal average v't'  for each run
%also calculate average associated with cold sector only

function [vt_ed_tzav,vt_ed_tzav_neg,vt_ed_tzav_pos,vt_ed_sdev,vt_ed_sdev_neg,vt_ed_sdev_pos] = vt_paper_plot_fun_blayer(run)

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


xvals = load('/project/rg312/mat_files/vt_lats_best.mat',x_var_n,x_var_s);
xn = xvals.(x_var_n);
xs = xvals.(x_var_s);

blev = load('/project/rg312/mat_files/blayer_trop_levs.mat',blev_var);
blev = blev.(blev_var);


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

vNt_ed_ll = vN_ed_ll.*t_ed_ll;

clear('vN_ed_ll')

%take pressure average
vNt_ed_pav = mean(vNt_ed_ll(:,:,1:blev(xn)-1,:),3);

%calculate the zonal integral of the latitude to look at
%(look at all lats first to check the cos weighting doesn't change our result)

t_ed_mask_neg = +(t_ed_ll < 0);
t_ed_mask_pos = +(t_ed_ll > 0);

vNt_ll_tneg = vNt_ed_ll.*t_ed_mask_neg;
vNt_ll_tpos = vNt_ed_ll.*t_ed_mask_pos;

vNt_ed_pav_tneg = squeeze(mean(vNt_ll_tneg(:,:,1:blev(xn)-1,:) ,3));
vNt_ed_pav_tpos = squeeze(mean(vNt_ll_tpos(:,:,1:blev(xn)-1,:) ,3));

for i=1:90

vNt_ed_pzint(i,:) = squeeze(mean(vNt_ed_pav(:,i,:),1));
vNt_ed_pzint_tneg(i,:) = squeeze(mean(vNt_ed_pav_tneg(:,i,:),1));
vNt_ed_pzint_tpos(i,:) = squeeze(mean(vNt_ed_pav_tpos(:,i,:),1));

end

vNt_ed_pzint_tzav = repmat(mean(vNt_ed_pzint,2),[1,720]);
vNt_ed_pzint_tzav_tneg = repmat(mean(vNt_ed_pzint_tneg,2),[1,720]);
vNt_ed_pzint_tzav_tpos = repmat(mean(vNt_ed_pzint_tpos,2),[1,720]);

vNt_ed_pzint_var = mean( (vNt_ed_pzint - vNt_ed_pzint_tzav).^2 ,2 );
vNt_ed_pzint_var_tneg = mean( (vNt_ed_pzint_tneg - vNt_ed_pzint_tzav_tneg).^2 ,2 );
vNt_ed_pzint_var_tpos = mean( (vNt_ed_pzint_tpos - vNt_ed_pzint_tzav_tpos).^2 ,2 );

vNt_ed_pzint_sdev = sqrt(vNt_ed_pzint_var);
vNt_ed_pzint_sdev_tneg = sqrt(vNt_ed_pzint_var_tneg);
vNt_ed_pzint_sdev_tpos = sqrt(vNt_ed_pzint_var_tpos);

vt_ed_tzav = (vNt_ed_pzint_tzav(xn,1) - vNt_ed_pzint_tzav(xs,1))./2;
vt_ed_tzav_neg = (vNt_ed_pzint_tzav_tneg(xn,1) - vNt_ed_pzint_tzav_tneg(xs,1))./2;
vt_ed_tzav_pos = (vNt_ed_pzint_tzav_tpos(xn,1) - vNt_ed_pzint_tzav_tpos(xs,1))./2;

vt_ed_sdev = sqrt((vNt_ed_pzint_var(xn,1) + vNt_ed_pzint_var(xs,1))./2)./sqrt(1440) ;
vt_ed_sdev_neg = sqrt((vNt_ed_pzint_var_tneg(xn,1) + vNt_ed_pzint_var_tneg(xs,1))./2)./sqrt(1440) ;
vt_ed_sdev_pos = sqrt((vNt_ed_pzint_var_tpos(xn,1) + vNt_ed_pzint_var_tpos(xs,1))./2)./sqrt(1440) ;


return






