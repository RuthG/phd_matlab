%use output from run_sbdart_vw_check.m and from radiation_mod_vw_check.m to check if mitgcm produces better heating rates now, plus to check if these are as expected by our scheme.

rDir='/disk1/MITgcm/verification/atm_gray_ruth/run_radon_varyingwin/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
ar=rdmds([rDir,'RAC']);
drC=squeeze(rdmds([rDir,'DRC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
ny=90;

%read files

nit=51360;

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhLWD '));
lwd=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhLWN '));
lwn=dyn(:,:,:,J);

p = 2000:4000:98000;
p_half = 0.:4000:100000;

xi=-179:2:180;yi=-89:2:90;
lwdll=cube2latlon(xc,yc,lwd,xi,yi);
lwnll=cube2latlon(xc,yc,lwn,xi,yi);

lwn_in(1,:) = flipdim(lwnll(1,46,:),3);
lwn_in(2,:) = flipdim(lwnll(1,81,:),3);

cp_air 		= 287.04./(2./7);

for k=1:24
   tdt_mit(:,k) = (lwn_in(:,k+1) - lwn_in(:,k)).*9.8./(cp_air.*(p(k+1) - p(k)));
end

tdt_mit = tdt_mit.*86400;

load('radmod_lw_vw_check.mat')
tdt_lw_vw = tdt_lw.*86400;
tdt_win_vw = tdt_win.*86400;
up_vw = up;
up_win_vw = up_win; 
down_vw = down;
down_win_vw = down_win;

load('radmod_lw_vw_check_orig.mat')
tdt_lw_orig = tdt_lw.*86400;
tdt_win_orig = tdt_win.*86400;
up_orig = up;
up_win_orig = up_win; 
down_orig = down;
down_win_orig = down_win;

load('radmod_lw_vw_check_np.mat')
tdt_lw_np = tdt_lw.*86400;
tdt_win_np = tdt_win.*86400;
up_np = up;
up_win_np = up_win; 
down_np = down;
down_win_np = down_win;

load('lw_sbdart.mat')
heat_lw_tot = heat_lw_l'+heat_lw_u'+heat_win';
fxdn_lw_tot = fxdn_lw_l'+fxdn_lw_u'+fxdn_win';
fxup_lw_tot = fxup_lw_l'+fxup_lw_u'+fxup_win';




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

plot(heat_lw_tot(:,1),p,'k')
set(gca,'YDir','reverse')
hold on
plot(tdt_lw_orig(1,:),p,'k--')
plot(tdt_lw_vw(1,:),p,'g')
plot(tdt_lw_np(1,:),p,'r')
title('Equator')
xlabel('Heat rate, K/day')
ylabel('Pressure, Pa')
legend('SBDART','Current scheme','Varying window frac','Const window refit','Location','SouthWest')

axes('position',[pos2x pos2y xSize_sub ySize_sub])

plot(heat_lw_tot(:,2),p,'k')
set(gca,'YDir','reverse')
hold on
plot(tdt_lw_orig(2,:),p,'k--')
plot(tdt_lw_vw(2,:),p,'g')
plot(tdt_lw_np(2,:),p,'r')
title('70N')
xlabel('Heat rate, K/day')

print('-dpdf','htrts_vwch.pdf')

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])

plot(fxdn_lw_tot(:,1),p_half,'k')
set(gca,'YDir','reverse')
hold on
plot(down_orig(1,:),p_half,'k--')
plot(down_vw(1,:),p_half,'g')
plot(down_np(1,:),p_half,'r')
title('Equator')
ylabel('Pressure, Pa')
xlabel('Downward Flux, Wm^{-2}')
legend('SBDART','Current scheme','Varying window frac','Const window refit','Location','SouthWest')

axes('position',[pos2x pos2y xSize_sub ySize_sub])

plot(fxdn_lw_tot(:,2),p_half,'k')
set(gca,'YDir','reverse')
hold on
plot(down_orig(2,:),p_half,'k--')
plot(down_vw(2,:),p_half,'g')
plot(down_np(2,:),p_half,'r')
title('70N')
xlabel('Downward Flux, Wm^{-2}')

axes('position',[pos3x pos3y xSize_sub ySize_sub])

plot(fxup_lw_tot(:,1),p_half,'k')
set(gca,'YDir','reverse')
hold on
plot(up_orig(1,:),p_half,'k--')
plot(up_vw(1,:),p_half,'g')
plot(up_np(1,:),p_half,'r')
xlabel('Upward Flux, Wm^{-2}')
ylabel('Pressure, Pa')

axes('position',[pos4x pos4y xSize_sub ySize_sub])

plot(fxup_lw_tot(:,2),p_half,'k')
set(gca,'YDir','reverse')
hold on
plot(up_orig(2,:),p_half,'k--')
plot(up_vw(2,:),p_half,'g')
plot(up_np(2,:),p_half,'r')
xlabel('Upward Flux, Wm^{-2}')

print('-dpdf','fluxes_vwch.pdf')
