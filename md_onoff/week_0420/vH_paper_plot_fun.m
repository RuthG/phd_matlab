%take pressure, time and zonal average v't'  for each run
%also calculate average associated with cold sector only

function [vH_ed_tzav,vH_ed_tzav_neg,vH_ed_tzav_pos,vH_ed_sdev,vH_ed_sdev_neg,vH_ed_sdev_pos] = vH_paper_plot_fun(run)


cpd = 1005;
L = 2.5e6;


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
xi=-179:2:180;yi=-89:2:90;

%load up latitudes of peak v'T'

%load heat rates
t_var = ['t_' run];
vN_var = ['vN_' run];
q_var = ['q_' run];
x_var_n = ['x' run 'n'];
x_var_s = ['x' run 's'];

xvals = load('/project/rg312/mat_files/vt_lats_best.mat',x_var_n,x_var_s);
xn = xvals.(x_var_n);
xs = xvals.(x_var_s);

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


q_cs = load('/project/rg312/mat_files/snapshot_data/q_snapshots_best.mat',q_var);
q_cs = q_cs.(q_var);
q_ll = squeeze(cube2latlon(xc,yc,q_cs,xi,yi));
q_ll_tav = repmat(mean(q_ll,4),[1 1 1 720]);
q_ed_ll = q_ll - q_ll_tav;
clear('q_cs','q_ll','q_ll_tav')


vNt_ed_ll = vN_ed_ll.*t_ed_ll;
vNq_ed_ll = vN_ed_ll.*q_ed_ll;

vNH_ed_ll = vNt_ed_ll.*cpd + vNq_ed_ll.*L;
vNHd_ed_ll = vNt_ed_ll.*cpd;

clear('vN_ed_ll')

%take pressure average
vNH_ed_pav = mean(vNH_ed_ll,3);
vNHd_ed_pav = mean(vNHd_ed_ll,3);

