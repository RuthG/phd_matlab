load('/net/spat-nas/project/rg312/mat_files/tt_paper_plot_data_blayer_final.mat')
tt_ed_b = tt_ed;
tt_ed_cold_b = tt_ed_cold;
tt_ed_warm_b = tt_ed_warm;
tt_ed_serr_b = tt_ed_serr.*sqrt(10);
tt_ed_cold_serr_b = tt_ed_cold_serr.*sqrt(10);
tt_ed_warm_serr_b = tt_ed_warm_serr.*sqrt(10);

load('/net/spat-nas/project/rg312/mat_files/tt_paper_plot_data_freetrop_final.mat')
tt_ed_ft = tt_ed;
tt_ed_cold_ft = tt_ed_cold;
tt_ed_warm_ft = tt_ed_warm;
tt_ed_serr_ft = tt_ed_serr.*sqrt(10);
tt_ed_cold_serr_ft = tt_ed_cold_serr.*sqrt(10);
tt_ed_warm_serr_ft = tt_ed_warm_serr.*sqrt(10);


load('/net/spat-nas/project/rg312/mat_files/vv_paper_plot_data_blayer_final_v.mat')
vv_ed_b = vv_ed;
vv_ed_cold_b = vv_ed_cold;
vv_ed_warm_b = vv_ed_warm;
vv_ed_serr_b = vv_ed_serr.*sqrt(10);
vv_ed_cold_serr_b = vv_ed_cold_serr.*sqrt(10);
vv_ed_warm_serr_b = vv_ed_warm_serr.*sqrt(10);

load('/net/spat-nas/project/rg312/mat_files/vv_paper_plot_data_freetrop_final_v.mat')
vv_ed_ft = vv_ed;
vv_ed_cold_ft = vv_ed_cold;
vv_ed_warm_ft = vv_ed_warm;
vv_ed_serr_ft = vv_ed_serr.*sqrt(10);
vv_ed_cold_serr_ft = vv_ed_cold_serr.*sqrt(10);
vv_ed_warm_serr_ft = vv_ed_warm_serr.*sqrt(10);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 24; %25.0;                  %# A4 paper size
X =  16; %32; % 20;                  %# A4 paper size
yMargin = 0;               %# left/right margins from page borders
xMargin = 0;               %# bottom/top margins from page borders
xSize = X - 2*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 2*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.35 ; %0.35; %0.4;
xSize_sub = 0.8 ; %0.35; %0.7;

pos1x = 0.15 ; 	pos1y = 0.6; 
pos2x = 0.15;	pos2y = 0.15; 


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
%set(hFig, 'PaperOrientation','portrait')




es0 = [0,0.1,0.25,0.5,0.75,1,1.25,1.5];
cp = 287.04./(2./7.);
filles0 = [es0, fliplr(es0)];

fillerrors = [tt_ed_b + 2.*tt_ed_serr_b, fliplr(tt_ed_b - 2.*tt_ed_serr_b)];
fillerrors_warm = [tt_ed_warm_b + 2.*tt_ed_warm_serr_b, fliplr(tt_ed_warm_b - 2.*tt_ed_warm_serr_b)];
fillerrors_cold = [tt_ed_cold_b + 2.*tt_ed_cold_serr_b, fliplr(tt_ed_cold_b - 2.*tt_ed_cold_serr_b)];

axes('position',[pos1x pos1y xSize_sub ySize_sub])
%plot(es0,tt_ed_b,'k--','Linewidth',2);
hold on
plot(es0,tt_ed_warm_b,'r--','Linewidth',2);
plot(es0,tt_ed_cold_b,'b--','Linewidth',2);
%fill(filles0,fillerrors,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_cold,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm,'r','FaceAlpha',0.25)
ylim([0 10])
%hold off
set(gca,'FontSize',15);
xlabel('Reference e_{s0} fraction','FontSize',18)
ylabel('<T''^2>, K^2','FontSize',18)
%legend('Total','+ve T''','-ve T''','Location','northwest')
%print('-dpng','tvar_pbl.png')


fillerrors = [tt_ed_ft + 2.*tt_ed_serr_ft, fliplr(tt_ed_ft - 2.*tt_ed_serr_ft)];
fillerrors_warm = [tt_ed_warm_ft + 2.*tt_ed_warm_serr_ft, fliplr(tt_ed_warm_ft - 2.*tt_ed_warm_serr_ft)];
fillerrors_cold = [tt_ed_cold_ft + 2.*tt_ed_cold_serr_ft, fliplr(tt_ed_cold_ft - 2.*tt_ed_cold_serr_ft)];

