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



load('~/md_onoff/radiation_chapter_beginning/lw_sbdart.mat')
fxdn_lw = fxdn_lw_u + fxdn_lw_l;
fxup_lw = fxup_lw_u + fxup_lw_l;

for k=1:25
dtrans_dn(:,k) = (fxdn_lw(:,k+1) - B(:,k)) ./ (fxdn_lw(:,k) - B(:,k));
dtrans_up(:,k) = (fxup_lw(:,k) - B(:,k)) ./ (fxup_lw(:,k+1) - B(:,k));
dtrans_win_dn(:,k) = (fxdn_win(:,k+1) - B_win(:,k)) ./ (fxdn_win(:,k) - B_win(:,k));
dtrans_win_up(:,k) = (fxup_win(:,k) - B_win(:,k)) ./ (fxup_win(:,k+1) - B_win(:,k));
end
dtau_dn_1co2 = -log(dtrans_dn);
dtau_win_dn_1co2 = -log(dtrans_win_dn);
dtau_up_1co2 = -log(dtrans_up);
dtau_win_up_1co2 = -log(dtrans_win_up);

load('double_co2_runs/lw_sbdart_2co2.mat')
fxdn_lw = fxdn_lw_u + fxdn_lw_l;
fxup_lw = fxup_lw_u + fxup_lw_l;
for k=1:25
dtrans_dn(:,k) = (fxdn_lw(:,k+1) - B(:,k)) ./ (fxdn_lw(:,k) - B(:,k));
dtrans_up(:,k) = (fxup_lw(:,k) - B(:,k)) ./ (fxup_lw(:,k+1) - B(:,k));
dtrans_win_dn(:,k) = (fxdn_win(:,k+1) - B_win(:,k)) ./ (fxdn_win(:,k) - B_win(:,k));
dtrans_win_up(:,k) = (fxup_win(:,k) - B_win(:,k)) ./ (fxup_win(:,k+1) - B_win(:,k));
end
dtau_dn_2co2 = -log(dtrans_dn);
dtau_win_dn_2co2 = -log(dtrans_win_dn);
dtau_up_2co2 = -log(dtrans_up);
dtau_win_up_2co2 = -log(dtrans_win_up);

load('4_co2_runs/lw_sbdart_4co2.mat')
fxdn_lw = fxdn_lw_u + fxdn_lw_l;
fxup_lw = fxup_lw_u + fxup_lw_l;
for k=1:25
dtrans_dn(:,k) = (fxdn_lw(:,k+1) - B(:,k)) ./ (fxdn_lw(:,k) - B(:,k));
dtrans_up(:,k) = (fxup_lw(:,k) - B(:,k)) ./ (fxup_lw(:,k+1) - B(:,k));
dtrans_win_dn(:,k) = (fxdn_win(:,k+1) - B_win(:,k)) ./ (fxdn_win(:,k) - B_win(:,k));
dtrans_win_up(:,k) = (fxup_win(:,k) - B_win(:,k)) ./ (fxup_win(:,k+1) - B_win(:,k));
end
dtau_dn_4co2 = -log(dtrans_dn);
dtau_win_dn_4co2 = -log(dtrans_win_dn);
dtau_up_4co2 = -log(dtrans_up);
dtau_win_up_4co2 = -log(dtrans_win_up);

clear('dtrans_dn','dtrans_win_dn','dtrans_up','dtrans_win_up')

load('10_co2_runs/lw_sbdart_10co2.mat')
fxdn_lw = fxdn_lw_u + fxdn_lw_l;
fxup_lw = fxup_lw_u + fxup_lw_l;
for k=1:25
dtrans_dn(:,k) = (fxdn_lw(1:45,k+1) - B(1:45,k)) ./ (fxdn_lw(1:45,k) - B(1:45,k));
dtrans_up(:,k) = (fxup_lw(1:45,k) - B(1:45,k)) ./ (fxup_lw(1:45,k+1) - B(1:45,k));
dtrans_win_dn(:,k) = (fxdn_win(1:45,k+1) - B_win(1:45,k)) ./ (fxdn_win(1:45,k) - B_win(1:45,k));
dtrans_win_up(:,k) = (fxup_win(1:45,k) - B_win(1:45,k)) ./ (fxup_win(1:45,k+1) - B_win(1:45,k));
end
dtau_dn_10co2 = -log(dtrans_dn);
dtau_win_dn_10co2 = -log(dtrans_win_dn);
dtau_up_10co2 = -log(dtrans_up);
dtau_win_up_10co2 = -log(dtrans_win_up);



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

v = 0:0.2:3;
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,dtau_dn_1co2(2:45,:)',v,'k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,dtau_dn_2co2(2:45,:)',v,'k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,dtau_dn_4co2(2:45,:)',v,'k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,dtau_dn_10co2(2:45,:)',v,'k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

print('-dpdf','dtau_zavs.pdf')




hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,dtau_dn_1co2(2:45,:)',v,'k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

v = 0:0.05:1;
axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,dtau_dn_2co2(2:45,:)' - dtau_dn_1co2(2:45,:)',v,'k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,dtau_dn_4co2(2:45,:)' - dtau_dn_1co2(2:45,:)',v,'k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,dtau_dn_10co2(2:45,:)' - dtau_dn_1co2(2:45,:)',v,'k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

print('-dpdf','dtau_zavs_diffs.pdf')

return

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,dtau_win_dn_1co2(2:45,:)','k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,dtau_win_dn_2co2(2:45,:)','k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,dtau_win_dn_4co2(2:45,:)','k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,dtau_win_dn_10co2(2:45,:)','k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

print('-dpdf','dtau_win_zavs.pdf')




hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

v = 0:0.001:3;
axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,dtau_win_dn_1co2(2:45,:)',v,'k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,dtau_win_dn_2co2(2:45,:)' - dtau_win_dn_1co2(2:45,:)',v,'k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,dtau_win_dn_4co2(2:45,:)' - dtau_win_dn_1co2(2:45,:)',v,'k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi(2:45),flipud(rC)./100,dtau_win_dn_10co2(2:45,:)' - dtau_win_dn_1co2(2:45,:)',v,'k');
clabel(C,h)
set(gca,'FontSize',10, 'YDir','reverse')
xlabel('Pressure, hPa','FontSize',12)
ylabel('Latitude','FontSize',12)

print('-dpdf','dtau_win_zavs_diffs.pdf')
