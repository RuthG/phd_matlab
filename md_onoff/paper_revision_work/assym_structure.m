load('/project/rg312/mat_files/vt_assym.mat')

yi = -89:2:89;
rC = 980:-40:20;

%load stormtracklats and blayer and trop levs
load('/project/rg312/mat_files/vt_lats_final.mat');
load('/project/rg312/mat_files/blayer_levs_final.mat');
load('/project/rg312/mat_files/trop_levs_final.mat');

for i=2:89
    bl_000(i) = rC(b_lev_000(i));
    bl_010(i) = rC(b_lev_010(i));
    bl_025(i) = rC(b_lev_025(i));
    bl_050(i) = rC(b_lev_050(i));
    bl_075(i) = rC(b_lev_075(i));
    bl_100(i) = rC(b_lev_100(i));
    bl_125(i) = rC(b_lev_125(i));
    bl_150(i) = rC(b_lev_150(i));
end



figure
h=pcolor(yi,rC,(tt_w_000'-tt_c_000')./(tt_w_000'+tt_c_000'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,tt_w_000'+tt_c_000',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x000n),yi(x000n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x000s),yi(x000s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_000(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('000' ,'FontSize',15)
colormap(b2r(-0.5,0.5));
%caxis([-0.5 0.5])
colorbar('FontSize',15)
print('-dpng','tt_assym_000.png')


figure
h=pcolor(yi,rC,(tt_w_010'-tt_c_010')./(tt_w_010'+tt_c_010'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,tt_w_010'+tt_c_010',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x010n),yi(x010n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x010s),yi(x010s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_010(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('010' ,'FontSize',15)
colormap(b2r(-0.5,0.5));
colorbar('FontSize',15)
print('-dpng','tt_assym_010.png')




figure
h=pcolor(yi,rC,(tt_w_025'-tt_c_025')./(tt_w_025'+tt_c_025'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,tt_w_025'+tt_c_025',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x025n),yi(x025n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x025s),yi(x025s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_025(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('025' ,'FontSize',15)
colormap(b2r(-0.5,0.5));
colorbar('FontSize',15)
print('-dpng','tt_assym_025.png')





figure
h=pcolor(yi,rC,(tt_w_050'-tt_c_050')./(tt_w_050'+tt_c_050'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,tt_w_050'+tt_c_050',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x050n),yi(x050n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x050s),yi(x050s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_050(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('050' ,'FontSize',15)
colormap(b2r(-0.5,0.5));
colorbar('FontSize',15)
print('-dpng','tt_assym_050.png')






figure
h=pcolor(yi,rC,(tt_w_075'-tt_c_075')./(tt_w_075'+tt_c_075'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,tt_w_075'+tt_c_075',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x075n),yi(x075n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x075s),yi(x075s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_075(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('075' ,'FontSize',15)
colormap(b2r(-0.5,0.5));
colorbar('FontSize',15)
print('-dpng','tt_assym_075.png')





figure
h=pcolor(yi,rC,(tt_w_100'-tt_c_100')./(tt_w_100'+tt_c_100'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,tt_w_100'+tt_c_100',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x100n),yi(x100n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x100s),yi(x100s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_100(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('100' ,'FontSize',15)
colormap(b2r(-0.5,0.5));
colorbar('FontSize',15)
print('-dpng','tt_assym_100.png')





figure
h=pcolor(yi,rC,(tt_w_125'-tt_c_125')./(tt_w_125'+tt_c_125'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,tt_w_125'+tt_c_125',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x125n),yi(x125n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x125s),yi(x125s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_125(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('125' ,'FontSize',15)
colormap(b2r(-0.5,0.5));
colorbar('FontSize',15)
print('-dpng','tt_assym_125.png')




figure
h=pcolor(yi,rC,(tt_w_150'-tt_c_150')./(tt_w_150'+tt_c_150'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,tt_w_150'+tt_c_150',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x150n),yi(x150n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x150s),yi(x150s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_150(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('150' ,'FontSize',15)
colormap(b2r(-0.5,0.5));
colorbar('FontSize',15)
print('-dpng','tt_assym_150.png')






figure
h=pcolor(yi,rC,(vt_w_000' - vt_c_000')./(vt_c_000' + vt_w_000') );
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_000'+vt_c_000',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x000n),yi(x000n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x000s),yi(x000s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_000(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('000' ,'FontSize',15)
colormap(b2r(-0.5,0.5));
colorbar('FontSize',15)
print('-dpng','vt_assym2_000.png')


figure
h=pcolor(yi,rC,(vt_w_010' - vt_c_010')./(vt_c_010' + vt_w_010') );
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_010'+vt_c_010',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x010n),yi(x010n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x010s),yi(x010s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_010(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('010' ,'FontSize',15)
colormap(b2r(-0.5,0.5));
colorbar('FontSize',15)
print('-dpng','vt_assym2_010.png')


figure
h=pcolor(yi,rC,(vt_w_025' - vt_c_025')./(vt_c_025' + vt_w_025') );
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_025'+vt_c_025',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x025n),yi(x025n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x025s),yi(x025s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_025(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('025' ,'FontSize',15)
colormap(b2r(-0.5,0.5));
colorbar('FontSize',15)
print('-dpng','vt_assym2_025.png')


figure
h=pcolor(yi,rC,(vt_w_050' - vt_c_050')./(vt_c_050' + vt_w_050') );
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_050'+vt_c_050',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x050n),yi(x050n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x050s),yi(x050s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_050(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('050' ,'FontSize',15)
colormap(b2r(-0.5,0.5));
colorbar('FontSize',15)
print('-dpng','vt_assym2_050.png')


figure
h=pcolor(yi,rC,(vt_w_075' - vt_c_075')./(vt_c_075' + vt_w_075') );
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_075'+vt_c_075',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x075n),yi(x075n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x075s),yi(x075s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_075(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('075' ,'FontSize',15)
colormap(b2r(-0.5,0.5));
colorbar('FontSize',15)
print('-dpng','vt_assym2_075.png')


figure
h=pcolor(yi,rC,(vt_w_100' - vt_c_100')./(vt_c_100' + vt_w_100') );
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_100'+vt_c_100',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x100n),yi(x100n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x100s),yi(x100s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_100(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('100' ,'FontSize',15)
colormap(b2r(-0.5,0.5));
colorbar('FontSize',15)
print('-dpng','vt_assym2_100.png')


figure
h=pcolor(yi,rC,(vt_w_125' - vt_c_125')./(vt_c_125' + vt_w_125') );
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_125'+vt_c_125',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x125n),yi(x125n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x125s),yi(x125s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_125(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('125' ,'FontSize',15)
colormap(b2r(-0.5,0.5));
colorbar('FontSize',15)
print('-dpng','vt_assym2_125.png')


figure
h=pcolor(yi,rC,(vt_w_150' - vt_c_150')./(vt_c_150' + vt_w_150') );
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_150'+vt_c_150',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x150n),yi(x150n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x150s),yi(x150s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_150(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('150' ,'FontSize',15)
colormap(b2r(-0.5,0.5));
colorbar('FontSize',15)
print('-dpng','vt_assym2_150.png')





return




figure
h=pcolor(yi,rC,(vt_c_000'./vt_w_000'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_000'+vt_c_000',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x000n),yi(x000n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x000s),yi(x000s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_000(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('000' ,'FontSize',15)
caxis([0 2])
colorbar('FontSize',15)
print('-dpng','vt_assym_000.png')


figure
h=pcolor(yi,rC,(vt_c_010'./vt_w_010'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_010'+vt_c_010',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x010n),yi(x010n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x010s),yi(x010s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_010(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('010' ,'FontSize',15)
caxis([0 2])
colorbar('FontSize',15)
print('-dpng','vt_assym_010.png')




figure
h=pcolor(yi,rC,(vt_c_025'./vt_w_025'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_025'+vt_c_025',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x025n),yi(x025n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x025s),yi(x025s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_025(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('025' ,'FontSize',15)
caxis([0 2])
colorbar('FontSize',15)
print('-dpng','vt_assym_025.png')





figure
h=pcolor(yi,rC,(vt_c_050'./vt_w_050'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_050'+vt_c_050',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x050n),yi(x050n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x050s),yi(x050s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_050(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('050' ,'FontSize',15)
caxis([0 2])
colorbar('FontSize',15)
print('-dpng','vt_assym_050.png')






figure
h=pcolor(yi,rC,(vt_c_075'./vt_w_075'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_075'+vt_c_075',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x075n),yi(x075n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x075s),yi(x075s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_075(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('075' ,'FontSize',15)
caxis([0 2])
colorbar('FontSize',15)
print('-dpng','vt_assym_075.png')





figure
h=pcolor(yi,rC,(vt_c_100'./vt_w_100'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_100'+vt_c_100',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x100n),yi(x100n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x100s),yi(x100s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_100(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('100' ,'FontSize',15)
caxis([0 2])
colorbar('FontSize',15)
print('-dpng','vt_assym_100.png')





figure
h=pcolor(yi,rC,(vt_c_125'./vt_w_125'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_125'+vt_c_125',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x125n),yi(x125n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x125s),yi(x125s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_125(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('125' ,'FontSize',15)
caxis([0 2])
colorbar('FontSize',15)
print('-dpng','vt_assym_125.png')




figure
h=pcolor(yi,rC,(vt_c_150'./vt_w_150'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_150'+vt_c_150',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x150n),yi(x150n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x150s),yi(x150s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_150(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('150' ,'FontSize',15)
caxis([0 2])
colorbar('FontSize',15)
print('-dpng','vt_assym_150.png')


return


figure
h=pcolor(yi,rC,(vt_w_000'./vt_c_000'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_000'+vt_c_000',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x000n),yi(x000n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x000s),yi(x000s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_000(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('000' ,'FontSize',15)
caxis([0 2])
colorbar('FontSize',15)
print('-dpng','vt_assym_000.png')


figure
h=pcolor(yi,rC,(vt_w_010'./vt_c_010'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_010'+vt_c_010',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x010n),yi(x010n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x010s),yi(x010s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_010(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('010' ,'FontSize',15)
caxis([0 2])
colorbar('FontSize',15)
print('-dpng','vt_assym_010.png')




figure
h=pcolor(yi,rC,(vt_w_025'./vt_c_025'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_025'+vt_c_025',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x025n),yi(x025n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x025s),yi(x025s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_025(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('025' ,'FontSize',15)
caxis([0 2])
colorbar('FontSize',15)
print('-dpng','vt_assym_025.png')





figure
h=pcolor(yi,rC,(vt_w_050'./vt_c_050'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_050'+vt_c_050',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x050n),yi(x050n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x050s),yi(x050s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_050(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('050' ,'FontSize',15)
caxis([0 2])
colorbar('FontSize',15)
print('-dpng','vt_assym_050.png')






figure
h=pcolor(yi,rC,(vt_w_075'./vt_c_075'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_075'+vt_c_075',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x075n),yi(x075n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x075s),yi(x075s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_075(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('075' ,'FontSize',15)
caxis([0 2])
colorbar('FontSize',15)
print('-dpng','vt_assym_075.png')





figure
h=pcolor(yi,rC,(vt_w_100'./vt_c_100'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_100'+vt_c_100',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x100n),yi(x100n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x100s),yi(x100s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_100(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('100' ,'FontSize',15)
caxis([0 2])
colorbar('FontSize',15)
print('-dpng','vt_assym_100.png')





figure
h=pcolor(yi,rC,(vt_w_125'./vt_c_125'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_125'+vt_c_125',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x125n),yi(x125n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x125s),yi(x125s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_125(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('125' ,'FontSize',15)
caxis([0 2])
colorbar('FontSize',15)
print('-dpng','vt_assym_125.png')




figure
h=pcolor(yi,rC,(vt_w_150'./vt_c_150'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_150'+vt_c_150',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x150n),yi(x150n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x150s),yi(x150s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_150(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('150' ,'FontSize',15)
caxis([0 2])
colorbar('FontSize',15)
print('-dpng','vt_assym_150.png')


return







figure
h=pcolor(yi,rC,(vt_w_000'-vt_c_000'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_000'+vt_c_000',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x000n),yi(x000n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x000s),yi(x000s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_000(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('000' ,'FontSize',15)
caxis([-5 5])
colorbar('FontSize',15)
print('-dpng','vt_assym_000.png')


figure
h=pcolor(yi,rC,(vt_w_010'-vt_c_010'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_010'+vt_c_010',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x010n),yi(x010n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x010s),yi(x010s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_010(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('010' ,'FontSize',15)
caxis([-5 5])
colorbar('FontSize',15)
print('-dpng','vt_assym_010.png')




figure
h=pcolor(yi,rC,(vt_w_025'-vt_c_025'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_025'+vt_c_025',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x025n),yi(x025n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x025s),yi(x025s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_025(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('025' ,'FontSize',15)
caxis([-5 5])
colorbar('FontSize',15)
print('-dpng','vt_assym_025.png')





figure
h=pcolor(yi,rC,(vt_w_050'-vt_c_050'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_050'+vt_c_050',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x050n),yi(x050n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x050s),yi(x050s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_050(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('050' ,'FontSize',15)
caxis([-5 5])
colorbar('FontSize',15)
print('-dpng','vt_assym_050.png')






figure
h=pcolor(yi,rC,(vt_w_075'-vt_c_075'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_075'+vt_c_075',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x075n),yi(x075n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x075s),yi(x075s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_075(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('075' ,'FontSize',15)
caxis([-5 5])
colorbar('FontSize',15)
print('-dpng','vt_assym_075.png')





figure
h=pcolor(yi,rC,(vt_w_100'-vt_c_100'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_100'+vt_c_100',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x100n),yi(x100n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x100s),yi(x100s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_100(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('100' ,'FontSize',15)
caxis([-5 5])
colorbar('FontSize',15)
print('-dpng','vt_assym_100.png')





figure
h=pcolor(yi,rC,(vt_w_125'-vt_c_125'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_125'+vt_c_125',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x125n),yi(x125n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x125s),yi(x125s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_125(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('125' ,'FontSize',15)
caxis([-5 5])
colorbar('FontSize',15)
print('-dpng','vt_assym_125.png')




figure
h=pcolor(yi,rC,(vt_w_150'-vt_c_150'));
set(h,'edgecolor','none')
hold on
[C,h]=contour(yi,rC,vt_w_150'+vt_c_150',-25:5:25,'k', 'LineWidth',1);
clabel(C,h);
plot([yi(x150n),yi(x150n)],[0,980],'k--', 'LineWidth',2)
plot([yi(x150s),yi(x150s)],[0,980],'k--', 'LineWidth',2)
plot(yi(2:89),bl_150(2:89),'k--', 'LineWidth',2)
set(gca,'YDir','reverse','FontSize',12)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, hPa','FontSize',15)
title('150' ,'FontSize',15)
caxis([-5 5])
colorbar('FontSize',15)
print('-dpng','vt_assym_150.png')





