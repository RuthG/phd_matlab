%relevant sbdart output is stored in week_0922
%load this up and plot up heat rate based on their optical depths calculated from downwelling fluxes, and our insolation.

load('sw_sbdart_10co2.mat')

load('lw_sbdart_10co2.mat')
heat_lw = heat_lw_u+ heat_lw_l + heat_win;

for i=1:25
trans(:,i) = fxdn_sw(:,i+1)./fxdn_sw(:,1);
end

lat = (-89:2:-1).*pi./180;
solar_constant 	= 1360.0;

ss = sin(lat);
p2 = (1. - 3.*ss.^2)./4;
del_sol = 1.4;
solar = repmat(0.25.*solar_constant.*(1.0 + del_sol.*p2'),[1,25]);

mitflux(:,1) = solar(:,1);
mitflux(:,2:26) = solar.*trans;

p_half = 0:4000:100000;
p = 2000:4000:98000;
grav = 9.8;
cp_air 		= 287.04./(2./7);

for k=1:25
   tdt_sw(:,k) = -(mitflux(:,k+1) - mitflux (:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));
   tdt_dn(:,k) = -(fxdn_sw(:,k+1) - fxdn_sw (:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));
   tdt_up(:,k) = (fxup_sw(:,k+1) - fxup_sw (:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));
   tdt_dir(:,k) = -(fxdir_sw(:,k+1) - fxdir_sw (:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));

end

yi = -89:2:-1;

%scattering/upward effect estimate
for i =1:45
fxup_sw_mit(i,:) = fxup_sw(i,:)./fxup_sw(i,25).*mitflux(i,25).*0.06;
end

for k=1:25
   tdt_up_mit(:,k) = (fxup_sw_mit(:,k+1) - fxup_sw_mit (:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));
end


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
xSize_sub = 0.375;

pos1x = 0.1 ; 	pos1y = 0.7; 
pos2x = 0.55;	pos2y = 0.7; 
pos3x = 0.1; 	pos3y = 0.05;
pos4x = 0.55; 	pos4y = 0.05;



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-10:0.25:10;
label = -10:1:10;
%v=-5:0.25:1.6;
%label = -5:0.25:1.6;
[C,h] = contour(yi(2:45),p./100,heat_lw(2:45,:)',v,'k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=0:0.2:1.6;
label = 0:0.2:1.6;
[C,h] = contour(yi(2:45),p./100,tdt_sw(2:45,:)'.*86400,v,'k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
%ylabel('Pressure, hPa','FontSize',12)

print('-dpdf','sbdart_heat_10co2.pdf')


