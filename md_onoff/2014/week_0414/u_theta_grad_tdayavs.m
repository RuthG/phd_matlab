%calculate the various gradient terms in dqdphi and look at what matters...

%Load in data to calculate quasi-geostrophic refractive index.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%We need: u, theta, T

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_tropheat3/'; 
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

i=0;
for nit = 691440:240:705600; 
i=i+1

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_tropheat3/'; 
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE_th3(:,:,:,i),vN_th3(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_th3(:,:,:,i) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp_th3(:,:,j,i)=theta_th3(:,:,j,i).*convthetatoT(j,1);
end

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_accidentalcontrol/'; 
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE_c(:,:,:,i),vN_c(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'THETA   '));
theta_c(:,:,:,i) = dyn(:,:,:,J);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp_c(:,:,j,i)=theta_c(:,:,j,i).*convthetatoT(j,1);
end

end

for i=1:6

uE_av_th3(:,:,:,i) = mean(uE_th3(:,:,:,10*i-9:10*i),4);
theta_av_th3(:,:,:,i) = mean(theta_th3(:,:,:,10*i-9:10*i),4);
temp_av_th3(:,:,:,i) = mean(temp_th3(:,:,:,10*i-9:10*i),4);

uE_av_c(:,:,:,i) = mean(uE_c(:,:,:,10*i-9:10*i),4);
theta_av_c(:,:,:,i) = mean(theta_c(:,:,:,10*i-9:10*i),4);
temp_av_c(:,:,:,i) = mean(temp_c(:,:,:,10*i-9:10*i),4);

end

[uE_zav_th3,mskzon,ylat,areazon]=calcZonalAvgCube(uE_av_th3,ny,yc,ar,hc);
[theta_zav_th3,mskzon,ylat,areazon]=calcZonalAvgCube(theta_av_th3,ny,yc,ar,hc);
[temp_zav_th3,mskzon,ylat,areazon]=calcZonalAvgCube(temp_av_th3,ny,yc,ar,hc);

