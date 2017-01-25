%load in v'H' and cpv'T' lines for free trop
%calculate v'T' estimate due to blayer


load('/net/spat-nas/project/rg312/mat_files/blayer_levs_final.mat');
load('/net/spat-nas/project/rg312/mat_files/trop_levs_final.mat');
load('/net/spat-nas/project/rg312/mat_files/vt_lats_final.mat');

h(1) = b_lev_000(x000n);
h(2) = b_lev_010(x010n);
h(3) = b_lev_025(x025n);
h(4) = b_lev_050(x050n);
h(5) = b_lev_075(x075n);
h(6) = b_lev_100(x100n);
h(7) = b_lev_125(x125n);
h(8) = b_lev_150(x150n);

ht(1) = trop_lev_000(x000n);
ht(2) = trop_lev_010(x010n);
ht(3) = trop_lev_025(x025n);
ht(4) = trop_lev_050(x050n);
ht(5) = trop_lev_075(x075n);
ht(6) = trop_lev_100(x100n);
ht(7) = trop_lev_125(x125n);
ht(8) = trop_lev_150(x150n);

load('/net/spat-nas/project/rg312/mat_files/vNt_paper_plot_data_freetrop_final.mat')
vNt_ed_ft = vNt_ed;
vNt_ed_cold_ft = vNt_ed_cold;
vNt_ed_warm_ft = vNt_ed_warm;
vNt_ed_serr_ft = vNt_ed_serr;
vNt_ed_cold_serr_ft = vNt_ed_cold_serr;
vNt_ed_warm_serr_ft = vNt_ed_warm_serr;

load('/net/spat-nas/project/rg312/mat_files/vNt_paper_plot_data_trop_final.mat')
vNt_ed_t = vNt_ed;
vNt_ed_cold_t = vNt_ed_cold;
vNt_ed_warm_t = vNt_ed_warm;
vNt_ed_serr_t = vNt_ed_serr;
vNt_ed_cold_serr_t = vNt_ed_cold_serr;
vNt_ed_warm_serr_t = vNt_ed_warm_serr;

load('/net/spat-nas/project/rg312/mat_files/vNt_paper_plot_data_blayer_final.mat')
vNt_ed_b = vNt_ed;
vNt_ed_cold_b = vNt_ed_cold;
vNt_ed_warm_b = vNt_ed_warm;
vNt_ed_serr_b = vNt_ed_serr;
vNt_ed_cold_serr_b = vNt_ed_cold_serr;
vNt_ed_warm_serr_b = vNt_ed_warm_serr;

vNt_av_ft = (vNt_ed_cold_ft + vNt_ed_warm_ft)./2;
vNt_av_ft_serr = sqrt(vNt_ed_cold_serr_ft.^2 + vNt_ed_warm_serr_ft.^2)./2;

vNt_ed_cold_est = vNt_ed_cold_b.*h./ht + vNt_av_ft.*(ht-h)./ht;
vNt_ed_cold_est_serr = sqrt( (vNt_ed_cold_serr_b.*h./ht).^2 + (vNt_av_ft_serr.*(ht-h)./ht).^2 );

vNt_ed_warm_est = vNt_ed_warm_b.*h./ht + vNt_av_ft.*(ht-h)./ht;
vNt_ed_warm_est_serr = sqrt( (vNt_ed_warm_serr_b.*h./ht).^2 + (vNt_av_ft_serr.*(ht-h)./ht).^2 );


load('/net/spat-nas/project/rg312/mat_files/vNH_paper_plot_data_trop_final.mat')
load('/net/spat-nas/project/rg312/mat_files/vNph_paper_plot_data_trop_final.mat')

vNHph_ed = vNph_ed + vNH_ed;
vNHph_ed_warm = vNph_ed_warm + vNH_ed_warm;
vNHph_ed_cold = vNph_ed_cold + vNH_ed_cold;

