% load up v'T' and temperature data to calculate lowest level of the tropopause and the extent of the 'baroclinic zone'

rDir='/project/rg312/run_delsol02/';

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
yi = -89:2:89;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run %%%%%%%%%%%%%%%%

niti = 173040;
nits = 240;
nitt = 259200;

var(1,:) = 'UVEL    ';
var(2,:) = 'THETA   ';
var(3,:) = 'UVELTH  ';
var(4,:) = 'UVELSQ  ';
var(5,:) = 'VVELSQ  ';

%varv = zeros(size(var));
varv(1,:) = 'VVEL    ';
varv(2,:) = '        ';
varv(3,:) = 'VVELTH  ';
varv(4,:) = '        ';
varv(5,:) = '        ';

preloaded = true;

if preloaded

load('barzonvars.mat')

else

rDir='/project/rg312/run_delsol02/';
[tzav_02,tzavv_02] = mit_zavs(rDir,var,niti,nitt,nits,'varv',varv);

'tzav_02 loaded'

rDir='/project/rg312/wv_on_rad_off/run_doshallower_5year/';
[tzav_14,tzavv_14] = mit_zavs(rDir,var,259200,'varv',varv);

'tzav_14 loaded'

rDir='/project/rg312/run_delsol18/';
[tzav_18,tzavv_18] = mit_zavs(rDir,var,niti,nitt,nits,'varv',varv);

'tzav_18 loaded'

end

tke_02 = (tzav_02(:,:,4) + tzav_02(:,:,5))./2;
tke_14 = (tzav_14(:,:,4) + tzav_14(:,:,5))./2;
tke_18 = (tzav_18(:,:,4) + tzav_18(:,:,5))./2;


convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
t_02(:,j)=tzav_02(:,j,2).*convthetatoT(j,1);
t_14(:,j)=tzav_14(:,j,2).*convthetatoT(j,1);
t_18(:,j)=tzav_18(:,j,2).*convthetatoT(j,1);

end

zke_02 = (tzav_02(:,:,1).^2 + tzavv_02(:,:,1).^2)./2;
zke_14 = (tzav_14(:,:,1).^2 + tzavv_14(:,:,1).^2)./2;
zke_18 = (tzav_18(:,:,1).^2 + tzavv_18(:,:,1).^2)./2;


eke_02 =  tke_02 - zke_02;
eke_14 =  tke_14 - zke_14;
eke_18 =  tke_18 - zke_18;

vNt_zon_02 = tzavv_02(:,:,1).*tzav_02(:,:,2);
vNt_zon_14 = tzavv_14(:,:,1).*tzav_14(:,:,2);
vNt_zon_18 = tzavv_18(:,:,1).*tzav_18(:,:,2);

vNt_ed_02 = tzavv_02(:,:,3) - vNt_zon_02;
vNt_ed_14 = tzavv_14(:,:,3) - vNt_zon_14;
vNt_ed_18 = tzavv_18(:,:,3) - vNt_zon_18;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% first find tropopause height %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:25
rhoair_02(:,i) = rC(i)./(287.058.*t_02(:,i));
rhoair_14(:,i) = rC(i)./(287.058.*t_14(:,i));
rhoair_18(:,i) = rC(i)./(287.058.*t_18(:,i));
end

g=9.81;
dtdp_02 = gradient(t_02,-4000.);
dtdz_02 = -1.*rhoair_02.*g.*dtdp_02.*1000;
dtdp_14 = gradient(t_14,-4000.);
dtdz_14 = -1.*rhoair_14.*g.*dtdp_14.*1000;
dtdp_18 = gradient(t_18,-4000.);
dtdz_18 = -1.*rhoair_18.*g.*dtdp_18.*1000;


for i=1:88
trop_02(i) = rC(min(find((dtdz_02(i+1,:) >= -2))));
trop_14(i) = rC(min(find((dtdz_14(i+1,:) >= -2))));
trop_18(i) = rC(min(find((dtdz_18(i+1,:) >= -2))));
end

sigma_t_max_02 = max(trop_02);
level_02 = find(rC == sigma_t_max_02);
sigma_t_max_14 = max(trop_14);
level_14 = find(rC == sigma_t_max_14);
sigma_t_max_18 = max(trop_18);
level_18 = find(rC == sigma_t_max_18);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%Now use this to calculate latitude where integral of v'theta'cos(lat) from surf to tropopause is max %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dsigma = 4000/100000;

for i=1:90
barzon_a_02(i,:) = vNt_ed_02(i,1:level_02).*cos(yi(i).*pi./180);
barzon_a_14(i,:) = vNt_ed_14(i,1:level_14).*cos(yi(i).*pi./180);
barzon_a_18(i,:) = vNt_ed_18(i,1:level_18).*cos(yi(i).*pi./180);
end

barzon_b_02 = dsigma.*sum(barzon_a_02,2);
barzon_b_14 = dsigma.*sum(barzon_a_14,2);
barzon_b_18 = dsigma.*sum(barzon_a_18,2);

