%for a given heating field and run calculate:
%<j'th'>
%<th.^2>
%<j'th'>/<th.^2>

function [dcoeff_p, dcoeff_n, jth_ed_p, jth_ed_n, th_var_p, th_var_n] = damping_coeff_blayer_fun(run, var)


rDir='/project/rg312/final_runs/run_100_final/';
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


%load boundary layer height and storm track lats
x_var_n = ['x' run 'n'];
x_var_s = ['x' run 's'];
blev_var = ['b_lev_' run];


xvals = load('/project/rg312/mat_files/vt_lats_final.mat',x_var_n,x_var_s);
xn = xvals.(x_var_n);
xs = xvals.(x_var_s);

blev = load('/project/rg312/mat_files/blayer_levs_final.mat',blev_var);
blev = blev.(blev_var);

%ditto j
j_mean = [var '_' run '_timemean.mat'];
j_tavname = [var '_ll_tav'];
jvarload = load(['/project/rg312/mat_files/snapshot_data_final/run_' run '/' j_mean]);
j_ll_tav = jvarload.(j_tavname);
j_ll_tav_lats(:,1,:,:) = repmat(j_ll_tav(:,xn,:),[1 1 1 360]).*86400;
j_ll_tav_lats(:,2,:,:) = repmat(j_ll_tav(:,xs,:),[1 1 1 360]).*86400;
clear('j_ll_tav')

%MISTAKE IN LOADING DATA SO HTRT AVS FOR 000 NS RUN ARE IN 000 FOLDER
%define directory
dir = run;
if run == '000'
dir = '000_ns';
end


%load theta time mean and take at storm track lat
load(['/project/rg312/mat_files/snapshot_data_final/run_' dir '/t_' run '_timemean.mat']);
convthetatoT=(rC/100000.0).^(2./7.);
for k=1:size(rC)
theta_ll_tav(:,:,k,:)=t_ll_tav(:,:,k,:)./convthetatoT(k,1);
end
theta_ll_tav_lats(:,1,:,:) = repmat(theta_ll_tav(:,xn,:),[1 1 1 360]);
theta_ll_tav_lats(:,2,:,:) = repmat(theta_ll_tav(:,xs,:),[1 1 1 360]);
clear('theta_ll_tav')



theta_var = ['theta_' run];
j_var = [var '_' run];

%loop over 10 years data

for year = 1:10
year 

theta_cs = load(['/project/rg312/mat_files/snapshot_data_final/run_' dir '/theta_' run '_' num2str(year) '.mat'],theta_var);
theta_cs = theta_cs.(theta_var);
theta_ll = squeeze(cube2latlon(xc,yc,theta_cs,xi,yi));
theta_ed(:,1,:,:) = theta_ll(:,xn,:,:) - theta_ll_tav_lats(:,1,:,:);
theta_ed(:,2,:,:) = theta_ll(:,xs,:,:) - theta_ll_tav_lats(:,2,:,:);
clear('theta_cs','theta_ll')

j_cs = load(['/project/rg312/mat_files/snapshot_data_final/run_' dir '/' var '_' run '_' num2str(year)],j_var);
j_cs = j_cs.(j_var);
j_ll = squeeze(cube2latlon(xc,yc,j_cs,xi,yi)).*86400;
j_ed(:,1,:,:) = j_ll(:,xn,:,:) - j_ll_tav_lats(:,1,:,:);
j_ed(:,2,:,:) = j_ll(:,xs,:,:) - j_ll_tav_lats(:,2,:,:);
clear('j_cs','j_ll')

theta_pos_mask = +(theta_ed > 0);
theta_neg_mask = +(theta_ed < 0);

%calculate jth and thth products
jth_ed = j_ed.*theta_ed;
thth_ed = theta_ed.*theta_ed;

jth_ed_tneg = jth_ed.*theta_neg_mask;
jth_ed_tpos = jth_ed.*theta_pos_mask;
thth_ed_tneg = thth_ed.*theta_neg_mask;
thth_ed_tpos = thth_ed.*theta_pos_mask;

