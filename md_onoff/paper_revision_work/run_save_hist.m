xbins_t = -40:0.2:40;
xbins_v = -70:0.5:70;

for i=1:10
    i
    t_hist_000_5(:,i) = t_hist_fun('000',i,5);
    t_hist_100_5(:,i) = t_hist_fun('100',i,5);
    v_hist_000_5(:,i) = v_hist_fun('000',i,5);
    v_hist_100_5(:,i) = v_hist_fun('100',i,5);
end

t_hist_000_5_norm = sum(t_hist_000_5,2)./sum(sum(t_hist_000_5));
t_hist_100_5_norm = sum(t_hist_100_5,2)./sum(sum(t_hist_100_5));

v_hist_000_5_norm = sum(v_hist_000_5,2)./sum(sum(v_hist_000_5));
v_hist_100_5_norm = sum(v_hist_100_5,2)./sum(sum(v_hist_100_5));

save('/project/rg312/mat_files/snapshot_data_final/tv_histograms_290416.mat')
