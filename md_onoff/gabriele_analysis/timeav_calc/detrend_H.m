%load in H anomalies and detrend

load('/project/rg312/gabriele/vN_H_ed.mat')

t=1:3600;

coeff_h860n = zeros(180,30,2);
coeff_h860s = zeros(180,30,2);
coeff_h300n = zeros(180,30,2);
coeff_h300s = zeros(180,30,2);
coeff_v860n = zeros(180,30,2);
coeff_v860s = zeros(180,30,2);
coeff_v300n = zeros(180,30,2);
coeff_v300s = zeros(180,30,2);

for i=1:180
i
for j=1:30

a = polyfit(t, squeeze(H_ed_860_n(i,j,:))', 1 );
coeff_h860n(i,j,:) = a;

a = polyfit(t, squeeze(H_ed_860_s(i,j,:))', 1 );
coeff_h860s(i,j,:) = a;

a = polyfit(t, squeeze(H_ed_300_n(i,j,:))', 1 );
coeff_h300n(i,j,:) = a;

a = polyfit(t, squeeze(H_ed_300_s(i,j,:))', 1 );
coeff_h300s(i,j,:) = a;


a = polyfit(t, squeeze(vN_ed_860_n(i,j,:))', 1 );
coeff_v860n(i,j,:) = a;

a = polyfit(t, squeeze(vN_ed_860_s(i,j,:))', 1 );
coeff_v860s(i,j,:) = a;

a = polyfit(t, squeeze(vN_ed_300_n(i,j,:))', 1 );
coeff_v300n(i,j,:) = a;

a = polyfit(t, squeeze(vN_ed_300_s(i,j,:))', 1 );
coeff_v300s(i,j,:) = a;

end
end

save('/project/rg312/gabriele/detrend_coeffs.mat', 'coeff_h860n', 'coeff_h860s', 'coeff_h300n', 'coeff_h300s', 'coeff_v860n', 'coeff_v860s', 'coeff_v300n', 'coeff_v300s')


for i=1:180
i
for j=1:30

h860n_lin(i,j,:) = polyval(squeeze(coeff_h860n(i,j,:)), t);
h860s_lin(i,j,:) = polyval(squeeze(coeff_h860s(i,j,:)), t);
h300n_lin(i,j,:) = polyval(squeeze(coeff_h300n(i,j,:)), t);
h300s_lin(i,j,:) = polyval(squeeze(coeff_h300s(i,j,:)), t);

v860n_lin(i,j,:) = polyval(squeeze(coeff_v860n(i,j,:)), t);
v860s_lin(i,j,:) = polyval(squeeze(coeff_v860s(i,j,:)), t);
v300n_lin(i,j,:) = polyval(squeeze(coeff_v300n(i,j,:)), t);
v300s_lin(i,j,:) = polyval(squeeze(coeff_v300s(i,j,:)), t);

end
end

H_ed_860_n_dt = H_ed_860_n - h860n_lin + repmat(mean(h860n_lin,3),[1,1,3600]);
H_ed_860_s_dt = H_ed_860_s - h860s_lin + repmat(mean(h860s_lin,3),[1,1,3600]);
H_ed_300_n_dt = H_ed_300_n - h300n_lin + repmat(mean(h300n_lin,3),[1,1,3600]);
H_ed_300_s_dt = H_ed_300_s - h300s_lin + repmat(mean(h300s_lin,3),[1,1,3600]);

vN_ed_860_n_dt = vN_ed_860_n - v860n_lin + repmat(mean(v860n_lin,3),[1,1,3600]);
vN_ed_860_s_dt = vN_ed_860_s - v860s_lin + repmat(mean(v860s_lin,3),[1,1,3600]);
vN_ed_300_n_dt = vN_ed_300_n - v300n_lin + repmat(mean(v300n_lin,3),[1,1,3600]);
vN_ed_300_s_dt = vN_ed_300_s - v300s_lin + repmat(mean(v300s_lin,3),[1,1,3600]);

save('/project/rg312/gabriele/vN_H_ed_detrended.mat', 'H_ed_860_n_dt', 'H_ed_860_s_dt', 'vN_ed_860_n_dt', 'vN_ed_860_s_dt', 'H_ed_300_n_dt', 'H_ed_300_s_dt', 'vN_ed_300_n_dt', 'vN_ed_300_s_dt')

vNH_ed_860n = H_ed_860_n_dt .* vN_ed_860_n_dt;
vNH_ed_860s = H_ed_860_s_dt .* vN_ed_860_s_dt;
vNH_ed_300n = H_ed_300_n_dt .* vN_ed_300_n_dt;
vNH_ed_300s = H_ed_300_s_dt .* vN_ed_300_s_dt;

save('/project/rg312/gabriele/vNH_ed.mat', 'vNH_ed_860n', 'vNH_ed_860s', 'vNH_ed_300n', 'vNH_ed_300s')
