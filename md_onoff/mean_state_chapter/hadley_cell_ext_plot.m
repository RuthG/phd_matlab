load('/project/rg312/mat_files/chapter2_variables/cell_ext_S.mat')
cell_S(1) =  phi_s_000;            
cell_S(2) =  phi_s_010;        
cell_S(3) =  phi_s_025;           
cell_S(4) =  phi_s_050;           
cell_S(5) =  phi_s_075;    
cell_S(6) =  phi_s_100;
%cell_S(7) =  phi_s_125;             
cell_S(8) =  phi_s_150;

cell_seq(1) =  phi_seq_000;            
cell_seq(2) =  phi_seq_010;        
cell_seq(3) =  phi_seq_025;           
cell_seq(4) =  phi_seq_050;           
cell_seq(5) =  phi_seq_075;    
cell_seq(6) =  phi_seq_100;
cell_seq(7) =  phi_seq_125;             
cell_seq(8) =  phi_seq_150;

load('/project/rg312/mat_files/chapter2_variables/cell_ext_H.mat')
cell_h(1) =  phi_h_000;            
cell_h(2) =  phi_h_010;        
cell_h(3) =  phi_h_025;           
cell_h(4) =  phi_h_050;           
cell_h(5) =  phi_h_075;    
cell_h(6) =  phi_h_100;
cell_h(7) =  phi_h_125;             
cell_h(8) =  phi_h_150;

load('/project/rg312/mat_files/chapter2_variables/cell_ext_HH.mat')
cell_hh(1) =  phi_hh_000;            
cell_hh(2) =  phi_hh_010;        
cell_hh(3) =  phi_hh_025;           
cell_hh(4) =  phi_hh_050;           
cell_hh(5) =  phi_hh_075;    
cell_hh(6) =  phi_hh_100;
cell_hh(7) =  phi_hh_125;             
cell_hh(8) =  phi_hh_150;

load('/project/rg312/mat_files/chapter2_variables/cell_edge.mat')
term_lat(1) = term_lat_000;
term_lat(2) = term_lat_010;
term_lat(3) = term_lat_025;
term_lat(4) = term_lat_050;
term_lat(5) = term_lat_075;
term_lat(6) = term_lat_100;
term_lat(7) = term_lat_125;
term_lat(8) = term_lat_150;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 29.7;                  %# A4 paper size
X = 21;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 1*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 0*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.2625; 
xSize_sub = 0.6; 

%pos1x = 0.1 ; 	pos1y = 0.7; 


Y = 29.7;                  %# A4 paper size
X = 21;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 1*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 0*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.225; %0.4;
xSize_sub = 0.375;

pos1x = 0.1 ; 	pos1y = 0.7; 
pos2x = 0.55;	pos2y = 0.7; 

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
%plot(term_lat,cell_hh,'x')
set(gca,'FontSize',10)
hold on
plot(term_lat(1),cell_h(1),'+k')
plot(term_lat(2),cell_h(2),'*k')
plot(term_lat(3),cell_h(3),'vk')
plot(term_lat(4),cell_h(4),'sk')
plot(term_lat(5),cell_h(5),'dk')
plot(term_lat(6),cell_h(6),'xk')
plot(term_lat(7),cell_h(7),'^k')
plot(term_lat(8),cell_h(8),'pk')
plot(term_lat(1),cell_S(1),'+g')
plot(term_lat(2),cell_S(2),'*g')
plot(term_lat(3),cell_S(3),'vg')
plot(term_lat(4),cell_S(4),'sg')
plot(term_lat(5),cell_S(5),'dg')
plot(term_lat(6),cell_S(6),'xg')
plot(term_lat(7),cell_S(7),'^g')
plot(term_lat(8),cell_S(8),'pg')
plot([0 55],[0 55],'k:')
xlim([20 45]); ylim([10 55]);
xlabel('Latitude of model Hadley cell width','FontSize',12)
ylabel('Latitude predicted by theories','FontSize',12)
%print('-dpdf','hadley_cell_ext.pdf')




load('/project/rg312/mat_files/chapter2_variables/cell_height_equator.mat')
load('/project/rg312/mat_files/chapter2_variables/cell_height_est_new.mat')  

%hFig = figure('Menubar','none');
%# figure size printed on paper
%set(hFig, 'PaperUnits','centimeters')
%set(hFig, 'PaperSize',[X Y])
%set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
%set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
%plot(cell_height_000./1000,height_est_000./1000,'+k')
herrorbar(cell_height_000./1000,height_est_000./1000,cell_height_err_000(1)./1000,cell_height_err_000(2)./1000,'+k')
set(gca,'FontSize',10)
hold on
%plot(cell_height_010./1000,height_est_010./1000,'*k')
herrorbar(cell_height_010./1000,height_est_010./1000,cell_height_err_010(1)./1000,cell_height_err_010(2)./1000,'*k')
%plot(cell_height_025./1000,height_est_025./1000,'vk')
herrorbar(cell_height_025./1000,height_est_025./1000,cell_height_err_025(1)./1000,cell_height_err_025(2)./1000,'vk')
%plot(cell_height_050./1000,height_est_050./1000,'sk')
herrorbar(cell_height_050./1000,height_est_050./1000,cell_height_err_050(1)./1000,cell_height_err_050(2)./1000,'sk')
%plot(cell_height_075./1000,height_est_075./1000,'dk')
herrorbar(cell_height_075./1000,height_est_075./1000,cell_height_err_075(1)./1000,cell_height_err_075(2)./1000,'dk')
%plot(cell_height_100./1000,height_est_100./1000,'xk')
herrorbar(cell_height_100./1000,height_est_100./1000,cell_height_err_100(1)./1000,cell_height_err_100(2)./1000,'xk')
%plot(cell_height_125./1000,height_est_125./1000,'^k')
herrorbar(cell_height_125./1000,height_est_125./1000,cell_height_err_125(1)./1000,cell_height_err_125(2)./1000,'^k')
%plot(cell_height_150./1000,height_est_150./1000,'pk')
herrorbar(cell_height_150./1000,height_est_150./1000,cell_height_err_150(1)./1000,cell_height_err_150(2)./1000,'pk')
plot([0 26],[0 26],'k:')
xlim([10 20])
xlabel('Height of model Hadley cell, km','FontSize',12)
ylabel('Height predicted from theory, km','FontSize',12)
%print('-dpdf','hadley_cell_height.pdf')

print('-dpdf','hadley_cell_height_and_lat.pdf')
