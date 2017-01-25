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

load('/project/rg312/mat_files/chapter2_variables/epvars_tav_000.mat','uv_tav','vNth_tav')
load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_000.mat','uE_tav','vN_tav','theta_tav')
xi=-179:2:180;yi=-89:2:90;
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
uvll=cube2latlon(xc,yc,uv_tav,xi,yi);
vNtll=cube2latlon(xc,yc,vNth_tav,xi,yi);
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);

uE_zav_000(:,:) = mean(uEll,1);
vN_zav_000(:,:) = mean(vNll,1);
uv_zav_000(:,:) = mean(uvll,1);
vNt_zav_000(:,:) = mean(vNtll,1);
theta_zav_000(:,:) = mean(thetall,1);
vNt_ed_zav_000 = vNt_zav_000 - vN_zav_000.*theta_zav_000;
uv_ed_zav_000 = uv_zav_000 - uE_zav_000.*vN_zav_000;


load('/project/rg312/mat_files/chapter2_variables/epvars_tav_010.mat','uv_tav','vNth_tav')
load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_010.mat','uE_tav','vN_tav','theta_tav')
xi=-179:2:180;yi=-89:2:90;
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
uvll=cube2latlon(xc,yc,uv_tav,xi,yi);
vNtll=cube2latlon(xc,yc,vNth_tav,xi,yi);
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);

uE_zav_010(:,:) = mean(uEll,1);
vN_zav_010(:,:) = mean(vNll,1);
uv_zav_010(:,:) = mean(uvll,1);
vNt_zav_010(:,:) = mean(vNtll,1);
theta_zav_010(:,:) = mean(thetall,1);
vNt_ed_zav_010 = vNt_zav_010 - vN_zav_010.*theta_zav_010;
uv_ed_zav_010 = uv_zav_010 - uE_zav_010.*vN_zav_010;


load('/project/rg312/mat_files/chapter2_variables/epvars_tav_025.mat','uv_tav','vNth_tav')
load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_025.mat','uE_tav','vN_tav','theta_tav')
xi=-179:2:180;yi=-89:2:90;
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
uvll=cube2latlon(xc,yc,uv_tav,xi,yi);
vNtll=cube2latlon(xc,yc,vNth_tav,xi,yi);
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);

uE_zav_025(:,:) = mean(uEll,1);
vN_zav_025(:,:) = mean(vNll,1);
uv_zav_025(:,:) = mean(uvll,1);
vNt_zav_025(:,:) = mean(vNtll,1);
theta_zav_025(:,:) = mean(thetall,1);
vNt_ed_zav_025 = vNt_zav_025 - vN_zav_025.*theta_zav_025;
uv_ed_zav_025 = uv_zav_025 - uE_zav_025.*vN_zav_025;


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


load('/project/rg312/mat_files/chapter2_variables/epvars_tav_050_tropheat.mat','uv_tav','vNth_tav')
load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_050_tropheat.mat','uE_tav','vN_tav','theta_tav')
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


load('/project/rg312/mat_files/chapter2_variables/epvars_tav_100.mat','uv_tav','vNth_tav')
load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_100.mat','uE_tav','vN_tav','theta_tav')
xi=-179:2:180;yi=-89:2:90;
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
uvll=cube2latlon(xc,yc,uv_tav,xi,yi);
vNtll=cube2latlon(xc,yc,vNth_tav,xi,yi);
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);

uE_zav_100(:,:) = mean(uEll,1);
vN_zav_100(:,:) = mean(vNll,1);
uv_zav_100(:,:) = mean(uvll,1);
vNt_zav_100(:,:) = mean(vNtll,1);
theta_zav_100(:,:) = mean(thetall,1);
vNt_ed_zav_100 = vNt_zav_100 - vN_zav_100.*theta_zav_100;
uv_ed_zav_100 = uv_zav_100 - uE_zav_100.*vN_zav_100;


