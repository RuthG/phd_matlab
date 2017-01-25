%for each run, load in w_snapshots and transform to ll grid
%at each latitude calculate the no of ascending and descending cells, and take the ratio
%average over time to get a lat plot of this for each run

% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_doshallower10/';
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

load('/project/rg312/mat_files/snapshot_data/w_snapshots.mat')

%transfer w to ll
xi=-179:2:180;yi=-89:2:90;
w_000_ll = cube2latlon(xc,yc,w_000,xi,yi);
w_010_ll = cube2latlon(xc,yc,w_010,xi,yi);
w_025_ll = cube2latlon(xc,yc,w_025,xi,yi);
w_050_ll = cube2latlon(xc,yc,w_050,xi,yi);
w_075_ll = cube2latlon(xc,yc,w_075,xi,yi);
w_100_ll = cube2latlon(xc,yc,w_100,xi,yi);

clear('w_000','w_010','w_025','w_050','w_075','w_100')

for i=1:90
ratio_000(i) = sum(sum( (w_000_ll(:,i,4,:) > 0))) ./ sum(sum(w_000_ll(:,i,4,:) < 0));
ratio_010(i) = sum(sum( (w_010_ll(:,i,4,:) > 0))) ./ sum(sum(w_010_ll(:,i,4,:) < 0));
ratio_025(i) = sum(sum( (w_025_ll(:,i,4,:) > 0))) ./ sum(sum(w_025_ll(:,i,4,:) < 0));
ratio_050(i) = sum(sum( (w_050_ll(:,i,4,:) > 0))) ./ sum(sum(w_050_ll(:,i,4,:) < 0));
ratio_075(i) = sum(sum( (w_075_ll(:,i,4,:) > 0))) ./ sum(sum(w_075_ll(:,i,4,:) < 0));
ratio_100(i) = sum(sum( (w_100_ll(:,i,4,:) > 0))) ./ sum(sum(w_100_ll(:,i,4,:) < 0));
end
