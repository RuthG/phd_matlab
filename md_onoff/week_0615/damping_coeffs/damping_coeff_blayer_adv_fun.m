%for a given heating field and run calculate:
%<j'th'>
%<th.^2>
%<j'th'>/<th.^2>

function [dcoeff_tot_p, dcoeff_tot_n, dcoeff_adv_p, dcoeff_adv_n] = damping_coeff_blayer_adv_fun(run)


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
yi=-89:2:89;
xi = -179:2:179;

tott_var = ['totttend_snap_' run];
x_var_n = ['x' run 'n'];
x_var_s = ['x' run 's'];
blev_var = ['b_lev_' run];

xvals = load('/project/rg312/mat_files/vt_lats_best.mat',x_var_n,x_var_s);
xn = xvals.(x_var_n);
xs = xvals.(x_var_s);

blev = load('/project/rg312/mat_files/blayer_trop_levs.mat',blev_var);
blev = blev.(blev_var);

theta_var = ['theta_' run];
theta_cs = load('/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat',theta_var);
theta_cs = theta_cs.(theta_var);
theta_ll = squeeze(cube2latlon(xc,yc,theta_cs,xi,yi));
theta_ll_tav = repmat(mean(theta_ll,4),[1 1 1 719]);
theta_ed_ll = theta_ll(:,:,:,1:719) - theta_ll_tav;
clear('theta_cs','theta_ll','theta_ll_tav')


tott_cs = load(['/project/rg312/mat_files/totttend_' run '_best.mat'],tott_var);
tott_cs = tott_cs.(tott_var);
tott_ll = squeeze(cube2latlon(xc,yc,tott_cs,xi,yi));
tott_ll_tav = repmat(mean(tott_ll,4),[1 1 1 719]);
tott_ed_ll = tott_ll(:,:,:,1:719) - tott_ll_tav;
clear('tott_cs','tott_ll','tott_ll_tav')

htrt_var = ['htrt_' run];
htrt_cs = load('/project/rg312/mat_files/heat_rates_best.mat',htrt_var);
htrt_cs = htrt_cs.(htrt_var);
htrt_ll = squeeze(cube2latlon(xc,yc,htrt_cs,xi,yi)).*86400;
htrt_ll_tav = repmat(mean(htrt_ll,4),[1 1 1 719]);
htrt_ed_ll = htrt_ll(:,:,:,1:719) - htrt_ll_tav;
clear('htrt_cs','htrt_ll')

adv_ed_ll = tott_ed_ll - htrt_ed_ll; 
clear('htrt_ed_ll','htrt_ll_tav')

theta_pos_mask = +(theta_ed_ll > 0);
theta_neg_mask = +(theta_ed_ll < 0);

tottth_ed_ll = tott_ed_ll.*theta_ed_ll;
advth_ed_ll = adv_ed_ll.*theta_ed_ll;
thth_ed_ll = theta_ed_ll.*theta_ed_ll;

tottth_ll_tneg = tottth_ed_ll.*theta_neg_mask;
tottth_ll_tpos = tottth_ed_ll.*theta_pos_mask;
advth_ll_tneg = advth_ed_ll.*theta_neg_mask;
advth_ll_tpos = advth_ed_ll.*theta_pos_mask;
thth_ll_tneg = thth_ed_ll.*theta_neg_mask;
thth_ll_tpos = thth_ed_ll.*theta_pos_mask;

dcoeff_ll_tot_n = squeeze(mean(tottth_ll_tneg,1)./mean(thth_ll_tneg,1));
dcoeff_ll_tot_p = squeeze(mean(tottth_ll_tpos,1)./mean(thth_ll_tpos,1));
dcoeff_ll_adv_n = squeeze(mean(advth_ll_tneg,1)./mean(thth_ll_tneg,1));
dcoeff_ll_adv_p = squeeze(mean(advth_ll_tpos,1)./mean(thth_ll_tpos,1));

%jth_ll_n = squeeze(mean(jth_ll_tneg,1));
%jth_ll_p = squeeze(mean(jth_ll_tpos,1));
%thth_ll_n = squeeze(mean(thth_ll_tneg,1));
%thth_ll_p = squeeze(mean(thth_ll_tpos,1));

