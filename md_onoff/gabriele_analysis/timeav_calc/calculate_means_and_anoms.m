load('/project/rg312/gabriele/H_ll.mat')

H_ll_860_n_mean = mean(H_ll_860_n,3);
H_ed_860_n = H_ll_860_n - repmat(H_ll_860_n_mean,[1 1 3600]);
H_ll_860_s_mean = mean(H_ll_860_s,3);
H_ed_860_s = H_ll_860_s - repmat(H_ll_860_s_mean,[1 1 3600]);
H_ll_300_n_mean = mean(H_ll_300_n,3);
H_ed_300_n = H_ll_300_n - repmat(H_ll_300_n_mean,[1 1 3600]);
H_ll_300_s_mean = mean(H_ll_300_s,3);
H_ed_300_s = H_ll_300_s - repmat(H_ll_300_s_mean,[1 1 3600]);

load('/project/rg312/gabriele/vN_ll.mat')

vN_ll_860_n_mean = mean(vN_ll_860_n,3);
vN_ed_860_n = vN_ll_860_n - repmat(vN_ll_860_n_mean,[1 1 3600]);
vN_ll_860_s_mean = mean(vN_ll_860_s,3);
vN_ed_860_s = vN_ll_860_s - repmat(vN_ll_860_s_mean,[1 1 3600]);
vN_ll_300_n_mean = mean(vN_ll_300_n,3);
vN_ed_300_n = vN_ll_300_n - repmat(vN_ll_300_n_mean,[1 1 3600]);
vN_ll_300_s_mean = mean(vN_ll_300_s,3);
vN_ed_300_s = vN_ll_300_s - repmat(vN_ll_300_s_mean,[1 1 3600]);

save('/project/rg312/gabriele/vN_H_ed.mat', 'H_ll_860_s_mean', 'H_ll_860_n_mean', 'H_ll_300_s_mean', 'H_ll_300_n_mean', 'vN_ll_860_s_mean', 'vN_ll_860_n_mean', 'vN_ll_300_s_mean', 'vN_ll_300_n_mean', 'H_ed_860_n', 'H_ed_860_s', 'H_ed_300_n', 'H_ed_300_s', 'vN_ed_860_n', 'vN_ed_860_s', 'vN_ed_300_n', 'vN_ed_300_s')