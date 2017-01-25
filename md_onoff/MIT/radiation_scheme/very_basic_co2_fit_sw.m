%load up q and tau data for each run
%take mean difference of tau from 1co2 run
%fit co2 to this
%replot dtau fits with adjustment to see if cross terms could be avoided...


%load grid
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

%load q and t data
load('/project/rg312/mat_files/radiation_chapter/uvwqt_tav_radon.mat','q_tav','theta_tav')

    convthetatoT=(rC/100000.0).^(2./7.);
    for k=1:size(rC)
      t_tav(:,:,k)=theta_tav(:,:,k).*convthetatoT(k,1);
    end

q_ll=cube2latlon(xc,yc,q_tav,xi,yi);
t_ll=cube2latlon(xc,yc,t_tav,xi,yi);
q_zav(:,:) = mean(q_ll,1);
t_zav(:,:) = mean(t_ll,1);
q_in = flipdim(q_zav,2);
t_in = flipdim(t_zav,2);

%consts
stefan 	= 5.6734e-8;
B_tot = stefan.*t_in.^4;
window = 0.3732;
B_win = B_tot.*window;
B = B_tot - B_win;

load('~/md_onoff/radiation_chapter_beginning/sw_sbdart.mat')
for i=1:26
tau(:,i) = -log(fxdn_sw(:,i)./fxdn_sw(:,1));
end
%dtau between flux levels
for k=1:25
dtau(:,k)=tau(:,k+1)-tau(:,k);
end
dtaudsigma_1co2 = dtau./0.04;
clear('tau','dtau')

load('double_co2_runs/sw_sbdart_2co2.mat')
for i=1:26
tau(:,i) = -log(fxdn_sw(:,i)./fxdn_sw(:,1));
end
%dtau between flux levels
for k=1:25
dtau(:,k)=tau(:,k+1)-tau(:,k);
end
dtaudsigma_2co2 = dtau./0.04;
clear('tau','dtau')

load('4_co2_runs/sw_sbdart_4co2.mat')
for i=1:26
tau(:,i) = -log(fxdn_sw(:,i)./fxdn_sw(:,1));
end
%dtau between flux levels
for k=1:25
dtau(:,k)=tau(:,k+1)-tau(:,k);
end
dtaudsigma_4co2 = dtau./0.04;
clear('tau','dtau')

load('10_co2_runs/sw_sbdart_10co2.mat')
for i=1:26
tau(:,i) = -log(fxdn_sw(:,i)./fxdn_sw(:,1));
end
%dtau between flux levels
for k=1:25
dtau(:,k)=tau(:,k+1)-tau(:,k);
end
dtaudsigma_10co2 = dtau./0.04;
clear('tau','dtau')

tau_diff_mean(1) = 0;
tau_diff_mean(2) = mean(mean((real(dtaudsigma_2co2(2:89,:)  - dtaudsigma_1co2(2:89,:)))));
tau_diff_mean(3) = mean(mean((real(dtaudsigma_4co2(2:89,:)  - dtaudsigma_1co2(2:89,:)))));
tau_diff_mean(4) = mean(mean((real(dtaudsigma_10co2(2:45,:)  - dtaudsigma_1co2(2:45,:)))));


%Fitting time!

