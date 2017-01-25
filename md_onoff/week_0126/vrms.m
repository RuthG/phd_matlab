%load in eke and see how vrms changes with height

load('/project/rg312/mat_files/eke_loaded.mat')


vrms_000 = sqrt(eke_000_zav);
vrms_010 = sqrt(eke_010_zav);
vrms_025 = sqrt(eke_025_zav);
vrms_050 = sqrt(eke_050_zav);
vrms_075 = sqrt(eke_075_zav);
vrms_100 = sqrt(eke_100_zav);
vrms_th = sqrt(eke_th_zav);


vrms_000_pav = mean(vrms_000,2);
vrms_010_pav = mean(vrms_010,2);
vrms_025_pav = mean(vrms_025,2);
vrms_050_pav = mean(vrms_050,2);
vrms_075_pav = mean(vrms_075,2);
vrms_100_pav = mean(vrms_100,2);
vrms_th_pav = mean(vrms_th,2);


for i= 1:25

vrms_000_diff(:,i) = vrms_000(:,i) - vrms_000_pav;
vrms_010_diff(:,i) = vrms_010(:,i) - vrms_010_pav;
vrms_025_diff(:,i) = vrms_025(:,i) - vrms_025_pav;
vrms_050_diff(:,i) = vrms_050(:,i) - vrms_050_pav;
vrms_075_diff(:,i) = vrms_075(:,i) - vrms_075_pav;
vrms_100_diff(:,i) = vrms_100(:,i) - vrms_100_pav;
vrms_th_diff(:,i) = vrms_th(:,i) - vrms_th_pav;

end

vrms_000_pdev = sqrt(mean(vrms_000_diff.^2,2));
vrms_010_pdev = sqrt(mean(vrms_010_diff.^2,2));
vrms_025_pdev = sqrt(mean(vrms_025_diff.^2,2));
vrms_050_pdev = sqrt(mean(vrms_050_diff.^2,2));
vrms_075_pdev = sqrt(mean(vrms_075_diff.^2,2));
vrms_100_pdev = sqrt(mean(vrms_100_diff.^2,2));
vrms_th_pdev = sqrt(mean(vrms_th_diff.^2,2));
