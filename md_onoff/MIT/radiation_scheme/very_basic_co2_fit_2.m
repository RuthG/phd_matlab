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


load('0_co2_runs/lw_sbdart_0co2.mat')
fxdn_lw = fxdn_lw_u + fxdn_lw_l;
for k=1:25
dtrans_dn(:,k) = (fxdn_lw(:,k+1) - B(1:45,k)) ./ (fxdn_lw(:,k) - B(1:45,k));
dtrans_win_dn(:,k) = (fxdn_win(:,k+1) - B_win(1:45,k)) ./ (fxdn_win(:,k) - B_win(1:45,k));
end
dtau_dn_0co2 = -log(dtrans_dn);
dtau_win_dn_0co2 = -log(dtrans_win_dn);

clear('dtrans_dn','dtrans_win_dn')

load('~/md_onoff/radiation_chapter_beginning/lw_sbdart.mat')
fxdn_lw = fxdn_lw_u + fxdn_lw_l;
for k=1:25
dtrans_dn(:,k) = (fxdn_lw(:,k+1) - B(:,k)) ./ (fxdn_lw(:,k) - B(:,k));
dtrans_win_dn(:,k) = (fxdn_win(:,k+1) - B_win(:,k)) ./ (fxdn_win(:,k) - B_win(:,k));
end
dtau_dn_1co2 = -log(dtrans_dn);
dtau_win_dn_1co2 = -log(dtrans_win_dn);

load('double_co2_runs/lw_sbdart_2co2.mat')
fxdn_lw = fxdn_lw_u + fxdn_lw_l;
for k=1:25
dtrans_dn(:,k) = (fxdn_lw(:,k+1) - B(:,k)) ./ (fxdn_lw(:,k) - B(:,k));
dtrans_win_dn(:,k) = (fxdn_win(:,k+1) - B_win(:,k)) ./ (fxdn_win(:,k) - B_win(:,k));
end
dtau_dn_2co2 = -log(dtrans_dn);
dtau_win_dn_2co2 = -log(dtrans_win_dn);

load('4_co2_runs/lw_sbdart_4co2.mat')
fxdn_lw = fxdn_lw_u + fxdn_lw_l;
for k=1:25
dtrans_dn(:,k) = (fxdn_lw(:,k+1) - B(:,k)) ./ (fxdn_lw(:,k) - B(:,k));
dtrans_win_dn(:,k) = (fxdn_win(:,k+1) - B_win(:,k)) ./ (fxdn_win(:,k) - B_win(:,k));
end
dtau_dn_4co2 = -log(dtrans_dn);
dtau_win_dn_4co2 = -log(dtrans_win_dn);

clear('dtrans_dn','dtrans_win_dn')

load('10_co2_runs/lw_sbdart_10co2.mat')
fxdn_lw = fxdn_lw_u + fxdn_lw_l;
for k=1:25
dtrans_dn(:,k) = (fxdn_lw(1:45,k+1) - B(1:45,k)) ./ (fxdn_lw(1:45,k) - B(1:45,k));
dtrans_win_dn(:,k) = (fxdn_win(1:45,k+1) - B_win(1:45,k)) ./ (fxdn_win(1:45,k) - B_win(1:45,k));
end
dtau_dn_10co2 = -log(dtrans_dn);
dtau_win_dn_10co2 = -log(dtrans_win_dn);

tau_diff_mean(1) = 0;
tau_diff_mean(2) = mean(mean((real(dtau_dn_2co2(2:89,1:5)  - dtau_dn_1co2(2:89,1:5)))))./0.04;
tau_diff_mean(3) = mean(mean((real(dtau_dn_4co2(2:89,1:5)  - dtau_dn_1co2(2:89,1:5)))))./0.04;
tau_diff_mean(4) = mean(mean((real(dtau_dn_10co2(2:45,1:5) - dtau_dn_1co2(2:45,1:5)))))./0.04;

tau_win_diff_mean(1) = 0;
tau_win_diff_mean(2) = mean(mean((real(dtau_win_dn_2co2(2:89,1:12)  - dtau_win_dn_1co2(2:89,1:12)))))./0.04;
tau_win_diff_mean(3) = mean(mean((real(dtau_win_dn_4co2(2:89,1:12)  - dtau_win_dn_1co2(2:89,1:12)))))./0.04;
tau_win_diff_mean(4) = mean(mean((real(dtau_win_dn_10co2(2:45,1:12) - dtau_win_dn_1co2(2:45,1:12)))))./0.04;


%Fitting time!

co2 = [360,720,1440,3600];
b_l = regress(tau_diff_mean',log(co2'./360));
b_sq = regress(tau_diff_mean',sqrt(co2')-sqrt(360));
regress_vals(:,1) = (co2./360 - 1).^2;
regress_vals(:,2) = co2./360 - 1;
b_q = regress(tau_diff_mean',regress_vals);

b_l_win = regress(tau_win_diff_mean',log(co2'./360));
b_sq_win = regress(tau_win_diff_mean',sqrt(co2')-sqrt(360));
b_q_win = regress(tau_win_diff_mean',regress_vals);

figure
plot(co2,tau_diff_mean,'xk')
hold on
plot(co2,b_sq.*(sqrt(co2) - sqrt(360)),'b');
plot(co2,b_q(1).*(co2./360 - 1).^2 + b_q(2).*(co2./360 - 1),'r');
plot(co2,b_l.*log(co2./360),'g');
print('-dpng','basic_co2_fit_nonwin_new.png')

figure
plot(co2,tau_win_diff_mean,'xk')
hold on
plot(co2,b_sq_win.*(sqrt(co2) - sqrt(360)),'b');
plot(co2,b_q_win(1).*(co2./360 - 1).^2 + b_q_win(2).*(co2./360 - 1),'r');
plot(co2,b_l_win.*log(co2./360),'g');
print('-dpng','basic_co2_fit_win_new.png')

co2_const = b_l.*log(co2./360);
co2_win_const = b_q_win(1).*(co2./360 - 1).^2 + b_q_win(2).*(co2./360 - 1);



ir_tau_co2 	= 0.154925; 
ir_tau_wv 	= 351.48; 
ir_tau_co2_win  = 0.2150;
ir_tau_wv_win1  = 147.11;
ir_tau_wv_win2  = 1.0814e4;

del_tau = (ir_tau_co2 + ir_tau_wv.*q_in.^0.5).*0.04;
del_tau_win = (ir_tau_co2_win + ir_tau_wv_win1.*q_in + ir_tau_wv_win2.*q_in.^2).*0.04;

del_tau_2 = del_tau + co2_const(2).*0.04; %tau_diff_mean(2).*0.04;
del_tau_4 = del_tau + co2_const(3).*0.04; %tau_diff_mean(3).*0.04;
del_tau_10 = del_tau + co2_const(4).*0.04; %tau_diff_mean(4).*0.04;

del_tau_win_2 = del_tau_win + co2_win_const(2).*0.04; %tau_win_diff_mean(2).*0.04;
del_tau_win_4 = del_tau_win + co2_win_const(3).*0.04; %tau_win_diff_mean(3).*0.04;
del_tau_win_10 = del_tau_win + co2_win_const(4).*0.04; %tau_win_diff_mean(4).*0.04;


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