co2 = [360,720,1440,3600];
b_l = regress(tau_diff_mean',log(co2'./360));
b_sq = regress(tau_diff_mean',sqrt(co2')-sqrt(360));
regress_vals(:,1) = (co2./360 - 1).^2;
regress_vals(:,2) = co2./360 - 1;
b_q = regress(tau_diff_mean',regress_vals);

figure
plot(co2,tau_diff_mean,'xk')
hold on
plot(co2,b_sq.*(sqrt(co2) - sqrt(360)),'b');
plot(co2,b_q(1).*(co2./360 - 1).^2 + b_q(2).*(co2./360 - 1),'r');
plot(co2,b_l.*log(co2./360),'g');




yi = -89:2:89;
p = 2000:4000:98000;
p_half = 0.:4000:100000;
yy=yi*90/60*pi/180;
sinyy=sin(yy);
sst=27*(1-sinyy.*sinyy);
sst(find(abs(yi)>=60))=0;
t_surf=sst+273.15;

%define constants
solar_constant 	= 1360.0;
del_sol		= 1.4;
del_sw 		= 0.;
atm_abs 	= 0.;
sw_diff 	= 0.0;
albedo 	= 0.06;
deg_to_rad 	= pi./180.;
grav 		= 9.8;
cp_air 		= 287.04./(2./7);
lat		= yi.*deg_to_rad;

ss = sin(lat);
p2 = (1. - 3.*ss.^2)./4;
solar = 0.25.*solar_constant.*(1.0 + del_sol.*p2 + del_sw.*ss);

solar_tau_1co2 = zeros(90,25);
solar_tau_1co2(:,1) = 0.;
solar_tau_2co2 = zeros(90,25);
solar_tau_2co2(:,1) = 0.;
solar_tau_4co2 = zeros(90,25);
solar_tau_4co2(:,1) = 0.;
solar_tau_10co2 = zeros(90,25);
solar_tau_10co2(:,1) = 0.;


co2_const = b_q(1).*(co2./360 - 1).^2 + b_q(2).*(co2./360 - 1);

  for k=1:25;
   sw_wv_1co2 = exp(0.01887./(solar_tau_1co2(:,k) + 0.009522) + 1.603./((solar_tau_1co2(:,k) + 0.5194).^2));
   del_sol_tau_1co2 = ( 0.0596 + co2_const(1) + sw_wv_1co2.*q_in(:,k) ) .* 0.04;
   solar_tau_1co2(:,k+1) = solar_tau_1co2(:,k) + del_sol_tau_1co2;
   dtrans_sol_1co2(:,k) = exp( -del_sol_tau_1co2);

   sw_wv_2co2 = exp(0.01887./(solar_tau_2co2(:,k) + 0.009522) + 1.603./((solar_tau_2co2(:,k) + 0.5194).^2));
   del_sol_tau_2co2 = ( 0.0596 + co2_const(2) + sw_wv_2co2.*q_in(:,k) ) .* 0.04;
   solar_tau_2co2(:,k+1) = solar_tau_2co2(:,k) + del_sol_tau_2co2;
   dtrans_sol_2co2(:,k) = exp( -del_sol_tau_2co2);

   sw_wv_4co2 = exp(0.01887./(solar_tau_4co2(:,k) + 0.009522) + 1.603./((solar_tau_4co2(:,k) + 0.5194).^2));
   del_sol_tau_4co2 = ( 0.0596 + co2_const(3) + sw_wv_4co2.*q_in(:,k) ) .* 0.04;
   solar_tau_4co2(:,k+1) = solar_tau_4co2(:,k) + del_sol_tau_4co2;
   dtrans_sol_4co2(:,k) = exp( -del_sol_tau_4co2);

   sw_wv_10co2 = exp(0.01887./(solar_tau_10co2(:,k) + 0.009522) + 1.603./((solar_tau_10co2(:,k) + 0.5194).^2));
   del_sol_tau_10co2 = ( 0.0596 + co2_const(4) + sw_wv_10co2.*q_in(:,k) ) .* 0.04;
   solar_tau_10co2(:,k+1) = solar_tau_10co2(:,k) + del_sol_tau_10co2;
   dtrans_sol_10co2(:,k) = exp( -del_sol_tau_10co2);

  end


solar_down_1co2(:,1) = solar;
solar_down_2co2(:,1) = solar;
solar_down_4co2(:,1) = solar;
solar_down_10co2(:,1) = solar;


for k = 1:25
  solar_down_1co2(:,k+1) = solar_down_1co2(:,k).*dtrans_sol_1co2(:,k);
  solar_down_2co2(:,k+1) = solar_down_2co2(:,k).*dtrans_sol_2co2(:,k);
  solar_down_4co2(:,k+1) = solar_down_4co2(:,k).*dtrans_sol_4co2(:,k);
  solar_down_10co2(:,k+1) = solar_down_10co2(:,k).*dtrans_sol_10co2(:,k);
end

for k=1:26
  flux_sw_1co2(:,k) = albedo.*solar_down_1co2(:,26) - solar_down_1co2(:,k);
  flux_sw_2co2(:,k) = albedo.*solar_down_2co2(:,26) - solar_down_2co2(:,k);
  flux_sw_4co2(:,k) = albedo.*solar_down_4co2(:,26) - solar_down_4co2(:,k);
  flux_sw_10co2(:,k) = albedo.*solar_down_10co2(:,26) - solar_down_10co2(:,k);
end

for k=1:25
   tdt_sw_1co2(:,k) = (flux_sw_1co2(:,k+1) - flux_sw_1co2(:,k)).*grav./(cp_air.*4000);
   tdt_sw_2co2(:,k) = (flux_sw_2co2(:,k+1) - flux_sw_2co2(:,k)).*grav./(cp_air.*4000);
   tdt_sw_4co2(:,k) = (flux_sw_4co2(:,k+1) - flux_sw_4co2(:,k)).*grav./(cp_air.*4000);
   tdt_sw_10co2(:,k) = (flux_sw_10co2(:,k+1) - flux_sw_10co2(:,k)).*grav./(cp_air.*4000);
end

return


%%%%%% Plots %%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 29.7;                  %# A4 paper size
X = 21;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 1*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 0*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.15; %0.4;
xSize_sub = 0.375;

pos1x = 0.1 ; 	pos1y = 0.8; 
pos2x = 0.55;	pos2y = 0.8; 
pos3x = 0.1; 	pos3y = 0.6;
pos4x = 0.55; 	pos4y = 0.6;


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(q_in.*1000,dtau_dn_2co2,'xk')
hold on
plot(q_in.*1000,del_tau_2,'c')
set(gca,'FontSize',10)
ylim([ 0 7])
xlabel('Specific Humidity, g/kg','FontSize',12)
ylabel('d\tau','FontSize',12)

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(q_in.*1000,dtau_win_dn_2co2,'xk')
hold on
plot(q_in.*1000,del_tau_win_2,'c')
set(gca,'FontSize',10)
ylim([0 0.35])
xlabel('Specific Humidity, g/kg','FontSize',12)

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(q_in.*1000,dtau_dn_2co2,'xk')
hold on
plot(q_in.*1000,del_tau_2,'c')
set(gca,'FontSize',10)
ylim([0 0.8])
xlim([0 2])
xlabel('Specific Humidity, g/kg','FontSize',12)
ylabel('d\tau','FontSize',12)

axes('position',[pos4x pos4y xSize_sub ySize_sub])
plot(q_in.*1000,dtau_win_dn_2co2,'xk')
hold on
plot(q_in.*1000,del_tau_win_2,'c')
set(gca,'FontSize',10)
ylim([0 0.03])
xlim([0 2])
xlabel('Specific Humidity, g/kg','FontSize',12)

print('-dpdf','dtau_co2fit_2.pdf')




hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(q_in.*1000,dtau_dn_4co2,'xk')
hold on
plot(q_in.*1000,del_tau_4,'c')
set(gca,'FontSize',10)
ylim([ 0 7])
xlabel('Specific Humidity, g/kg','FontSize',12)
ylabel('d\tau','FontSize',12)

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(q_in.*1000,dtau_win_dn_4co2,'xk')
hold on
plot(q_in.*1000,del_tau_win_4,'c')
set(gca,'FontSize',10)
ylim([0 0.35])
xlabel('Specific Humidity, g/kg','FontSize',12)

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(q_in.*1000,dtau_dn_4co2,'xk')
hold on
plot(q_in.*1000,del_tau_4,'c')
set(gca,'FontSize',10)
ylim([0 0.8])
xlim([0 2])
xlabel('Specific Humidity, g/kg','FontSize',12)
ylabel('d\tau','FontSize',12)

axes('position',[pos4x pos4y xSize_sub ySize_sub])
plot(q_in.*1000,dtau_win_dn_4co2,'xk')
hold on
plot(q_in.*1000,del_tau_win_4,'c')
set(gca,'FontSize',10)
ylim([0 0.03])
xlim([0 2])
xlabel('Specific Humidity, g/kg','FontSize',12)

print('-dpdf','dtau_co2fit_4.pdf')





hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(q_in(1:45,:).*1000,dtau_dn_10co2,'xk')
hold on
plot(q_in.*1000,del_tau_10,'c')
set(gca,'FontSize',10)
ylim([ 0 7])
xlabel('Specific Humidity, g/kg','FontSize',12)
ylabel('d\tau','FontSize',12)

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(q_in(1:45,:).*1000,dtau_win_dn_10co2,'xk')
hold on
plot(q_in.*1000,del_tau_win_10,'c')
set(gca,'FontSize',10)
ylim([0 0.35])
xlabel('Specific Humidity, g/kg','FontSize',12)

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(q_in(1:45,:).*1000,dtau_dn_10co2,'xk')
hold on
plot(q_in.*1000,del_tau_10,'c')
set(gca,'FontSize',10)
ylim([0 0.8])
xlim([0 2])
xlabel('Specific Humidity, g/kg','FontSize',12)
ylabel('d\tau','FontSize',12)

axes('position',[pos4x pos4y xSize_sub ySize_sub])
plot(q_in(1:45,:).*1000,dtau_win_dn_10co2,'xk')
hold on
plot(q_in.*1000,del_tau_win_10,'c')
set(gca,'FontSize',10)
ylim([0 0.03])
xlim([0 2])
xlabel('Specific Humidity, g/kg','FontSize',12)

print('-dpdf','dtau_co2fit_10.pdf')

