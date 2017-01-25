%load up daily tau data, incl spinup, so can check how the mom budg issues develop over time.

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
yi = -89:2:89;
xi = -179:2:179;
Ra=287.04;

%[evap,precip] = load_evpr_fun('100');
load('/project/rg312/mat_files/chapter2_variables/evpr_100.mat');

omega = 2*pi/(24*60*60);
a=6371.0e3;

%[taux,tauy,tauE] = load_tau_fun('100');
load('/project/rg312/mat_files/chapter2_variables/tau_100.mat');


for j=1:10
j
name=['/project/rg312/mat_files/snapshot_data_final/run_100/eta_100_' num2str(j) '.mat'];
load(name);

name=['/project/rg312/mat_files/snapshot_data_final/run_100/t_100_' num2str(j) '.mat'];
load(name);

rho_100(:,:,:) = 98000./(Ra.*t_100(:,:,1,:));

ph_surf(:,:,j*360-359:j*360) = eta_100./rho_100;
eta(:,:,j*360-359:j*360) = eta_100;

end

eta_ll = cube2latlon(xc,yc,eta,xi,yi);
h_surf_ll = cube2latlon(xc,yc,ph_surf,xi,yi)./9.8;

dhdlon = shiftdim(gradient(shiftdim(h_surf_ll,2),pi./90),1);

tq_o_step = sum(dhdlon.*eta_ll , 1).*pi./90.*a;

for j=1:90
    tq_o_nextstep(j,:) = tq_o_step(1,j,:).*cos(yi(j).*pi./180);
end

tq_o_sum = sum(tq_o_nextstep(2:89,:),1).*pi./90.*a;
tq_o_mean = tq_o_sum./sum(sum(ar));



%tauE_ll=cube2latlon(xc,yc,tauE,xi,yi);

for j=1:11
  for i=1:360
    ms_tq(j,i) = sum(sum((evap(:,:,j,i)-precip(:,:,j,i)).*omega.*a.^2.*cos(yc.*pi./180).^2.*ar,1),2)./sum(sum(ar));
    tau_mean(j,i) = sum(sum(tauE(:,:,j,i).*ar,1),2)./sum(sum(ar));
    tq_mean(j,i) = sum(sum(tauE(:,:,j,i).*cos(yc.*pi./180).*a.*ar,1),2)./sum(sum(ar));
  end
end

figure
plot(tau_mean(11,:))
xlabel('Time, days')
ylabel('Global mean surface stress, N/m^2')

figure
plot(tq_mean(11,:))
xlabel('Time, days')
ylabel('Global mean torque')

tau_mean_tseries = reshape(tau_mean,[1,360*11]);
ms_tq_tseries = reshape(ms_tq,[1,360*11]);
tq_mean_tseries = reshape(tq_mean,[1,360*11]);


figure
plot(tau_mean_tseries)
xlabel('Time, days')
ylabel('Global mean surface stress, N/m^2')

figure
plot(ms_tq_tseries)
xlabel('Time, days')
ylabel('Global mean moisture torque')

figure
plot(tq_mean_tseries)
xlabel('Time, days')
ylabel('Global mean wind stress torque')
