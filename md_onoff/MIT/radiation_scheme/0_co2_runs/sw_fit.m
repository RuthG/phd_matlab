%refit sw parametrisation with polar profile and plot resulting heating rates


load('sw_sbdart_0co2.mat')
load('/project/rg312/mat_files/radiation_chapter/uvwqt_tav_radon.mat','q_tav','theta_tav')

rDir='/project/rg312/final_runs/run_100_rad_on/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));
drC=squeeze(rdmds([rDir,'DRC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
xi=-179:2:179;
yi=-89:2:89;


    convthetatoT=(rC/100000.0).^(2./7.);
    for k=1:size(rC)
      t_tav(:,:,k)=theta_tav(:,:,k).*convthetatoT(k,1);
    end


q_ll=cube2latlon(xc,yc,q_tav,xi,yi);
%theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
t_ll=cube2latlon(xc,yc,t_tav,xi,yi);

q_zav(:,:) = mean(q_ll,1);
%theta_zav(:,:) = mean(theta_ll,1);
t_zav(:,:) = mean(t_ll,1);

t_zav = flipdim(t_zav,2);
q_zav = flipdim(q_zav,2);


%tau on flux levels

for i=1:26
tau(:,i) = -log(fxdn_sw(:,i)./fxdn_sw(:,1));
end

%calculate dtau/sigma - amu
dsigma = 0.04;

%dtau between flux levels
for k=1:25
dtau(:,k)=tau(:,k+1)-tau(:,k);
end

dtaudsigma = dtau./dsigma;

%dtaudsigma = amu + b(tau)*q

%q_mit = specific humidity kg/kg

%want q on dtaudsigma layers

amu = 0.0596;

b = (dtaudsigma - amu)./q_zav(1:45,:);
logb = log(b);

%x0=[0.02,0.01,1.6,0.5];
%fun3 = @(x,tau) x(1)./(tau + x(2)) + x(3)./(tau + x(4)).^2;
%[c,resnorm] = lsqcurvefit(fun3,x0,tau(89,4:25),logb(89,4:25));



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

pos1x = 0.1 ; 	pos1y = 0.6; 


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])


plot(tau(:,1:25),b,'kx')
set(gca,'FontSize',10)
hold on

tau_in = 0:0.001:0.25;
b_est = exp(0.01887./(tau_in + 0.009522) + 1.603./(tau_in+0.5194).^2);
plot(tau_in,b_est,'r','LineWidth',2)

tau_in = 0.01:0.001:0.25;
%plot(tau_in,exp(fun3(c,tau_in)),'c','LineWidth',2)

ylim([0 1800])
xlim([0 0.25])

xlabel('Optical depth','FontSize',12)
ylabel('b','FontSize',12)

print('-dpdf','sw_fits.pdf')





hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(q_zav(1:45,:).*100,dtaudsigma,'kx')
set(gca,'FontSize',10)
xlabel('Specific humidity, g/kg','FontSize',12)
ylabel('d\tau/d\sigma','FontSize',12)

print('-dpdf','dtaudsigma_q.pdf')









load('~/md_onoff/radiation_chapter_beginning/sw_sbdart.mat')

%tau on flux levels

for i=1:26
tau(:,i) = -log(fxdn_sw(1:45,i)./fxdn_sw(1:45,1));
end

%calculate dtau/sigma - amu
dsigma = 0.04;

%dtau between flux levels
for k=1:25
dtau(:,k)=tau(:,k+1)-tau(:,k);
end

dtaudsigma_1co2 = dtau./dsigma;


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')
axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(q_zav(1:45,:).*100,dtaudsigma - dtaudsigma_1co2,'kx')
set(gca,'FontSize',10)
xlabel('Specific humidity, g/kg','FontSize',12)
ylabel('d\tau/d\sigma','FontSize',12)

print('-dpdf','dtaudsigma_0m1co2.pdf')