vNHph_ed_serr = sqrt(vNph_ed_serr.^2 + (sqrt(10).*vNH_ed_serr).^2);
vNHph_ed_warm_serr = sqrt(vNph_ed_warm_serr.^2 + (sqrt(10).*vNH_ed_warm_serr).^2);
vNHph_ed_cold_serr = sqrt(vNph_ed_cold_serr.^2 + (sqrt(10).*vNH_ed_cold_serr).^2);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 29.7;                  %# A4 paper size
X = 21;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 1*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 0*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.225; %0.4;
xSize_sub = 0.4;

pos1x = 0.07 ; 	pos1y = 0.7; 
pos2x = 0.57;	pos2y = 0.7; 

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')



es0 = [0,0.1,0.25,0.5,0.75,1,1.25,1.5];
cp = 287.04./(2./7.);
filles0 = [es0, fliplr(es0)];
fillerrors = [vNHph_ed+2.*vNHph_ed_serr, fliplr(vNHph_ed-2.*vNHph_ed_serr)];
fillerrors_warm = [vNHph_ed_warm+2.*vNHph_ed_warm_serr, fliplr(vNHph_ed_warm -2.*vNHph_ed_warm_serr)];
fillerrors_cold = [vNHph_ed_cold+2.*vNHph_ed_cold_serr, fliplr(vNHph_ed_cold -2.*vNHph_ed_cold_serr)];


axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(es0,vNHph_ed,'k','Linewidth',2);
hold on
plot(es0,vNHph_ed_warm,'r','Linewidth',2);
plot(es0,vNHph_ed_cold,'b','Linewidth',2);
fill(filles0,fillerrors,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_cold,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm,'r','FaceAlpha',0.25)
hold off
ylim([0.2e4 2.2e4])
set(gca,'FontSize',10);
xlabel('Reference e_{s0} fraction','FontSize',12)
ylabel('v''H'', Wm/kg ','FontSize',12)
%legend('Total','+ve T''','-ve T''','Location','northwest')



fillerrors = [vNt_ed_t+2.*vNt_ed_serr.*sqrt(10), fliplr(vNt_ed_t-2.*vNt_ed_serr_t.*sqrt(10))];
fillerrors_warm = [vNt_ed_warm_t+2.*vNt_ed_warm_serr_t.*sqrt(10), fliplr(vNt_ed_warm_t -2.*vNt_ed_warm_serr_t.*sqrt(10))];
fillerrors_cold = [vNt_ed_cold_t+2.*vNt_ed_cold_serr_t.*sqrt(10), fliplr(vNt_ed_cold_t -2.*vNt_ed_cold_serr_t.*sqrt(10))];

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(es0,vNt_ed_t.*cp,'k','Linewidth',2);
hold on
plot(es0,vNt_ed_warm_t.*cp,'r','Linewidth',2);
plot(es0,vNt_ed_cold_t.*cp,'b','Linewidth',2);
fill(filles0,fillerrors.*cp,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_cold.*cp,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm.*cp,'r','FaceAlpha',0.25)


fillerrors_warm = [vNt_ed_warm_est+2.*vNt_ed_warm_est_serr.*sqrt(10), fliplr(vNt_ed_warm_est -2.*vNt_ed_warm_est_serr.*sqrt(10))];
fillerrors_cold = [vNt_ed_cold_est+2.*vNt_ed_cold_est_serr.*sqrt(10), fliplr(vNt_ed_cold_est -2.*vNt_ed_cold_est_serr.*sqrt(10))];

plot(es0,vNt_ed_warm_est.*cp,'r--','Linewidth',2);
plot(es0,vNt_ed_cold_est.*cp,'b--','Linewidth',2);
fill(filles0,fillerrors_cold.*cp,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm.*cp,'r','FaceAlpha',0.25)

