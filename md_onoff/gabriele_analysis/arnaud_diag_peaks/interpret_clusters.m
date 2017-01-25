%load in snapshots and remove averages. Contour plots of T' and v'T snapshots for 0 and 1 runs with front diag overlaid


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

load('Cluster_transp8605n.mat')

cluster_plotter = zeros(180,29);

for i = 1:29
	a = cluster_cell{i,801};
	if size(a,2) > 0
		for j = 1:size(a,2)
			cluster_plotter(a(1,j):a(2,j),i) = 1.;
			%cluster_plotter(a(2,j),i) = 1.;
		end
	end
end

contour(xi,yi,cluster_plotter')