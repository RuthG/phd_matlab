%for a given heating field and run calculate:
%<j'th'>
%<th.^2>
%<j'th'>/<th.^2>

rDir='/project/rg312/final_runs/run_100_rad_on/';
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


load('/project/rg312/mat_files/vt_lats_final.mat','x100n','x100s');
xn = x100n;
xs = x100s;

load('/project/rg312/mat_files/blayer_levs_final.mat','b_lev_100');


load('/project/rg312/mat_files/snapshot_data_final/run_100_ro/theta_100_ro_1.mat','theta_100');
theta_ll = squeeze(cube2latlon(xc,yc,theta_100,xi,yi));
theta_ll_tav = repmat(mean(theta_ll,4),[1 1 1 360]);
theta_ed_ll = theta_ll(:,:,:,1:360) - theta_ll_tav;
clear('theta_cs','theta_ll')

load('/project/rg312/mat_files/snapshot_data_final/run_100_ro/radht_100_1.mat','radht_100');
radht_ll = squeeze(cube2latlon(xc,yc,radht_100,xi,yi)).*86400;
radht_ll_tav = repmat(mean(radht_ll,4),[1 1 1 360]);
radht_ed_ll = radht_ll(:,:,:,1:360) - radht_ll_tav;
clear('radht_cs','radht_ll')

theta_pos_mask = +(theta_ed_ll > 0);
theta_neg_mask = +(theta_ed_ll < 0);

radhtth_ed_ll = radht_ed_ll.*theta_ed_ll;
thth_ed_ll = theta_ed_ll.*theta_ed_ll;

radhtth_ll_tneg = radhtth_ed_ll.*theta_neg_mask;
radhtth_ll_tpos = radhtth_ed_ll.*theta_pos_mask;
thth_ll_tneg = thth_ed_ll.*theta_neg_mask;
thth_ll_tpos = thth_ed_ll.*theta_pos_mask;

dcoeff_ll_n = squeeze(mean(radhtth_ll_tneg,1)./mean(thth_ll_tneg,1));
dcoeff_ll_p = squeeze(mean(radhtth_ll_tpos,1)./mean(thth_ll_tpos,1));

radhtth_ll_n = squeeze(mean(radhtth_ll_tneg,1));
radhtth_ll_p = squeeze(mean(radhtth_ll_tpos,1));
thth_ll_n = squeeze(mean(thth_ll_tneg,1));
thth_ll_p = squeeze(mean(thth_ll_tpos,1));

%take pressure average
dcoeff_ll_n_pav = squeeze(mean(dcoeff_ll_n(:,1:b_lev_100(xn),:),2));
dcoeff_ll_p_pav = squeeze(mean(dcoeff_ll_p(:,1:b_lev_100(xn),:),2));
radhtth_ll_n_pav = squeeze(mean(radhtth_ll_n(:,1:b_lev_100(xn),:),2));
radhtth_ll_p_pav = squeeze(mean(radhtth_ll_p(:,1:b_lev_100(xn),:),2));
thth_ll_n_pav = squeeze(mean(thth_ll_n(:,1:b_lev_100(xn),:),2));
thth_ll_p_pav = squeeze(mean(thth_ll_p(:,1:b_lev_100(xn),:),2));


%take time average
dcoeff_n_tzav = repmat(mean(dcoeff_ll_n_pav,2),[1,360]);
dcoeff_p_tzav = repmat(mean(dcoeff_ll_p_pav,2),[1,360]);
radhtth_n_tzav = repmat(mean(radhtth_ll_n_pav,2),[1,360]);
radhtth_p_tzav = repmat(mean(radhtth_ll_p_pav,2),[1,360]);
thth_n_tzav = repmat(mean(thth_ll_n_pav,2),[1,360]);
thth_p_tzav = repmat(mean(thth_ll_p_pav,2),[1,360]);


dcoeff_n_var = mean( (dcoeff_ll_n_pav - dcoeff_n_tzav).^2 ,2 );
dcoeff_p_var = mean( (dcoeff_ll_p_pav - dcoeff_p_tzav).^2 ,2 );
radhtth_n_var = mean( (radhtth_ll_n_pav - radhtth_n_tzav).^2 ,2 );
radhtth_p_var = mean( (radhtth_ll_p_pav - radhtth_p_tzav).^2 ,2 );
thth_n_var = mean( (thth_ll_n_pav - thth_n_tzav).^2 ,2 );
thth_p_var = mean( (thth_ll_p_pav - thth_p_tzav).^2 ,2 );

dcoeff_n = (dcoeff_n_tzav(xn,1) + dcoeff_n_tzav(xs,2))./2;
dcoeff_p = (dcoeff_p_tzav(xn,1) + dcoeff_p_tzav(xs,2))./2;
radhtth_n = (radhtth_n_tzav(xn,1) + radhtth_n_tzav(xs,2))./2;
radhtth_p = (radhtth_p_tzav(xn,1) + radhtth_p_tzav(xs,2))./2;
thth_n = (thth_n_tzav(xn,1) + thth_n_tzav(xs,2))./2;
thth_p = (thth_p_tzav(xn,1) + thth_p_tzav(xs,2))./2;

dcoeff_n(:,2) = sqrt( (dcoeff_n_var(xn,1) + dcoeff_n_var(xs,1))./2 )./sqrt(720) ; 
dcoeff_p(:,2) = sqrt( (dcoeff_p_var(xn,1) + dcoeff_p_var(xs,1))./2 )./sqrt(720) ; 
radhtth_n(:,2) = sqrt( (radhtth_n_var(xn,1) + radhtth_n_var(xs,1))./2 )./sqrt(720) ; 
radhtth_p(:,2) = sqrt( (radhtth_p_var(xn,1) + radhtth_p_var(xs,1))./2 )./sqrt(720) ; 
thth_n(:,2) = sqrt( (thth_n_var(xn,1) + thth_n_var(xs,1))./2 )./sqrt(720) ; 
thth_p(:,2) = sqrt( (thth_p_var(xn,1) + thth_p_var(xs,1))./2 )./sqrt(720) ; 



