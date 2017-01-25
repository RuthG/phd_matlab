%for a given heating field and run calculate:
%<j'th'>
%<th.^2>
%<j'th'>/<th.^2>

function [dcoeff_p, dcoeff_n, jth_ed_p, jth_ed_n, th_var_p, th_var_n] = damping_coeff_troplid_fun(run, var)


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

theta_var = ['theta_' run];
theta_cs = load('/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat',theta_var);
theta_cs = theta_cs.(theta_var);
theta_ll = squeeze(cube2latlon(xc,yc,theta_cs,xi,yi));
theta_ll_tav = repmat(mean(theta_ll,4),[1 1 1 719]);
theta_ed_ll = theta_ll(:,:,:,1:719) - theta_ll_tav;
clear('theta_cs','theta_ll')

j_var = [var '_' run];
j_cs = load('/project/rg312/mat_files/heat_rates_best.mat',j_var);
j_cs = j_cs.(j_var);
j_ll = squeeze(cube2latlon(xc,yc,j_cs,xi,yi)).*86400;
j_ll_tav = repmat(mean(j_ll,4),[1 1 1 719]);
j_ed_ll = j_ll(:,:,:,1:719) - j_ll_tav;
clear('j_cs','j_ll')

theta_pos_mask = +(theta_ed_ll > 0);
theta_neg_mask = +(theta_ed_ll < 0);

jth_ed_ll = j_ed_ll.*theta_ed_ll;
thth_ed_ll = theta_ed_ll.*theta_ed_ll;

jth_ll_tneg = jth_ed_ll.*theta_neg_mask;
jth_ll_tpos = jth_ed_ll.*theta_pos_mask;
thth_ll_tneg = thth_ed_ll.*theta_neg_mask;
thth_ll_tpos = thth_ed_ll.*theta_pos_mask;

dcoeff_ll_n = squeeze(mean(jth_ll_tneg,1)./mean(thth_ll_tneg,1));
dcoeff_ll_p = squeeze(mean(jth_ll_tpos,1)./mean(thth_ll_tpos,1));

jth_ll_n = squeeze(mean(jth_ll_tneg,1));
jth_ll_p = squeeze(mean(jth_ll_tpos,1));
thth_ll_n = squeeze(mean(thth_ll_tneg,1));
thth_ll_p = squeeze(mean(thth_ll_tpos,1));

%take pressure average
dcoeff_ll_n_pav = squeeze(mean(dcoeff_ll_n(:,1:tlev(xn),:),2));
dcoeff_ll_p_pav = squeeze(mean(dcoeff_ll_p(:,1:tlev(xn),:),2));
jth_ll_n_pav = squeeze(mean(jth_ll_n(:,1:tlev(xn),:),2));
jth_ll_p_pav = squeeze(mean(jth_ll_p(:,1:tlev(xn),:),2));
thth_ll_n_pav = squeeze(mean(thth_ll_n(:,1:tlev(xn),:),2));
thth_ll_p_pav = squeeze(mean(thth_ll_p(:,1:tlev(xn),:),2));


%take time average
dcoeff_n_tzav = repmat(mean(dcoeff_ll_n_pav,2),[1,719]);
dcoeff_p_tzav = repmat(mean(dcoeff_ll_p_pav,2),[1,719]);
jth_n_tzav = repmat(mean(jth_ll_n_pav,2),[1,719]);
jth_p_tzav = repmat(mean(jth_ll_p_pav,2),[1,719]);
thth_n_tzav = repmat(mean(thth_ll_n_pav,2),[1,719]);
thth_p_tzav = repmat(mean(thth_ll_p_pav,2),[1,719]);


dcoeff_n_var = mean( (dcoeff_ll_n_pav - dcoeff_n_tzav).^2 ,2 );
dcoeff_p_var = mean( (dcoeff_ll_p_pav - dcoeff_p_tzav).^2 ,2 );
jth_n_var = mean( (jth_ll_n_pav - jth_n_tzav).^2 ,2 );
jth_p_var = mean( (jth_ll_p_pav - jth_p_tzav).^2 ,2 );
thth_n_var = mean( (thth_ll_n_pav - thth_n_tzav).^2 ,2 );
thth_p_var = mean( (thth_ll_p_pav - thth_p_tzav).^2 ,2 );

dcoeff_n = (dcoeff_n_tzav(xn,1) + dcoeff_n_tzav(xs,2))./2;
dcoeff_p = (dcoeff_p_tzav(xn,1) + dcoeff_p_tzav(xs,2))./2;
jth_n = (jth_n_tzav(xn,1) + jth_n_tzav(xs,2))./2;
jth_p = (jth_p_tzav(xn,1) + jth_p_tzav(xs,2))./2;
thth_n = (thth_n_tzav(xn,1) + thth_n_tzav(xs,2))./2;
thth_p = (thth_p_tzav(xn,1) + thth_p_tzav(xs,2))./2;

dcoeff_n(:,2) = sqrt( (dcoeff_n_var(xn,1) + dcoeff_n_var(xs,1))./2 )./sqrt(1438) ; 
dcoeff_p(:,2) = sqrt( (dcoeff_p_var(xn,1) + dcoeff_p_var(xs,1))./2 )./sqrt(1438) ; 
jth_n(:,2) = sqrt( (jth_n_var(xn,1) + jth_n_var(xs,1))./2 )./sqrt(1438) ; 
jth_p(:,2) = sqrt( (jth_p_var(xn,1) + jth_p_var(xs,1))./2 )./sqrt(1438) ; 
thth_n(:,2) = sqrt( (thth_n_var(xn,1) + thth_n_var(xs,1))./2 )./sqrt(1438) ; 
thth_p(:,2) = sqrt( (thth_p_var(xn,1) + thth_p_var(xs,1))./2 )./sqrt(1438) ; 



