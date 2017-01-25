%load and save average boundary layer heights using blayer_offline

rDir='/project/rg312/final_runs/run_000_final/';
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
xi=-179:2:180;
yi=-89:2:90;


blayer_lev_000 = blayer_offline('000');
blayer_lev_010 = blayer_offline('010');
blayer_lev_025 = blayer_offline('025');
blayer_lev_050 = blayer_offline('050');
blayer_lev_075 = blayer_offline('075');
blayer_lev_100 = blayer_offline('100');


blayer_lev_000_ll = cube2latlon(xc,yc,blayer_lev_000,xi,yi);
blayer_lev_010_ll = cube2latlon(xc,yc,blayer_lev_010,xi,yi);
blayer_lev_025_ll = cube2latlon(xc,yc,blayer_lev_025,xi,yi);
blayer_lev_050_ll = cube2latlon(xc,yc,blayer_lev_050,xi,yi);
blayer_lev_075_ll = cube2latlon(xc,yc,blayer_lev_075,xi,yi);
blayer_lev_100_ll = cube2latlon(xc,yc,blayer_lev_100,xi,yi);

save('/project/rg312/mat_files/blayer_offline.mat')
