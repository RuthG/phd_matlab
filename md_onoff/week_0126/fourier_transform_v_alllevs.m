%load up w and plot fourier series vs lat
radius=6371.0e3;


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
load('/project/rg312/mat_files/rhines_scale_plevs.mat')
load('/project/rg312/mat_files/rossby_td_rad.mat')

clear('vN_050','vN_075','vN_100')

vN_000_ll = cube2latlon(xc,yc,vN_000,xi,yi);
clear('vN_000')
vN_010_ll = cube2latlon(xc,yc,vN_010,xi,yi);
clear('vN_010')
vN_025_ll = cube2latlon(xc,yc,vN_025,xi,yi);
clear('vN_025')

%two sided fourier series
fftx_000_ts = mean(abs(fft(vN_000_ll)),4)./180;
clear('vN_000_ll')
fftx_010_ts = mean(abs(fft(vN_010_ll)),4)./180;
clear('vN_010_ll')
fftx_025_ts = mean(abs(fft(vN_025_ll)),4)./180;
clear('vN_025_ll')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')
clear('vN_000','vN_010','vN_025')

vN_050_ll = cube2latlon(xc,yc,vN_050,xi,yi);
clear('vN_050')
vN_075_ll = cube2latlon(xc,yc,vN_075,xi,yi);
clear('vN_075')
vN_100_ll = cube2latlon(xc,yc,vN_100,xi,yi);
clear('vN_100')

fftx_050_ts = mean(abs(fft(vN_050_ll)),4)./180;
clear('vN_050_ll')
fftx_075_ts = mean(abs(fft(vN_075_ll)),4)./180;
clear('vN_075_ll')
fftx_100_ts = mean(abs(fft(vN_100_ll)),4)./180;
clear('vN_100_ll')

load('/project/rg312/mat_files/snapshot_data/vN_snapshots_th.mat')

vN_th_ll = cube2latlon(xc,yc,vN_th,xi,yi);
clear('vN_th')
fftx_th_ts = mean(abs(fft(vN_th_ll)),4)./180;
clear('vN_th_ll')


points = size(fftx_100_ts,1);

%single sides series
fftx_000_ss(1,:,:) = fftx_000_ts(1,:,:);
fftx_000_ss(2:points./2+1,:,:) = fftx_000_ts(2:points./2+1,:,:).*2;
fftx_010_ss(1,:,:) = fftx_010_ts(1,:,:);
fftx_010_ss(2:points./2+1,:,:) = fftx_010_ts(2:points./2+1,:,:).*2;
fftx_025_ss(1,:,:) = fftx_025_ts(1,:,:);
fftx_025_ss(2:points./2+1,:,:) = fftx_025_ts(2:points./2+1,:,:).*2;
fftx_050_ss(1,:,:) = fftx_050_ts(1,:,:);
fftx_050_ss(2:points./2+1,:,:) = fftx_050_ts(2:points./2+1,:,:).*2;
fftx_075_ss(1,:,:) = fftx_075_ts(1,:,:);
fftx_075_ss(2:points./2+1,:,:) = fftx_075_ts(2:points./2+1,:,:).*2;
fftx_100_ss(1,:,:) = fftx_100_ts(1,:,:);
fftx_100_ss(2:points./2+1,:,:) = fftx_100_ts(2:points./2+1,:,:).*2;
fftx_th_ss(1,:,:) = fftx_th_ts(1,:,:);
fftx_th_ss(2:points./2+1,:,:) = fftx_th_ts(2:points./2+1,:,:).*2;


for i = 1:45

fftx_000_ss_hzav(:,i,:) = (fftx_000_ss(:,45+i,:) + fftx_000_ss(:,46-i,:))./2;
fftx_010_ss_hzav(:,i,:) = (fftx_010_ss(:,45+i,:) + fftx_010_ss(:,46-i,:))./2;
fftx_025_ss_hzav(:,i,:) = (fftx_025_ss(:,45+i,:) + fftx_025_ss(:,46-i,:))./2;
fftx_050_ss_hzav(:,i,:) = (fftx_050_ss(:,45+i,:) + fftx_050_ss(:,46-i,:))./2;
fftx_075_ss_hzav(:,i,:) = (fftx_075_ss(:,45+i,:) + fftx_075_ss(:,46-i,:))./2;
fftx_100_ss_hzav(:,i,:) = (fftx_100_ss(:,45+i,:) + fftx_100_ss(:,46-i,:))./2;
fftx_th_ss_hzav(:,i,:) = (fftx_th_ss(:,45+i,:) + fftx_th_ss(:,46-i,:))./2;

