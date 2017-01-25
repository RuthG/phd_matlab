%calculate the fraction of blackbody radiation in the window band, and use to check our approx for this

yi=-89:2:89;

yy=yi*90/60*pi/180;
sinyy=sin(yy);
sst=27*(1-sinyy.*sinyy);
sst(find(abs(yi)>=60))=0;
t_surf=sst+273.15;

lambda = 0.25e-6:0.005e-6:100e-6;
T = 200:10:300;
T(12) = 300.15;

h = 6.626e-34;  % Js = kg m2 s-1
c = 2.997e8;    % m/s
kb = 1.38e-23;  % m2 kg s-2 K-1
stefan 	= 5.6734e-8;  % W m−2 K−4   = kg s-3 K-4


lambda5 = lambda.^5; % m5
const1 = 2.*h.*c.^2;  % kg m4 s-3


for i=1:12

expterm = exp( (h.*c)./(lambda.*kb.*T(i)) ); 
B(i,:) = const1 ./ lambda5 ./ (expterm - 1);   % kg m-1 s-3

B_l(i) = sum(B(i,752:1550),2).*pi.*0.005e-6;
B_win(i) = sum(B(i,1551:2751),2).*pi.*0.005e-6;
B_tot(i) = sum(B(i,:),2).*pi.*0.005e-6;

end

B_stefan = stefan.*T.^4;

p = polyfit(T./100,B_win./B_stefan,2);

p = [-0.0967, 0.6516, -0.7089]

B_check = p(1).*(T./100).^2 + p(2).*T./100 + p(3);


fill_lambda = [lambda(1551:2751), fliplr(lambda(1551:2751))];
fill_B = [zeros(1201,1)', fliplr(B(12,1551:2751)./1000.*1e-6)];



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

pos1x = 0.1 ; 	pos1y = 0.65; 

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])

plot(lambda./1e-6,B(12,:)./1000.*1e-6,'k','LineWidth',2)
hold on
fill(fill_lambda./1e-6,fill_B,'b','FaceAlpha',0.25)
set(gca,'FontSize',10)
xlim([0 100])
xlabel('Wavelength, \mum','FontSize',12)
ylabel('Blackbody emission,  Wsr^{-1}m^{-2}\mum^{-1}','FontSize',12)
print('-dpdf','bb_spectrum.pdf')





hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])

plot(T,B_win./B_stefan,'k','LineWidth',2)
set(gca,'FontSize',10)
hold on
plot(T,B_check,'r--','LineWidth',2)
xlim([200 300])
xlabel('Temperature, K','FontSize',12)
ylabel('B_{win}/(\sigma T^{4})','FontSize',12)
print('-dpdf','bb_win_frac.pdf')


maxB = max(B,2);






return
plot(lambda.*10^6,B270)
hold on
plot(lambda.*10^6,B280,'r')
plot(lambda.*10^6,B290,'g')
plot(lambda.*10^6,B300,'k')
