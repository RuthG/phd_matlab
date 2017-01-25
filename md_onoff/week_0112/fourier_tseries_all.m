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

load('/project/rg312/mat_files/climatology_vars.mat')

[a,b_000]=max(mean(uE_000_zav(46:90,:),2));
[a,b_010]=max(mean(uE_010_zav(46:90,:),2));
[a,b_025]=max(mean(uE_025_zav(46:90,:),2));
[a,b_050]=max(mean(uE_050_zav(46:90,:),2));
[a,b_075]=max(mean(uE_075_zav(46:90,:),2));
[a,b_100]=max(mean(uE_100_zav(46:90,:),2));



load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')

clear('vN_010','vN_025','vN_050','vN_075','vN_100')

vN_000_ll = cube2latlon(xc,yc,vN_000,xi,yi);
clear('vN_000')

fftx_000_ss = fourier_transform_tseries(vN_000_ll);




load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')

clear('vN_000','vN_025','vN_050','vN_075','vN_100')

vN_010_ll = cube2latlon(xc,yc,vN_010,xi,yi);
clear('vN_010')

fftx_010_ss = fourier_transform_tseries(vN_010_ll);




load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')

clear('vN_000','vN_010','vN_050','vN_075','vN_100')

vN_025_ll = cube2latlon(xc,yc,vN_025,xi,yi);
clear('vN_025')

fftx_025_ss = fourier_transform_tseries(vN_025_ll);





load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')

clear('vN_000','vN_010','vN_025','vN_075','vN_100')

vN_050_ll = cube2latlon(xc,yc,vN_050,xi,yi);
clear('vN_050')

fftx_050_ss = fourier_transform_tseries(vN_050_ll);



load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')

clear('vN_000','vN_010','vN_025','vN_050','vN_100')

vN_075_ll = cube2latlon(xc,yc,vN_075,xi,yi);
clear('vN_075')

fftx_075_ss = fourier_transform_tseries(vN_075_ll);






load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')

clear('vN_000','vN_010','vN_025','vN_050','vN_075')

vN_100_ll = cube2latlon(xc,yc,vN_100,xi,yi);
clear('vN_100')

fftx_100_ss = fourier_transform_tseries(vN_100_ll);

time = 1:720;
wavenos = 0:90;

v = 0:2:16;
figure
[C,h] = contourf(time, wavenos,squeeze(fftx_000_ss(:,b_000+45,:)),v);
ylim([0 20])
xlabel('Time, days')
ylabel('Wavenumber')
colorbar
caxis([0 15])
print('-dpng','fourier_tseries_000.png')

figure
[C,h] = contourf(time, wavenos,squeeze(fftx_010_ss(:,b_010+45,:)),v);
ylim([0 20])
xlabel('Time, days')
ylabel('Wavenumber')
colorbar
caxis([0 15])
print('-dpng','fourier_tseries_010.png')

figure
[C,h] = contourf(time, wavenos,squeeze(fftx_025_ss(:,b_025+45,:)),v);
ylim([0 20])
xlabel('Time, days')
ylabel('Wavenumber')
colorbar
caxis([0 15])
print('-dpng','fourier_tseries_025.png')

figure
[C,h] = contourf(time, wavenos,squeeze(fftx_050_ss(:,b_050+45,:)),v);
ylim([0 20])
xlabel('Time, days')
ylabel('Wavenumber')
colorbar
caxis([0 15])
print('-dpng','fourier_tseries_050.png')

figure
[C,h] = contourf(time, wavenos,squeeze(fftx_075_ss(:,b_075+45,:)),v);
ylim([0 20])
xlabel('Time, days')
ylabel('Wavenumber')
colorbar
caxis([0 15])
print('-dpng','fourier_tseries_075.png')

figure
[C,h] = contourf(time, wavenos,squeeze(fftx_100_ss(:,b_100+45,:)),v);
ylim([0 20])
xlabel('Time, days')
ylabel('Wavenumber')
colorbar
caxis([0 15])
print('-dpng','fourier_tseries_100.png')





