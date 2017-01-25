%load in w composite data and calculate standard deviation for each point to get idea of signal:noise

load('/project/rg312/mat_files/composite_data_tlag/vt_compdata_100.mat')

comp_data_mean = nanmean(comp_data,3);
weight_fn = sum(1-isnan(comp_data),3);


for i=1:max(size(comp_data))

comp_diffsq(:,:,i) = (comp_data(:,:,i) - comp_data_mean).^2;

end

comp_var = nanmean(comp_diffsq,3);

comp_std = sqrt(comp_var);


