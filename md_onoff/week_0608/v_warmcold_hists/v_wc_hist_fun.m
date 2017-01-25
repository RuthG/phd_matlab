%plot histogram of v' associated with the warm sector for a given run

function [vN_hist_warm,vN_hist_cold] = v_wc_hist_fun(run,lev)


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
yi = -89:2:89;
xi = -179:2:179;


t_var = ['t_' run];
t_cs = load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat',t_var);
t_cs = t_cs.(t_var);
t_ll = squeeze(cube2latlon(xc,yc,t_cs(:,:,lev,1:720),xi,yi));
clear('t_cs')
t_ll_tav = repmat(mean(t_ll,3),[1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_ll','t_ll_tav')

vN_var = ['vN_' run];
vN_cs = load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat',vN_var);
vN_cs = vN_cs.(vN_var);
vN_ll = squeeze(cube2latlon(xc,yc,vN_cs(:,:,lev,1:720),xi,yi));
clear('vN_cs')
vN_ll_tav = repmat(mean(vN_ll,3),[1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_ll','vN_ll_tav')
vN_ed_ll(:,1:45,:) = -vN_ed_ll(:,1:45,:);

%create mask so we only look at positive T' 
t_mask_pos = +(t_ed_ll > 0 );
t_mask_neg = +(t_ed_ll < 0 );

vN_ed_pos = vN_ed_ll.*t_mask_pos;
vN_ed_neg = vN_ed_ll.*t_mask_neg;


xbins=-70:0.5:70;

for i=1:90
%include lat weighting too
i;

%select lat to look at for masked plots, and empty out 0 (i.e. masked) elements
vN_ed_pos_in = vN_ed_pos(:,i,:);
vN_ed_pos_in(vN_ed_pos_in == 0) =[];

vN_ed_pos_counts = hist(reshape(vN_ed_pos_in,[numel(vN_ed_pos_in),1]),xbins);
vN_ed_pos_counts_cos(i,:) = vN_ed_pos_counts.*cos(yi(i).*pi./180);


vN_ed_neg_in = vN_ed_neg(:,i,:);
vN_ed_neg_in(vN_ed_neg_in == 0) =[];

vN_ed_neg_counts = hist(reshape(vN_ed_neg_in,[numel(vN_ed_neg_in),1]),xbins);
vN_ed_neg_counts_cos(i,:) = vN_ed_neg_counts.*cos(yi(i).*pi./180);

end


vN_hist_warm = sum(vN_ed_pos_counts_cos,1)./sum(sum(vN_ed_pos_counts_cos));
vN_hist_cold = sum(vN_ed_neg_counts_cos,1)./sum(sum(vN_ed_neg_counts_cos));




