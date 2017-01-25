data = load('/project/rg312/mat_files/paper_vars_290416.mat');


run={'000','010','025','050','075','100','125','150'};

for i=1:8
    varnm = ['output_' char(run(i))];
    var = data.(varnm);
    tt(i,:,:) = var.tt;
    tt_cold(i,:,:) = var.tt_cold;
    tt_warm(i,:,:) = var.tt_warm;
    vv(i,:,:) = var.vv;
    vv_cold(i,:,:) = var.vv_cold;
    vv_warm(i,:,:) = var.vv_warm;    
end


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

fillerrors = [tt(:,2,1)' + 2.*tt(:,2,2)'.*sqrt(10), fliplr(tt(:,2,1)' - 2.*tt(:,2,2)'.*sqrt(10))];
fillerrors_warm = [tt_warm(:,2,1)' + 2.*tt_warm(:,2,2)'.*sqrt(10), fliplr(tt_warm(:,2,1)' - 2.*tt_warm(:,2,2)'.*sqrt(10))];
fillerrors_cold = [tt_cold(:,2,1)' + 2.*tt_cold(:,2,2)'.*sqrt(10), fliplr(tt_cold(:,2,1)' - 2.*tt_cold(:,2,2)'.*sqrt(10))];

axes('position',[pos1x pos1y xSize_sub ySize_sub])
hold on
grid on
plot(es0,tt_warm(:,2,1),'r--','Linewidth',2);
plot(es0,tt_cold(:,2,1),'b--','Linewidth',2);
fill(filles0,fillerrors_cold,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm,'r','FaceAlpha',0.25)

fillerrors = [tt(:,3,1)' + 2.*tt(:,3,2)'.*sqrt(10), fliplr(tt(:,3,1)' - 2.*tt(:,3,2)'.*sqrt(10))];
fillerrors_warm = [tt_warm(:,3,1)' + 2.*tt_warm(:,3,2)'.*sqrt(10), fliplr(tt_warm(:,3,1)' - 2.*tt_warm(:,3,2)'.*sqrt(10))];
fillerrors_cold = [tt_cold(:,3,1)' + 2.*tt_cold(:,3,2)'.*sqrt(10), fliplr(tt_cold(:,3,1)' - 2.*tt_cold(:,3,2)'.*sqrt(10))];

plot(es0,tt_warm(:,3,1),'r','Linewidth',2);
plot(es0,tt_cold(:,3,1),'b','Linewidth',2);
fill(filles0,fillerrors_cold,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm,'r','FaceAlpha',0.25)


hold off
%ylim([0.2e4 2.2e4])
text(-0.25,10,'\fontsize{15} (a)')
set(gca,'FontSize',12);
%xlabel('Reference e_{s0} fraction')
ylabel('<T''>, K^2','FontSize',15)
%legend('Total','+ve T''','-ve T''','Location','northwest')


fillerrors = [vv(:,2,1)' + 2.*vv(:,2,2)'.*sqrt(10), fliplr(vv(:,2,1)' - 2.*vv(:,2,2)'.*sqrt(10))];
fillerrors_warm = [vv_warm(:,2,1)' + 2.*vv_warm(:,2,2)'.*sqrt(10), fliplr(vv_warm(:,2,1)' - 2.*vv_warm(:,2,2)'.*sqrt(10))];
fillerrors_cold = [vv_cold(:,2,1)' + 2.*vv_cold(:,2,2)'.*sqrt(10), fliplr(vv_cold(:,2,1)' - 2.*vv_cold(:,2,2)'.*sqrt(10))];

axes('position',[pos2x pos2y xSize_sub ySize_sub])
hold on
grid on
plot(es0,vv_warm(:,2,1),'r--','Linewidth',2);
plot(es0,vv_cold(:,2,1),'b--','Linewidth',2);
fill(filles0,fillerrors_cold,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm,'r','FaceAlpha',0.25)

fillerrors = [vv(:,3,1)' + 2.*vv(:,3,2)'.*sqrt(10), fliplr(vv(:,3,1)' - 2.*vv(:,3,2)'.*sqrt(10))];
fillerrors_warm = [vv_warm(:,3,1)' + 2.*vv_warm(:,3,2)'.*sqrt(10), fliplr(vv_warm(:,3,1)' - 2.*vv_warm(:,3,2)'.*sqrt(10))];
fillerrors_cold = [vv_cold(:,3,1)' + 2.*vv_cold(:,3,2)'.*sqrt(10), fliplr(vv_cold(:,3,1)' - 2.*vv_cold(:,3,2)'.*sqrt(10))];

plot(es0,vv_warm(:,3,1),'r','Linewidth',2);
plot(es0,vv_cold(:,3,1),'b','Linewidth',2);
fill(filles0,fillerrors_cold,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm,'r','FaceAlpha',0.25)


hold off
%ylim([0.2e4 2.2e4])
text(-0.25,80,'\fontsize{15} (b)')
set(gca,'FontSize',12);
xlabel('Reference e_{s0} fraction','FontSize',15)
ylabel('<v''>, (m/s)^2','FontSize',15)
%legend('Total','+ve T''','-ve T''','Location','northwest')

%print('-dpng','figure_4.png')
print('-dpdf','figure_4.pdf')
%print('-depsc2','figure_4.eps')
