%use snapshot data to locate strongest vt peaks

%loads data
%regrids
%calculates eddy heat flux
%saves eddy fluxes
%finds the distribution of w'T' and plots this
%cumulative sums over this and finds 95 percentile
%defines threshold, finds peaks over this threshold that are more prominent that half the threshold
%saves threshold and peaks

%load data
load('/project/rg312/mat_files/vt_lats.mat')
load('/project/rg312/mat_files/snapshot_data/w_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat')
'data loaded'

rDir='/project/rg312/wv_on_rad_off/run_doshallower00/';
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

%transfer to lat lon grid
xi=-179:2:180;yi=-89:2:90;
w_000_ll = cube2latlon(xc,yc,w_000,xi,yi);
w_010_ll = cube2latlon(xc,yc,w_010,xi,yi);
w_025_ll = cube2latlon(xc,yc,w_025,xi,yi);
w_050_ll = cube2latlon(xc,yc,w_050,xi,yi);
w_075_ll = cube2latlon(xc,yc,w_075,xi,yi);
w_100_ll = cube2latlon(xc,yc,w_100,xi,yi);
t_000_ll = cube2latlon(xc,yc,t_000,xi,yi);
t_010_ll = cube2latlon(xc,yc,t_010,xi,yi);
t_025_ll = cube2latlon(xc,yc,t_025,xi,yi);
t_050_ll = cube2latlon(xc,yc,t_050,xi,yi);
t_075_ll = cube2latlon(xc,yc,t_075,xi,yi);
t_100_ll = cube2latlon(xc,yc,t_100,xi,yi);
'll done'
clear('w_000','w_010','w_025','w_050','w_075','w_100','t_000','t_010','t_025','t_050','t_075','t_100')

%take time average
w_000_tav = mean(w_000_ll,4);
w_010_tav = mean(w_010_ll,4);
w_025_tav = mean(w_025_ll,4);
w_050_tav = mean(w_050_ll,4);
w_075_tav = mean(w_075_ll,4);
w_100_tav = mean(w_100_ll,4);
t_000_tav = mean(t_000_ll,4);
t_010_tav = mean(t_010_ll,4);
t_025_tav = mean(t_025_ll,4);
t_050_tav = mean(t_050_ll,4);
t_075_tav = mean(t_075_ll,4);
t_100_tav = mean(t_100_ll,4);
'tavs done'


%calculate (w-[w])(t-[t]) to get transient eddy heat transport 
for i=1:720

wt_ed_000n(:,:,:,i) = squeeze((w_000_ll(:,x000n-7:x000n+7,:,i) - w_000_tav(:,x000n-7:x000n+7,:)) .* (t_000_ll(:,x000n-7:x000n+7,:,i) - t_000_tav(:,x000n-7:x000n+7,:)));
wt_ed_010n(:,:,:,i) = squeeze((w_010_ll(:,x010n-7:x010n+7,:,i) - w_010_tav(:,x010n-7:x010n+7,:)) .* (t_010_ll(:,x010n-7:x010n+7,:,i) - t_010_tav(:,x010n-7:x010n+7,:)));
wt_ed_025n(:,:,:,i) = squeeze((w_025_ll(:,x025n-7:x025n+7,:,i) - w_025_tav(:,x025n-7:x025n+7,:)) .* (t_025_ll(:,x025n-7:x025n+7,:,i) - t_025_tav(:,x025n-7:x025n+7,:)));
wt_ed_050n(:,:,:,i) = squeeze((w_050_ll(:,x050n-7:x050n+7,:,i) - w_050_tav(:,x050n-7:x050n+7,:)) .* (t_050_ll(:,x050n-7:x050n+7,:,i) - t_050_tav(:,x050n-7:x050n+7,:)));
wt_ed_075n(:,:,:,i) = squeeze((w_075_ll(:,x075n-7:x075n+7,:,i) - w_075_tav(:,x075n-7:x075n+7,:)) .* (t_075_ll(:,x075n-7:x075n+7,:,i) - t_075_tav(:,x075n-7:x075n+7,:)));
wt_ed_100n(:,:,:,i) = squeeze((w_100_ll(:,x100n-7:x100n+7,:,i) - w_100_tav(:,x100n-7:x100n+7,:)) .* (t_100_ll(:,x100n-7:x100n+7,:,i) - t_100_tav(:,x100n-7:x100n+7,:)));

wt_ed_000s(:,:,:,i) = squeeze((w_000_ll(:,x000s-7:x000s+7,:,i) - w_000_tav(:,x000s-7:x000s+7,:)) .* (t_000_ll(:,x000s-7:x000s+7,:,i) - t_000_tav(:,x000s-7:x000s+7,:)));
wt_ed_010s(:,:,:,i) = squeeze((w_010_ll(:,x010s-7:x010s+7,:,i) - w_010_tav(:,x010s-7:x010s+7,:)) .* (t_010_ll(:,x010s-7:x010s+7,:,i) - t_010_tav(:,x010s-7:x010s+7,:)));
wt_ed_025s(:,:,:,i) = squeeze((w_025_ll(:,x025s-7:x025s+7,:,i) - w_025_tav(:,x025s-7:x025s+7,:)) .* (t_025_ll(:,x025s-7:x025s+7,:,i) - t_025_tav(:,x025s-7:x025s+7,:)));
wt_ed_050s(:,:,:,i) = squeeze((w_050_ll(:,x050s-7:x050s+7,:,i) - w_050_tav(:,x050s-7:x050s+7,:)) .* (t_050_ll(:,x050s-7:x050s+7,:,i) - t_050_tav(:,x050s-7:x050s+7,:)));
wt_ed_075s(:,:,:,i) = squeeze((w_075_ll(:,x075s-7:x075s+7,:,i) - w_075_tav(:,x075s-7:x075s+7,:)) .* (t_075_ll(:,x075s-7:x075s+7,:,i) - t_075_tav(:,x075s-7:x075s+7,:)));
wt_ed_100s(:,:,:,i) = squeeze((w_100_ll(:,x100s-7:x100s+7,:,i) - w_100_tav(:,x100s-7:x100s+7,:)) .* (t_100_ll(:,x100s-7:x100s+7,:,i) - t_100_tav(:,x100s-7:x100s+7,:)));

end
'eddies done'
clear('w_000_ll','w_010_ll','w_025_ll','w_050_ll','w_075_ll','w_100_ll','t_000_ll','t_010_ll','t_025_ll','t_050_ll','t_075_ll','t_100_ll')


save('/project/rg312/mat_files/snapshot_data/wt_ed_data.mat','wt_ed_000n','wt_ed_010n','wt_ed_025n','wt_ed_050n','wt_ed_075n','wt_ed_100n'...
,'wt_ed_000s','wt_ed_010s','wt_ed_025s','wt_ed_050s','wt_ed_075s','wt_ed_100s')

