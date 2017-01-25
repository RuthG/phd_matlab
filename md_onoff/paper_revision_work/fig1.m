%load in v'H' and cpv'T' lines for free trop
%calculate v'T' estimate due to blayer

blevs = load('/net/spat-nas/project/rg312/mat_files/blayer_levs_final.mat');
tlevs = load('/net/spat-nas/project/rg312/mat_files/trop_levs_final.mat');
vtlats = load('/net/spat-nas/project/rg312/mat_files/vt_lats_final.mat');

data = load('/project/rg312/mat_files/paper_vars_290416.mat');

run={'000','010','025','050','075','100','125','150'};

for i=1:8
    varnm = ['output_' char(run(i))];
    var = data.(varnm);
    vH(i,:,:) = var.vH;
    vH_cold(i,:,:) = var.vH_cold;
    vH_warm(i,:,:) = var.vH_warm;
    vt(i,:,:) = var.vT;
    vt_cold(i,:,:) = var.vT_cold;
    vt_warm(i,:,:) = var.vT_warm;
    
    xnm = ['x' char(run(i)) 'n'];
    xn = vtlats.(xnm);
    
    bnm = ['b_lev_' char(run(i))];
    bl = blevs.(bnm);
    h(i) = bl(xn);
    
    tnm = ['trop_lev_' char(run(i))];
    tl = tlevs.(tnm);
    ht(i) = tl(xn);
    
end


tot_diff_sens = vt(6,:,:) - vt(1,:,:);
cold_diff_sens = vt_cold(6,:,:) - vt_cold(1,:,:);



load('/net/spat-nas/project/rg312/mat_files/vNt_paper_plot_data_freetrop_final.mat')
vNt_ed_ft = vNt_ed;
vNt_ed_cold_ft = vNt_ed_cold;
vNt_ed_warm_ft = vNt_ed_warm;
vNt_ed_serr_ft = vNt_ed_serr;
vNt_ed_cold_serr_ft = vNt_ed_cold_serr;
vNt_ed_warm_serr_ft = vNt_ed_warm_serr;


load('/net/spat-nas/project/rg312/mat_files/vNt_paper_plot_data_blayer_final.mat')
vNt_ed_b = vNt_ed;
vNt_ed_cold_b = vNt_ed_cold;
vNt_ed_warm_b = vNt_ed_warm;
vNt_ed_serr_b = vNt_ed_serr;
vNt_ed_cold_serr_b = vNt_ed_cold_serr;
vNt_ed_warm_serr_b = vNt_ed_warm_serr;

vt_av = (vt_cold(:,3,1) + vt_warm(:,3,1))./2;
vt_av_serr = sqrt(vt_cold(:,3,2).^2 + vt_warm(:,3,2).^2)./2;

vt_cold_est = vt_cold(:,2,1)'.*h./ht + vt_av'.*(ht-h)./ht;
vt_cold_est_serr = sqrt( (vt_cold(:,2,2)'.*h./ht).^2 + (vt_av_serr'.*(ht-h)./ht).^2 );

vt_warm_est = vt_warm(:,2,1)'.*h./ht + vt_av'.*(ht-h)./ht;
vt_warm_est_serr = sqrt( (vt_warm(:,2,2)'.*h./ht).^2 + (vt_av_serr'.*(ht-h)./ht).^2 );



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
fillerrors = [vH(:,1,1)'+2.*vH(:,1,2)'.*sqrt(10), fliplr(vH(:,1,1)'-2.*vH(:,1,2)'.*sqrt(10))];
fillerrors_warm = [vH_warm(:,1,1)'+2.*vH_warm(:,1,2)'.*sqrt(10), fliplr(vH_warm(:,1,1)' -2.*vH_warm(:,1,2)'.*sqrt(10))];
fillerrors_cold = [vH_cold(:,1,1)'+2.*vH_cold(:,1,2)'.*sqrt(10), fliplr(vH_cold(:,1,1)' -2.*vH_cold(:,1,2)'.*sqrt(10))];


axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(es0,vH(:,1,1),'k','Linewidth',2);
hold on
plot(es0,vH_warm(:,1,1),'r','Linewidth',2);
plot(es0,vH_cold(:,1,1),'b','Linewidth',2);
fill(filles0,fillerrors,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_cold,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm,'r','FaceAlpha',0.25)
grid on
hold off
ylim([0.2e4 2.2e4])
set(gca,'FontSize',12);
%xlabel('Reference e_{s0} fraction')
ylabel('v''H'', Wm/kg ','FontSize',15)
text(-0.25,2.1e4,'\fontsize{15} (a)')
%text(1.4,2.1e4,'\bf \fontsize{15} (a)')
%legend('Total','+ve T''','-ve T''','Location','northwest')


fillerrors = [vt(:,1,1)'+2.*vt(:,1,2)'.*sqrt(10), fliplr(vt(:,1,1)'-2.*vt(:,1,2)'.*sqrt(10))];
fillerrors_warm = [vt_warm(:,1,1)'+2.*vt_warm(:,1,2)'.*sqrt(10), fliplr(vt_warm(:,1,1)' -2.*vt_warm(:,1,2)'.*sqrt(10))];
fillerrors_cold = [vt_cold(:,1,1)'+2.*vt_cold(:,1,2)'.*sqrt(10), fliplr(vt_cold(:,1,1)' -2.*vt_cold(:,1,2)'.*sqrt(10))];

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(es0,vt(:,1,1).*cp,'k','Linewidth',2);
hold on
plot(es0,vt_warm(:,1,1).*cp,'r','Linewidth',2);
plot(es0,vt_cold(:,1,1).*cp,'b','Linewidth',2);
fill(filles0,fillerrors.*cp,'k','FaceAlpha',0.25)
fill(filles0,fillerrors_cold.*cp,'b','FaceAlpha',0.25)
fill(filles0,fillerrors_warm.*cp,'r','FaceAlpha',0.25)
grid on


fillerrors_warm = [vt_warm_est+2.*vt_warm_est_serr.*sqrt(10), fliplr(vt_warm_est -2.*vt_warm_est_serr.*sqrt(10))];
fillerrors_cold = [vt_cold_est+2.*vt_cold_est_serr.*sqrt(10), fliplr(vt_cold_est -2.*vt_cold_est_serr.*sqrt(10))];

plot(es0,vt_warm_est.*cp,'r--','Linewidth',2);
plot(es0,vt_cold_est.*cp,'b--','Linewidth',2);
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

%print('-dpng','figure_1.png')
print('-dpdf','figure_1.pdf')
%print('-depsc2','figure_1.eps')

return


