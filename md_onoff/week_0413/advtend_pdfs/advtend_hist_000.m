

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

%load up 000 snapshots and calculate eddy quantities

load('/project/rg312/mat_files/heat_rates_best.mat','htrt_000')
htrt_000_ll = squeeze(cube2latlon(xc,yc,htrt_000(:,:,5,1:719),xi,yi)).*86400;
htrt_000_ll_tav = repmat(mean(htrt_000_ll,3),[1 1 719]);
htrt_ed_000_ll = htrt_000_ll - htrt_000_ll_tav;
clear('htrt_000')

load('/project/rg312/mat_files/totttend_000_best.mat','totttend_snap_000')
totttend_000_ll = squeeze(cube2latlon(xc,yc,totttend_snap_000(:,:,5,1:719),xi,yi));
totttend_000_ll_tav = repmat(mean(totttend_000_ll,3),[1 1 719]);
totttend_ed_000_ll = totttend_000_ll - totttend_000_ll_tav;
clear('totttend_000')

advtend_ed_000_ll = totttend_ed_000_ll -  htrt_ed_000_ll;

for i=1:90
%include lat weighting too
i
xbins = -45:0.2:45;

advtend_ed_000_counts = hist(reshape(advtend_ed_000_ll,[numel(advtend_ed_000_ll),1]),xbins);
advtend_ed_000_counts_cos(i,:) = advtend_ed_000_counts.*cos(yi(i).*pi./180);

totttend_ed_000_counts = hist(reshape(totttend_ed_000_ll,[numel(totttend_ed_000_ll),1]),xbins);
totttend_ed_000_counts_cos(i,:) = totttend_ed_000_counts.*cos(yi(i).*pi./180);

end

advtend_hist = sum(advtend_ed_000_counts_cos,1)./sum(sum(advtend_ed_000_counts_cos));
totttend_hist = sum(totttend_ed_000_counts_cos,1)./sum(sum(totttend_ed_000_counts_cos));


save('/project/rg312/mat_files/tottend_advtend_hists_000.mat')

