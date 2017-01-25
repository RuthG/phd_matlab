load('mape_wv_off_rad_off_run_5year_c.mat')
mape_dry = mape_out;
load('mape_wv_on_rad_off_run_5year_c.mat')
mape_wet = mape_out;
load('mape_wv_on_rad_off_run_halfwv.mat')
mape_half = mape_out;
load('mape_wv_on_rad_off_run_quarterwv.mat')
mape_qtr = mape_out;
load('mape_wv_on_rad_off_run_halfwv_tropheat3eq.mat')
mape_trph = mape_out;

load('eke_wv_off_rad_off_run_5year_c.mat')
eke_dry = eke_out;
load('eke_wv_on_rad_off_run_5year_c.mat')
eke_wet = eke_out;
load('eke_wv_on_rad_off_run_halfwv.mat')
eke_half = eke_out;
load('eke_wv_on_rad_off_run_quarterwv.mat')
eke_qtr = eke_out;
load('eke_wv_on_rad_off_run_halfwv_tropheat3eq.mat')
eke_trph = eke_out;



%# centimeters units
X = 20.0;                  %# A4 paper size
Y = 11.0;                  %# A4 paper size
xMargin = 1;               %# left/right margins from page borders
yMargin = 1;               %# bottom/top margins from page borders
xSize = X - 1*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 1*yMargin;     %# figure size on paper (widht & hieght)

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


plot(mape_dry,eke_dry,'ko','MarkerSize',10)% ,'MarkerFaceColor',[0 0 0])
hold on
plot(mape_qtr,eke_qtr,'kd','MarkerSize',10)% ,'MarkerFaceColor',[0 0 0])
plot(mape_half,eke_half,'ks','MarkerSize',10)% ,'MarkerFaceColor',[0 0 0])
plot(mape_wet,eke_wet,'k^','MarkerSize',10)% ,'MarkerFaceColor',[0 0 0])
plot(mape_trph,eke_trph,'k+','MarkerSize',10)% ,'MarkerFaceColor',[0 0 0])
xlabel('Mean Available Potential Energy, Jm^{-2}','FontSize',12)
ylabel('Eddy Kinetic Energy, Jm^{-2}','FontSize',12)
legend('0xwv', '0.25xwv', '0.5xwv', '1xwv', 'tropheat')
print('-dpdf','ekemape.pdf')

%print('-dpng','ekemape.png')