end


for i=1:90
kbeta_000_a(i,:) = 2.*pi.*radius.*cos(yi(i).*pi./180)./lbeta_000_a(i,:);
kbeta_010_a(i,:) = 2.*pi.*radius.*cos(yi(i).*pi./180)./lbeta_010_a(i,:);
kbeta_025_a(i,:) = 2.*pi.*radius.*cos(yi(i).*pi./180)./lbeta_025_a(i,:);
kbeta_050_a(i,:) = 2.*pi.*radius.*cos(yi(i).*pi./180)./lbeta_050_a(i,:);
kbeta_075_a(i,:) = 2.*pi.*radius.*cos(yi(i).*pi./180)./lbeta_075_a(i,:);
kbeta_100_a(i,:) = 2.*pi.*radius.*cos(yi(i).*pi./180)./lbeta_100_a(i,:);
kbeta_th_a(i,:) = 2.*pi.*radius.*cos(yi(i).*pi./180)./lbeta_th_a(i,:);
end


wavenos = [0:points-1]./points.*180;


for i=1:25


set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:14; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_000_ss_hzav(1:21,:,i)',v);
hold on
plot(kbeta_000_a(46:90,i),yi(46:90),'Color',[1 1 1],'LineWidth',2)
plot(kd_td_000(46:90,i),yi(46:90),'Color',[0 0 0],'LineWidth',2)
hold off
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 14])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 0.0 Pa')
name = ['fft_000/fft_000_pav_' num2str(i) '.png'];
print('-dpng',name)


set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:14; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_010_ss_hzav(1:21,:,i)',v);
hold on
plot(kbeta_010_a(46:90,i),yi(46:90),'Color',[1 1 1],'LineWidth',2)
plot(kd_td_010(46:90,i),yi(46:90),'Color',[0 0 0],'LineWidth',2)
hold off
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 14])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 61.078 Pa')
name = ['fft_010/fft_010_pav_' num2str(i) '.png'];
print('-dpng',name)



set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:14; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_025_ss_hzav(1:21,:,i)',v);
hold on
plot(kbeta_025_a(46:90,i),yi(46:90),'Color',[1 1 1],'LineWidth',2)
plot(kd_td_025(46:90,i),yi(46:90),'Color',[0 0 0],'LineWidth',2)
hold off
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 14])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 152.695 Pa')
name = ['fft_025/fft_025_pav_' num2str(i) '.png'];
print('-dpng',name)



set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:14; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_050_ss_hzav(1:21,:,i)',v);
hold on
plot(kbeta_050_a(46:90,i),yi(46:90),'Color',[1 1 1],'LineWidth',2)
plot(kd_td_050(46:90,i),yi(46:90),'Color',[0 0 0],'LineWidth',2)
hold off
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 14])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 305.39 Pa')
name = ['fft_050/fft_050_pav_' num2str(i) '.png'];
print('-dpng',name)



set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:14; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_075_ss_hzav(1:21,:,i)',v);
hold on
plot(kbeta_075_a(46:90,i),yi(46:90),'Color',[1 1 1],'LineWidth',2)
plot(kd_td_075(46:90,i),yi(46:90),'Color',[0 0 0],'LineWidth',2)
hold off
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 14])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 458.085 Pa')
name = ['fft_075/fft_075_pav_' num2str(i) '.png'];
print('-dpng',name)



set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:14; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_100_ss_hzav(1:21,:,i)',v);
hold on
plot(kbeta_100_a(46:90,i),yi(46:90),'Color',[1 1 1],'LineWidth',2)
plot(kd_td_100(46:90,i),yi(46:90),'Color',[0 0 0],'LineWidth',2)
hold off
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 14])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 610.78 Pa')
name = ['fft_100/fft_100_pav_' num2str(i) '.png'];
print('-dpng',name)



set(gcf, 'PaperPositionMode','manual' );      
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25 2.5 8.0 3.0]);
v=0:1:14; 
[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_th_ss_hzav(1:21,:,i)',v);
hold on
plot(kbeta_th_a(46:90,i),yi(46:90),'Color',[1 1 1],'LineWidth',2)
plot(kd_td_th(46:90,i),yi(46:90),'Color',[0 0 0],'LineWidth',2)
hold off
set(h,'LineColor','none')
colorbar('FontSize',15);
caxis([0 14])
set(gca,'FontSize',15);
ylabel('Latitude','FontSize',15)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber')
title('e_{s0} = 305.39 Pa + tropheat')
name = ['fft_th/fft_th_pav_' num2str(i) '.png'];
print('-dpng',name)


end


return


