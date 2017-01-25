%load up SBDART LW data, invert to get taus and show our current parameterisation


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5year/';
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
ny=90;

%read files
i=0;
for nit = 259200:86400:432000;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'SALT    '));
q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta(:,:,:,i)=dyn(:,:,:,J);

end

    convthetatoT=(rC/101325.0).^(2./7.);
    for k=1:size(rC)
      t(:,:,k,:)=theta(:,:,k,:).*convthetatoT(k,1);
    end

q_mean = mean(q,4);
theta_mean = mean(theta,4);
t_mean = mean(t,4);

xi=-179:2:180;yi=-89:2:90;
qll=cube2latlon(xc,yc,q_mean,xi,yi);
thetall=cube2latlon(xc,yc,theta_mean,xi,yi);
tll=cube2latlon(xc,yc,t_mean,xi,yi);

q_zav(:,:) = mean(qll,1);
theta_zav(:,:) = mean(thetall,1);
t_zav(:,:) = mean(tll,1);

q_in = flipdim(q_zav,2);
t_in = flipdim(t_zav,2);

stefan 	= 5.6734e-8;

B_tot = stefan.*t_in.^4;

window = 0.3732;
B_win = B_tot.*window;
B = B_tot - B_win;


load('../week_0922/lw_sbdart.mat')

p_half = 0.:4000:100000;

fxdn_lw = fxdn_lw_u + fxdn_lw_l;
fxup_lw = fxup_lw_u + fxup_lw_l;

for k=1:25

dtrans_dn(:,k) = (fxdn_lw(:,k+1) - B(:,k)) ./ (fxdn_lw(:,k) - B(:,k));

dtrans_up(:,k) = (fxup_lw(:,k) - B(:,k)) ./ (fxup_lw(:,k+1) - B(:,k));

dtrans_win_dn(:,k) = (fxdn_win(:,k+1) - B_win(:,k)) ./ (fxdn_win(:,k) - B_win(:,k));

dtrans_win_up(:,k) = (fxup_win(:,k) - B_win(:,k)) ./ (fxup_win(:,k+1) - B_win(:,k));

end

dtau_up = -log(dtrans_up);
dtau_win_up = -log(dtrans_win_up);

dtau_dn = -log(dtrans_dn);
dtau_win_dn = -log(dtrans_win_dn);


ir_tau_co2 	= 0.154925; 
ir_tau_wv 	= 351.48; 
ir_tau_co2_win  = 0.2150;
ir_tau_wv_win1  = 147.11;
ir_tau_wv_win2  = 1.0814e4;

ir_tau_co2_np 	= 1.5080; 
ir_tau_wv_np 	= 305.1259; 

n=25;

  for k= 1:n
    del_tau(:,k) = (ir_tau_co2 + ir_tau_wv.*q_in(:,k).^0.5).*(p_half(k+1) - p_half(k))./p_half(n+1);
    dtrans(:,k) = exp(-del_tau(:,k));
    del_tau_win(:,k) = (ir_tau_co2_win + ir_tau_wv_win1.*q_in(:,k) + ir_tau_wv_win2.*q_in(:,k).^2).*(p_half(k+1) - p_half(k))./p_half(n+1);
    dtrans_win(:,k) = exp(-del_tau_win(:,k));

    del_tau_np(:,k) = (ir_tau_co2_np + ir_tau_wv_np.*q_in(:,k).^0.5).*(p_half(k+1) - p_half(k))./p_half(n+1);
    dtrans_np(:,k) = exp(-del_tau_np(:,k));


  end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 21.0;                  %# A4 paper size
X = 29.7;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 2*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 2*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.3; %0.4;
xSize_sub = 1./2-0.1;

pos1x = 0.1 ; 	pos1y = 0.45; %1/2+0.05;
pos2x = 0.55;	pos2y = 0.45; %1/2+0.05;
pos3x = 0.1; 	pos3y = 0.05;
pos4x = 0.55; 	pos4y = 0.05;


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(q_in.*1000,dtau_dn,'xc')
hold on
plot(q_in.*1000,del_tau,'k')
plot(q_in.*1000,del_tau_np,'r')
xlabel('Specific Humidity, g/kg')
ylabel('d\tau')
title('Non-Window Region')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(q_in.*1000,dtau_win_dn,'xc')
hold on
plot(q_in.*1000,del_tau_win,'k')
xlabel('Specific Humidity, g/kg')
title('Window Region')


axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(q_in.*1000,dtau_dn,'xc')
hold on
plot(q_in.*1000,del_tau,'k')
plot(q_in.*1000,del_tau_np,'r')
xlim([0 2])
xlabel('Specific Humidity, g/kg')
ylabel('d\tau')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
plot(q_in.*1000,dtau_win_dn,'xc')
hold on
plot(q_in.*1000,del_tau_win,'k')
xlim([0 2])
xlabel('Specific Humidity, g/kg')




print('-dpdf','dtau_fits_current.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(q_in.*1000,dtrans_dn,'xc')
hold on
plot(q_in.*1000,dtrans,'k')
plot(q_in.*1000,dtrans_np,'r')
xlabel('Specific Humidity, g/kg')
ylabel('dtrans')
title('Non-Window Region')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(q_in.*1000,dtrans_win_dn,'xc')
hold on
plot(q_in.*1000,dtrans_win,'k')
xlabel('Specific Humidity, g/kg')
title('Window Region')


axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(q_in.*1000,dtrans_dn,'xc')
hold on
plot(q_in.*1000,dtrans,'k')
plot(q_in.*1000,dtrans_np,'r')
xlim([0 2])
xlabel('Specific Humidity, g/kg')
ylabel('dtrans')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
plot(q_in.*1000,dtrans_win_dn,'xc')
hold on
plot(q_in.*1000,dtrans_win,'k')
xlim([0 2])
xlabel('Specific Humidity, g/kg')




print('-dpdf','dtrans_fits_current.pdf')



