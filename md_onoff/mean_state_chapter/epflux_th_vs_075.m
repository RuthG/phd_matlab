
rDir='/project/rg312/final_runs/run_000_final_noshallow/';
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


load('/project/rg312/mat_files/chapter2_variables/epvars_tav_050.mat','uv_tav','vNth_tav')
load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_050.mat','uE_tav','vN_tav','theta_tav')
xi=-179:2:180;yi=-89:2:90;
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
uvll=cube2latlon(xc,yc,uv_tav,xi,yi);
vNtll=cube2latlon(xc,yc,vNth_tav,xi,yi);
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);

uE_zav_050(:,:) = mean(uEll,1);
vN_zav_050(:,:) = mean(vNll,1);
uv_zav_050(:,:) = mean(uvll,1);
vNt_zav_050(:,:) = mean(vNtll,1);
theta_zav_050(:,:) = mean(thetall,1);
vNt_ed_zav_050 = vNt_zav_050 - vN_zav_050.*theta_zav_050;
uv_ed_zav_050 = uv_zav_050 - uE_zav_050.*vN_zav_050;


load('/project/rg312/mat_files/chapter2_variables/epvars_tav_075.mat','uv_tav','vNth_tav')
load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_075.mat','uE_tav','vN_tav','theta_tav')
xi=-179:2:180;yi=-89:2:90;
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
uvll=cube2latlon(xc,yc,uv_tav,xi,yi);
vNtll=cube2latlon(xc,yc,vNth_tav,xi,yi);
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);

uE_zav_075(:,:) = mean(uEll,1);
vN_zav_075(:,:) = mean(vNll,1);
uv_zav_075(:,:) = mean(uvll,1);
vNt_zav_075(:,:) = mean(vNtll,1);
theta_zav_075(:,:) = mean(thetall,1);
vNt_ed_zav_075 = vNt_zav_075 - vN_zav_075.*theta_zav_075;
uv_ed_zav_075 = uv_zav_075 - uE_zav_075.*vN_zav_075;


load('/project/rg312/mat_files/chapter2_variables/epvars_tav_050_tropheat.mat', 'uv_tav','vNth_tav')
load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_050_tropheat.mat', 'uE_tav','vN_tav','theta_tav')
xi=-179:2:180;yi=-89:2:90;
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
uvll=cube2latlon(xc,yc,uv_tav,xi,yi);
vNtll=cube2latlon(xc,yc,vNth_tav,xi,yi);
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);

uE_zav_th(:,:) = mean(uEll,1);
vN_zav_th(:,:) = mean(vNll,1);
uv_zav_th(:,:) = mean(uvll,1);
vNt_zav_th(:,:) = mean(vNtll,1);
theta_zav_th(:,:) = mean(thetall,1);
vNt_ed_zav_th = vNt_zav_th - vN_zav_th.*theta_zav_th;
uv_ed_zav_th = uv_zav_th - uE_zav_th.*vN_zav_th;



for i=1:44
uv_ed_hzav_050(i,:) = (uv_ed_zav_050(45+i,:) - uv_ed_zav_050(46-i))./2;
vNt_ed_hzav_050(i,:) = (vNt_ed_zav_050(45+i,:) - vNt_ed_zav_050(46-i))./2;
theta_hzav_050(i,:) = (theta_zav_050(45+i,:) + theta_zav_050(46-i))./2;

uv_ed_hzav_075(i,:) = (uv_ed_zav_075(45+i,:) - uv_ed_zav_075(46-i))./2;
vNt_ed_hzav_075(i,:) = (vNt_ed_zav_075(45+i,:) - vNt_ed_zav_075(46-i))./2;
theta_hzav_075(i,:) = (theta_zav_075(45+i,:) + theta_zav_075(46-i))./2;

uv_ed_hzav_th(i,:) = (uv_ed_zav_th(45+i,:) - uv_ed_zav_th(46-i))./2;
vNt_ed_hzav_th(i,:) = (vNt_ed_zav_th(45+i,:) - vNt_ed_zav_th(46-i))./2;
theta_hzav_th(i,:) = (theta_zav_th(45+i,:) + theta_zav_th(46-i))./2;

end



%%%%%%%%%%%%%%%%%%%%%%% EP fluxes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dthetadp_050 = gradient(theta_hzav_050,-4000.);
dthetadp_075 = gradient(theta_hzav_075,-4000.);
dthetadp_th = gradient(theta_hzav_th,-4000.);

cosphi = zeros(44,25);
f = zeros(44,25);
omega = 2*pi/(24*60*60);
g=9.8;
a=6371.0e3;

for i=1:25
cosphi(:,i) = cos(yi(46:89).*pi./180);
f(:,i) = 2*omega*sin(yi(46:89).*pi./180);
end

prefactor = cosphi.*2.*pi.*a.^2./g;


%Calculate fluxes and scaled fluxes (Edmon 1980)

Fphi_050 = -1.*a.*cosphi.*uv_ed_hzav_050;
Fp_050 = a.*f.*cosphi.*vNt_ed_hzav_050./dthetadp_050;
Fphi_scaled_050 = Fphi_050.*prefactor./a;
Fp_scaled_050 = Fp_050.*prefactor;
[fluxdiv_p_050 ,fdp_y] = gradient(Fp_scaled_050,-4000);
[fdphi_050,fluxdiv_phi_050] = gradient(Fphi_scaled_050,pi./90.);
fluxdiv_050 = fluxdiv_p_050 + fluxdiv_phi_050;

