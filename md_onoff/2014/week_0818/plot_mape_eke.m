load('mape_out.mat')
load('eke_out.mat')



%# centimeters units
X = 20.0;                  %# A4 paper size
Y = 11.0;                  %# A4 paper size
xMargin = 1;               %# left/right margins from page borders
yMargin = 1;               %# bottom/top margins from page borders
xSize = X - 1*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 1*yMargin;     %# figure size on paper (widht & hieght)

hFig = figure; %('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


plot(mape_out_d,eke_out_d,'ko','MarkerSize',10)% ,'MarkerFaceColor',[0 0 0])
hold on
plot(mape_out_q,eke_out_q,'kd','MarkerSize',10)% ,'MarkerFaceColor',[0 0 0])
plot(mape_out_h,eke_out_h,'ks','MarkerSize',10)% ,'MarkerFaceColor',[0 0 0])
plot(mape_out_w,eke_out_w,'k^','MarkerSize',10)% ,'MarkerFaceColor',[0 0 0])
xlabel('Mean Available Potential Energy, Jm^{-2}','FontSize',12)
ylabel('Eddy Kinetic Energy, Jm^{-2}','FontSize',12)
legend('0xwv', '0.25xwv', '0.5xwv', '1xwv') %,'Location','NorthWest')
print('-dpdf','ekemape.pdf')

%print('-dpng','ekemape.png')
