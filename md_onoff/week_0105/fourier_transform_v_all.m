%load up w and plot fourier series vs lat



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

load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')

clear('vN_050','vN_075','vN_100')

vN_000_ll = cube2latlon(xc,yc,vN_000,xi,yi);
clear('vN_000')
vN_010_ll = cube2latlon(xc,yc,vN_010,xi,yi);
clear('vN_010')
vN_025_ll = cube2latlon(xc,yc,vN_025,xi,yi);
clear('vN_025')

%two sided fourier series
fftx_000_ts = mean(mean(abs(fft(vN_000_ll)),3),4)./180;
clear('vN_000_ll')
fftx_010_ts = mean(mean(abs(fft(vN_010_ll)),3),4)./180;
clear('vN_010_ll')
fftx_025_ts = mean(mean(abs(fft(vN_025_ll)),3),4)./180;
clear('vN_025_ll')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')
clear('vN_000','vN_010','vN_025')

vN_050_ll = cube2latlon(xc,yc,vN_050,xi,yi);
clear('vN_050')
vN_075_ll = cube2latlon(xc,yc,vN_075,xi,yi);
clear('vN_075')
vN_100_ll = cube2latlon(xc,yc,vN_100,xi,yi);
clear('vN_100')

fftx_050_ts = mean(mean(abs(fft(vN_050_ll)),3),4)./180;
clear('vN_050_ll')
fftx_075_ts = mean(mean(abs(fft(vN_075_ll)),3),4)./180;
clear('vN_075_ll')
fftx_100_ts = mean(mean(abs(fft(vN_100_ll)),3),4)./180;
clear('vN_100_ll')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_th.mat')

vN_th_ll = cube2latlon(xc,yc,vN_th,xi,yi);
clear('vN_th')
fftx_th_ts = mean(mean(abs(fft(vN_th_ll)),3),4)./180;
clear('vN_th_ll')


points = size(fftx_100_ts,1);

%single sides series
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



wavenos = [0:points-1]./points.*180;

figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:7; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_000_ss_hzav(1:21,:)',v);
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 7])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 0.0 Pa')
print('-dpng','fft_000_pav.png')


figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:7; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_010_ss_hzav(1:21,:)',v);
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 7])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 61.078 Pa')
print('-dpng','fft_010_pav.png')


figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:7; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_025_ss_hzav(1:21,:)',v);
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 7])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 152.695 Pa')
print('-dpng','fft_025_pav.png')


figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:7; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_050_ss_hzav(1:21,:)',v);
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 7])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 305.39 Pa')
print('-dpng','fft_050_pav.png')


figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:7; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_075_ss_hzav(1:21,:)',v);
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 7])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 458.085 Pa')
print('-dpng','fft_075_pav.png')

figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_100_ss_hzav(1:21,:)',v);
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 7])
set(gca,'FontSize',15);
%set(gca,'YTickLabel',[]);
xlabel('Wavenumber')
ylabel('Latitude','FontSize',15)
title('e_{s0} = 610.78 Pa')
print('-dpng','fft_100_pav.png')


figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_th_ss_hzav(1:21,:)',v);
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 7])
set(gca,'FontSize',15);
%set(gca,'YTickLabel',[]);
xlabel('Wavenumber')
ylabel('Latitude','FontSize',15)
title('e_{s0} = 305.39 Pa + tropheat')
print('-dpng','fft_th_pav.png')


save('/project/rg312/mat_files/toulouse_poster/fft_poster.mat', 'fftx_000_ss_hzav','fftx_010_ss_hzav','fftx_025_ss_hzav','fftx_050_ss_hzav','fftx_075_ss_hzav' ,'fftx_100_ss_hzav','fftx_th_ss_hzav')
