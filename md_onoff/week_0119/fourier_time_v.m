%load in v snapshots
%for each latitude band take the fourier transform of the time series at each longitude
%identify frequencies and average over time and pressure


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
xi=-179:2:180;yi=-89:2:90;


Fs = 1/60/60/24;
T = 1/Fs;
L = 720;
t = (0:L-1).*T;

NFFT = 2^nextpow2(L); % Next power of 2 from length of y


load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')

clear('vN_010','vN_025','vN_050','vN_075','vN_100')

vN_000_ll = cube2latlon(xc,yc,vN_000,xi,yi);
clear('vN_000')

x_000 = shiftdim(vN_000_ll,3);
clear('vN_000_ll')

%two sided fourier series
fftx_000_ts = squeeze(mean(mean(abs(fft(x_000,NFFT)),2),4)./720);


load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')

clear('vN_000','vN_025','vN_050','vN_075','vN_100')

vN_010_ll = cube2latlon(xc,yc,vN_010,xi,yi);
clear('vN_010')

x_010 = shiftdim(vN_010_ll,3);
clear('vN_010_ll')

%two sided fourier series
fftx_010_ts = squeeze(mean(mean(abs(fft(x_010,NFFT)),2),4)./720);

load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')

clear('vN_010','vN_000','vN_050','vN_075','vN_100')

vN_025_ll = cube2latlon(xc,yc,vN_025,xi,yi);
clear('vN_025')

x_025 = shiftdim(vN_025_ll,3);
clear('vN_025_ll')

%two sided fourier series
fftx_025_ts = squeeze(mean(mean(abs(fft(x_025,NFFT)),2),4)./720);


load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')

clear('vN_010','vN_025','vN_000','vN_075','vN_100')

vN_050_ll = cube2latlon(xc,yc,vN_050,xi,yi);
clear('vN_050')

x_050 = shiftdim(vN_050_ll,3);
clear('vN_050_ll')

%two sided fourier series
fftx_050_ts = squeeze(mean(mean(abs(fft(x_050,NFFT)),2),4)./720);

load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')

clear('vN_010','vN_025','vN_050','vN_000','vN_100')

vN_075_ll = cube2latlon(xc,yc,vN_075,xi,yi);
clear('vN_075')

x_075 = shiftdim(vN_075_ll,3);
clear('vN_075_ll')

%two sided fourier series
fftx_075_ts = squeeze(mean(mean(abs(fft(x_075,NFFT)),2),4)./720);

load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')

clear('vN_010','vN_025','vN_050','vN_075','vN_000')

vN_100_ll = cube2latlon(xc,yc,vN_100,xi,yi);
clear('vN_100')

x_100 = shiftdim(vN_100_ll,3);
clear('vN_100_ll')

%two sided fourier series
fftx_100_ts = squeeze(mean(mean(abs(fft(x_100,NFFT)),2),4)./720);


load('/project/rg312/mat_files/snapshot_data/vN_snapshots_th.mat')

vN_th_ll = cube2latlon(xc,yc,vN_th,xi,yi);
clear('vN_th')

x_th = shiftdim(vN_th_ll,3);
clear('vN_th_ll')

%two sided fourier series
fftx_th_ts = squeeze(mean(mean(abs(fft(x_th,NFFT)),2),4)./720);

points = size(fftx_100_ts,1);


%single sided series
fftx_000_ss(1,:) = fftx_000_ts(1,:);
fftx_000_ss(2:points./2+1,:) = fftx_000_ts(2:points./2+1,:).*2;
fftx_010_ss(1,:) = fftx_010_ts(1,:);
fftx_010_ss(2:points./2+1,:) = fftx_010_ts(2:points./2+1,:).*2;
fftx_025_ss(1,:) = fftx_025_ts(1,:);
fftx_025_ss(2:points./2+1,:) = fftx_025_ts(2:points./2+1,:).*2;
fftx_050_ss(1,:) = fftx_050_ts(1,:);
fftx_050_ss(2:points./2+1,:) = fftx_050_ts(2:points./2+1,:).*2;
fftx_075_ss(1,:) = fftx_075_ts(1,:);
fftx_075_ss(2:points./2+1,:) = fftx_075_ts(2:points./2+1,:).*2;
fftx_100_ss(1,:) = fftx_100_ts(1,:);
fftx_100_ss(2:points./2+1,:) = fftx_100_ts(2:points./2+1,:).*2;
fftx_th_ss(1,:) = fftx_th_ts(1,:);
fftx_th_ss(2:points./2+1,:) = fftx_th_ts(2:points./2+1,:).*2;

for i = 1:45

fftx_000_ss_hzav(:,i) = (fftx_000_ss(:,45+i) + fftx_000_ss(:,46-i))./2;
fftx_010_ss_hzav(:,i) = (fftx_010_ss(:,45+i) + fftx_010_ss(:,46-i))./2;
fftx_025_ss_hzav(:,i) = (fftx_025_ss(:,45+i) + fftx_025_ss(:,46-i))./2;
fftx_050_ss_hzav(:,i) = (fftx_050_ss(:,45+i) + fftx_050_ss(:,46-i))./2;
fftx_075_ss_hzav(:,i) = (fftx_075_ss(:,45+i) + fftx_075_ss(:,46-i))./2;
fftx_100_ss_hzav(:,i) = (fftx_100_ss(:,45+i) + fftx_100_ss(:,46-i))./2;
fftx_th_ss_hzav(:,i) = (fftx_th_ss(:,45+i) + fftx_th_ss(:,46-i))./2;
end


f = Fs/2*linspace(0,1,NFFT/2+1);
period = 1./f./86400;


figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:0.25:3; 
[C,h] = contourf(period(29:513), yi(46:90), fftx_000_ss_hzav(29:513,:)',v);
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 3])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Time Period, days')
title('e_{s0} = 0.0 Pa')
print('-dpng','fft_time_000_pav.png')




figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:0.25:3; 
[C,h] = contourf(period(29:513), yi(46:90), fftx_010_ss_hzav(29:513,:)',v);
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 3])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Time Period, days')
title('e_{s0} = 61.078 Pa')
print('-dpng','fft_time_010_pav.png')



figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:0.25:3; 
[C,h] = contourf(period(29:513), yi(46:90), fftx_025_ss_hzav(29:513,:)',v);
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 3])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Time Period, days')
title('e_{s0} = 152.695 Pa')
print('-dpng','fft_time_025_pav.png')




figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:0.25:3; 
[C,h] = contourf(period(29:513), yi(46:90), fftx_050_ss_hzav(29:513,:)',v);
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 3])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Time Period, days')
title('e_{s0} = 305.39 Pa')
print('-dpng','fft_time_050_pav.png')




figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:0.25:3; 
[C,h] = contourf(period(29:513), yi(46:90), fftx_th_ss_hzav(29:513,:)',v);
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 3])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Time Period, days')
title('e_{s0} = 305.39 Pa + Tropical Heating')
print('-dpng','fft_time_th_pav.png')



figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:0.25:3; 
[C,h] = contourf(period(29:513), yi(46:90), fftx_075_ss_hzav(29:513,:)',v);
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 3])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Time Period, days')
title('e_{s0} = 458.085 Pa')
print('-dpng','fft_time_075_pav.png')




figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:0.25:3; 
[C,h] = contourf(period(29:513), yi(46:90), fftx_100_ss_hzav(29:513,:)',v);
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 3])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Time Period, days')
title('e_{s0} = 610.78 Pa')
print('-dpng','fft_time_100_pav.png')