load('/project/rg312/mat_files/chapter2_variables/epvars_tav_125.mat','uv_tav','vNth_tav')
load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_125.mat','uE_tav','vN_tav','theta_tav')
xi=-179:2:180;yi=-89:2:90;
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
uvll=cube2latlon(xc,yc,uv_tav,xi,yi);
vNtll=cube2latlon(xc,yc,vNth_tav,xi,yi);
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);

uE_zav_125(:,:) = mean(uEll,1);
vN_zav_125(:,:) = mean(vNll,1);
uv_zav_125(:,:) = mean(uvll,1);
vNt_zav_125(:,:) = mean(vNtll,1);
theta_zav_125(:,:) = mean(thetall,1);
vNt_ed_zav_125 = vNt_zav_125 - vN_zav_125.*theta_zav_125;
uv_ed_zav_125 = uv_zav_125 - uE_zav_125.*vN_zav_125;


load('/project/rg312/mat_files/chapter2_variables/epvars_tav_150.mat','uv_tav','vNth_tav')
load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_150.mat','uE_tav','vN_tav','theta_tav')
xi=-179:2:180;yi=-89:2:90;
uEll=cube2latlon(xc,yc,uE_tav,xi,yi);
vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
uvll=cube2latlon(xc,yc,uv_tav,xi,yi);
vNtll=cube2latlon(xc,yc,vNth_tav,xi,yi);
thetall=cube2latlon(xc,yc,theta_tav,xi,yi);

uE_zav_150(:,:) = mean(uEll,1);
vN_zav_150(:,:) = mean(vNll,1);
uv_zav_150(:,:) = mean(uvll,1);
vNt_zav_150(:,:) = mean(vNtll,1);
theta_zav_150(:,:) = mean(thetall,1);
vNt_ed_zav_150 = vNt_zav_150 - vN_zav_150.*theta_zav_150;
uv_ed_zav_150 = uv_zav_150 - uE_zav_150.*vN_zav_150;





for i=1:45
uv_ed_hzav_000(i,:) = (uv_ed_zav_000(45+i,:) - uv_ed_zav_000(46-i))./2;
vNt_ed_hzav_000(i,:) = (vNt_ed_zav_000(45+i,:) - vNt_ed_zav_000(46-i))./2;
theta_hzav_000(i,:) = (theta_zav_000(45+i,:) + theta_zav_000(46-i))./2;

uv_ed_hzav_010(i,:) = (uv_ed_zav_010(45+i,:) - uv_ed_zav_010(46-i))./2;
vNt_ed_hzav_010(i,:) = (vNt_ed_zav_010(45+i,:) - vNt_ed_zav_010(46-i))./2;
theta_hzav_010(i,:) = (theta_zav_010(45+i,:) + theta_zav_010(46-i))./2;

uv_ed_hzav_025(i,:) = (uv_ed_zav_025(45+i,:) - uv_ed_zav_025(46-i))./2;
vNt_ed_hzav_025(i,:) = (vNt_ed_zav_025(45+i,:) - vNt_ed_zav_025(46-i))./2;
theta_hzav_025(i,:) = (theta_zav_025(45+i,:) + theta_zav_025(46-i))./2;

uv_ed_hzav_050(i,:) = (uv_ed_zav_050(45+i,:) - uv_ed_zav_050(46-i))./2;
vNt_ed_hzav_050(i,:) = (vNt_ed_zav_050(45+i,:) - vNt_ed_zav_050(46-i))./2;
theta_hzav_050(i,:) = (theta_zav_050(45+i,:) + theta_zav_050(46-i))./2;

uv_ed_hzav_th(i,:) = (uv_ed_zav_th(45+i,:) - uv_ed_zav_th(46-i))./2;
vNt_ed_hzav_th(i,:) = (vNt_ed_zav_th(45+i,:) - vNt_ed_zav_th(46-i))./2;
theta_hzav_th(i,:) = (theta_zav_th(45+i,:) + theta_zav_th(46-i))./2;