hold off
ylim([0.2e4 2.2e4])
set(gca,'FontSize',10);
xlabel('Reference e_{s0} fraction','FontSize',12)
ylabel('c_{p}v''T'', Wm/kg ','FontSize',12)

print('-dpdf','vH_cpvT.pdf')




return

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
fillerrors = [vNH_ed+2.*vNH_ed_serr.*sqrt(10), fliplr(vNH_ed-2.*vNH_ed_serr.*sqrt(10))];
fillerrors_warm = [vNH_ed_warm+2.*vNH_ed_warm_serr.*sqrt(10), fliplr(vNH_ed_warm -2.*vNH_ed_warm_serr.*sqrt(10))];
fillerrors_cold = [vNH_ed_cold+2.*vNH_ed_cold_serr.*sqrt(10), fliplr(vNH_ed_cold -2.*vNH_ed_cold_serr.*sqrt(10))];


axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(es0,vNH_ed,'k','Linewidth',2);
hold on
plot(es0,vNH_ed_warm,'r','Linewidth',2);
plot(es0,vNH_ed_cold,'b','Linewidth',2);
fill(filles0,fillerrors,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_cold,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm,'r','FaceAlpha',0.25)
hold off
ylim([0.2e4 2.2e4])
set(gca,'FontSize',12);
%xlabel('Reference e_{s0} fraction')
ylabel('v''H'', Wm/kg ','FontSize',15)
text(-0.25,2.1e4,'\fontsize{15} (a)')
%text(1.4,2.1e4,'\bf \fontsize{15} (a)')
%legend('Total','+ve T''','-ve T''','Location','northwest')


fillerrors = [vNt_ed_t+2.*vNt_ed_serr.*sqrt(10), fliplr(vNt_ed_t-2.*vNt_ed_serr_t.*sqrt(10))];
fillerrors_warm = [vNt_ed_warm_t+2.*vNt_ed_warm_serr_t.*sqrt(10), fliplr(vNt_ed_warm_t -2.*vNt_ed_warm_serr_t.*sqrt(10))];
fillerrors_cold = [vNt_ed_cold_t+2.*vNt_ed_cold_serr_t.*sqrt(10), fliplr(vNt_ed_cold_t -2.*vNt_ed_cold_serr_t.*sqrt(10))];

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(es0,vNt_ed_t.*cp,'k','Linewidth',2);
hold on
plot(es0,vNt_ed_warm_t.*cp,'r','Linewidth',2);
plot(es0,vNt_ed_cold_t.*cp,'b','Linewidth',2);
fill(filles0,fillerrors.*cp,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_cold.*cp,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm.*cp,'r','FaceAlpha',0.25)


fillerrors_warm = [vNt_ed_warm_est+2.*vNt_ed_warm_est_serr.*sqrt(10), fliplr(vNt_ed_warm_est -2.*vNt_ed_warm_est_serr.*sqrt(10))];
fillerrors_cold = [vNt_ed_cold_est+2.*vNt_ed_cold_est_serr.*sqrt(10), fliplr(vNt_ed_cold_est -2.*vNt_ed_cold_est_serr.*sqrt(10))];

plot(es0,vNt_ed_warm_est.*cp,'r--','Linewidth',2);
plot(es0,vNt_ed_cold_est.*cp,'b--','Linewidth',2);
fill(filles0,fillerrors_cold.*cp,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm.*cp,'r','FaceAlpha',0.25)

hold off
ylim([0.2e4 2.2e4])
set(gca,'FontSize',12);
xlabel('Reference e_{s0} fraction','FontSize',15)
ylabel('c_{p}v''T'', Wm/kg ','FontSize',15)
text(-0.25,2.1e4,'\fontsize{15} (b)')
%text(1.4,2.1e4,'\bf \fontsize{15} (b)')
%legend('Total','+ve T''','-ve T''','Location','northwest')

print('-dpng','figure_1.png')
print('-dpdf','figure_1.pdf')
print('-depsc2','figure_1.eps')
