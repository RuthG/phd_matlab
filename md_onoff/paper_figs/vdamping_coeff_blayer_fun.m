%for a given heating field and run calculate:
%<j'th'>
%<th.^2>
%<j'th'>/<th.^2>

function [dcoeff_p, dcoeff_n, vNdvNdt_ed_p, vNdvNdt_ed_n, vN_var_p, vN_var_n] = vdamping_coeff_blayer_fun(run)


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

%define directory
dir = run;
if run == '000'
dir = '000_ns';
end

%load dvdt time mean and take at storm track lat
load(['/project/rg312/mat_files/snapshot_data_final/run_' dir '/dvNdt_' run '_timemean.mat']);
dvNdt_ll_tav_lats(:,1,:,:) = repmat(dvNdt_ll_tav(:,xn,:),[1 1 1 360]).*86400;
dvNdt_ll_tav_lats(:,2,:,:) = repmat(dvNdt_ll_tav(:,xs,:),[1 1 1 360]).*86400;
clear('dvNdt_ll_tav')

%load v time mean and take at storm track lat
load(['/project/rg312/mat_files/snapshot_data_final/run_' dir '/vN_' run '_timemean.mat']);
vN_ll_tav_lats(:,1,:,:) = repmat(vN_ll_tav(:,xn,:),[1 1 1 360]);
vN_ll_tav_lats(:,2,:,:) = repmat(vN_ll_tav(:,xs,:),[1 1 1 360]);
clear('vN_ll_tav')

%load t time mean and take at storm track lat
load(['/project/rg312/mat_files/snapshot_data_final/run_' dir '/t_' run '_timemean.mat']);
t_ll_tav_lats(:,1,:,:) = repmat(t_ll_tav(:,xn,:),[1 1 1 360]);
t_ll_tav_lats(:,2,:,:) = repmat(t_ll_tav(:,xs,:),[1 1 1 360]);
clear('t_ll_tav')

t_var = ['t_' run];
vN_var = ['vN_' run];
dvNdt_var = ['dvNdt_' run];

%loop over 10 years data

for year = 1:10
year 

t_cs = load(['/project/rg312/mat_files/snapshot_data_final/run_' dir '/t_' run '_' num2str(year) '.mat'],t_var);
t_cs = t_cs.(t_var);
t_ll = squeeze(cube2latlon(xc,yc,t_cs,xi,yi));
t_ed(:,1,:,:) = t_ll(:,xn,:,:) - t_ll_tav_lats(:,1,:,:);
t_ed(:,2,:,:) = t_ll(:,xs,:,:) - t_ll_tav_lats(:,2,:,:);
clear('t_cs','t_ll')

vN_cs = load(['/project/rg312/mat_files/snapshot_data_final/run_' dir '/vN_' run '_' num2str(year) '.mat'],vN_var);
vN_cs = vN_cs.(vN_var);
vN_ll = squeeze(cube2latlon(xc,yc,vN_cs,xi,yi));
vN_ed(:,1,:,:) = vN_ll(:,xn,:,:) - vN_ll_tav_lats(:,1,:,:);
vN_ed(:,2,:,:) = vN_ll(:,xs,:,:) - vN_ll_tav_lats(:,2,:,:);
clear('vN_cs','vN_ll')

dvNdt_cs = load(['/project/rg312/mat_files/snapshot_data_final/run_' dir '/dvNdt_' run '_' num2str(year)],dvNdt_var);
dvNdt_cs = dvNdt_cs.(dvNdt_var);
dvNdt_ll = squeeze(cube2latlon(xc,yc,dvNdt_cs,xi,yi)).*86400;
dvNdt_ed(:,1,:,:) = dvNdt_ll(:,xn,:,:) - dvNdt_ll_tav_lats(:,1,:,:);
dvNdt_ed(:,2,:,:) = dvNdt_ll(:,xs,:,:) - dvNdt_ll_tav_lats(:,2,:,:);
clear('dvNdt_cs','dvNdt_ll')

t_pos_mask = +(t_ed > 0);
t_neg_mask = +(t_ed < 0);

%calculate jth and thth products
vNdvNdt_ed = dvNdt_ed.*vN_ed;
vNvN_ed = vN_ed.*vN_ed;

vNdvNdt_ed_tneg = vNdvNdt_ed.*t_neg_mask;
vNdvNdt_ed_tpos = vNdvNdt_ed.*t_pos_mask;
vNvN_ed_tneg = vNvN_ed.*t_neg_mask;
vNvN_ed_tpos = vNvN_ed.*t_pos_mask;

