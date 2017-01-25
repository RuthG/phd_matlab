%load in v'T' and check correlation for each run; does increase come from mag or from correlation?

rDir='/project/rg312/wv_on_rad_off/run_000_best/';
rC=squeeze(rdmds([rDir,'RC']));
yi = -89:2:89;
xi = -179:2:179;

vt_corr_000 = vt_corr_fun('vN_000','t_000');
vt_corr_010 = vt_corr_fun('vN_010','t_010');
vt_corr_025 = vt_corr_fun('vN_025','t_025');
vt_corr_050 = vt_corr_fun('vN_050','t_050');
vt_corr_075 = vt_corr_fun('vN_075','t_075');
vt_corr_100 = vt_corr_fun('vN_100','t_100');

plot(yi,vt_corr_000)
hold on
plot(yi,vt_corr_010,'y')
plot(yi,vt_corr_025,'m')
plot(yi,vt_corr_050,'g')
plot(yi,vt_corr_075,'c')
plot(yi,vt_corr_100,'r')
set(gca,'FontSize',15)
legend('0','0.1','0.25','0.5','0.75','1','FontSize',15)
xlabel('Latitude','FontSize',15)
ylabel('Correlation coefficient for v'' and t''','FontSize',15)
print('-dpng','vt_correlation.png')


return