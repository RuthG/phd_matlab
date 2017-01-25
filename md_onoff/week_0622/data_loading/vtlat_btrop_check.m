%load in zonal mean v'T', storm track lats, boundary layer and tropopause levels, and check all looks ok

rDir='/project/rg312/final_runs/run_000_final/';
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
xi=-179:2:179;
yi=-89:2:89;

load('/project/rg312/mat_files/blayer_levs_final.mat')
load('/project/rg312/mat_files/trop_levs_final.mat')
load('/project/rg312/mat_files/snapshot_data_final/vNt_ed_mean_data.mat')
load('/project/rg312/mat_files/vt_lats_final.mat')

for i=2:89
b_rC_000(i) = rC(b_lev_000(i));
trop_rC_000(i) = rC(trop_lev_000(i));
b_rC_010(i) = rC(b_lev_010(i));
trop_rC_010(i) = rC(trop_lev_010(i));
b_rC_025(i) = rC(b_lev_025(i));
trop_rC_025(i) = rC(trop_lev_025(i));
b_rC_050(i) = rC(b_lev_050(i));
trop_rC_050(i) = rC(trop_lev_050(i));
b_rC_075(i) = rC(b_lev_075(i));
trop_rC_075(i) = rC(trop_lev_075(i));
b_rC_100(i) = rC(b_lev_100(i));
trop_rC_100(i) = rC(trop_lev_100(i));
b_rC_125(i) = rC(b_lev_125(i));
trop_rC_125(i) = rC(trop_lev_125(i));
b_rC_150(i) = rC(b_lev_150(i));
trop_rC_150(i) = rC(trop_lev_150(i));
end

b_rC_000(1) = NaN; b_rC_000(90) = NaN;
trop_rC_000(1) = NaN; trop_rC_000(90) = NaN;
b_rC_010(1) = NaN; b_rC_010(90) = NaN;
trop_rC_010(1) = NaN; trop_rC_010(90) = NaN;
b_rC_025(1) = NaN; b_rC_025(90) = NaN;
trop_rC_025(1) = NaN; trop_rC_025(90) = NaN;
b_rC_050(1) = NaN; b_rC_050(90) = NaN;
trop_rC_050(1) = NaN; trop_rC_050(90) = NaN;
b_rC_075(1) = NaN; b_rC_075(90) = NaN;
trop_rC_075(1) = NaN; trop_rC_075(90) = NaN;
b_rC_100(1) = NaN; b_rC_100(90) = NaN;
trop_rC_100(1) = NaN; trop_rC_100(90) = NaN;
b_rC_125(1) = NaN; b_rC_125(90) = NaN;
trop_rC_125(1) = NaN; trop_rC_125(90) = NaN;
b_rC_150(1) = NaN; b_rC_150(90) = NaN;
trop_rC_150(1) = NaN; trop_rC_150(90) = NaN;


v=-20:5:20;

