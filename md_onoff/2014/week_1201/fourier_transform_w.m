%load up w and plot fourier series vs lat



% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_doshallower_5year/';
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

load('/project/rg312/mat_files/snapshot_data/w_snapshots.mat')

%transfer w to ll
xi=-179:2:180;yi=-89:2:90;
w_000_ll = cube2latlon(xc,yc,w_000,xi,yi);
w_010_ll = cube2latlon(xc,yc,w_010,xi,yi);
w_025_ll = cube2latlon(xc,yc,w_025,xi,yi);
w_050_ll = cube2latlon(xc,yc,w_050,xi,yi);
w_075_ll = cube2latlon(xc,yc,w_075,xi,yi);
w_100_ll = cube2latlon(xc,yc,w_100,xi,yi);

x_000 = squeeze(w_000_ll(:,:,4,:));
x_010 = squeeze(w_010_ll(:,:,4,:));
x_025 = squeeze(w_025_ll(:,:,4,:));
x_050 = squeeze(w_050_ll(:,:,4,:));
x_075 = squeeze(w_075_ll(:,:,4,:));
x_100 = squeeze(w_100_ll(:,:,4,:));

points = 2.^nextpow2(180);
%two sided fourier series
fftx_000_ts = mean((abs(fft(x_000,points))),3)./180;
fftx_010_ts = mean((abs(fft(x_010,points))),3)./180;
fftx_025_ts = mean((abs(fft(x_025,points))),3)./180;
fftx_050_ts = mean((abs(fft(x_050,points))),3)./180;
fftx_075_ts = mean((abs(fft(x_075,points))),3)./180;
fftx_100_ts = mean((abs(fft(x_100,points))),3)./180;

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


fftx_000_time_ts = abs(fft(x_000,points))./180;
fftx_010_time_ts = abs(fft(x_010,points))./180;
fftx_025_time_ts = abs(fft(x_025,points))./180;
fftx_050_time_ts = abs(fft(x_050,points))./180;
fftx_075_time_ts = abs(fft(x_075,points))./180;
fftx_100_time_ts = abs(fft(x_100,points))./180;


fftx_000_time_ss(1,:,:) = fftx_000_time_ts(1,:,:);
fftx_000_time_ss(2:points./2+1,:,:) = fftx_000_time_ts(2:points./2+1,:,:).*2;
fftx_010_time_ss(1,:,:) = fftx_010_time_ts(1,:,:);
fftx_010_time_ss(2:points./2+1,:,:) = fftx_010_time_ts(2:points./2+1,:,:).*2;
fftx_025_time_ss(1,:,:) = fftx_025_time_ts(1,:,:);
fftx_025_time_ss(2:points./2+1,:,:) = fftx_025_time_ts(2:points./2+1,:,:).*2;
fftx_050_time_ss(1,:,:) = fftx_050_time_ts(1,:,:);
fftx_050_time_ss(2:points./2+1,:,:) = fftx_050_time_ts(2:points./2+1,:,:).*2;
fftx_075_time_ss(1,:,:) = fftx_075_time_ts(1,:,:);
fftx_075_time_ss(2:points./2+1,:,:) = fftx_075_time_ts(2:points./2+1,:,:).*2;
fftx_100_time_ss(1,:,:) = fftx_100_time_ts(1,:,:);
fftx_100_time_ss(2:points./2+1,:,:) = fftx_100_time_ts(2:points./2+1,:,:).*2;

test000 = squeeze(fftx_000_time_ss(:,30,:));





wavenos = [0:points-1]./points.*180;

v=0:0.004:0.04; 
contourf(wavenos(1:points./2+1), yi, fftx_000_ss',v);
colorbar('FontSize',15);
caxis([0 0.04])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
xlabel('Wavenumber')
title('Fourier series of w, 0es0')
print('-dpng','fft_000.png')

contourf(wavenos(1:points./2+1), yi, fftx_010_ss',v);
colorbar('FontSize',15);
caxis([0 0.04])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
xlabel('Wavenumber')
title('Fourier series of w, 0.1es0')
print('-dpng','fft_010.png')

contourf(wavenos(1:points./2+1), yi, fftx_025_ss',v);
colorbar('FontSize',15);
caxis([0 0.04])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
xlabel('Wavenumber')
title('Fourier series of w, 0.25es0')
print('-dpng','fft_025.png')

contourf(wavenos(1:points./2+1), yi, fftx_050_ss',v);
colorbar('FontSize',15);
caxis([0 0.04])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
xlabel('Wavenumber')
title('Fourier series of w, 0.5es0')
print('-dpng','fft_050.png')


contourf(wavenos(1:points./2+1), yi, fftx_075_ss',v);
colorbar('FontSize',15);
caxis([0 0.04])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
xlabel('Wavenumber')
title('Fourier series of w, 0.75es0')
print('-dpng','fft_075.png')


contourf(wavenos(1:points./2+1), yi, fftx_100_ss',v);
colorbar('FontSize',15);
caxis([0 0.04])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
xlabel('Wavenumber')
title('Fourier series of w, 1es0')
print('-dpng','fft_100.png')