%take mean around latitude circle
dcoeff_ll_n = squeeze(mean(vNdvNdt_ed_tneg,1)./mean(vNvN_ed_tneg,1));
dcoeff_ll_p = squeeze(mean(vNdvNdt_ed_tpos,1)./mean(vNvN_ed_tpos,1));

vNdvNdt_ed_n = squeeze(mean(vNdvNdt_ed_tneg,1));
vNdvNdt_ed_p = squeeze(mean(vNdvNdt_ed_tpos,1));
vNvN_ed_n = squeeze(mean(vNvN_ed_tneg,1));
vNvN_ed_p = squeeze(mean(vNvN_ed_tpos,1));

%take pressure average
dcoeff_ll_n_pav(:,:,year) = squeeze(nanmean(dcoeff_ll_n(:,1:blev(xn),:),2));
dcoeff_ll_p_pav(:,:,year) = squeeze(nanmean(dcoeff_ll_p(:,1:blev(xn),:),2));
vNdvNdt_ed_n_pav(:,:,year) = squeeze(mean(vNdvNdt_ed_n(:,1:blev(xn),:),2));
vNdvNdt_ed_p_pav(:,:,year) = squeeze(mean(vNdvNdt_ed_p(:,1:blev(xn),:),2));
vNvN_ed_n_pav(:,:,year) = squeeze(mean(vNvN_ed_n(:,1:blev(xn),:),2));
vNvN_ed_p_pav(:,:,year) = squeeze(mean(vNvN_ed_p(:,1:blev(xn),:),2));

end

%take time average
dcoeff_n_tzav = repmat(mean(mean(mean(dcoeff_ll_n_pav))),[2,360,10]);
dcoeff_p_tzav = repmat(mean(mean(mean(dcoeff_ll_p_pav))),[2,360,10]);
vNdvNdt_ed_n_tzav = repmat(mean(mean(mean(vNdvNdt_ed_n_pav))),[2,360,10]);
vNdvNdt_ed_p_tzav = repmat(mean(mean(mean(vNdvNdt_ed_p_pav))),[2,360,10]);
vNvN_ed_n_tzav = repmat(mean(mean(mean(vNvN_ed_n_pav))),[2,360,10]);
vNvN_ed_p_tzav = repmat(mean(mean(mean(vNvN_ed_p_pav))),[2,360,10]);


dcoeff_n_var = mean(mean(mean((dcoeff_ll_n_pav - dcoeff_n_tzav).^2 )));
dcoeff_p_var = mean(mean(mean((dcoeff_ll_p_pav - dcoeff_p_tzav).^2 )));
vNdvNdt_ed_n_var = mean(mean(mean((vNdvNdt_ed_n_pav - vNdvNdt_ed_n_tzav).^2 )));
vNdvNdt_ed_p_var = mean(mean(mean((vNdvNdt_ed_p_pav - vNdvNdt_ed_p_tzav).^2 )));
vNvN_ed_n_var = mean(mean(mean((vNvN_ed_n_pav - vNvN_ed_n_tzav).^2 )));
vNvN_ed_p_var = mean(mean(mean((vNvN_ed_p_pav - vNvN_ed_p_tzav).^2 )));

dcoeff_n(:,1) = dcoeff_n_tzav(1,1,1);
dcoeff_p(:,1) = dcoeff_p_tzav(1,1,1);
vNdvNdt_ed_n(:,1) = vNdvNdt_ed_n_tzav(1,1,1);
vNdvNdt_ed_p(:,1) = vNdvNdt_ed_p_tzav(1,1,1);
vN_var_n(:,1) = vNvN_ed_n_tzav(1,1,1);
vN_var_p(:,1) = vNvN_ed_p_tzav(1,1,1);

dcoeff_n(:,2) = sqrt( dcoeff_n_var )./sqrt(360.*2.*10) ; 
dcoeff_p(:,2) = sqrt( dcoeff_p_var )./sqrt(360.*2.*10) ; 
vNdvNdt_ed_n(:,2) = sqrt( vNdvNdt_ed_n_var )./sqrt(360.*2.*10) ; 
vNdvNdt_ed_p(:,2) = sqrt( vNdvNdt_ed_p_var )./sqrt(360.*2.*10) ; 
vN_var_n(:,2) = sqrt( vNvN_ed_n_var )./sqrt(360.*2.*10) ; 
vN_var_p(:,2) = sqrt( vNvN_ed_p_var )./sqrt(360.*2.*10) ; 


save(['/project/rg312/mat_files/snapshot_data_final/vdamping_coeffs_blayer_' run '.mat'],'dcoeff_n','dcoeff_p','vNdvNdt_ed_n','vNdvNdt_ed_p','vN_var_n','vN_var_p')
