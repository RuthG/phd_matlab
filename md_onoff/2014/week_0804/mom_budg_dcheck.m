%double check our original problems with the momentum budget (sanity check)

%need u, v, uv, friction


% choose directory, load grid
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';
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
for nit = 259200:86400:604800;
i=i+1

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
ucs_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_w(:,:,:,i)=dyn(:,:,:,J);
[uE_w(:,:,:,i),vN_w(:,:,:,i)] = rotate_uv2uvEN(ucs_w(:,:,:,i),vcs_w(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'UV_VEL_C'));
uv_w(:,:,:,i)=dyn(:,:,:,J);
[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhTauX'));
tauxcs_w(:,:,i)=surf(:,:,J);
J=find(strcmp(fldList,'AtPhTauY'));
tauycs_w(:,:,i)=surf(:,:,J);
[tauE_w(:,:,i),tauW_w(:,:,i)] = rotate_uv2uvEN(tauxcs_w(:,:,i),tauycs_w(:,:,i),AngleCS,AngleSN,Grid);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
ucs_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_h(:,:,:,i)=dyn(:,:,:,J);
[uE_h(:,:,:,i),vN_h(:,:,:,i)] = rotate_uv2uvEN(ucs_h(:,:,:,i),vcs_h(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'UV_VEL_C'));
uv_h(:,:,:,i)=dyn(:,:,:,J);
[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhTauX'));
tauxcs_h(:,:,i)=surf(:,:,J);
J=find(strcmp(fldList,'AtPhTauY'));
tauycs_h(:,:,i)=surf(:,:,J);
[tauE_h(:,:,i),tauW_h(:,:,i)] = rotate_uv2uvEN(tauxcs_h(:,:,i),tauycs_h(:,:,i),AngleCS,AngleSN,Grid);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_quarterwv/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
ucs_q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_q(:,:,:,i)=dyn(:,:,:,J);
[uE_q(:,:,:,i),vN_q(:,:,:,i)] = rotate_uv2uvEN(ucs_q(:,:,:,i),vcs_q(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'UV_VEL_C'));
uv_q(:,:,:,i)=dyn(:,:,:,J);
[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhTauX'));
tauxcs_q(:,:,i)=surf(:,:,J);
J=find(strcmp(fldList,'AtPhTauY'));
tauycs_q(:,:,i)=surf(:,:,J);
[tauE_q(:,:,i),tauW_q(:,:,i)] = rotate_uv2uvEN(tauxcs_q(:,:,i),tauycs_q(:,:,i),AngleCS,AngleSN,Grid);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_5year_c/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
ucs_d(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_d(:,:,:,i)=dyn(:,:,:,J);
[uE_d(:,:,:,i),vN_d(:,:,:,i)] = rotate_uv2uvEN(ucs_d(:,:,:,i),vcs_d(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'UV_VEL_C'));
uv_d(:,:,:,i)=dyn(:,:,:,J);
[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhTauX'));
tauxcs_d(:,:,i)=surf(:,:,J);
J=find(strcmp(fldList,'AtPhTauY'));
tauycs_d(:,:,i)=surf(:,:,J);
[tauE_d(:,:,i),tauW_d(:,:,i)] = rotate_uv2uvEN(tauxcs_d(:,:,i),tauycs_d(:,:,i),AngleCS,AngleSN,Grid);

end

uE_w_mean = mean(uE_w,4);
uE_h_mean = mean(uE_h,4);
uE_q_mean = mean(uE_q,4);
uE_d_mean = mean(uE_d,4);

vN_w_mean = mean(vN_w,4);
vN_h_mean = mean(vN_h,4);
vN_q_mean = mean(vN_q,4);
vN_d_mean = mean(vN_d,4);

uv_w_mean = mean(uv_w,4);
uv_h_mean = mean(uv_h,4);
uv_q_mean = mean(uv_q,4);
uv_d_mean = mean(uv_d,4);

tauE_w_mean = mean(tauE_w,3);
tauE_h_mean = mean(tauE_h,3);
tauE_q_mean = mean(tauE_q,3);
tauE_d_mean = mean(tauE_d,3);

xi=-179:2:180;yi=-89:2:90;

uEll_w=cube2latlon(xc,yc,uE_w_mean,xi,yi);
uEll_h=cube2latlon(xc,yc,uE_h_mean,xi,yi);
uEll_q=cube2latlon(xc,yc,uE_q_mean,xi,yi);
uEll_d=cube2latlon(xc,yc,uE_d_mean,xi,yi);

vNll_w=cube2latlon(xc,yc,vN_w_mean,xi,yi);
vNll_h=cube2latlon(xc,yc,vN_h_mean,xi,yi);
vNll_q=cube2latlon(xc,yc,vN_q_mean,xi,yi);
vNll_d=cube2latlon(xc,yc,vN_d_mean,xi,yi);

uvll_w=cube2latlon(xc,yc,uv_w_mean,xi,yi);
uvll_h=cube2latlon(xc,yc,uv_h_mean,xi,yi);
uvll_q=cube2latlon(xc,yc,uv_q_mean,xi,yi);
uvll_d=cube2latlon(xc,yc,uv_d_mean,xi,yi);

tauEll_w=cube2latlon(xc,yc,tauE_w_mean,xi,yi);
tauEll_h=cube2latlon(xc,yc,tauE_h_mean,xi,yi);
tauEll_q=cube2latlon(xc,yc,tauE_q_mean,xi,yi);
tauEll_d=cube2latlon(xc,yc,tauE_d_mean,xi,yi);

uE_w_zav(:,:) = mean(uEll_w,1);
uE_h_zav(:,:) = mean(uEll_h,1);
uE_q_zav(:,:) = mean(uEll_q,1);
uE_d_zav(:,:) = mean(uEll_d,1);

vN_w_zav(:,:) = mean(vNll_w,1);
vN_h_zav(:,:) = mean(vNll_h,1);
vN_q_zav(:,:) = mean(vNll_q,1);
vN_d_zav(:,:) = mean(vNll_d,1);

uv_w_zav(:,:) = mean(uvll_w,1);
uv_h_zav(:,:) = mean(uvll_h,1);
uv_q_zav(:,:) = mean(uvll_q,1);
uv_d_zav(:,:) = mean(uvll_d,1);

tauE_w_zav = mean(tauEll_w,1);
tauE_h_zav = mean(tauEll_h,1);
tauE_q_zav = mean(tauEll_q,1);
tauE_d_zav = mean(tauEll_d,1);

uv_w_zon_zav = uE_w_zav.*vN_w_zav;
uv_h_zon_zav = uE_h_zav.*vN_h_zav;
uv_q_zon_zav = uE_q_zav.*vN_q_zav;
uv_d_zon_zav = uE_d_zav.*vN_d_zav;

g=9.81;
intfac = 4000./g;

uE_w_vint = sum(uE_w_zav,2).*intfac;
uE_h_vint = sum(uE_h_zav,2).*intfac;
uE_q_vint = sum(uE_q_zav,2).*intfac;
uE_d_vint = sum(uE_d_zav,2).*intfac;

vN_w_vint = sum(vN_w_zav,2).*intfac;
vN_h_vint = sum(vN_h_zav,2).*intfac;
vN_q_vint = sum(vN_q_zav,2).*intfac;
vN_d_vint = sum(vN_d_zav,2).*intfac;

uv_w_vint = sum(uv_w_zav,2).*intfac;
uv_h_vint = sum(uv_h_zav,2).*intfac;
uv_q_vint = sum(uv_q_zav,2).*intfac;
uv_d_vint = sum(uv_d_zav,2).*intfac;

uv_w_zon_vint = sum(uv_w_zon_zav,2).*intfac;
uv_h_zon_vint = sum(uv_h_zon_zav,2).*intfac;
uv_q_zon_vint = sum(uv_q_zon_zav,2).*intfac;
uv_d_zon_vint = sum(uv_d_zon_zav,2).*intfac;


cosphi = cos(yi.*pi./180)';

uv_w_weight = uv_w_vint.*cosphi.*cosphi;
uv_h_weight = uv_h_vint.*cosphi.*cosphi;
uv_q_weight = uv_q_vint.*cosphi.*cosphi;
uv_d_weight = uv_d_vint.*cosphi.*cosphi;

uv_w_zon_weight = uv_w_zon_vint.*cosphi.*cosphi;
uv_h_zon_weight = uv_h_zon_vint.*cosphi.*cosphi;
uv_q_zon_weight = uv_q_zon_vint.*cosphi.*cosphi;
uv_d_zon_weight = uv_d_zon_vint.*cosphi.*cosphi;

a=6371.0e3;
duvdy_w = gradient(uv_w_weight,pi./90)./cosphi./cosphi./a;
duvdy_h = gradient(uv_h_weight,pi./90)./cosphi./cosphi./a;
duvdy_q = gradient(uv_q_weight,pi./90)./cosphi./cosphi./a;
duvdy_d = gradient(uv_d_weight,pi./90)./cosphi./cosphi./a;

duvdy_w_zon = gradient(uv_w_zon_weight,pi./90)./cosphi./cosphi./a;
duvdy_h_zon = gradient(uv_h_zon_weight,pi./90)./cosphi./cosphi./a;
duvdy_q_zon = gradient(uv_q_zon_weight,pi./90)./cosphi./cosphi./a;
duvdy_d_zon = gradient(uv_d_zon_weight,pi./90)./cosphi./cosphi./a;


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

axes('position',[pos4x pos4y xSize_sub ySize_sub])
plot(yi,duvdy_w)
hold on
plot(yi,tauE_w_zav,'r')
plot(yi,duvdy_w_zon,'g')
plot(yi,duvdy_w - duvdy_w_zon,'c')
xlabel('Latitude')
set(gca,'YDir','reverse')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
plot(yi,duvdy_h)
hold on
plot(yi,tauE_h_zav,'r')
plot(yi,duvdy_h_zon,'g')
plot(yi,duvdy_h - duvdy_h_zon,'c')
ylabel('Pressure, hPa')
xlabel('Latitude')
set(gca,'YDir','reverse')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
plot(yi,duvdy_q)
hold on
plot(yi,tauE_q_zav,'r')
plot(yi,duvdy_q_zon,'g')
plot(yi,duvdy_q - duvdy_q_zon,'c')
set(gca,'YDir','reverse')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(yi,duvdy_d)
hold on
plot(yi,tauE_d_zav,'r')
plot(yi,duvdy_d_zon,'g')
plot(yi,duvdy_d - duvdy_d_zon,'c')
ylabel('Pressure, hPa')
set(gca,'YDir','reverse')

print('mombudgcheck.pdf','-dpdf')
