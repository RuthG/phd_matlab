%load up U data and find peak of wind speed

rDir='/project/rg312/final_runs/run_000_final_noshallow/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xi=-179:2:179;
yi=-89:2:89;


for i=1:10
	i
	load(['/project/rg312/mat_files/snapshot_data_final/run_100_ro/uE_100_ro_' num2str(i) '.mat'])
	uE_mean(:,:,:,i) = mean(uE_100,4);
end

uE_mean = mean(uE_mean,4);

uE_ll= cube2latlon(xc,yc,uE_mean,xi,yi);
uE_zav = squeeze(mean(uE_ll,1));

[a,b]=max(mean(uE_zav(46:90,:),2));
y = yi(b+45)

[a,b]=max(uE_zav(46:90,4));
y860 = yi(b+45)

[a,b]=max(uE_zav(46:90,18));
y300 = yi(b+45)

%values: 47, 49,23