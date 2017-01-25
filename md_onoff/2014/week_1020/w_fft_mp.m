%compare fractions of descent to ascent in snapshots


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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run %%%%%%%%%%%%%%%%


niti = 86640;
nits = 240;
nitt = 259200;

var(1,:) = 'W';

clear rDir
rDir(1,:)=cellstr('/project/rg312/wv_on_rad_off/run_doshallower01/');
rDir(2,:)=cellstr('/project/rg312/wv_on_rad_off/run_doshallower75/');
rDir(3,:)=cellstr('/project/rg312/wv_on_rad_off/run_doshallower10/');

w = mit_snapshots(rDir,var,niti,nitt,nits);

clear var
var(1,:) = 'WVEL    ';
var(2,:) = 'WVELSQ  ';

wavs = mit_zavs(rDir,var,niti,nitt,nits);

wsq_ed = wavs(:,:,2,:) - wavs(:,:,1,:).^2;


latmask = (abs(yc(:,:)) > 20); % & abs(yc(:,:) < 60));


%FOURIER TRANSFORM 

x_01 = squeeze(w(:,:,11,:,1));
x_75 = squeeze(w(:,:,11,:,2));
x_10 = squeeze(w(:,:,11,:,3));

fftx_01 = mean(abs(fft(x_01)),3);
fftx_75 = mean(abs(fft(x_75)),3);
fftx_10 = mean(abs(fft(x_10)),3);

%x_01 = squeeze(w(:,63,10,:,1));
%x_75 =squeeze(w(:,27,11,:,2));
%x_10 =squeeze(w(:,27,11,:,3));

%x_01_av = mean(x_01,2);
%x_75_av = mean(x_75,2);
%x_10_av = mean(x_10,2);

%fftx_01 = mean(abs(fft(x_01)),2);
%fftx_75 = mean(abs(fft(x_75)),2);
%fftx_10 = mean(abs(fft(x_10)),2);

%fftx_01_av = abs(fft(x_01_av));


figure
contourf(0:19,yi,fftx_01(1:20,:)')
xlabel('Wavenumber')
ylabel('Latitude')
print('-dpdf','waveno_lat_01.pdf')

figure
contourf(0:19,yi,fftx_75(1:20,:)')
xlabel('Wavenumber')
ylabel('Latitude')
print('-dpdf','waveno_lat_75.pdf')

figure
contourf(0:19,yi,fftx_10(1:20,:)')
xlabel('Wavenumber')
ylabel('Latitude')
print('-dpdf','waveno_lat_10.pdf')

return

plot(0:89,2.*fftx_01(1:90)./180)
hold on
plot(0:89,2.*fftx_75(1:90)./180,'r')
plot(0:89,2.*fftx_10(1:90)./180,'k')
xlabel('Wavenumber')
ylabel('Power')
title('Fourier Series of W (Pa/s)')
legend('0.1es0','0.75es0','1.0es0','Location','NorthEast')
print('-dpdf','fft_means_0175.pdf')


return
figure
plot(0:89,2.*fftx_01_av(1:90)./180)
xlabel('Wavenumber')
ylabel('Power')
title('Fourier Series of W (Pa/s)')
print('-dpdf','fft_ofmean_01.pdf')

figure
plot(-179:2:179,x_01(:,720))
hold on
plot(-179:2:179,x_75(:,720),'r')
plot(-179:2:179,x_10(:,720),'k')
xlabel('Longitude')
ylabel('W, Pa/s')
legend('0.1es0','0.75es0','Location','NorthEast')
print('-dpdf','w_lon_0175.pdf')

figure
plot(-179:2:179,x_01_av)
xlabel('Longitude')
ylabel('W, Pa/s')
print('-dpdf','w_av_lon_01.pdf')

return
[C,h]=contour(yi,rC,wsq_ed(:,:,1,1)','k');
set(gca,'YDir','reverse')
clabel(C,h);

figure
[C,h]=contour(yi,rC,wsq_ed(:,:,1,2)','k');
set(gca,'YDir','reverse')
clabel(C,h);






return

