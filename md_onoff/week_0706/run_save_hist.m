xbins_t = -40:0.2:40;
xbins_v = -70:0.5:70;

for i=1:10
i

t_hist_000_3(:,i) = t_hist_fun('000',i,3);
t_hist_100_3(:,i) = t_hist_fun('100',i,3);

t_hist_000_5(:,i) = t_hist_fun('000',i,5);
t_hist_100_5(:,i) = t_hist_fun('100',i,5);

t_hist_000_10(:,i) = t_hist_fun('000',i,10);
t_hist_100_10(:,i) = t_hist_fun('100',i,10);

v_hist_000_3(:,i) = v_hist_fun('000',i,3);
v_hist_100_3(:,i) = v_hist_fun('100',i,3);

v_hist_000_5(:,i) = v_hist_fun('000',i,5);
v_hist_100_5(:,i) = v_hist_fun('100',i,5);

v_hist_000_10(:,i) = v_hist_fun('000',i,10);
v_hist_100_10(:,i) = v_hist_fun('100',i,10);

end


t_hist_000_3_norm = sum(t_hist_000_3,2)./sum(sum(t_hist_000_3));
t_hist_100_3_norm = sum(t_hist_100_3,2)./sum(sum(t_hist_100_3));

t_hist_000_5_norm = sum(t_hist_000_5,2)./sum(sum(t_hist_000_5));
t_hist_100_5_norm = sum(t_hist_100_5,2)./sum(sum(t_hist_100_5));

t_hist_000_10_norm = sum(t_hist_000_10,2)./sum(sum(t_hist_000_10));
t_hist_100_10_norm = sum(t_hist_100_10,2)./sum(sum(t_hist_100_10));

v_hist_000_3_norm = sum(v_hist_000_3,2)./sum(sum(v_hist_000_3));
v_hist_100_3_norm = sum(v_hist_100_3,2)./sum(sum(v_hist_100_3));

v_hist_000_5_norm = sum(v_hist_000_5,2)./sum(sum(v_hist_000_5));
v_hist_100_5_norm = sum(v_hist_100_5,2)./sum(sum(v_hist_100_5));

v_hist_000_10_norm = sum(v_hist_000_10,2)./sum(sum(v_hist_000_10));
v_hist_100_10_norm = sum(v_hist_100_10,2)./sum(sum(v_hist_100_10));

save('/project/rg312/mat_files/snapshot_data_final/tv_histograms.mat')
