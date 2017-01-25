
%load in data

% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_doshallower10/';
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

load('/project/rg312/mat_files/snapshot_data/vt_extreme_data.mat')
load('/project/rg312/mat_files/vt_lats.mat')
load('/project/rg312/mat_files/snapshot_data/vt_ed_data.mat')



[comp_vt_000,check0] = composite_fun(peaks_000,vt_thresh_000,vt_ed_000n,vt_ed_000s,'/project/rg312/mat_files/composite_data_ss/vt_compdata_000.mat');
[comp_vt_010,check1] = composite_fun(peaks_010,vt_thresh_010,vt_ed_010n,vt_ed_010s,'/project/rg312/mat_files/composite_data_ss/vt_compdata_010.mat');
[comp_vt_025,check2] = composite_fun(peaks_025,vt_thresh_025,vt_ed_025n,vt_ed_025s,'/project/rg312/mat_files/composite_data_ss/vt_compdata_025.mat');
[comp_vt_050,check3] = composite_fun(peaks_050,vt_thresh_050,vt_ed_050n,vt_ed_050s,'/project/rg312/mat_files/composite_data_ss/vt_compdata_050.mat');
[comp_vt_075,check4] = composite_fun(peaks_075,vt_thresh_075,vt_ed_075n,vt_ed_075s,'/project/rg312/mat_files/composite_data_ss/vt_compdata_075.mat');
[comp_vt_100,check5] = composite_fun(peaks_100,vt_thresh_100,vt_ed_100n,vt_ed_100s,'/project/rg312/mat_files/composite_data_ss/vt_compdata_100.mat');

for i=1:15
vt_ed_000_mean(i,:,:) = (mean(vt_ed_000n(:,i,:,:),1) + mean(vt_ed_000s(:,16-i,:,:),1))./2;
vt_ed_010_mean(i,:,:) = (mean(vt_ed_010n(:,i,:,:),1) + mean(vt_ed_010s(:,16-i,:,:),1))./2;
vt_ed_025_mean(i,:,:) = (mean(vt_ed_025n(:,i,:,:),1) + mean(vt_ed_025s(:,16-i,:,:),1))./2;
vt_ed_050_mean(i,:,:) = (mean(vt_ed_050n(:,i,:,:),1) + mean(vt_ed_050s(:,16-i,:,:),1))./2;
vt_ed_075_mean(i,:,:) = (mean(vt_ed_075n(:,i,:,:),1) + mean(vt_ed_075s(:,16-i,:,:),1))./2;
vt_ed_100_mean(i,:,:) = (mean(vt_ed_100n(:,i,:,:),1) + mean(vt_ed_100s(:,16-i,:,:),1))./2;
end

figure
plot(squeeze(vt_ed_000_mean(:,4,:))')
xlabel('Time, days')
ylabel('Zonal mean v''T'' at 860 hPa')
title('Zonal mean v''T'' over the baroclinic zone at 860 hPa')
print('-dpng','drift_check_000.png')

plot(squeeze(vt_ed_010_mean(:,4,:))')
xlabel('Time, days')
ylabel('Zonal mean v''T'' at 860 hPa')
title('Zonal mean v''T'' over the baroclinic zone at 860 hPa')
print('-dpng','drift_check_010.png')

plot(squeeze(vt_ed_025_mean(:,4,:))')
xlabel('Time, days')
ylabel('Zonal mean v''T'' at 860 hPa')
title('Zonal mean v''T'' over the baroclinic zone at 860 hPa')
print('-dpng','drift_check_025.png')

plot(squeeze(vt_ed_050_mean(:,4,:))')
xlabel('Time, days')
ylabel('Zonal mean v''T'' at 860 hPa')
title('Zonal mean v''T'' over the baroclinic zone at 860 hPa')
print('-dpng','drift_check_050.png')

plot(squeeze(vt_ed_075_mean(:,4,:))')
xlabel('Time, days')
ylabel('Zonal mean v''T'' at 860 hPa')
title('Zonal mean v''T'' over the baroclinic zone at 860 hPa')
print('-dpng','drift_check_075.png')

plot(squeeze(vt_ed_100_mean(:,4,:))')
xlabel('Time, days')
ylabel('Zonal mean v''T'' at 860 hPa')
title('Zonal mean v''T'' over the baroclinic zone at 860 hPa')
print('-dpng','drift_check_100.png')

figure
plot(sum(sum(check0,1),3))
xlabel('Time, days')
ylabel('Number of ''extreme'' peaks')
title('No. of extremes vs time, 0es_{0}')
print('-dpng','extremeno_000.png')

plot(sum(sum(check1,1),3))
xlabel('Time, days')
ylabel('Number of ''extreme'' peaks')
title('No. of extremes vs time, 0.1es_{0}')
print('-dpng','extremeno_010.png')

plot(sum(sum(check2,1),3))
xlabel('Time, days')
ylabel('Number of ''extreme'' peaks')
title('No. of extremes vs time, 0.25es_{0}')
print('-dpng','extremeno_025.png')

plot(sum(sum(check3,1),3))
xlabel('Time, days')
ylabel('Number of ''extreme'' peaks')
title('No. of extremes vs time, 0.5es_{0}')
print('-dpng','extremeno_050.png')

plot(sum(sum(check4,1),3))
xlabel('Time, days')
ylabel('Number of ''extreme'' peaks')
title('No. of extremes vs time, 0.75es_{0}')
print('-dpng','extremeno_075.png')

plot(sum(sum(check5,1),3))
xlabel('Time, days')
ylabel('Number of ''extreme'' peaks')
title('No. of extremes vs time, 1.0es_{0}')
print('-dpng','extremeno_100.png')
