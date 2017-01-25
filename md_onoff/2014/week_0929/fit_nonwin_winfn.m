%have another look at the nonwindow fit, see if prioritising low wv helps us at all. Include weighting of window fraction with temperature

%load data 

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

%calculate BB emission
B_tot = stefan.*t_in.^4;

%calculate amount in window as a fn of temperature
window = -0.0967.*(t_in./100).^2 + 0.6516.*t_in./100 - 0.7089;

%partition into window and non window
B_win = B_tot.*window;
B = B_tot - B_win;

%load sbdart data
load('../week_0922/lw_sbdart.mat')

p_half = 0.:4000:100000;

fxdn_lw = fxdn_lw_u + fxdn_lw_l;
fxup_lw = fxup_lw_u + fxup_lw_l;

%calculate transmission coeffs for up and down branches
for k=1:25

dtrans_dn(:,k) = (fxdn_lw(:,k+1) - B(:,k)) ./ (fxdn_lw(:,k) - B(:,k));

dtrans_up(:,k) = (fxup_lw(:,k) - B(:,k)) ./ (fxup_lw(:,k+1) - B(:,k));

dtrans_win_dn(:,k) = (fxdn_win(:,k+1) - B_win(:,k)) ./ (fxdn_win(:,k) - B_win(:,k));

dtrans_win_up(:,k) = (fxup_win(:,k) - B_win(:,k)) ./ (fxup_win(:,k+1) - B_win(:,k));

end

%calculate optical depth increments
dtau_up = -log(dtrans_up);
dtau_win_up = -log(dtrans_win_up);

dtau_dn = real(-log(dtrans_dn));
dtau_win_dn = real(-log(dtrans_win_dn));

%remove negative transmittances 

listed(3,:) = reshape(q_in(2:89,:),1,2200);
listed(2,:) = reshape(dtau_dn(2:89,:),1,2200);
listed(1,:) = reshape(dtrans_dn(2:89,:),1,2200);

B = sortrows(listed');

clear listed

listed = B(find(B(:,1)>0),:);

listed = flipdim(listed,2);

B = sortrows(listed);

q_list = B(:,1);
dtau_dn_list = B(:,2);
dtrans_dn_list = B(:,3);

clear listed

listed(1,:) = reshape(q_in(2:89,:),1,2200);
listed(2,:) = reshape(dtau_win_dn(2:89,:),1,2200);
listed(3,:) = reshape(dtrans_win_dn(2:89,:),1,2200);

B = sortrows(listed');

q_win_list = B(:,1);
dtau_win_dn_list = B(:,2);
dtrans_win_dn_list = B(:,3);

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
plot(q_list.*1000,dtrans_dn_list,'x')
xlabel('Specific humidity, g/kg')
ylabel('Transmission')
title('varying window frac')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(q_list.*1000,dtau_dn_list,'x')
xlabel('Specific humidity, g/kg')
ylabel('Optical Depth')

print('-dpdf','dtrans_dn_vwf')

clear X
X(:,1) = q_list;
X(:,2) = 1;

[b1,b1int,r1] = regress(dtau_dn_list,X);
[b2,b2int,r2] = regress(dtau_dn_list,sqrt(X));
p = polyfit(q_list,dtau_dn_list,2);
[b3,b3int,r3] = regress(dtau_dn_list(1:1587),sqrt(X(1:1587,:)));

figure
plot(q_list,dtau_dn_list,'xr')
hold on
plot(q_list,b1(1).*q_list + b1(2))
plot(q_list,b2(1).*sqrt(q_list) + b2(2))
plot(q_list,p(1).*q_list.^2 + p(2).*q_list + p(3))
plot(q_list,b3(1).*sqrt(q_list) + b3(2))
plot(q_list,(351.48.*sqrt(q_list) + 0.154925).*0.04)



p = polyfit(q_win_list,dtau_win_dn_list,2);

figure
plot(q_win_list,dtau_win_dn_list,'xr')
hold on
plot(q_win_list,p(1).*q_win_list.^2 + p(2).*q_win_list + p(3))
plot(q_win_list,(1.0814e4.*q_win_list.^2 + 147.11.*q_win_list + 0.2150).*0.04)
