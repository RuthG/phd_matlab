%load in w_area data
%plot differences, see if we can pick up the change in the distribution

load('w_area_bits.mat')
w_bins_c = -1.495:0.01:1.5;
area_bins_c = 0.005e13:0.01e13:1e13;

figure
h=pcolor(w_bins_c,area_bins_c./(1000^2),maybe_pdf_10'-maybe_pdf_00');
 set(h,'EdgeColor','none')
%caxis([-35 35])
colorbar
xlabel('Vertical Velocity, Pa/s')
ylabel('Area Occupied, km^{2}')
print('-dpng','w_area_10_00_diff.png')


load('w_area_dists.mat')

figure
plot(abs(w_bins_c(151:300)),w_area_dist_000(151:300),'r')
hold on
plot(abs(w_bins_c(1:150)),w_area_dist_000(1:150))
set(gca,'YScale','log')

figure
plot(abs(w_bins_c(151:300)),w_area_dist_001(151:300),'r')
hold on
plot(abs(w_bins_c(1:150)),w_area_dist_001(1:150))
set(gca,'YScale','log')

figure
plot(abs(w_bins_c(151:300)),w_area_dist_025(151:300),'r')
hold on
plot(abs(w_bins_c(1:150)),w_area_dist_025(1:150))
set(gca,'YScale','log')

figure
plot(abs(w_bins_c(151:300)),w_area_dist_050(151:300),'r')
hold on
plot(abs(w_bins_c(1:150)),w_area_dist_050(1:150))
set(gca,'YScale','log')

figure
plot(abs(w_bins_c(151:300)),w_area_dist_075(151:300),'r')
hold on
plot(abs(w_bins_c(1:150)),w_area_dist_075(1:150))
set(gca,'YScale','log')

figure
plot(abs(w_bins_c(151:300)),w_area_dist_100(151:300),'r')
hold on
plot(abs(w_bins_c(1:150)),w_area_dist_100(1:150))
set(gca,'YScale','log')


figure
plot(abs(w_bins_c(151:300)),2.*(w_area_dist_000(151:300)-flipdim(w_area_dist_000(1:150),1))./(w_area_dist_000(151:300)+flipdim(w_area_dist_000(1:150),1)),'b')
plot(abs(w_bins_c(151:300)),2.*(w_area_dist_100(151:300)-flipdim(w_area_dist_100(1:150),1))./(w_area_dist_100(151:300)+flipdim(w_area_dist_100(1:150),1)),'r')
hold on
plot(abs(w_bins_c(151:300)),w_area_dist_001(151:300)-flipdim(w_area_dist_001(1:150),1),'c')
plot(abs(w_bins_c(151:300)),w_area_dist_025(151:300)-flipdim(w_area_dist_025(1:150),1),'m')
plot(abs(w_bins_c(151:300)),w_area_dist_050(151:300)-flipdim(w_area_dist_050(1:150),1),'g')
plot(abs(w_bins_c(151:300)),w_area_dist_075(151:300)-flipdim(w_area_dist_075(1:150),1),'k')
plot(abs(w_bins_c(151:300)),w_area_dist_100(151:300)-flipdim(w_area_dist_100(1:150),1),'r')
xlim([0 0.5])
xlabel('abs(w), Pa/s')
ylabel('Area of descent - area of ascent')
legend('0eso','0.1es0','0.25es0','0.5es0','0.75es0','1es0')
print('-dpng','area_pdf.png')

