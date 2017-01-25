%plot up the angular momentum in the upper branch of the Hadley Cell.

%load, evaluate and plot Ro, Ht, held hou extent, and subcriticality from walker and schneider

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
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
ny=90;

%read files
i=0;
for nit = 259200:86400:432000;
i=i+1

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5year/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
ucs_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_w(:,:,:,i)=dyn(:,:,:,J);
[uE_w(:,:,:,i),vN_w(:,:,:,i)] = rotate_uv2uvEN(ucs_w(:,:,:,i),vcs_w(:,:,:,i),AngleCS,AngleSN,Grid);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearh/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
ucs_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_h(:,:,:,i)=dyn(:,:,:,J);
[uE_h(:,:,:,i),vN_h(:,:,:,i)] = rotate_uv2uvEN(ucs_h(:,:,:,i),vcs_h(:,:,:,i),AngleCS,AngleSN,Grid);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearq/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
ucs_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_q(:,:,:,i)=dyn(:,:,:,J);
[uE_q(:,:,:,i),vN_q(:,:,:,i)] = rotate_uv2uvEN(ucs_q(:,:,:,i),vcs_q(:,:,:,i),AngleCS,AngleSN,Grid);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yeard/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
ucs_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_d(:,:,:,i)=dyn(:,:,:,J);
[uE_d(:,:,:,i),vN_d(:,:,:,i)] = rotate_uv2uvEN(ucs_d(:,:,:,i),vcs_d(:,:,:,i),AngleCS,AngleSN,Grid);

end

uE_w_mean = mean(uE_w,4);
uE_h_mean = mean(uE_h,4);
uE_q_mean = mean(uE_q,4);
uE_d_mean = mean(uE_d,4);

xi=-179:2:180;yi=-89:2:90;
uEll_w=cube2latlon(xc,yc,uE_w_mean,xi,yi);
uEll_h=cube2latlon(xc,yc,uE_h_mean,xi,yi);
uEll_q=cube2latlon(xc,yc,uE_q_mean,xi,yi);
uEll_d=cube2latlon(xc,yc,uE_d_mean,xi,yi);

uE_w_zav(:,:) = mean(uEll_w,1);
uE_h_zav(:,:) = mean(uEll_h,1);
uE_q_zav(:,:) = mean(uEll_q,1);
uE_d_zav(:,:) = mean(uEll_d,1);

g=9.81;
a=6371.0e3;
omega = 2.*pi./60./60./24;
rd = 287;
cosphi = zeros(90,25);
sinphi = zeros(90,25);
for k=1:25
cosphi(:,k) = cos(yi.*pi./180);
sinphi(:,k) = sin(yi.*pi./180);
end

angmom_w = (omega.*a.*cosphi + uE_w_zav).*a.*cosphi;
angmom_h = (omega.*a.*cosphi + uE_h_zav).*a.*cosphi;
angmom_q = (omega.*a.*cosphi + uE_q_zav).*a.*cosphi;
angmom_d = (omega.*a.*cosphi + uE_d_zav).*a.*cosphi;


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

labels = [1,5,10];
axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=0:1:10;
plot(yi(30:61),angmom_w(30:61,19)./(0.1*omega.*a^2));
hold on
plot(yi(30:61),angmom_h(30:61,19)./(0.1*omega.*a^2),'k');
plot(yi(30:61),angmom_q(30:61,18)./(0.1*omega.*a^2),'g');
plot(yi(30:61),angmom_d(30:61,15)./(0.1*omega.*a^2),'r');
xlim([-30 30])
xlabel('Latitude')
ylabel('Angular Momentum, units of 0.1\Omega a^{2}')
h=legend('1xwv','0.5xwv','0.25xwv','0xwv','Location','SouthEast');
print('-dpdf','angmom_ub.pdf')
