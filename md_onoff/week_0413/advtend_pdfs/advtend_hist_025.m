

rDir='/project/rg312/wv_on_rad_off/run_025_best/';
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

%load up 000 snapshots and calculate eddy quantities

load('/project/rg312/mat_files/heat_rates_best.mat','htrt_025')
htrt_025_ll = squeeze(cube2latlon(xc,yc,htrt_025(:,:,5,1:719),xi,yi)).*86400;
htrt_025_ll_tav = repmat(mean(htrt_025_ll,3),[1 1 719]);
htrt_ed_025_ll = htrt_025_ll - htrt_025_ll_tav;
clear('htrt_025')

load('/project/rg312/mat_files/totttend_025_best.mat','totttend_snap_025')
totttend_025_ll = squeeze(cube2latlon(xc,yc,totttend_snap_025(:,:,5,1:719),xi,yi));
totttend_025_ll_tav = repmat(mean(totttend_025_ll,3),[1 1 719]);
totttend_ed_025_ll = totttend_025_ll - totttend_025_ll_tav;
clear('totttend_025')

advtend_ed_025_ll = totttend_ed_025_ll -  htrt_ed_025_ll;

for i=1:90
%include lat weighting too
i
xbins = -45:0.2:45;

advtend_ed_025_counts = hist(reshape(advtend_ed_025_ll,[numel(advtend_ed_025_ll),1]),xbins);
advtend_ed_025_counts_cos(i,:) = advtend_ed_025_counts.*cos(yi(i).*pi./180);

totttend_ed_025_counts = hist(reshape(totttend_ed_025_ll,[numel(totttend_ed_025_ll),1]),xbins);
totttend_ed_025_counts_cos(i,:) = totttend_ed_025_counts.*cos(yi(i).*pi./180);

end

advtend_hist = sum(advtend_ed_025_counts_cos,1)./sum(sum(advtend_ed_025_counts_cos));
totttend_hist = sum(totttend_ed_025_counts_cos,1)./sum(sum(totttend_ed_025_counts_cos));


save('/project/rg312/mat_files/tottend_advtend_hists_025.mat')