[uE_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(uE_av_c,ny,yc,ar,hc);
[theta_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(theta_av_c,ny,yc,ar,hc);
[temp_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(temp_av_c,ny,yc,ar,hc);





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Constants needed: a, c, k, f/omega, H, R

a = 6371000; % radius of earth
c = 8.0; %phase speed guesstimate for now
k = 7;   %waveno to look at
omeg = 2.*pi./(24.*60.*60);  %rotation rate of earth
f = 2.*omeg.*sin(ylat.*pi./180);
H = 8000 ;   % Density scale height (taken from Isla's thesis)
R = 287.0 ; %gas const for dry air
g=9.81;

ylat_arr = zeros(90,25,6);
rC_arr = zeros(90,25,6);
f_arr = zeros(90,25,6);
for j=1:6
for i=1:25
ylat_arr(:,i,j) = ylat.*pi./180;
f_arr(:,i,j) = f;
end
for i=1:90
rC_arr(i,:,j) = rC;
end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Next evaluate dq/dphi. Need du/dp, dtheta/dp

%%%%%%%%%%%%%%%%% term1
term1 = 2.*omeg.*cos(ylat_arr);


%%%%%%%%%%%%%%%%% term2
[b,top_c,moo] = gradient(uE_zav_c.*cos(ylat_arr),pi./90);
bottom = a.*cos(ylat_arr);
frac_c = top_c./bottom;
[b,term2_c,moo] = gradient(frac_c,pi./90);           %%%%%%%%%%%%%% term2, control tick!

[b,top_th3,moo] = gradient(uE_zav_th3.*cos(ylat_arr),pi./90);
bottom = a.*cos(ylat_arr);
frac_th3 = top_th3./bottom;
[b,term2_th3,moo] = gradient(frac_th3,pi./90);           %%%%%%%%%%%%%% term2, tropheat3 tick!


%%%%%%%%%%%%%%%%% term3
[dudp_th3,b,moo] = gradient(uE_zav_th3,-4000);           %%%%%%%%%%%%%% du/dp, tropheat3 tick!
[dthetadp_th3,b,moo] = gradient(theta_zav_th3,-4000);    %%%%%%%%%%%%%% dtheta/dp, tropheat3 tick!
[dudp_c,b,moo] = gradient(uE_zav_c,-4000);           %%%%%%%%%%%%%% du/dp, control tick!
[dthetadp_c,b,moo] = gradient(theta_zav_c,-4000);    %%%%%%%%%%%%%% dtheta/dp, control tick!

% Now calculate: diff_c, diff_th3, and then diff_c with each term replaced with th3 contrib...

prod_c = rC_arr.*theta_zav_c./temp_zav_c.*dudp_c./dthetadp_c;
[diff_c,b,moo] = gradient(prod_c,-4000);

prod_th3 = rC_arr.*theta_zav_th3./temp_zav_th3.*dudp_th3./dthetadp_th3;
[diff_th3,b,moo] = gradient(prod_th3,-4000);

prod_1 = rC_arr.*theta_zav_th3./temp_zav_th3.*dudp_c./dthetadp_c;  %theta T ratio fn of p only, so shouldn't make big diff.
prod_2 = rC_arr.*theta_zav_c./temp_zav_c.*dudp_th3./dthetadp_c;    %effect of dudp
prod_3 = rC_arr.*theta_zav_c./temp_zav_c.*dudp_c./dthetadp_th3;    %effect of dthetadp

[diff_1,b,moo] = gradient(prod_1,-4000);
[diff_2,b,moo] = gradient(prod_2,-4000);
[diff_3,b,moo] = gradient(prod_3,-4000);

term3_c = a.*f_arr.^2./R.*diff_c;
term3_th3 = a.*f_arr.^2./R.*diff_th3;
term3_1 = a.*f_arr.^2./R.*diff_1;
term3_2 = a.*f_arr.^2./R.*diff_2;
term3_3 = a.*f_arr.^2./R.*diff_3;


dqdphi_th3 = term1 - term2_th3 + term3_th3;
dqdphi_c = term1 - term2_c + term3_c;


bit1_th3 = dqdphi_th3./(a.*(uE_zav_th3-c));
bit1_c = dqdphi_c./(a.*(uE_zav_c-c));
bit1_1 = dqdphi_th3./(a.*(uE_zav_c-c));
bit1_2 = dqdphi_c./(a.*(uE_zav_th3-c));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Page 1: change in qphi/a(u-c)
%Page 2: change in qphi/a(u-c) with only qphi changed
%Page 3: change in qphi/a(u-c) with only u changed
%Page 4: change in qphi
%Page 5: change in qphi with only dudthi changed
%Page 6: change in qphi with only last term changed
%Page 7: change in qphi with only dudp changed
%Page 8: change in qphi with only dthetadp changed

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
X = 21.0;                  %# A4 paper size
Y = 29.7;                  %# A4 paper size
xMargin = 0.75;               %# left/right margins from page borders
yMargin = 1;               %# bottom/top margins from page borders
xSize = X - 2*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 2*yMargin;     %# figure size on paper (widht & hieght)
xSize_sub = 0.4;
ySize_sub = 1./3-0.1;

pos1x = 0.1 ; 	pos1y = 2/3+0.05; 
pos2x = 0.55;	pos2y = 2/3+0.05;
pos3x = 0.1; 	pos3y = 1/3+0.05;
pos4x = 0.55; 	pos4y = 1/3+0.05;
pos5x = 0.1; 	pos5y = 0.05;
pos6x = 0.55; 	pos6y = 0.05;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



masking_c = zeros(90,25,6);
masking_c_load = zeros(90,25);
masking_th3 = zeros(90,25,6);
masking_th3_load = zeros(90,25);
masking_1 = zeros(90,25,6);
masking_1_load = zeros(90,25);
masking_2 = zeros(90,25,6);
masking_2_load = zeros(90,25);


for i=1:6
masking_th3_load(find(bit1_th3(:,:,i) >= 0 & bit1_c(:,:,i) >=0)) = 1;
masking_th3(:,:,i) = masking_th3_load;
masking_1_load(find(bit1_1(:,:,i) >= 0 & bit1_c(:,:,i) >=0)) = 1;
masking_1(:,:,i) = masking_1_load;
masking_2_load(find(bit1_2(:,:,i) >= 0 & bit1_c(:,:,i) >=0)) = 1;
masking_2(:,:,i) = masking_2_load;
end

bit1_diff_th3 = bit1_th3 - bit1_c;
bit1_diff_1 = bit1_1 - bit1_c;
bit1_diff_2 = bit1_2 - bit1_c;

for i=1:45
masking_th3_hzav(46-i,:,:) = (masking_th3(i,:,:) + masking_th3(91-i,:,:))./2;
masking_1_hzav(46-i,:,:) = (masking_1(i,:,:) + masking_1(91-i,:,:))./2;
masking_2_hzav(46-i,:,:) = (masking_2(i,:,:) + masking_2(91-i,:,:))./2;
bit1_diff_th3_hzav(46-i,:,:) = (bit1_diff_th3(i,:,:) + bit1_diff_th3(91-i,:,:))./2;
bit1_diff_1_hzav(46-i,:,:) = (bit1_diff_1(i,:,:) + bit1_diff_1(91-i,:,:))./2;
bit1_diff_2_hzav(46-i,:,:) = (bit1_diff_2(i,:,:) + bit1_diff_2(91-i,:,:))./2;
end

masking_th3_hzav(find(masking_th3_hzav < 1 )) = 0;
masking_1_hzav(find(masking_1_hzav < 1 )) = 0;
masking_2_hzav(find(masking_2_hzav < 1 )) = 0;

bit1_diff_masked_th3 = bit1_diff_th3_hzav.*masking_th3_hzav;
bit1_diff_masked_1 = bit1_diff_1_hzav.*masking_1_hzav;
bit1_diff_masked_2 = bit1_diff_2_hzav.*masking_2_hzav;



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-1e-11:0.5e-12:1e-11;
[C,h]=contourf(ylat(46:90),rC./100.,bit1_diff_masked_th3(:,:,1)',v,'k--');
colormap(b2r(-1e-11,1e-11));
colorbar
caxis([-1e-11 1e-11]);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-1e-11:0.5e-12:1e-11;
[C,h]=contourf(ylat(46:90),rC./100.,bit1_diff_masked_th3(:,:,2)',v,'k--');
colormap(b2r(-1e-11,1e-11));
colorbar
caxis([-1e-11 1e-11]);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-1e-11:0.5e-12:1e-11;
[C,h]=contourf(ylat(46:90),rC./100.,bit1_diff_masked_th3(:,:,3)',v,'k--');
colormap(b2r(-1e-11,1e-11));
colorbar
caxis([-1e-11 1e-11]);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-1e-11:0.5e-12:1e-11;
[C,h]=contourf(ylat(46:90),rC./100.,bit1_diff_masked_th3(:,:,4)',v,'k--');
colormap(b2r(-1e-11,1e-11));
colorbar
caxis([-1e-11 1e-11]);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);

axes('position',[pos5x pos5y xSize_sub ySize_sub])
v=-1e-11:0.5e-12:1e-11;
[C,h]=contourf(ylat(46:90),rC./100.,bit1_diff_masked_th3(:,:,5)',v,'k--');
colormap(b2r(-1e-11,1e-11));
colorbar
caxis([-1e-11 1e-11]);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);

axes('position',[pos6x pos6y xSize_sub ySize_sub])
v=-1e-11:0.5e-12:1e-11;
[C,h]=contourf(ylat(46:90),rC./100.,bit1_diff_masked_th3(:,:,6)',v,'k--');
colormap(b2r(-1e-11,1e-11));
colorbar
caxis([-1e-11 1e-11]);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);

print('-dpdf','bit1_tropheat3.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-1e-11:0.5e-12:1e-11;
[C,h]=contourf(ylat(46:90),rC./100.,bit1_diff_masked_1(:,:,1)',v,'k--');
colormap(b2r(-1e-11,1e-11));
colorbar
caxis([-1e-11 1e-11]);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-1e-11:0.5e-12:1e-11;
[C,h]=contourf(ylat(46:90),rC./100.,bit1_diff_masked_1(:,:,2)',v,'k--');
colormap(b2r(-1e-11,1e-11));
colorbar
caxis([-1e-11 1e-11]);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-1e-11:0.5e-12:1e-11;
[C,h]=contourf(ylat(46:90),rC./100.,bit1_diff_masked_1(:,:,3)',v,'k--');
colormap(b2r(-1e-11,1e-11));
colorbar
caxis([-1e-11 1e-11]);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-1e-11:0.5e-12:1e-11;
[C,h]=contourf(ylat(46:90),rC./100.,bit1_diff_masked_1(:,:,4)',v,'k--');
colormap(b2r(-1e-11,1e-11));
colorbar
caxis([-1e-11 1e-11]);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);

axes('position',[pos5x pos5y xSize_sub ySize_sub])
v=-1e-11:0.5e-12:1e-11;
[C,h]=contourf(ylat(46:90),rC./100.,bit1_diff_masked_1(:,:,5)',v,'k--');
colormap(b2r(-1e-11,1e-11));
colorbar
caxis([-1e-11 1e-11]);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);

axes('position',[pos6x pos6y xSize_sub ySize_sub])
v=-1e-11:0.5e-12:1e-11;
[C,h]=contourf(ylat(46:90),rC./100.,bit1_diff_masked_1(:,:,6)',v,'k--');
colormap(b2r(-1e-11,1e-11));
colorbar
caxis([-1e-11 1e-11]);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);

print('-dpdf','bit1_qphionly.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-1e-11:0.5e-12:1e-11;
[C,h]=contourf(ylat(46:90),rC./100.,bit1_diff_masked_2(:,:,1)',v,'k--');
colormap(b2r(-1e-11,1e-11));
colorbar
caxis([-1e-11 1e-11]);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);

axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-1e-11:0.5e-12:1e-11;
[C,h]=contourf(ylat(46:90),rC./100.,bit1_diff_masked_2(:,:,2)',v,'k--');
colormap(b2r(-1e-11,1e-11));
colorbar
caxis([-1e-11 1e-11]);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);

axes('position',[pos3x pos3y xSize_sub ySize_sub])
v=-1e-11:0.5e-12:1e-11;
[C,h]=contourf(ylat(46:90),rC./100.,bit1_diff_masked_2(:,:,3)',v,'k--');
colormap(b2r(-1e-11,1e-11));
colorbar
caxis([-1e-11 1e-11]);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);

axes('position',[pos4x pos4y xSize_sub ySize_sub])
v=-1e-11:0.5e-12:1e-11;
[C,h]=contourf(ylat(46:90),rC./100.,bit1_diff_masked_2(:,:,4)',v,'k--');
colormap(b2r(-1e-11,1e-11));
colorbar
caxis([-1e-11 1e-11]);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);

axes('position',[pos5x pos5y xSize_sub ySize_sub])
v=-1e-11:0.5e-12:1e-11;
[C,h]=contourf(ylat(46:90),rC./100.,bit1_diff_masked_2(:,:,5)',v,'k--');
colormap(b2r(-1e-11,1e-11));
colorbar
caxis([-1e-11 1e-11]);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);

axes('position',[pos6x pos6y xSize_sub ySize_sub])
v=-1e-11:0.5e-12:1e-11;
[C,h]=contourf(ylat(46:90),rC./100.,bit1_diff_masked_2(:,:,6)',v,'k--');
colormap(b2r(-1e-11,1e-11));
colorbar
caxis([-1e-11 1e-11]);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
freezeColors
cbfreeze(colorbar);

print('-dpdf','bit1_uonly.pdf')

return
 Now plot up changes in the above. What seems to be most responsible for changes to 'diff' (not trivial, but have a look. Maybe use control data to check what matters...?)

figure
v=-0.0005:0.00005:0.0005;
contourf(ylat,rC,-1.*term2_th3(:,:,6)' + term2_c(:,:,6)',v)
colormap(b2r(-0.0005,0.0005));
colorbar
caxis([-0.0005 0.0005]);
xlabel('Latitude');
ylabel('Pressure, Pa');
title('Change in dudthi dependent term');
set(gca,'YDir','reverse')
print('-dpng','term2_change.png')

figure
v=-0.0005:0.00005:0.0005;
contourf(ylat,rC,term3_th3(:,:,6)' - term3_c(:,:,6)',v)
colormap(b2r(-0.0005,0.0005));
colorbar
caxis([-0.0005 0.0005]);
xlabel('Latitude');
ylabel('Pressure, Pa');
title('Change in dudp and dthetadp dependent term');
set(gca,'YDir','reverse')
print('-dpng','term3_change.png')

%figure
%contourf(ylat,rC,term3_1(:,:,6)' - term3_c(:,:,6)')
%colorbar
%set(gca,'YDir','reverse')

figure
v=-0.0005:0.00005:0.0005;
contourf(ylat,rC,term3_2(:,:,6)' - term3_c(:,:,6)',v)
colormap(b2r(-0.0005,0.0005));
colorbar
caxis([-0.0005 0.0005]);
xlabel('Latitude');
ylabel('Pressure, Pa');
title('Change in dudp and dthetadp dependent term, only dudp changed');
set(gca,'YDir','reverse')
print('-dpng','dudp_change.png')

figure
v=-0.0005:0.00005:0.0005;
contourf(ylat,rC,term3_3(:,:,6)' - term3_c(:,:,6)',v)
colormap(b2r(-0.0005,0.0005));
colorbar
caxis([-0.0005 0.0005]);
xlabel('Latitude');
ylabel('Pressure, Pa');
title('Change in dudp and dthetadp dependent term, only dthetadp changed');
set(gca,'YDir','reverse')
print('-dpng','dthetadp_change.png')


figure
v=-0.0005:0.00005:0.0005;
contourf(ylat,rC,dqdphi_th3(:,:,6)' - dqdphi_c(:,:,6)',v)
colormap(b2r(-0.0005,0.0005));
colorbar
caxis([-0.0005 0.0005]);
xlabel('Latitude');
ylabel('Pressure, Pa');
title('Change in dqdthi');
set(gca,'YDir','reverse')
print('-dpng','dqdthi_change.png')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Produce similar plots for dqdphi compared with u changing in qgref


masking_c = zeros(90,25,6);
masking_c_load = zeros(90,25);
masking_th3 = zeros(90,25,6);
masking_th3_load = zeros(90,25);
masking_1 = zeros(90,25,6);
masking_1_load = zeros(90,25);
masking_2 = zeros(90,25,6);
masking_2_load = zeros(90,25);


for i=1:6

masking_th3_load(find(bit1_th3(:,:,i) >= 0 & bit1_c(:,:,i) >=0)) = 1;
masking_th3(:,:,i) = masking_th3_load;
masking_1_load(find(bit1_1(:,:,i) >= 0 & bit1_c(:,:,i) >=0)) = 1;
masking_1(:,:,i) = masking_1_load;
masking_2_load(find(bit1_2(:,:,i) >= 0 & bit1_c(:,:,i) >=0)) = 1;
masking_2(:,:,i) = masking_2_load;

end

bit1_diff_th3 = bit1_th3 - bit1_c;
bit1_diff_1 = bit1_1 - bit1_c;
bit1_diff_2 = bit1_2 - bit1_c;

bit1_diff_masked_th3 = bit1_diff_th3.*masking_th3;
bit1_diff_masked_1 = bit1_diff_1.*masking_1;
bit1_diff_masked_2 = bit1_diff_2.*masking_2;



figure
v=-1e-11:0.5e-12:1e-11;
[C,h] = contourf(ylat,rC,bit1_diff_masked_th3(:,:,1)',v);
colormap(b2r(-1e-11,1e-11));
colorbar
caxis([-1e-11 1e-11]);
xlabel('Latitude');
ylabel('Pressure, Pa');
title('Change in qphi/a(u-c)');
set(gca,'YDir','reverse')
print('-dpng','bit1_change.png')

figure
v=-1e-11:0.5e-12:1e-11;
[C,h] = contourf(ylat,rC,bit1_diff_masked_1(:,:,1)',v);
colormap(b2r(-1e-11,1e-11));
colorbar
caxis([-1e-11 1e-11]);
xlabel('Latitude');
ylabel('Pressure, Pa');
title('Change in qphi/a(u-c), only qphi');
set(gca,'YDir','reverse')
print('-dpng','bit1_dqdthi_change.png')

figure
v=-1e-11:0.5e-12:1e-11;
[C,h] = contourf(ylat,rC,bit1_diff_masked_2(:,:,1)',v);
colormap(b2r(-1e-11,1e-11));
colorbar
caxis([-1e-11 1e-11]);
xlabel('Latitude');
ylabel('Pressure, Pa');
title('Change in qphi/a(u-c), only u');
set(gca,'YDir','reverse')
print('-dpng','bit1_u_change.png')

