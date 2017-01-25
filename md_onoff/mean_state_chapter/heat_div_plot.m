
rDir='/project/rg312/final_runs/run_100_final/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
dyc=rdmds([rDir,'DYC']);
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
xi=-179:2:180;yi=-89:2:90;
rC_half = 100000:-4000:0';
a=6371.0e3;
cosphi = repmat(cos(yi.*pi./180)',[1,25]);
g = 9.8;

for i=1:22
    for j=1:13
        xspaces(i) = yi(i*2+44 );
        yspaces(j) = rC(j*2-1 );
    end
end

[vNt_ed_000,wt_ed_000,vNt_div_000,wt_div_000] = wt_vt_div('000');
[vNt_ed_010,wt_ed_010,vNt_div_010,wt_div_010] = wt_vt_div('010');
[vNt_ed_025,wt_ed_025,vNt_div_025,wt_div_025] = wt_vt_div('025');
[vNt_ed_050,wt_ed_050,vNt_div_050,wt_div_050] = wt_vt_div('050');
[vNt_ed_075,wt_ed_075,vNt_div_075,wt_div_075] = wt_vt_div('075');
[vNt_ed_100,wt_ed_100,vNt_div_100,wt_div_100] = wt_vt_div('100');
[vNt_ed_125,wt_ed_125,vNt_div_125,wt_div_125] = wt_vt_div('125');
[vNt_ed_150,wt_ed_150,vNt_div_150,wt_div_150] = wt_vt_div('150');

scalex = 1./a.*180./pi; %/(pi./90);
scaley = 1; %86400; %./(4000./g);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 29.7;                  %# A4 paper size
X = 21;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 1*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 0*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.15; 
xSize_sub = 0.17; 

pos1x = 0.07 ; 	pos1y = 0.75; 
pos2x = 0.29 ; 	pos2y = 0.75; 
pos3x = 0.51 ; 	pos3y = 0.75; 
pos4x = 0.73 ; 	pos4y = 0.75; 
pos5x = 0.07 ; 	pos5y = 0.55; 
pos6x = 0.29 ; 	pos6y = 0.55; 
pos7x = 0.51 ; 	pos7y = 0.55; 
pos8x = 0.73 ; 	pos8y = 0.55; 

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,-vNt_div_000' - wt_div_000',[-8:0.5:4]);
colormap(b2r(-8, 4))
set(gca,'YDir','reverse','FontSize',10)
title(['dry'],'FontSize',12)
ylabel('Pressure, hPa','FontSize',12)
hold on
f(1,:,:) = vNt_ed_000.*scalex;
f(2,:,:) = wt_ed_000.*scaley;
quiver(xspaces, yspaces./100, squeeze(f(1,:,:))', squeeze(f(2,:,:))'./100,'k'); 
freezeColors

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,-vNt_div_010' - wt_div_010',[-8:0.5:4]);
colormap(b2r(-8, 4))
set(gca,'YDir','reverse','FontSize',10)
title(['010'],'FontSize',12)
hold on
f(1,:,:) = vNt_ed_010.*scalex;
f(2,:,:) = wt_ed_010.*scaley;
quiver(xspaces, yspaces./100, squeeze(f(1,:,:))', squeeze(f(2,:,:))'./100,'k'); 
freezeColors

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,-vNt_div_025' - wt_div_025',[-8:0.5:4]);
colormap(b2r(-8, 4))
set(gca,'YDir','reverse','FontSize',10)
title(['025'],'FontSize',12)
hold on
f(1,:,:) = vNt_ed_025.*scalex;
f(2,:,:) = wt_ed_025.*scaley;
quiver(xspaces, yspaces./100, squeeze(f(1,:,:))', squeeze(f(2,:,:))'./100,'k'); 
freezeColors

axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,-vNt_div_050' - wt_div_050',[-8:0.5:4]);
colormap(b2r(-8, 4))
set(gca,'YDir','reverse','FontSize',10)
title(['050'],'FontSize',12)
hold on
f(1,:,:) = vNt_ed_050.*scalex;
f(2,:,:) = wt_ed_050.*scaley;
quiver(xspaces, yspaces./100, squeeze(f(1,:,:))', squeeze(f(2,:,:))'./100,'k');
freezeColors

axes('position',[pos5x pos5y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,-vNt_div_075' - wt_div_075',[-8:0.5:4]);
colormap(b2r(-8, 4))
set(gca,'YDir','reverse','FontSize',10)
title(['075'],'FontSize',12)
ylabel('Pressure, hPa','FontSize',12)
xlabel('Latitude','FontSize',12)
hold on
f(1,:,:) = vNt_ed_075.*scalex;
f(2,:,:) = wt_ed_075.*scaley;
quiver(xspaces, yspaces./100, squeeze(f(1,:,:))', squeeze(f(2,:,:))'./100,'k');
freezeColors

axes('position',[pos6x pos6y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,-vNt_div_100' - wt_div_100',[-8:0.5:4]);
colormap(b2r(-8, 4))
set(gca,'YDir','reverse','FontSize',10)
title(['wet'],'FontSize',12)
xlabel('Latitude','FontSize',12)
hold on
f(1,:,:) = vNt_ed_100.*scalex;
f(2,:,:) = wt_ed_100.*scaley;
quiver(xspaces, yspaces./100, squeeze(f(1,:,:))', squeeze(f(2,:,:))'./100,'k');
freezeColors

axes('position',[pos7x pos7y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,-vNt_div_125' - wt_div_125',[-8:0.5:4]);
colormap(b2r(-8, 4))
set(gca,'YDir','reverse','FontSize',10)
title(['125'],'FontSize',12)
xlabel('Latitude','FontSize',12)
hold on
f(1,:,:) = vNt_ed_125.*scalex;
f(2,:,:) = wt_ed_125.*scaley;
quiver(xspaces, yspaces./100, squeeze(f(1,:,:))', squeeze(f(2,:,:))'./100,'k');
freezeColors

axes('position',[pos8x pos8y xSize_sub ySize_sub])
[C,h] = contourf(yi(46:90),rC./100,-vNt_div_150' - wt_div_150',[-8:0.5:4]);
colormap(b2r(-8, 4))
set(gca,'YDir','reverse','FontSize',10)
title(['150'],'FontSize',12)
xlabel('Latitude','FontSize',12)
hold on
f(1,:,:) = vNt_ed_150.*scalex;
f(2,:,:) = wt_ed_150.*scaley;
quiver(xspaces, yspaces./100, squeeze(f(1,:,:))', squeeze(f(2,:,:))'./100,'k');
originalSize = get(gca, 'Position');
c = colorbar('eastoutside','FontSize',10);
x = get(c,'Position');
x(1) = 0.92; x(2) = 0.57; x(3) = 0.015; x(4) = 0.3;
set(c,'Position',x);
set(gca, 'Position', originalSize);
freezeColors

print('heat_div.pdf','-dpdf')




