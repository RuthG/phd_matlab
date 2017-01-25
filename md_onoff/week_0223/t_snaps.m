%take a quick look at progressive movement of t anoms over a few days, what might order of local dTdt be


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
xi = -179:2:179;


load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat','t_000')

t_000_ll(:,:,:,1:10) = cube2latlon(xc,yc,t_000(:,:,:,356:365),xi,yi);
t_000_ll_tav = cube2latlon(xc,yc,mean(t_000,4),xi,yi);
for i=1:10
t_ed_000_ll(:,:,:,i) = t_000_ll(:,:,:,i) - t_000_ll_tav;
end
