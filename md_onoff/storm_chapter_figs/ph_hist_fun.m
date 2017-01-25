%load data to plot geopot histograms

function [ph_hist_full, ph_hist_midlats] = ph_hist_fun(run)

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
drC=squeeze(rdmds([rDir,'DRC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
xi=-179:2:179;
yi=-89:2:89;

ph_var = ['ph_adj_' strtrim(run)];
x_var_n = ['x' strtrim(run) 'n'];
x_var_s = ['x' strtrim(run) 's'];

xn = load('/project/rg312/mat_files/vt_lats_final.mat',x_var_n);
xn = xn.(x_var_n);
xs = load('/project/rg312/mat_files/vt_lats_final.mat',x_var_s);
xs = xs.(x_var_s);

if run == '000'
    dir = ['run_000_ns/ph_adj_000'];
else
    dir = ['run_' strtrim(run) '/ph_adj_' strtrim(run)];
end

for j = 1:10
    j

    ph_cs = load(['/project/rg312/mat_files/snapshot_data_final/' dir '_' num2str(j) '.mat']);
    ph_adj = ph_cs.(ph_var);
    load(['/project/rg312/mat_files/snapshot_data_final/' dir '_timemean.mat']);

    ph_ed = zeros(180,90,360);

    for i=1:360
        ph_ed(:,:,i) = cube2latlon(xc,yc,ph_adj(:,:,8,i),xi,yi) - ph_adj_ll_tav(:,:,8);
    end

    xbins = -400:4:400;

    for i=1:90
        ph_ed_counts = hist(reshape(ph_ed(:,i,:)./9.8,[numel(ph_ed(:,i,:)),1]),xbins);
        ph_ed_counts_cos(i,:) = ph_ed_counts.*cos(yi(i).*pi./180);
    end

    ph_hist_full(:,j) = sum(ph_ed_counts_cos,1);
    ph_hist_midlats(:,j) = sum(ph_ed_counts_cos(xn-7:xn+7,:),1) + sum(ph_ed_counts_cos(xs-7:xs+7,:),1);

end


ph_hist_full = sum(ph_hist_full,2)./sum(sum(ph_hist_full));
ph_hist_midlats = sum(ph_hist_midlats,2)./sum(sum(ph_hist_midlats));


