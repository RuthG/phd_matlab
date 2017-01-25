%calculate stability, use v'T' lat to estimate storm track region, plot pdf of stability-moist lapse rate over storm track


% choose directory, load grid
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
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
ny=90;
xi=-179:2:180;yi=-89:2:90;

g=9.8;
cp = 1004.64;
L=2.5e6;
Ra=287.04;
Rv=461.50;
epsilon = Ra/Rv;
T0 = 273.16;
%convtheta(1,1,:,1)=(rC/100000.0).^(2./7.);
%convthetatoT = repmat(convtheta,[180,90,1]);

load('/project/rg312/mat_files/vt_lats_final.mat')

for j = 1:10
j

load(['/project/rg312/mat_files/snapshot_data_final/run_000_ns/t_000_' num2str(j) '.mat'])
t_000_ll = cube2latlon(xc,yc,t_000,xi,yi);
clear('t_000')

dtdp_000 = zeros(180,90,25,360);
[a,b,dtdp_000] = gradient(t_000_ll,-4000);

es_000 = 0.*610.78.*exp((L./Rv).*(1./T0 - 1./t_000_ll));

rho_000_ll = zeros(180,90,25,360);
for i=1:25
rho_000_ll(:,:,i,:) = rC(i)./(Ra.*t_000_ll(:,:,i,:));
end

dtdz_000 = g.*rho_000_ll.*dtdp_000;

mus_000 = zeros(180,90,25,360);
for i=1:25
mus_000(:,:,i,:) = epsilon.*es_000(:,:,i,:)./(rC(i)-es_000(:,:,i,:)); 
end

gamma_s_000 = g./cp .* (1 + L.*mus_000./(Ra.*t_000_ll))./(1+ L^2.*mus_000./(cp.*Rv.*t_000_ll.^2));

stab_diff(:,:,:) = (dtdz_000(:,:,13,:) - gamma_s_000(:,:,13,:)).*1000;



for i=1:90
%include lat weighting too
i
xbins = -15:0.3:15;

stab_counts = hist(reshape(stab_diff(:,i,:),[numel(stab_diff(:,i,:)),1]),xbins);
stab_counts_cos(i,:) = stab_counts.*cos(yi(i).*pi./180);

end

stab_hist_data_full(:,j) = sum(stab_counts_cos,1);

stab_hist_data_midlats(:,j) = sum(stab_counts_cos(x000n-7:x000n+7,:),1) + sum(stab_counts_cos(x000s-7:x000s+7,:),1);

stab_hist_data_midlatstight(:,j) = sum(stab_counts_cos(x000n,:),1) + sum(stab_counts_cos(x000s,:),1);

stab_hist_data_tropics(:,j) = sum(stab_counts_cos(41:50,:),1);

end

stab_hist_data_full = sum(stab_hist_data_full,2);
stab_hist_data_midlats = sum(stab_hist_data_midlats,2);
stab_hist_data_midlatstight = sum(stab_hist_data_midlatstight,2);
stab_hist_data_tropics = sum(stab_hist_data_tropics,2);

save('/project/rg312/mat_files/snapshot_data_final/run_000_ns/stab_hist_data_000.mat', 'xbins', 'stab_hist_data_full', 'stab_hist_data_midlats', 'stab_hist_data_midlatstight', 'stab_hist_data_tropics')

return

