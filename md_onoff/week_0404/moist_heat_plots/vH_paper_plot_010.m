%take pressure, time and zonal average v't'  for each run
%also calculate average associated with cold sector only


cpd = 1005;
L = 2.5e6;

% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_010_best/';
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

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat','vN_010')
load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_010')
load('/project/rg312/mat_files/snapshot_data/q_snapshots_best.mat','q_010')


t_ll = squeeze(cube2latlon(xc,yc,t_010,xi,yi));
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_010','t_ll','t_ll_tav')

q_ll = squeeze(cube2latlon(xc,yc,q_010,xi,yi));
q_ll_tav = repmat(mean(q_ll,4),[1 1 1 720]);
q_ed_ll = q_ll - q_ll_tav;
clear('q_010','q_ll','q_ll_tav')

vN_ll = squeeze(cube2latlon(xc,yc,vN_010,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_010','vN_ll','vN_ll_tav')

vNt_ed_ll = vN_ed_ll.*t_ed_ll;
vNq_ed_ll = vN_ed_ll.*q_ed_ll;

vNH_ed_ll = vNt_ed_ll.*cpd + vNq_ed_ll.*L;

clear('vN_ed_ll')

%take pressure average
vNH_ed_pav = mean(vNH_ed_ll,3);

%calculate the zonal integral of the latitude to look at
%(look at all lats first to check the cos weighting doesn't change our result)

t_ed_mask_neg = +(t_ed_ll < 0);
t_ed_mask_pos = +(t_ed_ll > 0);

vNH_ll_tneg = vNH_ed_ll.*t_ed_mask_neg;
vNH_ll_tpos = vNH_ed_ll.*t_ed_mask_pos;

vNH_ed_pav_tneg = mean(vNH_ll_tneg ,3);
vNH_ed_pav_tpos = mean(vNH_ll_tpos ,3);

for i=1:90

vNH_ed_pzint(i,:) = squeeze(mean(vNH_ed_pav(:,i,:,:),1));
vNH_ed_pzint_tneg(i,:) = squeeze(mean(vNH_ed_pav_tneg(:,i,:,:),1));
vNH_ed_pzint_tpos(i,:) = squeeze(mean(vNH_ed_pav_tpos(:,i,:,:),1));

end

vNH_ed_pzint_tzav = repmat(mean(vNH_ed_pzint,2),[1,720]);
vNH_ed_pzint_tzav_tneg = repmat(mean(vNH_ed_pzint_tneg,2),[1,720]);
vNH_ed_pzint_tzav_tpos = repmat(mean(vNH_ed_pzint_tpos,2),[1,720]);

vNH_ed_pzint_var = mean( (vNH_ed_pzint - vNH_ed_pzint_tzav).^2 ,2 );
vNH_ed_pzint_var_tneg = mean( (vNH_ed_pzint_tneg - vNH_ed_pzint_tzav_tneg).^2 ,2 );
vNH_ed_pzint_var_tpos = mean( (vNH_ed_pzint_tpos - vNH_ed_pzint_tzav_tpos).^2 ,2 );

vNH_ed_pzint_sdev = sqrt(vNH_ed_pzint_var);
vNH_ed_pzint_sdev_tneg = sqrt(vNH_ed_pzint_var_tneg);
vNH_ed_pzint_sdev_tpos = sqrt(vNH_ed_pzint_var_tpos);

save('/project/rg312/mat_files/vH_paper_plot_010.mat', 'vNH_ed_pzint_tzav', 'vNH_ed_pzint_tzav_tneg', 'vNH_ed_pzint_tzav_tpos', 'vNH_ed_pzint_var', 'vNH_ed_pzint_var_tneg', 'vNH_ed_pzint_var_tpos', 'vNH_ed_pzint_sdev', 'vNH_ed_pzint_sdev_tpos', 'vNH_ed_pzint_sdev_tneg' )

return






