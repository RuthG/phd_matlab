function [advt_hist,tott_hist,htrt_hist] = advtend_hist_fun(run,lev)

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

%load up snapshots and calculate eddy quantities
x_var_n = ['x' run 'n'];
x_var_s = ['x' run 's'];
htrt_var = ['htrt_' run];
totttend_var = ['totttend_snap_' run];

xvals = load('/project/rg312/mat_files/vt_lats_final.mat',x_var_n,x_var_s);
xn = xvals.(x_var_n);
xs = xvals.(x_var_s);

load('/project/rg312/mat_files/heat_rates_best.mat',htrt_var);
htrt_cs = load('/project/rg312/mat_files/heat_rates_best.mat',htrt_var);
htrt_cs = htrt_cs.(htrt_var);
htrt_ll = squeeze(cube2latlon(xc,yc,htrt_cs(:,:,lev,1:719),xi,yi)).*86400;
htrt_ll_tav = repmat(mean(htrt_ll,3),[1 1 719]);
htrt_ed_ll = htrt_ll - htrt_ll_tav;
clear('htrt_cs')

tott_cs = load(['/project/rg312/mat_files/totttend_' run '_best.mat'],totttend_var);
tott_cs = tott_cs.(totttend_var);
tott_ll = squeeze(cube2latlon(xc,yc,tott_cs(:,:,lev,1:719),xi,yi));
tott_ll_tav = repmat(mean(tott_ll,3),[1 1 719]);
tott_ed_ll = tott_ll - tott_ll_tav;
clear('tott_cs')

advt_ed_ll = tott_ed_ll -  htrt_ed_ll;

%for i=1:90
%include lat weighting too
%i
xbins = -45:0.2:45;

advt_ed_counts(1,:) = hist(reshape(advt_ed_ll(:,xn,:),[numel(advt_ed_ll(:,xn,:)),1]),xbins);
advt_ed_counts(2,:) = hist(reshape(advt_ed_ll(:,xs,:),[numel(advt_ed_ll(:,xs,:)),1]),xbins);
%advt_ed_counts_cos(i,:) = advt_ed_counts.*cos(yi(i).*pi./180);

tott_ed_counts(1,:) = hist(reshape(tott_ed_ll(:,xn,:),[numel(tott_ed_ll(:,xn,:)),1]),xbins);
tott_ed_counts(2,:) = hist(reshape(tott_ed_ll(:,xs,:),[numel(tott_ed_ll(:,xs,:)),1]),xbins);
%tott_ed_counts_cos(i,:) = tott_ed_counts.*cos(yi(i).*pi./180);

htrt_ed_counts(1,:) = hist(reshape(htrt_ed_ll(:,xn,:),[numel(htrt_ed_ll(:,xn,:)),1]),xbins);
htrt_ed_counts(2,:) = hist(reshape(htrt_ed_ll(:,xs,:),[numel(htrt_ed_ll(:,xs,:)),1]),xbins);
%htrt_ed_counts_cos(i,:) = htrt_ed_counts.*cos(yi(i).*pi./180);

%end

advt_hist = sum(advt_ed_counts,1)./sum(sum(advt_ed_counts));
tott_hist = sum(tott_ed_counts,1)./sum(sum(tott_ed_counts));
htrt_hist = sum(htrt_ed_counts,1)./sum(sum(htrt_ed_counts));

save(['/project/rg312/mat_files/advt_tott_' run '_' num2str(lev) '.mat'])


