%load in eddy heat transport for the wet run and check values and structure when this is integrated up against papers.

function [ed_heat_trans,dry_ed_heat_trans] = heat_transport_plot(run)

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
xi=-179:2:179;yi=-89:2:90;
L = 2.500e6;
cp = 287.04./(2./7.);
g=9.8;
a=6371.0e3;

%load up latitudes of peak v'T'

%load heat rates
t_var = ['t_' run];
q_var = ['q_' run];
vN_var = ['vN_' run];
blev_var = ['b_lev_' run];

load(['/project/rg312/mat_files/snapshot_data_final/run_' run '/vN_' run '_timemean.mat']);
vN_ll_tav = repmat(vN_ll_tav,[1 1 1 360]);

load(['/project/rg312/mat_files/snapshot_data_final/run_' run '/t_' run '_timemean.mat']);
t_ll_tav = repmat(t_ll_tav,[1 1 1 360]);

load(['/project/rg312/mat_files/snapshot_data_final/run_' run '/q_' run '_timemean.mat']);
q_ll_tav = repmat(q_ll_tav,[1 1 1 360]);

year = 1;

vN_cs = load(['/project/rg312/mat_files/snapshot_data_final/run_' run '/vN_' run '_' num2str(year) '.mat'],vN_var);
vN_cs = vN_cs.(vN_var);
vN_ll = squeeze(cube2latlon(xc,yc,vN_cs,xi,yi));
vN_ed = vN_ll - vN_ll_tav;
clear('vN_ll')

t_cs = load(['/project/rg312/mat_files/snapshot_data_final/run_' run '/t_' run '_' num2str(year) '.mat'],t_var);
t_cs = t_cs.(t_var);
t_ll = squeeze(cube2latlon(xc,yc,t_cs,xi,yi));
t_ed = t_ll - t_ll_tav;
clear('t_ll')

q_cs = load(['/project/rg312/mat_files/snapshot_data_final/run_' run '/q_' run '_' num2str(year) '.mat'],q_var);
q_cs = q_cs.(q_var);
q_ll = squeeze(cube2latlon(xc,yc,q_cs,xi,yi));
q_ed = q_ll - q_ll_tav;
clear('q_ll')

vNH_ed = cp.*vN_ed.*t_ed + L.*vN_ed.*q_ed;
cvNT_ed = cp.*vN_ed.*t_ed;

vNH_ed_mean = mean(vNH_ed,4);
cvNT_ed_mean = mean(cvNT_ed,4);

for i=1:90
ed_heat_trans(i) = 2.*pi.*a.*cos(yi(i).*pi./180).*squeeze(mean(sum(vNH_ed_mean(:,i,:),3),1)).*4000./g;
dry_ed_heat_trans(i) = 2.*pi.*a.*cos(yi(i).*pi./180).*squeeze(mean(sum(cvNT_ed_mean(:,i,:),3),1)).*4000./g;
end