uv_ed_hzav_075(i,:) = (uv_ed_zav_075(45+i,:) - uv_ed_zav_075(46-i))./2;
vNt_ed_hzav_075(i,:) = (vNt_ed_zav_075(45+i,:) - vNt_ed_zav_075(46-i))./2;
theta_hzav_075(i,:) = (theta_zav_075(45+i,:) + theta_zav_075(46-i))./2;

uv_ed_hzav_100(i,:) = (uv_ed_zav_100(45+i,:) - uv_ed_zav_100(46-i))./2;
vNt_ed_hzav_100(i,:) = (vNt_ed_zav_100(45+i,:) - vNt_ed_zav_100(46-i))./2;
theta_hzav_100(i,:) = (theta_zav_100(45+i,:) + theta_zav_100(46-i))./2;

uv_ed_hzav_125(i,:) = (uv_ed_zav_125(45+i,:) - uv_ed_zav_125(46-i))./2;
vNt_ed_hzav_125(i,:) = (vNt_ed_zav_125(45+i,:) - vNt_ed_zav_125(46-i))./2;
theta_hzav_125(i,:) = (theta_zav_125(45+i,:) + theta_zav_125(46-i))./2;

uv_ed_hzav_150(i,:) = (uv_ed_zav_150(45+i,:) - uv_ed_zav_150(46-i))./2;
vNt_ed_hzav_150(i,:) = (vNt_ed_zav_150(45+i,:) - vNt_ed_zav_150(46-i))./2;
theta_hzav_150(i,:) = (theta_zav_150(45+i,:) + theta_zav_150(46-i))./2;


end



%%%%%%%%%%%%%%%%%%%%%%% EP fluxes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dthetadp_000 = gradient(theta_hzav_000,-4000.);
dthetadp_010 = gradient(theta_hzav_010,-4000.);
dthetadp_025 = gradient(theta_hzav_025,-4000.);
dthetadp_050 = gradient(theta_hzav_050,-4000.);
dthetadp_th = gradient(theta_hzav_th,-4000.);
dthetadp_075 = gradient(theta_hzav_075,-4000.);
dthetadp_100 = gradient(theta_hzav_100,-4000.);
dthetadp_125 = gradient(theta_hzav_125,-4000.);
dthetadp_150 = gradient(theta_hzav_150,-4000.);

cosphi = zeros(45,25);
f = zeros(45,25);
omega = 2*pi/(24*60*60);
g=9.8;
a=6371.0e3;

for i=1:25
cosphi(:,i) = cos(yi(46:90).*pi./180);
f(:,i) = 2*omega*sin(yi(46:90).*pi./180);
end

prefactor = cosphi.*2.*pi.*a.^2./g;


%Calculate fluxes and scaled fluxes (Edmon 1980)

Fphi_000 = -1.*a.*cosphi.*uv_ed_hzav_000;
Fp_000 = a.*f.*cosphi.*vNt_ed_hzav_000./dthetadp_000;
Fphi_scaled_000 = Fphi_000.*prefactor./a;
Fp_scaled_000 = Fp_000.*prefactor;
[fluxdiv_p_000 ,fdp_y] = gradient(Fp_scaled_000,-4000);
[fdphi_000,fluxdiv_phi_000] = gradient(Fphi_scaled_000,pi./90.);
fluxdiv_000 = fluxdiv_p_000 + fluxdiv_phi_000;

Fphi_010 = -1.*a.*cosphi.*uv_ed_hzav_010;
Fp_010 = a.*f.*cosphi.*vNt_ed_hzav_010./dthetadp_010;
Fphi_scaled_010 = Fphi_010.*prefactor./a;
Fp_scaled_010 = Fp_010.*prefactor;
[fluxdiv_p_010 ,fdp_y] = gradient(Fp_scaled_010,-4000);
[fdphi_010,fluxdiv_phi_010] = gradient(Fphi_scaled_010,pi./90.);
fluxdiv_010 = fluxdiv_p_010 + fluxdiv_phi_010;

