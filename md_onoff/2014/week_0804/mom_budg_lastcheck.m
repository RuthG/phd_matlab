%double check our original problems with the momentum budget (sanity check)

%need u, v, uv, friction


% choose directory, load grid
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_diag_testing/';
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
for nit = 605040:240:691200;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
ucs_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_w(:,:,:,i)=dyn(:,:,:,J);
[uE_w(:,:,:,i),vN_w(:,:,:,i)] = rotate_uv2uvEN(ucs_w(:,:,:,i),vcs_w(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'UV_VEL_C'));
uv_w(:,:,:,i)=dyn(:,:,:,J);

J=find(strcmp(fldList,'WU_VEL  '));
wucs_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'WV_VEL  '));
wvcs_w(:,:,:,i)=dyn(:,:,:,J);
[wuE_w(:,:,:,i),wvN_w(:,:,:,i)] = rotate_uv2uvEN(wucs_w(:,:,:,i),wvcs_w(:,:,:,i),AngleCS,AngleSN,Grid);


[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhTauX'));
tauxcs_w(:,:,i)=surf(:,:,J);
J=find(strcmp(fldList,'AtPhTauY'));
tauycs_w(:,:,i)=surf(:,:,J);
[tauE_w(:,:,i),tauW_w(:,:,i)] = rotate_uv2uvEN(tauxcs_w(:,:,i),tauycs_w(:,:,i),AngleCS,AngleSN,Grid);

end

uE_w_mean = mean(uE_w,4);

vN_w_mean = mean(vN_w,4);

uv_w_mean = mean(uv_w,4);

wuE_w_mean = mean(wuE_w,4);

tauE_w_mean = mean(tauE_w,3);

xi=-179:2:180;yi=-89:2:90;

uEll_w=cube2latlon(xc,yc,uE_w_mean,xi,yi);

vNll_w=cube2latlon(xc,yc,vN_w_mean,xi,yi);

uvll_w=cube2latlon(xc,yc,uv_w_mean,xi,yi);

wuEll_w=cube2latlon(xc,yc,wuE_w_mean,xi,yi);

tauEll_w=cube2latlon(xc,yc,tauE_w_mean,xi,yi);

uE_w_zav(:,:) = mean(uEll_w,1);

vN_w_zav(:,:) = mean(vNll_w,1);

uv_w_zav(:,:) = mean(uvll_w,1);

wuE_w_zav(:,:) = mean(wuEll_w,1);

tauE_w_zav = mean(tauEll_w,1);

uv_w_zon_zav = uE_w_zav.*vN_w_zav;


dwuEdp = gradient(wuE_w_zav,-4000);

g=9.81;
intfac = 4000./g;

uE_w_vint = sum(uE_w_zav,2).*intfac;

vN_w_vint = sum(vN_w_zav,2).*intfac;

uv_w_vint = sum(uv_w_zav,2).*intfac;

dwuEdp_vint = sum(dwuEdp,2).*intfac;

uv_w_zon_vint = sum(uv_w_zon_zav,2).*intfac;


cosphi = cos(yi.*pi./180)';

uv_w_weight = uv_w_vint.*cosphi.*cosphi;

uv_w_zon_weight = uv_w_zon_vint.*cosphi.*cosphi;

a=6371.0e3;
duvdy_w = gradient(uv_w_weight,pi./90)./cosphi./cosphi./a;

duvdy_w_zon = gradient(uv_w_zon_weight,pi./90)./cosphi./cosphi./a;


return


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
