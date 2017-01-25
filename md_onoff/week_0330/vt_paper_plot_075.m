%take pressure, time and zonal average v't'  for each run
%also calculate average associated with cold sector only



% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_075_best/';
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
load('/project/rg312/mat_files/vt_lats_best.mat')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_075')
load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_075')

t_ll = squeeze(cube2latlon(xc,yc,t_075,xi,yi));
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_075','t_ll','t_ll_tav')

vN_ll = squeeze(cube2latlon(xc,yc,vN_075,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_075','vN_ll','vN_ll_tav')

vNt_ed_ll = vN_ed_ll.*t_ed_ll;

clear('vN_ed_ll')

%take pressure average
vNt_ed_pav = mean(vNt_ed_ll,3);

%calculate the zonal integral of the latitude to look at
%(look at all lats first to check the cos weighting doesn't change our result)

t_ed_mask_neg = +(t_ed_ll < 0);
t_ed_mask_pos = +(t_ed_ll > 0);

vNt_ll_tneg = vNt_ed_ll.*t_ed_mask_neg;
vNt_ll_tpos = vNt_ed_ll.*t_ed_mask_pos;

vNt_ed_pav_tneg = mean(vNt_ll_tneg ,3);
vNt_ed_pav_tpos = mean(vNt_ll_tpos ,3);

for i=1:90

vNt_ed_pzint(i,:) = squeeze(mean(vNt_ed_pav(:,i,:,:),1));
vNt_ed_pzint_tneg(i,:) = squeeze(mean(vNt_ed_pav_tneg(:,i,:,:),1));
vNt_ed_pzint_tpos(i,:) = squeeze(mean(vNt_ed_pav_tpos(:,i,:,:),1));

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

save('/project/rg312/mat_files/vt_paper_plot_075.mat', 'vNt_ed_pzint_tzav', 'vNt_ed_pzint_tzav_tneg', 'vNt_ed_pzint_tzav_tpos', 'vNt_ed_pzint_var', 'vNt_ed_pzint_var_tneg', 'vNt_ed_pzint_var_tpos', 'vNt_ed_pzint_sdev', 'vNt_ed_pzint_sdev_tpos', 'vNt_ed_pzint_sdev_tneg' )

return