for i=1:45
barzon_c_02(i) = (barzon_b_02(91-i) - barzon_b_02(i))./2;
barzon_c_14(i) = (barzon_b_14(91-i) - barzon_b_14(i))./2;
barzon_c_18(i) = (barzon_b_18(91-i) - barzon_b_18(i))./2;
end

barzon_centre_02 = find(barzon_c_02 == max(barzon_c_02));
barzon_centre_14 = find(barzon_c_14 == max(barzon_c_14));
barzon_centre_18 = find(barzon_c_18 == max(barzon_c_18));

barzon_lats_02(1) = abs(yi(barzon_centre_02)) - 15;
barzon_lats_02(2) = abs(yi(barzon_centre_02)) + 15;
barzon_lats_14(1) = abs(yi(barzon_centre_14)) - 15;
barzon_lats_14(2) = abs(yi(barzon_centre_14)) + 15;
barzon_lats_18(1) = abs(yi(barzon_centre_18)) - 15;
barzon_lats_18(2) = abs(yi(barzon_centre_18)) + 15;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% identify edges of baroclinic zone %%%%%%%%%%%%%%%%%%%%%%%%%

if(mod(barzon_lats_02(1),2)==0)
plot_min_02 = barzon_lats_02(1)-1;
plot_max_02 = barzon_lats_02(2)+1;
else
plot_min_02 = barzon_lats_02(1);
plot_max_02 = barzon_lats_02(2);
end

if(mod(barzon_lats_14(1),2)==0)
plot_min_14 = barzon_lats_14(1)-1;
plot_max_14 = barzon_lats_14(2)+1;
else
plot_min_14 = barzon_lats_14(1);
plot_max_14 = barzon_lats_14(2);
end

if(mod(barzon_lats_18(1),2)==0)
plot_min_18 = barzon_lats_18(1)-1;
plot_max_18 = barzon_lats_18(2)+1;
else
plot_min_18 = barzon_lats_18(1);
plot_max_18 = barzon_lats_18(2);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% plot to check calc makes sens %%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v = 180:5:300;
contourf(yi,rC,t_02',v)
colorbar
set(gca,'YDir','reverse')
caxis([180 300])
hold on
plot(yi(2:89),trop_02,'k','LineWidth',2)
plot([plot_min_02, plot_min_02],[98000,0],'k--')
plot([-plot_min_02, -plot_min_02],[98000,0],'k--')
plot([plot_max_02, plot_max_02],[98000,0],'k--')
plot([-plot_max_02, -plot_max_02],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_02,sigma_t_max_02],'k--')
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v = 180:5:300;
contourf(yi,rC,t_14',v)
colorbar
set(gca,'YDir','reverse')
caxis([180 300])
hold on
plot(yi(2:89),trop_14,'k','LineWidth',2)
plot([plot_min_14, plot_min_14],[98000,0],'k--')
plot([-plot_min_14, -plot_min_14],[98000,0],'k--')
plot([plot_max_14, plot_max_14],[98000,0],'k--')
plot([-plot_max_14, -plot_max_14],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_14,sigma_t_max_14],'k--')
hold off

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v = 180:5:300;
contourf(yi,rC,t_18',v)
colorbar
set(gca,'YDir','reverse')
caxis([180 300])
hold on
plot(yi(2:89),trop_18,'k','LineWidth',2)
plot([plot_min_18, plot_min_18],[98000,0],'k--')
plot([-plot_min_18, -plot_min_18],[98000,0],'k--')
plot([plot_max_18, plot_max_18],[98000,0],'k--')
plot([-plot_max_18, -plot_max_18],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_18,sigma_t_max_18],'k--')
hold off