%axes('position',[pos1x pos1y xSize_sub ySize_sub])
%plot(es0,tt_ed_ft,'k','Linewidth',2);
hold on
plot(es0,tt_ed_warm_ft,'r','Linewidth',2);
plot(es0,tt_ed_cold_ft,'b','Linewidth',2);
%fill(filles0,fillerrors,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_cold,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm,'r','FaceAlpha',0.25)
ylim([0 10])
hold off
%set(gca,'FontSize',12);
%xlabel('Reference e_{s0} fraction','FontSize',15)
%ylabel('<T''^2>, K^2','FontSize',15)
%legend('Total','+ve T''','-ve T''','Location','northwest')
print('-dpdf','tvar_notot.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
%set(hFig, 'PaperOrientation','portrait')
axes('position',[pos1x pos1y xSize_sub ySize_sub])
%plot(es0,tt_ed_ft,'k','Linewidth',2);
hold on
plot(es0,tt_ed_warm_ft,'r','Linewidth',2);
plot(es0,tt_ed_cold_ft,'b','Linewidth',2);
%fill(filles0,fillerrors,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_cold,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm,'r','FaceAlpha',0.25)
ylim([0 10])
hold off
set(gca,'FontSize',15);
xlabel('Reference e_{s0} fraction','FontSize',18)
ylabel('<T''^2>, K^2','FontSize',18)
%legend('Total','+ve T''','-ve T''','Location','northwest')
print('-dpdf','tvar_ft_notot.pdf')





hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
%set(hFig, 'PaperOrientation','portrait')


fillerrors = [vv_ed_b + 2.*vv_ed_serr_b, fliplr(vv_ed_b - 2.*vv_ed_serr_b)];
fillerrors_warm = [vv_ed_warm_b + 2.*vv_ed_warm_serr_b, fliplr(vv_ed_warm_b - 2.*vv_ed_warm_serr_b)];
fillerrors_cold = [vv_ed_cold_b + 2.*vv_ed_cold_serr_b, fliplr(vv_ed_cold_b - 2.*vv_ed_cold_serr_b)];

axes('position',[pos1x pos1y xSize_sub ySize_sub])
%plot(es0,vv_ed_b,'k--','Linewidth',2);
hold on
plot(es0,vv_ed_warm_b,'r--','Linewidth',2);
plot(es0,vv_ed_cold_b,'b--','Linewidth',2);
%fill(filles0,fillerrors,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_cold,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm,'r','FaceAlpha',0.25)

fillerrors = [vv_ed_ft + 2.*vv_ed_serr_ft, fliplr(vv_ed_ft - 2.*vv_ed_serr_ft)];
fillerrors_warm = [vv_ed_warm_ft + 2.*vv_ed_warm_serr_ft, fliplr(vv_ed_warm_ft - 2.*vv_ed_warm_serr_ft)];
fillerrors_cold = [vv_ed_cold_ft + 2.*vv_ed_cold_serr_ft, fliplr(vv_ed_cold_ft - 2.*vv_ed_cold_serr_ft)];

%plot(es0,vv_ed_ft,'k','Linewidth',2);
plot(es0,vv_ed_warm_ft,'r','Linewidth',2);
plot(es0,vv_ed_cold_ft,'b','Linewidth',2);
%fill(filles0,fillerrors,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_cold,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm,'r','FaceAlpha',0.25)
hold off
ylim([0 100])
set(gca,'FontSize',15);
xlabel('Reference e_{s0} fraction','FontSize',18)
ylabel('<v''^2>, (m/s)^2','FontSize',18)
%legend('Total','+ve v''','-ve v''','Location','northwest')

print('-dpdf','vvar_notot.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
%set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
%plot(es0,vv_ed_ft,'k','Linewidth',2);
hold on
plot(es0,vv_ed_warm_ft,'r','Linewidth',2);
plot(es0,vv_ed_cold_ft,'b','Linewidth',2);
%fill(filles0,fillerrors,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_cold,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm,'r','FaceAlpha',0.25)
hold off
ylim([0 100])
set(gca,'FontSize',15);
xlabel('Reference e_{s0} fraction','FontSize',18)
ylabel('<v''^2>, (m/s)^2','FontSize',18)
%legend('Total','+ve v''','-ve v''','Location','northwest')

print('-dpdf','vvar_ft_notot.pdf')
