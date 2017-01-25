
function t_hist_data = t_hist_fun(run,year,lev)

rDir='/project/rg312/final_runs/run_000_final_noshallow/';
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

%load heat rates
t_var = ['t_' run];
x_var_n = ['x' run 'n'];
x_var_s = ['x' run 's'];
xvals = load('/project/rg312/mat_files/vt_lats_final.mat',x_var_n,x_var_s);
xn = xvals.(x_var_n);
xs = xvals.(x_var_s);

dir = run;
if run == '000'
dir = '000_ns';
end

t_cs = load(['/net/spat-nas/project/rg312/mat_files/snapshot_data_final/run_' dir '/t_' run '_' num2str(year) '.mat'],t_var);
t_cs = t_cs.(t_var);
t_ll = cube2latlon(xc,yc,t_cs,xi,yi);
clear('t_cs')
load(['/net/spat-nas/project/rg312/mat_files/snapshot_data_final/run_' dir '/t_' run '_timemean.mat']);
t_ed = t_ll - repmat(t_ll_tav,[1 1 1 360]);
clear('t_ll')

t_hist_in(:,1,:) = t_ed(:,xn,lev,:);
t_hist_in(:,2,:) = t_ed(:,xs,lev,:);

%for i=1:90
%include lat weighting too

xbins = -40:0.2:40;

t_hist_data  = hist(reshape(t_hist_in,[numel(t_hist_in),1]),xbins);
%t_ed_counts_cos(i,:) = t_ed_counts.*cos(yi(i).*pi./180);

%end






