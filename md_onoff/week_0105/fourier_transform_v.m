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
%load('/project/rg312/mat_files/snapshot_data/vN_snapshots_th.mat')
clear('vN_010','vN_025','vN_050','vN_075')

vN_000_ll = cube2latlon(xc,yc,vN_000,xi,yi);
vN_100_ll = cube2latlon(xc,yc,vN_100,xi,yi);

clear('vN_000','vN_100')

x_000 = squeeze(vN_000_ll(:,:,:,:));
x_100 = squeeze(vN_100_ll(:,:,:,:));
x_000_u = squeeze(vN_000_ll(:,:,20,:));
x_100_u = squeeze(vN_100_ll(:,:,20,:));

%two sided fourier series
fftx_000_ts = mean(mean(abs(fft(x_000)),3),4)./180;
fftx_100_ts = mean(mean(abs(fft(x_100)),3),4)./180;

fftx_000_ts_u = mean(abs(fft(x_000_u)),3)./180;
fftx_100_ts_u = mean(abs(fft(x_100_u)),3)./180;

points = size(fftx_100_ts,1);

%single sides series
fftx_000_ss(1,:) = fftx_000_ts(1,:);
fftx_000_ss(2:points./2+1,:) = fftx_000_ts(2:points./2+1,:).*2;
fftx_100_ss(1,:) = fftx_100_ts(1,:);
fftx_100_ss(2:points./2+1,:) = fftx_100_ts(2:points./2+1,:).*2;

fftx_000_ss_u(1,:) = fftx_000_ts_u(1,:);
fftx_000_ss_u(2:points./2+1,:) = fftx_000_ts_u(2:points./2+1,:).*2;
fftx_100_ss_u(1,:) = fftx_100_ts_u(1,:);
fftx_100_ss_u(2:points./2+1,:) = fftx_100_ts_u(2:points./2+1,:).*2;

for i = 1:45

fftx_000_ss_hzav(:,i) = (fftx_000_ss(:,45+i) + fftx_000_ss(:,46-i))./2;
fftx_100_ss_hzav(:,i) = (fftx_100_ss(:,45+i) + fftx_100_ss(:,46-i))./2;

fftx_000_ss_u_hzav(:,i) = (fftx_000_ss_u(:,45+i) + fftx_000_ss_u(:,46-i))./2;
fftx_100_ss_u_hzav(:,i) = (fftx_100_ss_u(:,45+i) + fftx_100_ss_u(:,46-i))./2;

end

save('/project/rg312/mat_files/toulouse_poster/fft_poster.mat','fftx_000_ss_hzav','fftx_100_ss_hzav')

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
v=0:1:12; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_000_ss_u_hzav(1:21,:)',v);
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 12])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 0.0 Pa')
print('-dpng','fft_000.png')


figure
set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_100_ss_u_hzav(1:21,:)',v);
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 12])
set(gca,'FontSize',15);
%set(gca,'YTickLabel',[]);
xlabel('Wavenumber')
ylabel('Latitude','FontSize',15)
title('e_{s0} = 610.78 Pa')
print('-dpng','fft_100.png')



return

figure
v=0:0.5:5; 
[C,h] = contour(wavenos(1:21), yi(46:90), fftx_000_ss_hzav(1:21,:)',v,'k');
clabel(C,h,v,'FontSize',12);
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
xlabel('Wavenumber')
title('Fourier series of v, 0es0')
print('-dpng','fft_000_l.png')


figure
[C,h] = contour(wavenos(1:21), yi(46:90), fftx_100_ss_hzav(1:21,:)',v,'k');
clabel(C,h,v,'FontSize',12);
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
xlabel('Wavenumber')
title('Fourier series of v, 1es0')
print('-dpng','fft_100_l.png')



return



points = 2.^nextpow2(180);
%two sided fourier series
fftx_000_ts = mean((abs(fft(x_000,points))),3)./180;
fftx_050_ts = mean((abs(fft(x_050,points))),3)./180;
fftx_100_ts = mean((abs(fft(x_100,points))),3)./180;

%single sides series
fftx_000_ss(1,:) = fftx_000_ts(1,:);
fftx_000_ss(2:points./2+1,:) = fftx_000_ts(2:points./2+1,:).*2;
fftx_050_ss(1,:) = fftx_050_ts(1,:);
fftx_050_ss(2:points./2+1,:) = fftx_050_ts(2:points./2+1,:).*2;
fftx_100_ss(1,:) = fftx_100_ts(1,:);
fftx_100_ss(2:points./2+1,:) = fftx_100_ts(2:points./2+1,:).*2;

fftx_000_time_ts = abs(fft(x_000,points))./180;
fftx_050_time_ts = abs(fft(x_050,points))./180;
fftx_100_time_ts = abs(fft(x_100,points))./180;


fftx_000_time_ss(1,:,:) = fftx_000_time_ts(1,:,:);
fftx_000_time_ss(2:points./2+1,:,:) = fftx_000_time_ts(2:points./2+1,:,:).*2;
fftx_050_time_ss(1,:,:) = fftx_050_time_ts(1,:,:);
fftx_050_time_ss(2:points./2+1,:,:) = fftx_050_time_ts(2:points./2+1,:,:).*2;
fftx_100_time_ss(1,:,:) = fftx_100_time_ts(1,:,:);
fftx_100_time_ss(2:points./2+1,:,:) = fftx_100_time_ts(2:points./2+1,:,:).*2;

%test000 = squeeze(fftx_000_time_ss(:,30,:));


wavenos = [0:points-1]./points.*180;

figure
v=0:0.5:8; 
contourf(wavenos(1:points./2+1), yi, fftx_000_ss',v);
colorbar('FontSize',15);
caxis([0 8])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
xlabel('Wavenumber')
title('Fourier series of v, 0es0')
print('-dpng','fft_000.png')

figure
contourf(wavenos(1:points./2+1), yi, fftx_050_ss',v);
colorbar('FontSize',15);
caxis([0 8])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
xlabel('Wavenumber')
title('Fourier series of v, 0.5es0')
print('-dpng','fft_050.png')

figure
contourf(wavenos(1:points./2+1), yi, fftx_100_ss',v);
colorbar('FontSize',15);
caxis([0 8])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
xlabel('Wavenumber')
title('Fourier series of v, 1es0')
print('-dpng','fft_100.png')


