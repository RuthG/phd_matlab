%final tidy clean EP flux plots for report

% need vu, vtheta, theta, v, u


rDir='/project/rg312/final_runs/run_100_final/';
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


load('/project/rg312/mat_files/chapter2_variables/epvars_tav_050_tropheat.mat', 'uv_tav', 'vNth_tav')
load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_050_tropheat.mat', 'uE_tav', 'vN_tav', 'theta_tav')
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
uv_ed_hzav_th(i,:) = (uv_ed_zav_th(45+i,:) - uv_ed_zav_th(46-i))./2;
vNt_ed_hzav_th(i,:) = (vNt_ed_zav_th(45+i,:) - vNt_ed_zav_th(46-i))./2;
theta_hzav_th(i,:) = (theta_zav_th(45+i,:) + theta_zav_th(46-i))./2;
end



%%%%%%%%%%%%%%%%%%%%%%% EP fluxes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

Fphi_th = -1.*a.*cosphi.*uv_ed_hzav_th;
Fp_th = a.*f.*cosphi.*vNt_ed_hzav_th./dthetadp_th;
Fphi_scaled_th = Fphi_th.*prefactor./a;
Fp_scaled_th = Fp_th.*prefactor;
[fluxdiv_p_th ,fdp_y] = gradient(Fp_scaled_th,-4000);
[fdphi_th,fluxdiv_phi_th] = gradient(Fphi_scaled_th,pi./90.);
fluxdiv_th = fluxdiv_p_th + fluxdiv_phi_th;

load('/project/rg312/mat_files/blayer_levs_final_th.mat')

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
xSize_sub = 0.375;

pos1x = 0.1 ; 	pos1y = 0.7; 
pos2x = 0.55;	pos2y = 0.7; 


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


%%% test regridding
v=-5e16:0.25e16:2e16;

for i=1:44
Fphi_scaled_th(i, 1:b_lev_th(45+i)) = 0;
Fp_scaled_th(i, 1:b_lev_th(45+i)) =0;
fluxdiv_th(i, 1:b_lev_th(45+i)) =NaN;
end

for i=1:22
for j=1:13
Fphi_scaled_th_red(i,j) = Fphi_scaled_th(i*2 -1, j*2 -1);
Fp_scaled_th_red(i,j) = Fp_scaled_th(i*2 -1, j*2 -1);

xspaces(i) = yi(i*2+44 );
yspaces(j) = rC(j*2-1 );

end
end


axes('position',[pos1x pos1y xSize_sub ySize_sub])
labelling = num2str(shiftdim([100:100:1000],1));

[C,h]=contourf(yi(46:89),rC./1000,fluxdiv_th',v);
set(h,'LineStyle','none')
hold on
colormap(b2r(-5e16,2e16));
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_scaled_th_red',1.6e-20.*Fp_scaled_th_red','k','AutoScale','off');
set(gca,'YDir','reverse','FontSize',10)
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
title(['tropheat'],'FontSize',12)
text(45, 20, '\fontsize{8}1E15 M3(RAD)');
quiver(45, 15, 0, -8,'b');
text(46, 12, '\fontsize{8}5E20 M3(PA)');
ylabel('Pressure, hPa','FontSize',12)
xlabel('Latitude','FontSize',12)
hold off
freezeColors

print('ep_flux_tropheat.pdf','-dpdf')

