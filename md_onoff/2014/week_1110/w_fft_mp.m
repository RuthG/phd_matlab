%compare fractions of descent to ascent in snapshots

xi = -179:2:179;
yi = -89:2:89;
% choose directory, load grid
load('/project/rg312/mat_files/w_snapshots_saved.mat')
w_000_ll = squeeze(cube2latlon(xc,yc,w_000(:,:,11,:),xi,yi));
w_010_ll = squeeze(cube2latlon(xc,yc,w_010(:,:,11,:),xi,yi));
w_025_ll = squeeze(cube2latlon(xc,yc,w_025(:,:,11,:),xi,yi));
w_050_ll = squeeze(cube2latlon(xc,yc,w_050(:,:,11,:),xi,yi));
w_075_ll = squeeze(cube2latlon(xc,yc,w_075(:,:,11,:),xi,yi));
w_100_ll = squeeze(cube2latlon(xc,yc,w_100(:,:,11,:),xi,yi));

fftx_000 = mean(abs(fft(w_000_ll)),3);
fftx_010 = mean(abs(fft(w_010_ll)),3);
fftx_025 = mean(abs(fft(w_025_ll)),3);
fftx_050 = mean(abs(fft(w_050_ll)),3);
fftx_075 = mean(abs(fft(w_075_ll)),3);
fftx_100 = mean(abs(fft(w_100_ll)),3);

figure

[C,h] = contourf(0:19,yi,fftx_000(1:20,:)');
xlabel('Wavenumber')
ylabel('Latitude')
colorbar
print('-dpng','waveno_lat_000.png')

figure
[C,h] = contourf(0:19,yi,fftx_010(1:20,:)');
xlabel('Wavenumber')
ylabel('Latitude')
colorbar
print('-dpng','waveno_lat_010.png')

figure
[C,h] = contourf(0:19,yi,fftx_025(1:20,:)');
xlabel('Wavenumber')
ylabel('Latitude')
colorbar
print('-dpng','waveno_lat_025.png')

[C,h] = contourf(0:19,yi,fftx_050(1:20,:)');
xlabel('Wavenumber')
ylabel('Latitude')
colorbar
print('-dpng','waveno_lat_050.png')

figure
[C,h] = contourf(0:19,yi,fftx_075(1:20,:)');
xlabel('Wavenumber')
ylabel('Latitude')
colorbar
print('-dpng','waveno_lat_075.png')

figure
[C,h] = contourf(0:19,yi,fftx_100(1:20,:)');
xlabel('Wavenumber')
ylabel('Latitude')
colorbar
print('-dpng','waveno_lat_100.png')

return