Fphi_025 = -1.*a.*cosphi.*uv_ed_hzav_025;
Fp_025 = a.*f.*cosphi.*vNt_ed_hzav_025./dthetadp_025;
Fphi_scaled_025 = Fphi_025.*prefactor./a;
Fp_scaled_025 = Fp_025.*prefactor;
[fluxdiv_p_025 ,fdp_y] = gradient(Fp_scaled_025,-4000);
[fdphi_025,fluxdiv_phi_025] = gradient(Fphi_scaled_025,pi./90.);
fluxdiv_025 = fluxdiv_p_025 + fluxdiv_phi_025;

Fphi_050 = -1.*a.*cosphi.*uv_ed_hzav_050;
Fp_050 = a.*f.*cosphi.*vNt_ed_hzav_050./dthetadp_050;
Fphi_scaled_050 = Fphi_050.*prefactor./a;
Fp_scaled_050 = Fp_050.*prefactor;
[fluxdiv_p_050 ,fdp_y] = gradient(Fp_scaled_050,-4000);
[fdphi_050,fluxdiv_phi_050] = gradient(Fphi_scaled_050,pi./90.);
fluxdiv_050 = fluxdiv_p_050 + fluxdiv_phi_050;

Fphi_th = -1.*a.*cosphi.*uv_ed_hzav_th;
Fp_th = a.*f.*cosphi.*vNt_ed_hzav_th./dthetadp_th;
Fphi_scaled_th = Fphi_th.*prefactor./a;
Fp_scaled_th = Fp_th.*prefactor;
[fluxdiv_p_th ,fdp_y] = gradient(Fp_scaled_th,-4000);
[fdphi_th,fluxdiv_phi_th] = gradient(Fphi_scaled_th,pi./90.);
fluxdiv_th = fluxdiv_p_th + fluxdiv_phi_th;

Fphi_075 = -1.*a.*cosphi.*uv_ed_hzav_075;
Fp_075 = a.*f.*cosphi.*vNt_ed_hzav_075./dthetadp_075;
Fphi_scaled_075 = Fphi_075.*prefactor./a;
Fp_scaled_075 = Fp_075.*prefactor;
[fluxdiv_p_075 ,fdp_y] = gradient(Fp_scaled_075,-4000);
[fdphi_075,fluxdiv_phi_075] = gradient(Fphi_scaled_075,pi./90.);
fluxdiv_075 = fluxdiv_p_075 + fluxdiv_phi_075;

Fphi_100 = -1.*a.*cosphi.*uv_ed_hzav_100;
Fp_100 = a.*f.*cosphi.*vNt_ed_hzav_100./dthetadp_100;
Fphi_scaled_100 = Fphi_100.*prefactor./a;
Fp_scaled_100 = Fp_100.*prefactor;
[fluxdiv_p_100 ,fdp_y] = gradient(Fp_scaled_100,-4000);
[fdphi_100,fluxdiv_phi_100] = gradient(Fphi_scaled_100,pi./90.);
fluxdiv_100 = fluxdiv_p_100 + fluxdiv_phi_100;

Fphi_125 = -1.*a.*cosphi.*uv_ed_hzav_125;
Fp_125 = a.*f.*cosphi.*vNt_ed_hzav_125./dthetadp_125;
Fphi_scaled_125 = Fphi_125.*prefactor./a;
Fp_scaled_125 = Fp_125.*prefactor;
[fluxdiv_p_125 ,fdp_y] = gradient(Fp_scaled_125,-4000);
[fdphi_125,fluxdiv_phi_125] = gradient(Fphi_scaled_125,pi./90.);
fluxdiv_125 = fluxdiv_p_125 + fluxdiv_phi_125;

Fphi_150 = -1.*a.*cosphi.*uv_ed_hzav_150;
Fp_150 = a.*f.*cosphi.*vNt_ed_hzav_150./dthetadp_150;
Fphi_scaled_150 = Fphi_150.*prefactor./a;
Fp_scaled_150 = Fp_150.*prefactor;
[fluxdiv_p_150 ,fdp_y] = gradient(Fp_scaled_150,-4000);
[fdphi_150,fluxdiv_phi_150] = gradient(Fphi_scaled_150,pi./90.);
fluxdiv_150 = fluxdiv_p_150 + fluxdiv_phi_150;




