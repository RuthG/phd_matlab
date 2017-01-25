%load in snapshots and remove averages. Contour plots of T' and v'T snapshots for 0 and 1 runs with front diag overlaid

addpath('/project/rgeen/matlab/bin/')

rDir='/net/spat-nas/project/rg312/final_runs/run_000_final_noshallow/';
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
yi=31:2:87;
xi = -179:2:179;

load('/project/rg312/gabriele/vN_H_ed_detrended.mat')
load('/project/rg312/gabriele/vNH_ed.mat')

radius = 6371.0e3;
f = 10^-4;

load('/project/rg312/gabriele/front_diag.mat', 'dTgrad_vort');

load('Cluster_transp8605n.mat')
cluster_plotter = zeros(180,29);
for i = 1:29
	a = cluster_cell{i,801};
	if size(a,2) > 0
		for j = 1:size(a,2)
			cluster_plotter(a(1,j):a(2,j),i) = 1.;
		end
	end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 24; %25.0;                  %# A4 paper size
X =  16; %32; % 20;                  %# A4 paper size
yMargin = 0;               %# left/right margins from page borders
xMargin = 0;               %# bottom/top margins from page borders
xSize = X - 2*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 2*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.35 ; %0.35; %0.4;
xSize_sub = 0.65 ; %0.35; %0.7;

pos1x = 0.15 ; 	pos1y = 0.55; 
pos2x = 0.15;	pos2y = 0.15; 

for day=801
	
	hFig = figure('Menubar','none');
	%# figure size printed on paper
	set(hFig, 'PaperUnits','centimeters')
	set(hFig, 'PaperSize',[X Y])
	set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
	set(hFig, 'PaperOrientation','portrait')

	axes('position',[pos1x pos1y xSize_sub ySize_sub])
	v=-1e5:1e4:1e5;
	[C,h] = contourf(xi,yi,vNH_ed_860n(:,1:29,day)',v);
	set(h,'LineColor','none')
	set(gca,'FontSize',12)
	hold on
	v = -0.9:1:0.1;
    [C,h] = contour(xi,yi,dTgrad_vort(:,60:88,day)',v,'Color','k','LineWidth',1);
	[C,h] = contour(xi,yi,cluster_plotter',v,'Color',[0.5,0.5,0.5],'LineWidth',1);
	colormap(b2r(-1.e5,1.e5)); freezeColors
	xlim([-90 90])
	ylim([30 85])
	text(-115,85,'\fontsize{15} (a)')
	originalSize = get(gca, 'Position');
	c = colorbar('eastoutside','FontSize',15);
	set(gca, 'Position', originalSize)
	ylabel('Latitude','FontSize',15)

	axes('position',[pos2x pos2y xSize_sub ySize_sub])
	v=-1e4:1e3:1e4;
	[C,h] = contourf(xi,yi,H_ed_860_n_dt(:,1:29,day)',v);
	set(h,'LineColor','none')
	set(gca,'FontSize',12)
	hold on
	v = -0.9:1:0.1;
    [C,h] = contour(xi,yi,dTgrad_vort(:,60:88,day)',v,'Color','k','LineWidth',1);
	[C,h] = contour(xi,yi,cluster_plotter',v,'Color',[0.5,0.5,0.5],'LineWidth',1);
	colormap(b2r(-1e4,1e4)); freezeColors
	xlim([-90 90])
	ylim([30 85])
	text(-115,85,'\fontsize{15} (b)')
	originalSize = get(gca, 'Position');
	c = colorbar('eastoutside','FontSize',15);
	set(gca, 'Position', originalSize)
	ylabel('Latitude','FontSize',15)
	xlabel('Longitude','FontSize',15)

	print('-dpdf',['vH_H_snapshots_' num2str(day) '.pdf'])
	
	
	
	
	
	
	
	figure(1), clf
	axesm('pcarree','MapLatLimit',latlim,'MapLonLimit',lonlim);
	H1 = surfm(latmat,lonmat,h_var);
	xlabel('Longitude', 'fontsize', 26);
	ylabel('Latitude', 'fontsize', 26)
	hold on
	hp = plotm(lat,long,'k');
	set(hp,'LineWidth',2.0);
	%Display coastline
	contourm(latmat,lonmat,flipud(cluster_mat), [1 1], 'b', 'Linewidth', 2);
	contourm(latmat,lonmat,flipud(fronts_mat), [1 1], 'Color', [0.4 0 0], 'Linewidth', 2);
	hold off
	shading interp
	axis tight
	daspect(gca,[2 1 1]);
	colorbar('eastoutside');
	colormap(gca, cmap_strf)
	caxis([-1e4 1e4]);
	c = colorbar;
	c.Ticks = [-10000 -5000 0 5000 10000];
	


	hFig = figure('Menubar','none');
	%# figure size printed on paper
	set(hFig, 'PaperUnits','centimeters')
	set(hFig, 'PaperSize',[X Y])
	set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
	set(hFig, 'PaperOrientation','portrait')

	axes('position',[pos1x pos1y xSize_sub ySize_sub])
	v=-1e5:1e4:1e5;
	[C,h] = contourf(xi,yi,vNH_ed_860n(:,1:29,day)',v);
	set(h,'LineColor','none')
	set(gca,'FontSize',12)
	hold on
	v = -0.9:1:0.1;
    [C,h] = contour(xi,yi,dTgrad_vort(:,60:88,day)',v,'Color','k','LineWidth',1);
	[C,h] = contour(xi,yi,cluster_plotter',v,'Color',[0.5,0.5,0.5],'LineWidth',1);
	%colormap(b2r(-1.e5,1.e5)); freezeColors
	colormap(gca, cmap_strf)
	xlim([-180 180])
	ylim([30 85])
	text(-230,85,'\fontsize{15} (a)')
	originalSize = get(gca, 'Position');
	c = colorbar('eastoutside','FontSize',15);
	set(gca, 'Position', originalSize)
	ylabel('Latitude','FontSize',15)

	axes('position',[pos2x pos2y xSize_sub ySize_sub])
	v=-1e4:1e3:1e4;
	[C,h] = contourf(xi,yi,H_ed_860_n_dt(:,1:29,day)',v);
	set(h,'LineColor','none')
	set(gca,'FontSize',12)
	hold on
	v = -0.9:1:0.1;
    [C,h] = contour(xi,yi,dTgrad_vort(:,60:88,day)',v,'Color','k','LineWidth',1);
	[C,h] = contour(xi,yi,cluster_plotter',v,'Color',[0.5,0.5,0.5],'LineWidth',1);
	colormap(b2r(-1e4,1e4)); freezeColors
	xlim([-180 180])
	ylim([30 85])
	text(-230,85,'\fontsize{15} (b)')
	originalSize = get(gca, 'Position');
	c = colorbar('eastoutside','FontSize',15);
	set(gca, 'Position', originalSize)
	ylabel('Latitude','FontSize',15)
	xlabel('Longitude','FontSize',15)

	print('-dpdf',['vH_H_snapshots_full_' num2str(day) '.pdf'])

end

