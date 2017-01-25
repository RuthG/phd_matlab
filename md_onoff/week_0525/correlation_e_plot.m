%plot correlation w height at x_000 lat to give contour plot


[vt_corr_000,vt_ed_000,t_sd_000,vN_sd_000] = vt_corr_fun_warm('vN_000','t_000');
'000'
[vt_corr_010,vt_ed_010,t_sd_010,vN_sd_010] = vt_corr_fun_warm('vN_010','t_010');
'010'
[vt_corr_025,vt_ed_025,t_sd_025,vN_sd_025] = vt_corr_fun_warm('vN_025','t_025');
'025'
[vt_corr_050,vt_ed_050,t_sd_050,vN_sd_050] = vt_corr_fun_warm('vN_050','t_050');
'050'
[vt_corr_075,vt_ed_075,t_sd_075,vN_sd_075] = vt_corr_fun_warm('vN_075','t_075');
'075'
[vt_corr_100,vt_ed_100,t_sd_100,vN_sd_100] = vt_corr_fun_warm('vN_100','t_100');
'100'

save('/project/rg312/mat_files/vt_corr_vals_warm.mat');



[vt_corr_000,vt_ed_000,t_sd_000,vN_sd_000] = vt_corr_fun_cold('vN_000','t_000');
'000'
[vt_corr_010,vt_ed_010,t_sd_010,vN_sd_010] = vt_corr_fun_cold('vN_010','t_010');
'010'
[vt_corr_025,vt_ed_025,t_sd_025,vN_sd_025] = vt_corr_fun_cold('vN_025','t_025');
'025'
[vt_corr_050,vt_ed_050,t_sd_050,vN_sd_050] = vt_corr_fun_cold('vN_050','t_050');
'050'
[vt_corr_075,vt_ed_075,t_sd_075,vN_sd_075] = vt_corr_fun_cold('vN_075','t_075');
'075'
[vt_corr_100,vt_ed_100,t_sd_100,vN_sd_100] = vt_corr_fun_cold('vN_100','t_100');
'100'

save('/project/rg312/mat_files/vt_corr_vals_cold.mat');

return

[vt_corr_000,vt_ed_000,t_sd_000,vN_sd_000] = vt_corr_fun('vN_000','t_000');
'000'
[vt_corr_010,vt_ed_010,t_sd_010,vN_sd_010] = vt_corr_fun('vN_010','t_010');
'010'
[vt_corr_025,vt_ed_025,t_sd_025,vN_sd_025] = vt_corr_fun('vN_025','t_025');
'025'
[vt_corr_050,vt_ed_050,t_sd_050,vN_sd_050] = vt_corr_fun('vN_050','t_050');
'050'
[vt_corr_075,vt_ed_075,t_sd_075,vN_sd_075] = vt_corr_fun('vN_075','t_075');
'075'
[vt_corr_100,vt_ed_100,t_sd_100,vN_sd_100] = vt_corr_fun('vN_100','t_100');
'100'

save('/project/rg312/mat_files/vt_corr_vals.mat');

load('/project/rg312/mat_files/vt_lats_best.mat');

vt_corr(:,1) = vt_corr_000(x000n,:);
vt_corr(:,2) = vt_corr_010(x010n,:);
vt_corr(:,3) = vt_corr_025(x025n,:);
vt_corr(:,4) = vt_corr_050(x050n,:);
vt_corr(:,5) = vt_corr_075(x075n,:);
vt_corr(:,6) = vt_corr_100(x100n,:);

rC=980:-40:20;
es0 = [0,0.1,0.25,0.5,0.75,1]

[C,h] = contourf(es0,rC,vt_corr);
colorbar
v=0:0.1:1;
caxis([0 1])
set(gca,'YDir','reverse');
xlabel('Saturation vapour pressure fraction')
ylabel('Pressure, hPa')
print('-dpng','vt_corr_es0.png')