load('/project/rg312/mat_files/blayer_levs_final.mat');
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
ySize_sub = 0.10; 
xSize_sub = 0.2; 

pos1x = 0.1 ; 	pos1y = 0.83; 
pos2x = 0.37 ; 	pos2y = 0.83; 
pos3x = 0.64 ; 	pos3y = 0.83; 
pos4x = 0.1 ; 	pos4y = 0.69; 
pos5x = 0.37 ; 	pos5y = 0.69; 
pos6x = 0.64 ; 	pos6y = 0.69; 
pos7x = 0.1 ; 	pos7y = 0.55; 
pos8x = 0.37 ; 	pos8y = 0.55; 
pos9x = 0.64 ;   pos9y  = 0.55; 


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


%%% test regridding

for i=1:44
Fphi_scaled_000(i, 1:b_lev_000(45+i)) = 0;
Fp_scaled_000(i, 1:b_lev_000(45+i)) =0;
Fphi_scaled_010(i, 1:b_lev_010(45+i)) = 0;
Fp_scaled_010(i, 1:b_lev_010(45+i)) =0;
Fphi_scaled_025(i, 1:b_lev_025(45+i)) = 0;
Fp_scaled_025(i, 1:b_lev_025(45+i)) =0;
Fphi_scaled_050(i, 1:b_lev_050(45+i)) = 0;
Fp_scaled_050(i, 1:b_lev_050(45+i)) =0;
Fphi_scaled_th(i, 1:b_lev_th(45+i)) = 0;
Fp_scaled_th(i, 1:b_lev_th(45+i)) =0;
Fphi_scaled_075(i, 1:b_lev_075(45+i)) = 0;
Fp_scaled_075(i, 1:b_lev_075(45+i)) =0;
Fphi_scaled_100(i, 1:b_lev_100(45+i)) = 0;
Fp_scaled_100(i, 1:b_lev_100(45+i)) =0;
Fphi_scaled_125(i, 1:b_lev_125(45+i)) = 0;
Fp_scaled_125(i, 1:b_lev_125(45+i)) =0;
Fphi_scaled_150(i, 1:b_lev_150(45+i)) = 0;
Fp_scaled_150(i, 1:b_lev_150(45+i)) =0;
end

for i=1:23
for j=1:13
Fphi_scaled_000_red(i,j) = Fphi_scaled_000(i*2 -1, j*2 -1);
Fp_scaled_000_red(i,j) = Fp_scaled_000(i*2 -1, j*2 -1);
Fphi_scaled_010_red(i,j) = Fphi_scaled_010(i*2 -1, j*2 -1);
Fp_scaled_010_red(i,j) = Fp_scaled_010(i*2 -1, j*2 -1);
Fphi_scaled_025_red(i,j) = Fphi_scaled_025(i*2 -1, j*2 -1);
Fp_scaled_025_red(i,j) = Fp_scaled_025(i*2 -1, j*2 -1);
Fphi_scaled_050_red(i,j) = Fphi_scaled_050(i*2 -1, j*2 -1);
Fp_scaled_050_red(i,j) = Fp_scaled_050(i*2 -1, j*2 -1);
Fphi_scaled_th_red(i,j) = Fphi_scaled_th(i*2 -1, j*2 -1);
Fp_scaled_th_red(i,j) = Fp_scaled_th(i*2 -1, j*2 -1);
Fphi_scaled_075_red(i,j) = Fphi_scaled_075(i*2 -1, j*2 -1);
Fp_scaled_075_red(i,j) = Fp_scaled_075(i*2 -1, j*2 -1);
Fphi_scaled_100_red(i,j) = Fphi_scaled_100(i*2 -1, j*2 -1);
Fp_scaled_100_red(i,j) = Fp_scaled_100(i*2 -1, j*2 -1);
Fphi_scaled_125_red(i,j) = Fphi_scaled_125(i*2 -1, j*2 -1);
Fp_scaled_125_red(i,j) = Fp_scaled_125(i*2 -1, j*2 -1);
Fphi_scaled_150_red(i,j) = Fphi_scaled_150(i*2 -1, j*2 -1);
Fp_scaled_150_red(i,j) = Fp_scaled_150(i*2 -1, j*2 -1);

