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
xi = 1:2:359;

load('/project/rg312/gabriele/vN_H_ed_detrended.mat')
load('/project/rg312/gabriele/vNH_ed.mat')

radius = 6371.0e3;
f = 10^-4;

load('/project/rg312/gabriele/front_diag.mat', 'dTgrad_vort');

load('cmap_strf.mat');

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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for day=801
	

	hFig = figure(1); clf;
	%# figure size printed on paper
	set(hFig, 'PaperUnits','centimeters')
	set(hFig, 'PaperSize',[30 20])
	set(hFig, 'PaperPosition',[0 0 26 16])
%	set(hFig, 'PaperOrientation','portrait')
	
	%set(hFig, 'units', 'normalized', 'Position', [.1 .1 1. 1.])
	%figure(1), clf
	%axes('position',[0.15 0.15 0.8 0.8])
	v=-1e5:0.25e5:1e5;
	[C,h] = contourf(xi,yi,vNH_ed_860n(:,1:29,day)',v);
	set(h,'LineColor','none')
	hold on
	v = -0.9:1:0.1;
    [C,h] = contour(xi,yi,dTgrad_vort(:,60:88,day)',v,'Color',[0.4 0 0],'LineWidth',2);
	[C,h] = contour(xi,yi,cluster_plotter',v,'b','LineWidth',2);
	hold off
	shading interp
	axis tight
	xlim([0 360])
	ylim([30 85])
	set(gca,'XTick',[0 90 180 270]);
	set(gca,'YTick',[30 45 60 75]);
	daspect(gca,[2.2 1 1]) 
	colorbar('eastoutside');
	colormap(gca, cmap_strf)
	caxis([-1e5 1e5]);
	c = colorbar;
	c.Ticks = [-100000 -50000 0 50000 100000];
	ax = gca
	axpos = ax.Position;
	cpos = c.Position;
	cpos(3) = 0.3*cpos(3);
	c.Position = cpos;
	ax.Position = axpos;
	xlabel('Longitude');
	ylabel('Latitude')
	savefig(['vH_snapshots_full_' num2str(day)])
	%print('-bestfit',['vH_snapshots_full_' num2str(day)],'-dpdf')
	%print('-dpng',['vH_snapshots_full_' num2str(day) '.png'])
	

	figure(1), clf
	v=-1e4:0.25e4:1e4;
	[C,h] = contourf(xi,yi,H_ed_860_n_dt(:,1:29,day)',v);
	set(h,'LineColor','none')
	hold on
	v = -0.9:1:0.1;
    [C,h] = contour(xi,yi,dTgrad_vort(:,60:88,day)',v,'Color',[0.4 0 0],'LineWidth',2);
	[C,h] = contour(xi,yi,cluster_plotter',v,'b', 'LineWidth',2);
	hold off
	shading interp
	axis tight
	xlim([0 360])
	ylim([30 85])
	set(gca,'XTick',[0 90 180 270]);
	set(gca,'YTick',[30 45 60 75]);
	daspect(gca,[2.2 1 1]) 
	colorbar('eastoutside');
	colormap(gca, cmap_strf)
	caxis([-1e4 1e4]);
	c = colorbar;
	c.Ticks = [-10000 -5000 0 5000 10000];
	ax = gca
	axpos = ax.Position;
	cpos = c.Position;
	cpos(3) = 0.3*cpos(3);
	c.Position = cpos;
	ax.Position = axpos;
	xlabel('Longitude')%, 'fontsize', 26);
	ylabel('Latitude')%, 'fontsize', 26)
	savefig(['H_snapshots_full_' num2str(day)])
	print('-bestfit',['H_snapshots_full_' num2str(day)],'-dpdf')

end

