%load up KE and calculate rhines scale

load('/project/rg312/mat_files/snapshot_data_final/run_100_ro/fft_100.mat')

yi = -89:2:89;



v=0:1:7; 

[C,h] = contourf(wavenos(1:21), yi(46:90), fftx_100_ss_hzav(1:21,:)',v);
set(h,'LineColor','none')
set(gca,'FontSize',10)
caxis([0 7])
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber','FontSize',12)
c = colorbar('eastoutside','FontSize',10);
ylabel(c,'Variance, m^2/s^{2}')
freezeColors

print('-dpdf','fft.pdf')