figure
[C,h] = contourf(yi,rC,vNt_ed_000',v);
colorbar
caxis([-20 20])
set(gca,'YDir','reverse','FontSize',15)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, Pa','FontSize',15)
title('0.0 e_{s0}')
hold on
plot(yi,b_rC_000,'k','LineWidth',2)
plot(yi,trop_rC_000,'k','LineWidth',2)
plot([yi(x000n),yi(x000n)],[rC(1),rC(25)],'k','LineWidth',2)
plot([yi(x000s),yi(x000s)],[rC(1),rC(25)],'k','LineWidth',2)
hold off
print('-depsc2','-r300','vNt_ed_000.eps')



figure
[C,h] = contourf(yi,rC,vNt_ed_010',v);
colorbar
caxis([-20 20])
set(gca,'YDir','reverse','FontSize',15)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, Pa','FontSize',15)
title('0.1 e_{s0}')
hold on
plot(yi,b_rC_010,'k','LineWidth',2)
plot(yi,trop_rC_010,'k','LineWidth',2)
plot([yi(x010n),yi(x010n)],[rC(1),rC(25)],'k','LineWidth',2)
plot([yi(x010s),yi(x010s)],[rC(1),rC(25)],'k','LineWidth',2)
hold off
print('-depsc2','-r300','vNt_ed_010.eps')



figure
[C,h] = contourf(yi,rC,vNt_ed_025',v);
colorbar
caxis([-20 20])
set(gca,'YDir','reverse','FontSize',15)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, Pa','FontSize',15)
title('0.25 e_{s0}')
hold on
plot(yi,b_rC_025,'k','LineWidth',2)
plot(yi,trop_rC_025,'k','LineWidth',2)
plot([yi(x025n),yi(x025n)],[rC(1),rC(25)],'k','LineWidth',2)
plot([yi(x025s),yi(x025s)],[rC(1),rC(25)],'k','LineWidth',2)
hold off
print('-depsc2','-r300','vNt_ed_025.eps')




figure
[C,h] = contourf(yi,rC,vNt_ed_050',v);
colorbar
caxis([-20 20])
set(gca,'YDir','reverse','FontSize',15)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, Pa','FontSize',15)
title('0.5 e_{s0}')
hold on
plot(yi,b_rC_050,'k','LineWidth',2)
plot(yi,trop_rC_050,'k','LineWidth',2)
plot([yi(x050n),yi(x050n)],[rC(1),rC(25)],'k','LineWidth',2)
plot([yi(x050s),yi(x050s)],[rC(1),rC(25)],'k','LineWidth',2)
hold off
print('-depsc2','-r300','vNt_ed_050.eps')




figure
[C,h] = contourf(yi,rC,vNt_ed_075',v);
colorbar
caxis([-20 20])
set(gca,'YDir','reverse','FontSize',15)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, Pa','FontSize',15)
title('0.75 e_{s0}')
hold on
plot(yi,b_rC_075,'k','LineWidth',2)
plot(yi,trop_rC_075,'k','LineWidth',2)
plot([yi(x075n),yi(x075n)],[rC(1),rC(25)],'k','LineWidth',2)
plot([yi(x075s),yi(x075s)],[rC(1),rC(25)],'k','LineWidth',2)
hold off
print('-depsc2','-r300','vNt_ed_075.eps')




figure
[C,h] = contourf(yi,rC,vNt_ed_100',v);
colorbar
caxis([-20 20])
set(gca,'YDir','reverse','FontSize',15)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, Pa','FontSize',15)
title('1.0 e_{s0}')
hold on
plot(yi,b_rC_100,'k','LineWidth',2)
plot(yi,trop_rC_100,'k','LineWidth',2)
plot([yi(x100n),yi(x100n)],[rC(1),rC(25)],'k','LineWidth',2)
plot([yi(x100s),yi(x100s)],[rC(1),rC(25)],'k','LineWidth',2)
hold off
print('-depsc2','-r300','vNt_ed_100.eps')



figure
[C,h] = contourf(yi,rC,vNt_ed_125',v);
colorbar
caxis([-20 20])
set(gca,'YDir','reverse','FontSize',15)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, Pa','FontSize',15)
title('1.25 e_{s0}')
hold on
plot(yi,b_rC_125,'k','LineWidth',2)
plot(yi,trop_rC_125,'k','LineWidth',2)
plot([yi(x125n),yi(x125n)],[rC(1),rC(25)],'k','LineWidth',2)
plot([yi(x125s),yi(x125s)],[rC(1),rC(25)],'k','LineWidth',2)
hold off
print('-depsc2','-r300','vNt_ed_125.eps')



figure
[C,h] = contourf(yi,rC,vNt_ed_150',v);
colorbar
caxis([-20 20])
set(gca,'YDir','reverse','FontSize',15)
xlabel('Latitude','FontSize',15)
ylabel('Pressure, Pa','FontSize',15)
title('1.5 e_{s0}')
hold on
plot(yi,b_rC_150,'k','LineWidth',2)
plot(yi,trop_rC_150,'k','LineWidth',2)
plot([yi(x150n),yi(x150n)],[rC(1),rC(25)],'k','LineWidth',2)
plot([yi(x150s),yi(x150s)],[rC(1),rC(25)],'k','LineWidth',2)
hold off
print('-depsc2','-r300','vNt_ed_150.eps')