%take mean around latitude circle
dcoeff_ll_n = squeeze(mean(jth_ed_tneg,1)./mean(thth_ed_tneg,1));
dcoeff_ll_p = squeeze(mean(jth_ed_tpos,1)./mean(thth_ed_tpos,1));

jth_ed_n = squeeze(mean(jth_ed_tneg,1));
jth_ed_p = squeeze(mean(jth_ed_tpos,1));
thth_ed_n = squeeze(mean(thth_ed_tneg,1));
thth_ed_p = squeeze(mean(thth_ed_tpos,1));

%take pressure average
dcoeff_ll_n_pav(:,:,year) = squeeze(nanmean(dcoeff_ll_n(:,1:blev(xn),:),2));
dcoeff_ll_p_pav(:,:,year) = squeeze(nanmean(dcoeff_ll_p(:,1:blev(xn),:),2));
jth_ed_n_pav(:,:,year) = squeeze(mean(jth_ed_n(:,1:blev(xn),:),2));
jth_ed_p_pav(:,:,year) = squeeze(mean(jth_ed_p(:,1:blev(xn),:),2));
thth_ed_n_pav(:,:,year) = squeeze(mean(thth_ed_n(:,1:blev(xn),:),2));
thth_ed_p_pav(:,:,year) = squeeze(mean(thth_ed_p(:,1:blev(xn),:),2));

end

%take time average
dcoeff_n_tzav = repmat(mean(mean(mean(dcoeff_ll_n_pav))),[2,360,10]);
dcoeff_p_tzav = repmat(mean(mean(mean(dcoeff_ll_p_pav))),[2,360,10]);
jth_ed_n_tzav = repmat(mean(mean(mean(jth_ed_n_pav))),[2,360,10]);
jth_ed_p_tzav = repmat(mean(mean(mean(jth_ed_p_pav))),[2,360,10]);
thth_ed_n_tzav = repmat(mean(mean(mean(thth_ed_n_pav))),[2,360,10]);
thth_ed_p_tzav = repmat(mean(mean(mean(thth_ed_p_pav))),[2,360,10]);


dcoeff_n_var = mean(mean(mean((dcoeff_ll_n_pav - dcoeff_n_tzav).^2 )));
dcoeff_p_var = mean(mean(mean((dcoeff_ll_p_pav - dcoeff_p_tzav).^2 )));
jth_ed_n_var = mean(mean(mean((jth_ed_n_pav - jth_ed_n_tzav).^2 )));
jth_ed_p_var = mean(mean(mean((jth_ed_p_pav - jth_ed_p_tzav).^2 )));
thth_ed_n_var = mean(mean(mean((thth_ed_n_pav - thth_ed_n_tzav).^2 )));
thth_ed_p_var = mean(mean(mean((thth_ed_p_pav - thth_ed_p_tzav).^2 )));

dcoeff_n(:,1) = dcoeff_n_tzav(1,1,1);
dcoeff_p(:,1) = dcoeff_p_tzav(1,1,1);
jth_ed_n(:,1) = jth_ed_n_tzav(1,1,1);
jth_ed_p(:,1) = jth_ed_p_tzav(1,1,1);
th_var_n(:,1) = thth_ed_n_tzav(1,1,1);
th_var_p(:,1) = thth_ed_p_tzav(1,1,1);

dcoeff_n(:,2) = sqrt( dcoeff_n_var )./sqrt(360.*2.*10) ; 
dcoeff_p(:,2) = sqrt( dcoeff_p_var )./sqrt(360.*2.*10) ; 
jth_ed_n(:,2) = sqrt( jth_ed_n_var )./sqrt(360.*2.*10) ; 
jth_ed_p(:,2) = sqrt( jth_ed_p_var )./sqrt(360.*2.*10) ; 
th_var_n(:,2) = sqrt( thth_ed_n_var )./sqrt(360.*2.*10) ; 
th_var_p(:,2) = sqrt( thth_ed_p_var )./sqrt(360.*2.*10) ; 


save(['/project/rg312/mat_files/snapshot_data_final/damping_coeffs_blayer_' run '_' var '.mat'],'dcoeff_n','dcoeff_p','jth_ed_n','jth_ed_p','th_var_n','th_var_p')
