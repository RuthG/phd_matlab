%look at spread of values in the w composites and try to see if composite is significant.

load('/project/rg312/mat_files/w_composites.mat')

for i=1:size(w_sec_000,3)
w_000_vardiff(:,:,i) = (w_sec_000(:,:,i) - w_comp_000).^2;
end

w_000_var = mean(w_000_vardiff,3);

for i=1:size(w_sec_010,3)
w_010_vardiff(:,:,i) = (w_sec_010(:,:,i) - w_comp_010).^2;
end

w_010_var = mean(w_010_vardiff,3);

for i=1:size(w_sec_025,3)
w_025_vardiff(:,:,i) = (w_sec_025(:,:,i) - w_comp_025).^2;
end

w_025_var = mean(w_025_vardiff,3);

for i=1:size(w_sec_050,3)
w_050_vardiff(:,:,i) = (w_sec_050(:,:,i) - w_comp_050).^2;
end

w_050_var = mean(w_050_vardiff,3);

for i=1:size(w_sec_075,3)
w_075_vardiff(:,:,i) = (w_sec_075(:,:,i) - w_comp_075).^2;
end

w_075_var = mean(w_075_vardiff,3);

for i=1:size(w_sec_100,3)
w_100_vardiff(:,:,i) = (w_sec_100(:,:,i) - w_comp_100).^2;
end

w_100_var = mean(w_100_vardiff,3);
