%load up KE and calculate rhines scale

load('/project/rg312/gabriele/ffts.mat')

yi = -89:2:89;

figure
[C,h] = contourf(wavenos(2:21), yi(61:90), vN_860_fftx_ss(2:21,:)');
set(h,'LineColor','none')
set(gca,'FontSize',10)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber','FontSize',12)
hold on
%plot([wavenos(2),wavenos(21)],[47,47],'w--','LineWidth',2)
c = colorbar('eastoutside','FontSize',10);
ylabel(c,'Variance, m^2/s^{2}')
title('Wavenumber spectrum of v''')
%freezeColors
savefig('vN860_fft')
print('-dpdf','vN860_fft.pdf')
close all

figure
[C,h] = contourf(wavenos(2:21), yi(61:90), vN_300_fftx_ss(2:21,:)');
set(h,'LineColor','none')
set(gca,'FontSize',10)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber','FontSize',12)
hold on
%plot([wavenos(2),wavenos(21)],[47,47],'w--','LineWidth',2)
c = colorbar('eastoutside','FontSize',10);
ylabel(c,'Variance, m^2/s^{2}')
title('Wavenumber spectrum of v'' at 300 hPa')
%freezeColors
print('-dpdf','vN300_fft.pdf')
close all

figure
[C,h] = contourf(wavenos(2:21), yi(61:90), H_860_fftx_ss(2:21,:)');
set(h,'LineColor','none')
set(gca,'FontSize',10)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber','FontSize',12)
hold on
%plot([wavenos(2),wavenos(21)],[47,47],'w--','LineWidth',2)
c = colorbar('eastoutside','FontSize',10);
ylabel(c,'Variance, (J/kg)^2')
title('Wavenumber spectrum of H''')
%freezeColors
savefig('H860_fft')
print('-dpdf','H860_fft.pdf')
close all

figure
[C,h] = contourf(wavenos(2:21), yi(61:90), H_300_fftx_ss(2:21,:)');
set(h,'LineColor','none')
set(gca,'FontSize',10)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber','FontSize',12)
hold on
%plot([wavenos(2),wavenos(21)],[47,47],'w--','LineWidth',2)
c = colorbar('eastoutside','FontSize',10);
ylabel(c,'Variance, (J/kg)^2')
title('Wavenumber spectrum of H'' at 300 hPa')
%freezeColors
print('-dpdf','H300_fft.pdf')
close all

figure
[C,h] = contourf(wavenos(2:21), yi(61:90), vNH_860_fftx_ss(2:21,:)');
set(h,'LineColor','none')
set(gca,'FontSize',10)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber','FontSize',12)
hold on
%plot([wavenos(2),wavenos(21)],[47,47],'w--','LineWidth',2)
c = colorbar('eastoutside','FontSize',10);
ylabel(c,'Variance, (Wm/kg)^2')
title('Wavenumber spectrum of v''H''')
%freezeColors
savefig('vNH860_fft')
print('-dpdf','vNH860_fft.pdf')
close all

figure
[C,h] = contourf(wavenos(2:21), yi(61:90), vNH_300_fftx_ss(2:21,:)');
set(h,'LineColor','none')
set(gca,'FontSize',10)
%set(gca,'XTickLabel',[]);
xlabel('Wavenumber','FontSize',12)
hold on
%plot([wavenos(2),wavenos(21)],[47,47],'w--','LineWidth',2)
c = colorbar('eastoutside','FontSize',10);
ylabel(c,'Variance, (Wm/kg)^2')
title('Wavenumber spectrum of v''H'' at 300 hPa')
%freezeColors
print('-dpdf','vNH300_fft.pdf')
close all