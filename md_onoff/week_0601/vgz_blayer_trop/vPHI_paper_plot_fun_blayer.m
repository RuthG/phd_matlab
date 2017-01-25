%take pressure, time and zonal average v't'  for each run
%also calculate average associated with cold sector only

function [vPHI_ed_tzav,vPHI_ed_tzav_neg,vPHI_ed_tzav_pos,vPHI_ed_sdev,vPHI_ed_sdev_neg,vPHI_ed_sdev_pos] = vPHI_paper_plot_fun_blayer(run)

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

cpd = 1005;
L = 2.5e6;

%load up latitudes of peak v'T'

%load heat rates
t_var = ['t_' run];
vN_var = ['vN_' run];
%q_var = ['q_' run];
ph_var = ['ph_' run];
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


ph_cs = load('/project/rg312/mat_files/snapshot_data/ph_snapshots_best.mat',ph_var);
ph_cs = ph_cs.(ph_var);
ph_ll = squeeze(cube2latlon(xc,yc,ph_cs,xi,yi));
ph_ll_tav = repmat(mean(ph_ll,4),[1 1 1 720]);
ph_ed_ll = ph_ll - ph_ll_tav;
clear('ph_cs','ph_ll','ph_ll_tav')


vNt_ed_ll = vN_ed_ll.*t_ed_ll;
vNph_ed_ll = vN_ed_ll.*ph_ed_ll;
vNPHI_ed_ll = vNph_ed_ll;

clear('vN_ed_ll')

%take pressure average
vNPHI_ed_pav = mean(vNPHI_ed_ll(:,:,1:blev(xn),:),3);

%calculate the zonal integral of the latitude to look at
%(look at all lats first to check the cos weighting doesn't change our result)

t_ed_mask_neg = +(t_ed_ll < 0);
t_ed_mask_pos = +(t_ed_ll > 0);

vNPHI_ll_tneg = vNPHI_ed_ll.*t_ed_mask_neg;
vNPHI_ll_tpos = vNPHI_ed_ll.*t_ed_mask_pos;

vNPHI_ed_pav_tneg = squeeze(mean(vNPHI_ll_tneg(:,:,1:blev(xn),:) ,3));
vNPHI_ed_pav_tpos = squeeze(mean(vNPHI_ll_tpos(:,:,1:blev(xn),:) ,3));

for i=1:90

vNPHI_ed_pzint(i,:) = squeeze(mean(vNPHI_ed_pav(:,i,:),1));
vNPHI_ed_pzint_tneg(i,:) = squeeze(mean(vNPHI_ed_pav_tneg(:,i,:),1));
vNPHI_ed_pzint_tpos(i,:) = squeeze(mean(vNPHI_ed_pav_tpos(:,i,:),1));

end

vNPHI_ed_pzint_tzav = repmat(mean(vNPHI_ed_pzint,2),[1,720]);
vNPHI_ed_pzint_tzav_tneg = repmat(mean(vNPHI_ed_pzint_tneg,2),[1,720]);
vNPHI_ed_pzint_tzav_tpos = repmat(mean(vNPHI_ed_pzint_tpos,2),[1,720]);

vNPHI_ed_pzint_var = mean( (vNPHI_ed_pzint - vNPHI_ed_pzint_tzav).^2 ,2 );
vNPHI_ed_pzint_var_tneg = mean( (vNPHI_ed_pzint_tneg - vNPHI_ed_pzint_tzav_tneg).^2 ,2 );
vNPHI_ed_pzint_var_tpos = mean( (vNPHI_ed_pzint_tpos - vNPHI_ed_pzint_tzav_tpos).^2 ,2 );

vNPHI_ed_pzint_sdev = sqrt(vNPHI_ed_pzint_var);
vNPHI_ed_pzint_sdev_tneg = sqrt(vNPHI_ed_pzint_var_tneg);
vNPHI_ed_pzint_sdev_tpos = sqrt(vNPHI_ed_pzint_var_tpos);

vPHI_ed_tzav = (vNPHI_ed_pzint_tzav(xn,1) - vNPHI_ed_pzint_tzav(xs,1))./2;
vPHI_ed_tzav_neg = (vNPHI_ed_pzint_tzav_tneg(xn,1) - vNPHI_ed_pzint_tzav_tneg(xs,1))./2;
vPHI_ed_tzav_pos = (vNPHI_ed_pzint_tzav_tpos(xn,1) - vNPHI_ed_pzint_tzav_tpos(xs,1))./2;

vPHI_ed_sdev = sqrt((vNPHI_ed_pzint_var(xn,1) + vNPHI_ed_pzint_var(xs,1))./2)./sqrt(1440) ;
vPHI_ed_sdev_neg = sqrt((vNPHI_ed_pzint_var_tneg(xn,1) + vNPHI_ed_pzint_var_tneg(xs,1))./2)./sqrt(1440) ;
vPHI_ed_sdev_pos = sqrt((vNPHI_ed_pzint_var_tpos(xn,1) + vNPHI_ed_pzint_var_tpos(xs,1))./2)./sqrt(1440) ;


return