%take pressure average
dcoeff_ll_tot_n_pav = squeeze(mean(dcoeff_ll_tot_n(:,1:blev(xn),:),2));
dcoeff_ll_tot_p_pav = squeeze(mean(dcoeff_ll_tot_p(:,1:blev(xn),:),2));
dcoeff_ll_adv_n_pav = squeeze(mean(dcoeff_ll_adv_n(:,1:blev(xn),:),2));
dcoeff_ll_adv_p_pav = squeeze(mean(dcoeff_ll_adv_p(:,1:blev(xn),:),2));
%jth_ll_n_pav = squeeze(mean(jth_ll_n(:,1:blev(xn),:),2));
%jth_ll_p_pav = squeeze(mean(jth_ll_p(:,1:blev(xn),:),2));
%thth_ll_n_pav = squeeze(mean(thth_ll_n(:,1:blev(xn),:),2));
%thth_ll_p_pav = squeeze(mean(thth_ll_p(:,1:blev(xn),:),2));


%take time average
dcoeff_tot_n_tzav = repmat(mean(dcoeff_ll_tot_n_pav,2),[1,719]);
dcoeff_tot_p_tzav = repmat(mean(dcoeff_ll_tot_p_pav,2),[1,719]);
dcoeff_adv_n_tzav = repmat(mean(dcoeff_ll_adv_n_pav,2),[1,719]);
dcoeff_adv_p_tzav = repmat(mean(dcoeff_ll_adv_p_pav,2),[1,719]);
%jth_n_tzav = repmat(mean(jth_ll_n_pav,2),[1,719]);
%jth_p_tzav = repmat(mean(jth_ll_p_pav,2),[1,719]);
%thth_n_tzav = repmat(mean(thth_ll_n_pav,2),[1,719]);
%thth_p_tzav = repmat(mean(thth_ll_p_pav,2),[1,719]);


dcoeff_tot_n_var = mean( (dcoeff_ll_tot_n_pav - dcoeff_tot_n_tzav).^2 ,2 );
dcoeff_tot_p_var = mean( (dcoeff_ll_tot_p_pav - dcoeff_tot_p_tzav).^2 ,2 );
dcoeff_adv_n_var = mean( (dcoeff_ll_adv_n_pav - dcoeff_adv_n_tzav).^2 ,2 );
dcoeff_adv_p_var = mean( (dcoeff_ll_adv_p_pav - dcoeff_adv_p_tzav).^2 ,2 );
%jth_n_var = mean( (jth_ll_n_pav - jth_n_tzav).^2 ,2 );
%jth_p_var = mean( (jth_ll_p_pav - jth_p_tzav).^2 ,2 );
%thth_n_var = mean( (thth_ll_n_pav - thth_n_tzav).^2 ,2 );
%thth_p_var = mean( (thth_ll_p_pav - thth_p_tzav).^2 ,2 );

dcoeff_tot_n = (dcoeff_tot_n_tzav(xn,1) + dcoeff_tot_n_tzav(xs,2))./2;
dcoeff_tot_p = (dcoeff_tot_p_tzav(xn,1) + dcoeff_tot_p_tzav(xs,2))./2;
dcoeff_adv_n = (dcoeff_adv_n_tzav(xn,1) + dcoeff_adv_n_tzav(xs,2))./2;
dcoeff_adv_p = (dcoeff_adv_p_tzav(xn,1) + dcoeff_adv_p_tzav(xs,2))./2;
%jth_n = (jth_n_tzav(xn,1) + jth_n_tzav(xs,2))./2;
%jth_p = (jth_p_tzav(xn,1) + jth_p_tzav(xs,2))./2;
%thth_n = (thth_n_tzav(xn,1) + thth_n_tzav(xs,2))./2;
%thth_p = (thth_p_tzav(xn,1) + thth_p_tzav(xs,2))./2;

dcoeff_tot_n(:,2) = sqrt( (dcoeff_tot_n_var(xn,1) + dcoeff_tot_n_var(xs,1))./2 )./sqrt(1438) ; 
dcoeff_tot_p(:,2) = sqrt( (dcoeff_tot_p_var(xn,1) + dcoeff_tot_p_var(xs,1))./2 )./sqrt(1438) ; 
dcoeff_adv_n(:,2) = sqrt( (dcoeff_adv_n_var(xn,1) + dcoeff_adv_n_var(xs,1))./2 )./sqrt(1438) ; 
dcoeff_adv_p(:,2) = sqrt( (dcoeff_adv_p_var(xn,1) + dcoeff_adv_p_var(xs,1))./2 )./sqrt(1438) ; 
%jth_n(:,2) = sqrt( (jth_n_var(xn,1) + jth_n_var(xs,1))./2 )./sqrt(1438) ; 
%jth_p(:,2) = sqrt( (jth_p_var(xn,1) + jth_p_var(xs,1))./2 )./sqrt(1438) ; 
%thth_n(:,2) = sqrt( (thth_n_var(xn,1) + thth_n_var(xs,1))./2 )./sqrt(1438) ; 
%thth_p(:,2) = sqrt( (thth_p_var(xn,1) + thth_p_var(xs,1))./2 )./sqrt(1438) ; 