%calculate the zonal integral of the latitude to look at
%(look at all lats first to check the cos weighting doesn't change our result)

t_ed_mask_neg = +(t_ed_ll < 0);
t_ed_mask_pos = +(t_ed_ll > 0);

vNH_ll_tneg = vNH_ed_ll.*t_ed_mask_neg;
vNH_ll_tpos = vNH_ed_ll.*t_ed_mask_pos;
vNHd_ll_tneg = vNHd_ed_ll.*t_ed_mask_neg;
vNHd_ll_tpos = vNHd_ed_ll.*t_ed_mask_pos;

vNH_ed_pav_tneg = squeeze(mean(vNH_ll_tneg ,3));
vNH_ed_pav_tpos = squeeze(mean(vNH_ll_tpos ,3));
vNHd_ed_pav_tneg = squeeze(mean(vNHd_ll_tneg ,3));
vNHd_ed_pav_tpos = squeeze(mean(vNHd_ll_tpos ,3));



vNH_ed_pzint = squeeze(mean(vNH_ed_pav,1));
vNH_ed_pzint_tneg = squeeze(mean(vNH_ed_pav_tneg,1));
vNH_ed_pzint_tpos = squeeze(mean(vNH_ed_pav_tpos,1));

vNHd_ed_pzint = squeeze(mean(vNHd_ed_pav,1));
vNHd_ed_pzint_tneg = squeeze(mean(vNHd_ed_pav_tneg,1));
vNHd_ed_pzint_tpos = squeeze(mean(vNHd_ed_pav_tpos,1));



vNH_ed_pzint_tzav = repmat(mean(vNH_ed_pzint,2),[1,720]);
vNH_ed_pzint_tzav_tneg = repmat(mean(vNH_ed_pzint_tneg,2),[1,720]);
vNH_ed_pzint_tzav_tpos = repmat(mean(vNH_ed_pzint_tpos,2),[1,720]);

vNH_ed_pzint_var = mean( (vNH_ed_pzint - vNH_ed_pzint_tzav).^2 ,2 );
vNH_ed_pzint_var_tneg = mean( (vNH_ed_pzint_tneg - vNH_ed_pzint_tzav_tneg).^2 ,2 );
vNH_ed_pzint_var_tpos = mean( (vNH_ed_pzint_tpos - vNH_ed_pzint_tzav_tpos).^2 ,2 );

vNH_ed_pzint_sdev = sqrt(vNH_ed_pzint_var);
vNH_ed_pzint_sdev_tneg = sqrt(vNH_ed_pzint_var_tneg);
vNH_ed_pzint_sdev_tpos = sqrt(vNH_ed_pzint_var_tpos);


vNHd_ed_pzint_tzav = repmat(mean(vNHd_ed_pzint,2),[1,720]);
vNHd_ed_pzint_tzav_tneg = repmat(mean(vNHd_ed_pzint_tneg,2),[1,720]);
vNHd_ed_pzint_tzav_tpos = repmat(mean(vNHd_ed_pzint_tpos,2),[1,720]);

vNHd_ed_pzint_var = mean( (vNHd_ed_pzint - vNHd_ed_pzint_tzav).^2 ,2 );
vNHd_ed_pzint_var_tneg = mean( (vNHd_ed_pzint_tneg - vNHd_ed_pzint_tzav_tneg).^2 ,2 );
vNHd_ed_pzint_var_tpos = mean( (vNHd_ed_pzint_tpos - vNHd_ed_pzint_tzav_tpos).^2 ,2 );

vNHd_ed_pzint_sdev = sqrt(vNHd_ed_pzint_var);
vNHd_ed_pzint_sdev_tneg = sqrt(vNHd_ed_pzint_var_tneg);
vNHd_ed_pzint_sdev_tpos = sqrt(vNHd_ed_pzint_var_tpos);




vH_ed_tzav(1) = (vNH_ed_pzint_tzav(xn,1) - vNH_ed_pzint_tzav(xs,1))./2;
vH_ed_tzav_neg(1) = (vNH_ed_pzint_tzav_tneg(xn,1) - vNH_ed_pzint_tzav_tneg(xs,1))./2;
vH_ed_tzav_pos(1) = (vNH_ed_pzint_tzav_tpos(xn,1) - vNH_ed_pzint_tzav_tpos(xs,1))./2;

vH_ed_sdev(1) = sqrt((vNH_ed_pzint_var(xn,1) + vNH_ed_pzint_var(xs,1))./2)./sqrt(1440) ;
vH_ed_sdev_neg(1) = sqrt((vNH_ed_pzint_var_tneg(xn,1) + vNH_ed_pzint_var_tneg(xs,1))./2)./sqrt(1440) ;
vH_ed_sdev_pos(1) = sqrt((vNH_ed_pzint_var_tpos(xn,1) + vNH_ed_pzint_var_tpos(xs,1))./2)./sqrt(1440) ;

vH_ed_tzav(2) = (vNHd_ed_pzint_tzav(xn,1) - vNHd_ed_pzint_tzav(xs,1))./2;
vH_ed_tzav_neg(2) = (vNHd_ed_pzint_tzav_tneg(xn,1) - vNHd_ed_pzint_tzav_tneg(xs,1))./2;
vH_ed_tzav_pos(2) = (vNHd_ed_pzint_tzav_tpos(xn,1) - vNHd_ed_pzint_tzav_tpos(xs,1))./2;

vH_ed_sdev(2) = sqrt((vNHd_ed_pzint_var(xn,1) + vNHd_ed_pzint_var(xs,1))./2)./sqrt(1440) ;
vH_ed_sdev_neg(2) = sqrt((vNHd_ed_pzint_var_tneg(xn,1) + vNHd_ed_pzint_var_tneg(xs,1))./2)./sqrt(1440) ;
vH_ed_sdev_pos(2) = sqrt((vNHd_ed_pzint_var_tpos(xn,1) + vNHd_ed_pzint_var_tpos(xs,1))./2)./sqrt(1440) ;


return