print('-dpdf','temp_eke.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-20:2:20;
contourf(yi,rC,vNt_ed_02',v)
colorbar
set(gca,'YDir','reverse')
caxis([-20 20])
hold on
plot(yi(2:89),trop_02,'k','LineWidth',2)
plot([plot_min_02, plot_min_02],[98000,0],'k--')
plot([-plot_min_02, -plot_min_02],[98000,0],'k--')
plot([plot_max_02, plot_max_02],[98000,0],'k--')
plot([-plot_max_02, -plot_max_02],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_02,sigma_t_max_02],'k--')
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-20:2:20;
contourf(yi,rC,vNt_ed_14',v)
colorbar
set(gca,'YDir','reverse')
caxis([-20 20])
hold on
plot(yi(2:89),trop_14,'k','LineWidth',2)
plot([plot_min_14, plot_min_14],[98000,0],'k--')
plot([-plot_min_14, -plot_min_14],[98000,0],'k--')
plot([plot_max_14, plot_max_14],[98000,0],'k--')
plot([-plot_max_14, -plot_max_14],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_14,sigma_t_max_14],'k--')
hold off

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-20:2:20;
contourf(yi,rC,vNt_ed_18',v)
colorbar
set(gca,'YDir','reverse')
caxis([-20 20])
hold on
plot(yi(2:89),trop_18,'k','LineWidth',2)
plot([plot_min_18, plot_min_18],[98000,0],'k--')
plot([-plot_min_18, -plot_min_18],[98000,0],'k--')
plot([plot_max_18, plot_max_18],[98000,0],'k--')
plot([-plot_max_18, -plot_max_18],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_18,sigma_t_max_18],'k--')
hold off

print('-dpdf','vted_eke.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos2x pos2y xSize_sub ySize_sub])
v = 250:10:750;
contourf(yi,rC,tzav_02(:,:,2)',v)
colorbar
set(gca,'YDir','reverse')
caxis([250 750])
hold on
plot(yi(2:89),trop_02,'k','LineWidth',2)
plot([plot_min_02, plot_min_02],[98000,0],'k--')
plot([-plot_min_02, -plot_min_02],[98000,0],'k--')
plot([plot_max_02, plot_max_02],[98000,0],'k--')
plot([-plot_max_02, -plot_max_02],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_02,sigma_t_max_02],'k--')
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v = 250:10:750;
contourf(yi,rC,tzav_14(:,:,2)',v)
colorbar
set(gca,'YDir','reverse')
caxis([250 750])
hold on
plot(yi(2:89),trop_14,'k','LineWidth',2)
plot([plot_min_14, plot_min_14],[98000,0],'k--')
plot([-plot_min_14, -plot_min_14],[98000,0],'k--')
plot([plot_max_14, plot_max_14],[98000,0],'k--')
plot([-plot_max_14, -plot_max_14],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_14,sigma_t_max_14],'k--')
hold off

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v = 250:10:750;
contourf(yi,rC,tzav_18(:,:,2)',v)
colorbar
set(gca,'YDir','reverse')
caxis([250 750])
hold on
plot(yi(2:89),trop_18,'k','LineWidth',2)
plot([plot_min_18, plot_min_18],[98000,0],'k--')
plot([-plot_min_18, -plot_min_18],[98000,0],'k--')
plot([plot_max_18, plot_max_18],[98000,0],'k--')
plot([-plot_max_18, -plot_max_18],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_18,sigma_t_max_18],'k--')
hold off

print('-dpdf','theta_eke.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v = 0:10:230;
contourf(yi,rC,eke_02',v)
colorbar
set(gca,'YDir','reverse')
caxis([0 230])
hold on
plot(yi(2:89),trop_02,'k','LineWidth',2)
plot([plot_min_02, plot_min_02],[98000,0],'k--')
plot([-plot_min_02, -plot_min_02],[98000,0],'k--')
plot([plot_max_02, plot_max_02],[98000,0],'k--')
plot([-plot_max_02, -plot_max_02],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_02,sigma_t_max_02],'k--')
hold off

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v = 0:10:230;
contourf(yi,rC,eke_14',v)
colorbar
set(gca,'YDir','reverse')
caxis([0 230])
hold on
plot(yi(2:89),trop_14,'k','LineWidth',2)
plot([plot_min_14, plot_min_14],[98000,0],'k--')
plot([-plot_min_14, -plot_min_14],[98000,0],'k--')
plot([plot_max_14, plot_max_14],[98000,0],'k--')
plot([-plot_max_14, -plot_max_14],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_14,sigma_t_max_14],'k--')
hold off

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v = 0:10:230;
contourf(yi,rC,eke_18',v)
colorbar
set(gca,'YDir','reverse')
caxis([0 230])
hold on
plot(yi(2:89),trop_18,'k','LineWidth',2)
plot([plot_min_18, plot_min_18],[98000,0],'k--')
plot([-plot_min_18, -plot_min_18],[98000,0],'k--')
plot([plot_max_18, plot_max_18],[98000,0],'k--')
plot([-plot_max_18, -plot_max_18],[98000,0],'k--')
plot([-89, 89],[sigma_t_max_18,sigma_t_max_18],'k--')
hold off

print('-dpdf','eke_eke.pdf')





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

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v = -30:5:30;
contourf(yi,rC,vNt_ed_02',v)
colorbar
colormap(b2r(-30,30));
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v = -30:5:30;
contourf(yi,rC,vNt_ed_14',v)
colorbar
colormap(b2r(-30,30));
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v = -30:5:30;
contourf(yi,rC,vNt_ed_18')
colorbar
colormap(b2r(-30,30));
set(gca,'YDir','reverse')
freezeColors
cbfreeze(colorbar);

print('-dpdf','vt_ed_eke.pdf')


name = ['bc_box_02.mat'];
save(name,'barzon_lats_02','level_02')
name = ['bc_box_14.mat'];
save(name,'barzon_lats_14','level_14')
name = ['bc_box_18.mat'];
save(name,'barzon_lats_18','level_18')

return

