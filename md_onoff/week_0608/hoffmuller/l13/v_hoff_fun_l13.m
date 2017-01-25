%load up v snapshots, take eddy part at max v'T lat, make hoffmuller pic

function vhoff = v_hoff_fun_l13(run)


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


vN_var = ['vN_' run];
x_var_n = ['x' run 'n'];
x_var_s = ['x' run 's'];
xvals = load('/project/rg312/mat_files/vt_lats_best.mat',x_var_n,x_var_s);
xn = xvals.(x_var_n);
xs = xvals.(x_var_s);

vN_cs = load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat',vN_var);
vN_cs = vN_cs.(vN_var);
vN_ll = squeeze(cube2latlon(xc,yc,vN_cs,xi,yi));
vN_ll_tav = repmat(mean(vN_ll,4),[1 1 1 720]);
vN_ed_ll = vN_ll - vN_ll_tav;
clear('vN_cs','vN_ll','vN_ll_tav')


vhoff = squeeze(vN_ed_ll(:,xn,13,:));


