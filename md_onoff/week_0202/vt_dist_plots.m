%for extreme v't' v' and t' values, reproduce Gabs style plots for all runs

load('/project/rg312/mat_files/vNt_scatter_000.mat')
load('/project/rg312/mat_files/vNt_scatter_010.mat')
load('/project/rg312/mat_files/vNt_scatter_025.mat')
load('/project/rg312/mat_files/vNt_scatter_050.mat')
load('/project/rg312/mat_files/vNt_scatter_075.mat')
load('/project/rg312/mat_files/vNt_scatter_100.mat')
load('/project/rg312/mat_files/vNt_scatter_th.mat')

edges{2} = -40:0.4:40;
edges{1} = -20:0.2:20;

v_bin_c = -39.8:0.4:39.8;
t_bin_c = -19.9:0.2:19.9;

figure
X(:,1) = t_extvNt_000;
X(:,2) = vN_extvNt_000;
N_000 = hist3(X,'Edges',edges);
h=pcolor(t_bin_c,v_bin_c,N_000(1:200,1:200)./sum(sum(N_000(1:200,1:200))));
set(h,'Edgecolor','none'); set(gca,'FontSize',15);
xlim([-10 10]);
ylim([-20 20]);
xlabel('T'', K')
ylabel('V'', m/s')
title('e_{s0} = 0.0')
colorbar
caxis([0 0.01]);
clear X
print('-dpng','vt_000_hist.png')

figure
X(:,1) = t_extvNt_010;
X(:,2) = vN_extvNt_010;
N_010 = hist3(X,'Edges',edges);
h=pcolor(t_bin_c,v_bin_c,N_010(1:200,1:200)./sum(sum(N_010(1:200,1:200))));
set(h,'Edgecolor','none'); set(gca,'FontSize',15);
xlim([-10 10]);
ylim([-20 20]);
xlabel('T'', K')
ylabel('V'', m/s')
title('e_{s0} = 61.078')
colorbar
caxis([0 0.01]);
clear X
print('-dpng','vt_010_hist.png')


figure
X(:,1) = t_extvNt_025;
X(:,2) = vN_extvNt_025;
N_025 = hist3(X,'Edges',edges);
h=pcolor(t_bin_c,v_bin_c,N_025(1:200,1:200)./sum(sum(N_025(1:200,1:200))));
set(h,'Edgecolor','none'); set(gca,'FontSize',15);
xlim([-10 10]);
ylim([-20 20]);
colorbar
xlabel('T'', K')
ylabel('V'', m/s')
title('e_{s0} = 152.695')
caxis([0 0.01]);
clear X
print('-dpng','vt_025_hist.png')


figure
X(:,1) = t_extvNt_050;
X(:,2) = vN_extvNt_050;
N_050 = hist3(X,'Edges',edges);
h=pcolor(t_bin_c,v_bin_c,N_050(1:200,1:200)./sum(sum(N_050(1:200,1:200))));
set(h,'Edgecolor','none'); set(gca,'FontSize',15);
xlim([-10 10]);
ylim([-20 20]);
colorbar
xlabel('T'', K')
ylabel('V'', m/s')
title('e_{s0} = 305.39')
caxis([0 0.01]);
clear X
print('-dpng','vt_050_hist.png')


figure
X(:,1) = t_extvNt_075;
X(:,2) = vN_extvNt_075;
N_075 = hist3(X,'Edges',edges);
h=pcolor(t_bin_c,v_bin_c,N_075(1:200,1:200)./sum(sum(N_075(1:200,1:200))));
set(h,'Edgecolor','none'); set(gca,'FontSize',15);
xlim([-10 10]);
ylim([-20 20]);
colorbar
xlabel('T'', K')
ylabel('V'', m/s')
title('e_{s0} = 458.085')
caxis([0 0.01]);
clear X
print('-dpng','vt_075_hist.png')


figure
X(:,1) = t_extvNt_100;
X(:,2) = vN_extvNt_100;
N_100 = hist3(X,'Edges',edges);
h=pcolor(t_bin_c,v_bin_c,N_100(1:200,1:200)./sum(sum(N_100(1:200,1:200))));
set(h,'Edgecolor','none'); set(gca,'FontSize',15);
xlim([-10 10]);
ylim([-20 20]);
colorbar
xlabel('T'', K')
ylabel('V'', m/s')
title('e_{s0} = 610.78')
caxis([0 0.01]);
clear X
print('-dpng','vt_100_hist.png')


figure
X(:,1) = t_extvNt_th;
X(:,2) = vN_extvNt_th;
N_th = hist3(X,'Edges',edges);
h=pcolor(t_bin_c,v_bin_c,N_th(1:200,1:200)./sum(sum(N_th(1:200,1:200))));
set(h,'Edgecolor','none'); set(gca,'FontSize',15);
xlim([-10 10]);
ylim([-20 20]);
colorbar
xlabel('T'', K')
ylabel('V'', m/s')
title('e_{s0} = 305.39 + Tropical Heating')
caxis([0 0.01]);
clear X
print('-dpng','vt_th_hist.png')

a(1) = sum(sum(N_000(1:100,1:100)));
b(1) = sum(sum(N_000(101:200,101:200)));
a(2) = sum(sum(N_010(1:100,1:100)));
b(2) = sum(sum(N_010(101:200,101:200)));
a(3) = sum(sum(N_025(1:100,1:100)));
b(3) = sum(sum(N_025(101:200,101:200)));
a(4) = sum(sum(N_050(1:100,1:100)));
b(4) = sum(sum(N_050(101:200,101:200)));
a(7) = sum(sum(N_th(1:100,1:100)));
b(7) = sum(sum(N_th(101:200,101:200)));
a(5) = sum(sum(N_075(1:100,1:100)));
b(5) = sum(sum(N_075(101:200,101:200)));
a(6) = sum(sum(N_100(1:100,1:100)));
b(6) = sum(sum(N_100(101:200,101:200)));

wv_cont = [0,0.1,0.25,0.5,0.75,1,0.5];

figure
plot(wv_cont,a./b,'x','MarkerSize',12);
set(gca,'FontSize',15);
xlabel('e_{s0} Fraction')
%xlim([0 1])
%ylim([0 1])
title('Ratio of extreme v''T'' associated with -ve and +ve anomalies')
ylabel('v''T'' -ve : v''T'' +ve')
print('-dpng','vt_pm_ratio.png')