Fphi_075 = -1.*a.*cosphi.*uv_ed_hzav_075;
Fp_075 = a.*f.*cosphi.*vNt_ed_hzav_075./dthetadp_075;
Fphi_scaled_075 = Fphi_075.*prefactor./a;
Fp_scaled_075 = Fp_075.*prefactor;
[fluxdiv_p_075 ,fdp_y] = gradient(Fp_scaled_075,-4000);
[fdphi_075,fluxdiv_phi_075] = gradient(Fphi_scaled_075,pi./90.);
fluxdiv_075 = fluxdiv_p_075 + fluxdiv_phi_075;

Fphi_th = -1.*a.*cosphi.*uv_ed_hzav_th;
Fp_th = a.*f.*cosphi.*vNt_ed_hzav_th./dthetadp_th;
Fphi_scaled_th = Fphi_th.*prefactor./a;
Fp_scaled_th = Fp_th.*prefactor;
[fluxdiv_p_th ,fdp_y] = gradient(Fp_scaled_th,-4000);
[fdphi_th,fluxdiv_phi_th] = gradient(Fphi_scaled_th,pi./90.);
fluxdiv_th = fluxdiv_p_th + fluxdiv_phi_th;



load('/project/rg312/mat_files/blayer_levs_final.mat');
load('/project/rg312/mat_files/blayer_levs_final_th.mat')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 29.7;                  %# A4 paper size
X = 21;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 1*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 0*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.225; %0.4;
xSize_sub = 0.37;

pos1x = 0.1 ; 	pos1y = 0.7; 
pos2x = 0.525;	pos2y = 0.7; 

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')



%%% test regridding

for i=1:44
Fphi_scaled_050(i, 1:b_lev_050(45+i)) = NaN;
Fp_scaled_050(i, 1:b_lev_050(45+i)) =NaN;
fluxdiv_050(i, 1:b_lev_050(45+i)) =NaN;
Fphi_scaled_075(i, 1:b_lev_075(45+i)) = NaN;
Fp_scaled_075(i, 1:b_lev_075(45+i)) =NaN;
fluxdiv_075(i, 1:b_lev_075(45+i)) =NaN;
Fphi_scaled_th(i, 1:b_lev_th(45+i)) = NaN;
Fp_scaled_th(i, 1:b_lev_th(45+i)) =NaN;
fluxdiv_th(i, 1:b_lev_th(45+i)) =NaN;
end

for i=1:22
for j=1:13
Fphi_scaled_050_red(i,j) = Fphi_scaled_050(i*2 -1, j*2 -1);
Fp_scaled_050_red(i,j) = Fp_scaled_050(i*2 -1, j*2 -1);
Fphi_scaled_075_red(i,j) = Fphi_scaled_075(i*2 -1, j*2 -1);
Fp_scaled_075_red(i,j) = Fp_scaled_075(i*2 -1, j*2 -1);
Fphi_scaled_th_red(i,j) = Fphi_scaled_th(i*2 -1, j*2 -1);
Fp_scaled_th_red(i,j) = Fp_scaled_th(i*2 -1, j*2 -1);

xspaces(i) = yi(i*2+44 );
yspaces(j) = rC(j*2-1 );

end
end


axes('position',[pos1x pos1y xSize_sub ySize_sub])
labelling = num2str(shiftdim([200:200:1000],1));

v= -5e15:0.25e15:15e15;

[C,h]=contourf(yi(46:89),rC./1000,fluxdiv_th' - fluxdiv_050',v);
set(h,'LineStyle','none')
hold on
colormap(b2r(-5e15,15e15));
quiver(xspaces,yspaces./10^3,1e-14.*(Fphi_scaled_th_red' - Fphi_scaled_050_red'),1.6e-20.*(Fp_scaled_th_red' - Fp_scaled_050_red'),'k','AutoScale','off');
hold on
set(gca,'YDir','reverse','FontSize',10)
%xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
title(['tropheat - 050'],'FontSize',12)
quiver(40, 22, 10, 0,'b');
text(40, 19, '\fontsize{8}1E15 M3(RAD)');
quiver(40, 15, 0, -8,'b');
text(41, 12, '\fontsize{8}5E20 M3(PA)');
ylabel('Pressure, hPa','FontSize',12)
xlabel('Latitude','FontSize',12)
hold off
freezeColors



axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h]=contourf(yi(46:89),rC./1000,fluxdiv_075' - fluxdiv_050',v);
originalSize = get(gca, 'Position');
c = colorbar('eastoutside','FontSize',10);
x = get(c,'Position');
x(1) = 0.91; x(2) = 0.7; x(3) = 0.015; x(4) = 0.225;
set(c,'Position',x);
set(gca, 'Position', originalSize);
set(h,'LineStyle','none')
hold on
colormap(b2r(-5e15,15e15));
quiver(xspaces,yspaces./10^3,1e-14.*(Fphi_scaled_075_red' - Fphi_scaled_050_red'),1.6e-20.*(Fp_scaled_075_red' - Fp_scaled_050_red'),'k','AutoScale','off');
hold on
set(gca,'YDir','reverse','FontSize',10)
%xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
title(['075 - 050'],'FontSize',12)
%quiver(40, 22, 10, 0,'b');
%text(40, 19, '\fontsize{8}1E15 M3(RAD)');
%quiver(40, 15, 0, -8,'b');
%text(41, 12, '\fontsize{8}5E20 M3(PA)');
xlabel('Latitude','FontSize',12)
hold off
freezeColors



print('-dpdf','epflux_th_vs_075.pdf')

