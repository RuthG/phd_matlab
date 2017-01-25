%use sbdart data to evaluate dtrans values, try to work out if our model is any good or not :(

% choose directory, load grid
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

xi=-179:2:180;yi=-89:2:90;
yy=yi*90/60*pi/180;
sinyy=sin(yy);
sst=27*(1-sinyy.*sinyy);
sst(find(abs(yi)>=60))=0;
t_surf=sst+273.15;
p = 2000:4000:98000;
p_half = 0.:4000:100000;
grav 		= 9.8;
cp_air 		= 287.04./(2./7);

%read files
i=0;
for nit = 259200:86400:432000;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'THETA   '));
theta(:,:,:,i)=dyn(:,:,:,J);

end

    convthetatoT=(rC/101325.0).^(2./7.);
    for k=1:size(rC)
      t(:,:,k,:)=theta(:,:,k,:).*convthetatoT(k,1);
    end

t_mean = mean(t,4);


tll=cube2latlon(xc,yc,t_mean,xi,yi);

t_zav(:,:) = mean(tll,1);

t_in = flipdim(t_zav,2);

load('lw_sbdart_tdiff.mat')
load('sw_sbdart_tdiff.mat')
load('radmod_sw_tdiff.mat')
load('radmod_lw_tdiff.mat')

for i=1:25
trans_sw(:,i) = fxdn_sw_half(:,i+1)./fxdn_sw_half(:,1);
dtrans_sw(:,i) = fxdn_sw_half(:,i+1)./fxdn_sw_half(:,i);
end

stefan 	= 5.6734e-8;
window 		= 0.3732;

b = (1. - window).*stefan.*t_in.^4;
b_win = window.*stefan.*t_in.^4;
b_surf = stefan.*t_surf.^4;

fxdn_lw_half = fxdn_lw_l_half + fxdn_lw_u_half;
fxup_lw_half = fxup_lw_l_half + fxup_lw_u_half;
heat_lw = heat_lw_l + heat_lw_u;

%fxup_lw_half(:,26) = b_surf.*(1-window);
%fxup_win_half(:,26) = b_surf.*window;

for i=1:25

dtrans_lw_dn(:,i) = (fxdn_lw_half(:,i+1) - b(:,i) ) ./ (fxdn_lw_half(:,i) - b(:,i));
dtrans_lw_up(:,i) = (fxup_lw_half(:,i) - b(:,i) ) ./ (fxup_lw_half(:,i+1) - b(:,i));

dtrans_win_dn(:,i) = (fxdn_win_half(:,i+1) - b_win(:,i) ) ./ (fxdn_win_half(:,i) - b_win(:,i));
dtrans_win_up(:,i) = (fxup_win_half(:,i) - b_win(:,i) ) ./ (fxup_win_half(:,i+1) - b_win(:,i));

end


fxdn_sw_scaled(:,1) = solar_down(:,1);
for i=1:25
fxdn_sw_scaled(:,i+1) = solar_down(:,1).*trans_sw(:,i);
end


for k=1:25
%   tdt_lw(:,k) = (net(:,k+1) - net(:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));

   heat_scaled_sw(:,k) = (-fxdn_sw_scaled(:,k+1) + fxdn_sw_scaled(:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));


%check relative importance of upward sw fluxes
   heat_up_sw(:,k) = (fxup_sw_half(:,k+1) - fxup_sw_half(:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));

   heat_dn_sw(:,k) = (-fxdn_sw_half(:,k+1) + fxdn_sw_half(:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));

end


%plots!

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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
v=50:50:500;
[C,h] = contour(yi,p_half,fxdn_sw_scaled',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title('SW downward flux, Wm^{-2} (SBDART)')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi,p_half,solar_down',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
title('SW downward flux, Wm^{-2} (RadMod)')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=0.96:0.002:1;
[C,h] = contour(yi,p,dtrans_sw',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title('SW transmission (SBDART)')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi,p,dtrans_sol',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
title('SW transmission (RadMod)')

print('-dpdf','sw_flux_trans_tdiff.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=90:20:290;
[C,h] = contour(yi,p_half,fxup_lw_half',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title('LW upward flux, Wm^{-2} (SBDART)')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi,p_half,up'-up_win',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
title('LW upward flux, Wm^{-2} (RadMod)')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=0:20:280;
[C,h] = contour(yi,p_half,fxdn_lw_half',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title('LW downward flux, Wm^{-2} (SBDART)')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi,p_half,down'-down_win',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
title('LW downward flux, Wm^{-2} (RadMod)')

print('-dpdf','lw_fluxes_tdiff.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=90:5:180;
[C,h] = contour(yi,p_half,fxup_win_half',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title('WIN upward flux, Wm^{-2} (SBDART)')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi,p_half,up_win',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
title('WIN upward flux, Wm^{-2} (RadMod)')

v=0:10:130;
axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi,p_half,fxdn_win_half',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title('WIN downward flux, Wm^{-2} (SBDART)')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi,p_half,down_win',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
title('WIN downward flux, Wm^{-2} (RadMod)')

print('-dpdf','lw_fluxwin_tdiff.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=0:0.1:1.6;
label = 0:0.2:1.6;
[C,h] = contour(yi,p,heat_scaled_sw'.*86400,v,'k');
clabel(C,h,label);
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
title('SW heating rate, K/day (SBDART)')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi,p,tdt_sw'.*86400,v,'k');
clabel(C,h,label);
set(gca,'YDir','reverse')
title('SW heating rate, K/day (RadMod)')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-4:0.2:0.2;
[C,h] = contour(yi,p,(heat_lw'+heat_win'),v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
ylabel('Pressure, hPa')
xlabel('Latitude')
title('LW heating rate, K/day (SBDART)')

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contour(yi,p,tdt_lw'.*86400,v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
title('LW heating rate, K/day (RadMod)')

print('-dpdf','heatrates_tdiff.pdf')