xspaces(i) = yi(i*2+44 );
yspaces(j) = rC(j*2-1 );

end
end

for i=2:89
blev_press_000(i) = rC(b_lev_000(i));
end



axes('position',[pos1x pos1y xSize_sub ySize_sub])
labelling = num2str(shiftdim([100:100:1000],1));
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_scaled_000_red',1.6e-20.*Fp_scaled_000_red','k','AutoScale','off');
hold on
set(gca,'YDir','reverse','FontSize',10)
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
title(['0.0'],'FontSize',12)
quiver(45, 25, 10, 0,'b');
text(45, 20, '\fontsize{8}1E15 M3(RAD)');
quiver(45, 15, 0, -8,'b');
text(46, 12, '\fontsize{8}5E20 M3(PA)');
ylabel('Pressure, hPa','FontSize',12)
hold off


axes('position',[pos2x pos2y xSize_sub ySize_sub])
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_scaled_010_red',1.6e-20.*Fp_scaled_010_red','k','AutoScale','off');
set(gca,'YDir','reverse','FontSize',10)
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
title(['0.1'],'FontSize',12)
hold off


axes('position',[pos3x pos3y xSize_sub ySize_sub])
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_scaled_025_red',1.6e-20.*Fp_scaled_025_red','k','AutoScale','off');
set(gca,'YDir','reverse','FontSize',10)
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
title(['0.25'],'FontSize',12)
hold off

axes('position',[pos4x pos4y xSize_sub ySize_sub])
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_scaled_050_red',1.6e-20.*Fp_scaled_050_red','k','AutoScale','off');
set(gca,'YDir','reverse','FontSize',10)
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
title(['0.5'],'FontSize',12)
ylabel('Pressure, hPa','FontSize',12)
hold off

axes('position',[pos5x pos5y xSize_sub ySize_sub])
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_scaled_th_red',1.6e-20.*Fp_scaled_th_red','k','AutoScale','off');
set(gca,'YDir','reverse','FontSize',10)
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
title(['tropheat'],'FontSize',12)
hold off


axes('position',[pos6x pos6y xSize_sub ySize_sub])
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_scaled_075_red',1.6e-20.*Fp_scaled_075_red','k','AutoScale','off');
set(gca,'YDir','reverse','FontSize',10)
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
title(['0.75'],'FontSize',12)
hold off

axes('position',[pos7x pos7y xSize_sub ySize_sub])
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_scaled_100_red',1.6e-20.*Fp_scaled_100_red','k','AutoScale','off');
set(gca,'YDir','reverse','FontSize',10)
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)
title(['1.0'],'FontSize',12)
hold off


axes('position',[pos8x pos8y xSize_sub ySize_sub])
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_scaled_125_red',1.6e-20.*Fp_scaled_125_red','k','AutoScale','off');
set(gca,'YDir','reverse','FontSize',10)
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
title(['1.25'],'FontSize',12)
xlabel('Latitude','FontSize',12)
hold off


axes('position',[pos9x pos9y xSize_sub ySize_sub])
quiver(xspaces,yspaces./10^3,1e-14.*Fphi_scaled_150_red',1.6e-20.*Fp_scaled_150_red','k','AutoScale','off');
set(gca,'YDir','reverse','FontSize',10)
xlim([0 90])
ylim([rC(25)./10^3 rC(1)./10^3])
set(gca,'YTickLabel',labelling)
title(['1.5'],'FontSize',12)
xlabel('Latitude','FontSize',12)
hold off


print('ep_flux.pdf','-dpdf')

