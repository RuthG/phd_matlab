%load vpdtdy data and plot up histogram of heating and cooling


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
yi = -89:2:89;
xi = -179:2:179;
radius = 6371.0e3;

load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')

vN_000_ll = cube2latlon(xc,yc,vN_000(:,:,5,:),xi,yi);
vN_010_ll = cube2latlon(xc,yc,vN_010(:,:,5,:),xi,yi);
vN_025_ll = cube2latlon(xc,yc,vN_025(:,:,5,:),xi,yi);
vN_050_ll = cube2latlon(xc,yc,vN_050(:,:,5,:),xi,yi);
vN_075_ll = cube2latlon(xc,yc,vN_075(:,:,5,:),xi,yi);
vN_100_ll = cube2latlon(xc,yc,vN_100(:,:,5,:),xi,yi);

vN_ed_000_ll = vN_000_ll - repmat(cube2latlon(xc,yc,mean(vN_000(:,:,5,:),4),xi,yi),[1,1,1,720]);
vN_ed_010_ll = vN_010_ll - repmat(cube2latlon(xc,yc,mean(vN_010(:,:,5,:),4),xi,yi),[1,1,1,720]);
vN_ed_025_ll = vN_025_ll - repmat(cube2latlon(xc,yc,mean(vN_025(:,:,5,:),4),xi,yi),[1,1,1,720]);
vN_ed_050_ll = vN_050_ll - repmat(cube2latlon(xc,yc,mean(vN_050(:,:,5,:),4),xi,yi),[1,1,1,720]);
vN_ed_075_ll = vN_075_ll - repmat(cube2latlon(xc,yc,mean(vN_075(:,:,5,:),4),xi,yi),[1,1,1,720]);
vN_ed_100_ll = vN_100_ll - repmat(cube2latlon(xc,yc,mean(vN_100(:,:,5,:),4),xi,yi),[1,1,1,720]);

clear('vN_000','vN_010','vN_025','vN_050','vN_075','vN_100')

load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat')

t_000_ll = cube2latlon(xc,yc,t_000(:,:,5,:),xi,yi);
t_010_ll = cube2latlon(xc,yc,t_010(:,:,5,:),xi,yi);
t_025_ll = cube2latlon(xc,yc,t_025(:,:,5,:),xi,yi);
t_050_ll = cube2latlon(xc,yc,t_050(:,:,5,:),xi,yi);
t_075_ll = cube2latlon(xc,yc,t_075(:,:,5,:),xi,yi);
t_100_ll = cube2latlon(xc,yc,t_100(:,:,5,:),xi,yi);

t_000_ll_tav = cube2latlon(xc,yc,mean(t_000(:,:,5,:),4),xi,yi);
t_010_ll_tav = cube2latlon(xc,yc,mean(t_010(:,:,5,:),4),xi,yi);
t_025_ll_tav = cube2latlon(xc,yc,mean(t_025(:,:,5,:),4),xi,yi);
t_050_ll_tav = cube2latlon(xc,yc,mean(t_050(:,:,5,:),4),xi,yi);
t_075_ll_tav = cube2latlon(xc,yc,mean(t_075(:,:,5,:),4),xi,yi);
t_100_ll_tav = cube2latlon(xc,yc,mean(t_100(:,:,5,:),4),xi,yi);

t_ed_000_ll = t_000_ll - repmat(t_000_ll_tav,[1,1,1,720]);
t_ed_010_ll = t_010_ll - repmat(t_010_ll_tav,[1,1,1,720]);
t_ed_025_ll = t_025_ll - repmat(t_025_ll_tav,[1,1,1,720]);
t_ed_050_ll = t_050_ll - repmat(t_050_ll_tav,[1,1,1,720]);
t_ed_075_ll = t_075_ll - repmat(t_075_ll_tav,[1,1,1,720]);
t_ed_100_ll = t_100_ll - repmat(t_100_ll_tav,[1,1,1,720]);

clear('t_000','t_010','t_025','t_050','t075','t_100')


[dTdy_000,dTdx_000] = gradient(t_000_ll_tav,pi./90);
dTdy_000 = repmat(dTdy_000./radius,[1,1,1,720]);
[dTdy_010,dTdx_010] = gradient(t_010_ll_tav,pi./90);
dTdy_010 = repmat(dTdy_010./radius,[1,1,1,720]);
[dTdy_025,dTdx_025] = gradient(t_025_ll_tav,pi./90);
dTdy_025 = repmat(dTdy_025./radius,[1,1,1,720]);
[dTdy_050,dTdx_050] = gradient(t_050_ll_tav,pi./90);
dTdy_050 = repmat(dTdy_050./radius,[1,1,1,720]);
[dTdy_075,dTdx_075] = gradient(t_075_ll_tav,pi./90);
dTdy_075 = repmat(dTdy_075./radius,[1,1,1,720]);
[dTdy_100,dTdx_100] = gradient(t_100_ll_tav,pi./90);
dTdy_100 = repmat(dTdy_100./radius,[1,1,1,720]);

v_ed_dTdy_000 = -dTdy_000.*vN_ed_000_ll.*86400;
v_ed_dTdy_010 = -dTdy_010.*vN_ed_010_ll.*86400;
v_ed_dTdy_025 = -dTdy_025.*vN_ed_025_ll.*86400;
v_ed_dTdy_050 = -dTdy_050.*vN_ed_050_ll.*86400;
v_ed_dTdy_075 = -dTdy_075.*vN_ed_075_ll.*86400;
v_ed_dTdy_100 = -dTdy_100.*vN_ed_100_ll.*86400;

for i=1:45
vN_ed_000_ll(:,i,:) = -1.*vN_ed_000_ll(:,i,:);
vN_ed_010_ll(:,i,:) = -1.*vN_ed_010_ll(:,i,:);
vN_ed_025_ll(:,i,:) = -1.*vN_ed_025_ll(:,i,:);
vN_ed_050_ll(:,i,:) = -1.*vN_ed_050_ll(:,i,:);
vN_ed_075_ll(:,i,:) = -1.*vN_ed_075_ll(:,i,:);
vN_ed_100_ll(:,i,:) = -1.*vN_ed_100_ll(:,i,:);
end

xbins=-20:1:20;
for i=1:90
counts_000(i,:) = hist(reshape(v_ed_dTdy_000(:,i,:),[1,numel(v_ed_dTdy_000(:,i,:))]),xbins);
counts_000_cos(i,:) = counts_000(i,:).*cos(yi(i).*pi./180);

counts_010(i,:) = hist(reshape(v_ed_dTdy_010(:,i,:),[1,numel(v_ed_dTdy_010(:,i,:))]),xbins);
counts_010_cos(i,:) = counts_010(i,:).*cos(yi(i).*pi./180);

counts_025(i,:) = hist(reshape(v_ed_dTdy_025(:,i,:),[1,numel(v_ed_dTdy_025(:,i,:))]),xbins);
counts_025_cos(i,:) = counts_025(i,:).*cos(yi(i).*pi./180);

counts_050(i,:) = hist(reshape(v_ed_dTdy_050(:,i,:),[1,numel(v_ed_dTdy_050(:,i,:))]),xbins);
counts_050_cos(i,:) = counts_050(i,:).*cos(yi(i).*pi./180);

counts_075(i,:) = hist(reshape(v_ed_dTdy_075(:,i,:),[1,numel(v_ed_dTdy_075(:,i,:))]),xbins);
counts_075_cos(i,:) = counts_075(i,:).*cos(yi(i).*pi./180);

counts_100(i,:) = hist(reshape(v_ed_dTdy_100(:,i,:),[1,numel(v_ed_dTdy_100(:,i,:))]),xbins);
counts_100_cos(i,:) = counts_100(i,:).*cos(yi(i).*pi./180);
end

counts_000_hist = sum(counts_000_cos,1)./sum(sum(counts_000_cos));
counts_010_hist = sum(counts_010_cos,1)./sum(sum(counts_010_cos));
counts_025_hist = sum(counts_025_cos,1)./sum(sum(counts_025_cos));
counts_050_hist = sum(counts_050_cos,1)./sum(sum(counts_050_cos));
counts_075_hist = sum(counts_075_cos,1)./sum(sum(counts_075_cos));
counts_100_hist = sum(counts_100_cos,1)./sum(sum(counts_100_cos));

xbins=-20:1:20;
figure
bar(xbins,counts_000_hist);
ylim([0 1])
xlim([-20 20])
xlabel('v''dT/dy, K/day')
ylabel('Probability')
title('0.0 e_{s0}')
print('-dpng','vpdtdycos_pdf_000.png')

xbins=-20:1:20;
figure
bar(xbins,counts_010_hist);
ylim([0 1])
xlim([-20 20])
xlabel('v''dT/dy, K/day')
ylabel('Probability')
title('0.1 e_{s0}')
print('-dpng','vpdtdycos_pdf_010.png')

xbins=-20:1:20;
figure
bar(xbins,counts_025_hist);
ylim([0 1])
xlim([-20 20])
xlabel('v''dT/dy, K/day')
ylabel('Probability')
title('0.25 e_{s0}')
print('-dpng','vpdtdycos_pdf_025.png')

xbins=-20:1:20;
figure
bar(xbins,counts_050_hist);
ylim([0 1])
xlim([-20 20])
xlabel('v''dT/dy, K/day')
ylabel('Probability')
title('0.5 e_{s0}')
print('-dpng','vpdtdycos_pdf_050.png')

xbins=-20:1:20;
figure
bar(xbins,counts_075_hist);
ylim([0 1])
xlim([-20 20])
xlabel('v''dT/dy, K/day')
ylabel('Probability')
title('0.75 e_{s0}')
print('-dpng','vpdtdycos_pdf_075.png')

xbins=-20:1:20;
figure
bar(xbins,counts_100_hist);
ylim([0 1])
xlim([-20 20])
xlabel('v''dT/dy, K/day')
ylabel('Probability')
title('1.0 e_{s0}')
print('-dpng','vpdtdycos_pdf_100.png')










xbins=-40:2:40;
for i=1:90
counts_000(i,:) = hist(reshape(vN_ed_000_ll(:,i,:),[1,numel(vN_ed_000_ll(:,i,:))]),xbins);
counts_000_cos(i,:) = counts_000(i,:).*cos(yi(i).*pi./180);

counts_010(i,:) = hist(reshape(vN_ed_010_ll(:,i,:),[1,numel(vN_ed_010_ll(:,i,:))]),xbins);
counts_010_cos(i,:) = counts_010(i,:).*cos(yi(i).*pi./180);

counts_025(i,:) = hist(reshape(vN_ed_025_ll(:,i,:),[1,numel(vN_ed_025_ll(:,i,:))]),xbins);
counts_025_cos(i,:) = counts_025(i,:).*cos(yi(i).*pi./180);

counts_050(i,:) = hist(reshape(vN_ed_050_ll(:,i,:),[1,numel(vN_ed_050_ll(:,i,:))]),xbins);
counts_050_cos(i,:) = counts_050(i,:).*cos(yi(i).*pi./180);

counts_075(i,:) = hist(reshape(vN_ed_075_ll(:,i,:),[1,numel(vN_ed_075_ll(:,i,:))]),xbins);
counts_075_cos(i,:) = counts_075(i,:).*cos(yi(i).*pi./180);

counts_100(i,:) = hist(reshape(vN_ed_100_ll(:,i,:),[1,numel(vN_ed_100_ll(:,i,:))]),xbins);
counts_100_cos(i,:) = counts_100(i,:).*cos(yi(i).*pi./180);
end

counts_000_hist = sum(counts_000_cos,1)./sum(sum(counts_000_cos));
counts_010_hist = sum(counts_010_cos,1)./sum(sum(counts_010_cos));
counts_025_hist = sum(counts_025_cos,1)./sum(sum(counts_025_cos));
counts_050_hist = sum(counts_050_cos,1)./sum(sum(counts_050_cos));
counts_075_hist = sum(counts_075_cos,1)./sum(sum(counts_075_cos));
counts_100_hist = sum(counts_100_cos,1)./sum(sum(counts_100_cos));

figure
bar(xbins,counts_000_hist);
ylim([0 1])
xlim([-40 40])
xlabel('v'', m/s')
ylabel('Probability')
title('0.0 e_{s0}')
print('-dpng','vpcos_pdf_000.png')

figure
bar(xbins,counts_010_hist);
ylim([0 1])
xlim([-40 40])
xlabel('v'', m/s')
ylabel('Probability')
title('0.1 e_{s0}')
print('-dpng','vpcos_pdf_010.png')

figure
bar(xbins,counts_025_hist);
ylim([0 1])
xlim([-40 40])
xlabel('v'', m/s')
ylabel('Probability')
title('0.25 e_{s0}')
print('-dpng','vpcos_pdf_025.png')

figure
bar(xbins,counts_050_hist);
ylim([0 1])
xlim([-40 40])
xlabel('v'', m/s')
ylabel('Probability')
title('0.5 e_{s0}')
print('-dpng','vpcos_pdf_050.png')

figure
bar(xbins,counts_075_hist);
ylim([0 1])
xlim([-40 40])
xlabel('v'', m/s')
ylabel('Probability')
title('0.75 e_{s0}')
print('-dpng','vpcos_pdf_075.png')

figure
bar(xbins,counts_100_hist);
ylim([0 1])
xlim([-40 40])
xlabel('v'', m/s')
ylabel('Probability')
title('1.0 e_{s0}')
print('-dpng','vpcos_pdf_100.png')










xbins=-20:1:20;
for i=1:90
counts_000(i,:) = hist(reshape(t_ed_000_ll(:,i,:),[1,numel(t_ed_000_ll(:,i,:))]),xbins);
counts_000_cos(i,:) = counts_000(i,:).*cos(yi(i).*pi./180);

counts_010(i,:) = hist(reshape(t_ed_010_ll(:,i,:),[1,numel(t_ed_010_ll(:,i,:))]),xbins);
counts_010_cos(i,:) = counts_010(i,:).*cos(yi(i).*pi./180);

counts_025(i,:) = hist(reshape(t_ed_025_ll(:,i,:),[1,numel(t_ed_025_ll(:,i,:))]),xbins);
counts_025_cos(i,:) = counts_025(i,:).*cos(yi(i).*pi./180);

counts_050(i,:) = hist(reshape(t_ed_050_ll(:,i,:),[1,numel(t_ed_050_ll(:,i,:))]),xbins);
counts_050_cos(i,:) = counts_050(i,:).*cos(yi(i).*pi./180);

counts_075(i,:) = hist(reshape(t_ed_075_ll(:,i,:),[1,numel(t_ed_075_ll(:,i,:))]),xbins);
counts_075_cos(i,:) = counts_075(i,:).*cos(yi(i).*pi./180);

counts_100(i,:) = hist(reshape(t_ed_100_ll(:,i,:),[1,numel(t_ed_100_ll(:,i,:))]),xbins);
counts_100_cos(i,:) = counts_100(i,:).*cos(yi(i).*pi./180);
end

counts_000_hist = sum(counts_000_cos,1)./sum(sum(counts_000_cos));
counts_010_hist = sum(counts_010_cos,1)./sum(sum(counts_010_cos));
counts_025_hist = sum(counts_025_cos,1)./sum(sum(counts_025_cos));
counts_050_hist = sum(counts_050_cos,1)./sum(sum(counts_050_cos));
counts_075_hist = sum(counts_075_cos,1)./sum(sum(counts_075_cos));
counts_100_hist = sum(counts_100_cos,1)./sum(sum(counts_100_cos));

xbins=-20:1:20;
figure
bar(xbins,counts_000_hist);
ylim([0 1])
xlim([-20 20])
xlabel('T'', K')
ylabel('Probability')
title('0.0 e_{s0}')
print('-dpng','tpcos_pdf_000.png')

xbins=-20:1:20;
figure
bar(xbins,counts_010_hist);
ylim([0 1])
xlim([-20 20])
xlabel('T'', K')
ylabel('Probability')
title('0.1 e_{s0}')
print('-dpng','tpcos_pdf_010.png')

xbins=-20:1:20;
figure
bar(xbins,counts_025_hist);
ylim([0 1])
xlim([-20 20])
xlabel('T'', K)
ylabel('Probability')
title('0.25 e_{s0}')
print('-dpng','tpcos_pdf_025.png')

xbins=-20:1:20;
figure
bar(xbins,counts_050_hist);
ylim([0 1])
xlim([-20 20])
xlabel('T'', K')
ylabel('Probability')
title('0.5 e_{s0}')
print('-dpng','tpcos_pdf_050.png')

xbins=-20:1:20;
figure
bar(xbins,counts_075_hist);
ylim([0 1])
xlim([-20 20])
xlabel('T'', K')
ylabel('Probability')
title('0.75 e_{s0}')
print('-dpng','tpcos_pdf_075.png')

xbins=-20:1:20;
figure
bar(xbins,counts_100_hist);
ylim([0 1])
xlim([-20 20])
xlabel('T'', K')
ylabel('Probability')
title('1.0 e_{s0}')
print('-dpng','tpcos_pdf_100.png')





return

xbins=-20:1:20;
figure
[counts_000,centers_000] = hist(reshape(v_ed_dTdy_000,[1,numel(v_ed_dTdy_000)]),xbins);
bar(centers_000,counts_000./sum(counts_000));
ylim([0 1])
xlim([-20 20])
xlabel('v''dT/dy, K/day')
ylabel('Probability')
title('0.0 e_{s0}')
print('-dpng','vpdtdy_pdf_000.png')

figure
[counts_010,centers_010] = hist(reshape(v_ed_dTdy_010,[1,numel(v_ed_dTdy_010)]),xbins);
bar(centers_010,counts_010./sum(counts_010));
ylim([0 1])
xlim([-20 20])
xlabel('v''dT/dy, K/day')
ylabel('Probability')
title('0.1 e_{s0}')
print('-dpng','vpdtdy_pdf_010.png')

figure
[counts_025,centers_025] = hist(reshape(v_ed_dTdy_025,[1,numel(v_ed_dTdy_025)]),xbins);
bar(centers_025,counts_025./sum(counts_025));
ylim([0 1])
xlim([-20 20])
xlabel('v''dT/dy, K/day')
ylabel('Probability')
title('0.25 e_{s0}')
print('-dpng','vpdtdy_pdf_025.png')

figure
[counts_050,centers_050] = hist(reshape(v_ed_dTdy_050,[1,numel(v_ed_dTdy_050)]),xbins);
bar(centers_050,counts_050./sum(counts_050));
ylim([0 1])
xlim([-20 20])
xlabel('v''dT/dy, K/day')
ylabel('Probability')
title('0.5 e_{s0}')
print('-dpng','vpdtdy_pdf_050.png')

figure
[counts_075,centers_075] = hist(reshape(v_ed_dTdy_075,[1,numel(v_ed_dTdy_075)]),xbins);
bar(centers_075,counts_075./sum(counts_075));
ylim([0 1])
xlim([-20 20])
xlabel('v''dT/dy, K/day')
ylabel('Probability')
title('0.75 e_{s0}')
print('-dpng','vpdtdy_pdf_075.png')

figure
[counts_100,centers_100] = hist(reshape(v_ed_dTdy_100,[1,numel(v_ed_dTdy_100)]),xbins);
bar(centers_100,counts_100./sum(counts_100));
ylim([0 1])
xlim([-20 20])
xlabel('v''dT/dy, K/day')
ylabel('Probability')
title('1.0 e_{s0}')
print('-dpng','vpdtdy_pdf_100.png')




xbins=-40:2:40;
figure
[counts_000,centers_000] = hist(reshape(vN_ed_000_ll,[1,numel(vN_ed_000_ll)]),xbins);
bar(centers_000,counts_000./sum(counts_000));
ylim([0 1])
xlim([-40 40])
xlabel('v'', m/s')
ylabel('Probability')
title('0.0 e_{s0}')
print('-dpng','vp_pdf_000.png')

figure
[counts_010,centers_010] = hist(reshape(vN_ed_010_ll,[1,numel(vN_ed_010_ll)]),xbins);
bar(centers_010,counts_010./sum(counts_010));
ylim([0 1])
xlim([-40 40])
xlabel('v'', m/s')
ylabel('Probability')
title('0.1 e_{s0}')
print('-dpng','vp_pdf_010.png')

figure
[counts_025,centers_025] = hist(reshape(vN_ed_025_ll,[1,numel(vN_ed_025_ll)]),xbins);
bar(centers_025,counts_025./sum(counts_025));
ylim([0 1])
xlim([-40 40])
xlabel('v'', m/s')
ylabel('Probability')
title('0.25 e_{s0}')
print('-dpng','vp_pdf_025.png')

figure
[counts_050,centers_050] = hist(reshape(vN_ed_050_ll,[1,numel(vN_ed_050_ll)]),xbins);
bar(centers_050,counts_050./sum(counts_050));
ylim([0 1])
xlim([-40 40])
xlabel('v'', m/s')
ylabel('Probability')
title('0.5 e_{s0}')
print('-dpng','vp_pdf_050.png')

figure
[counts_075,centers_075] = hist(reshape(vN_ed_075_ll,[1,numel(vN_ed_075_ll)]),xbins);
bar(centers_075,counts_075./sum(counts_075));
ylim([0 1])
xlim([-40 40])
xlabel('v'', m/s')
ylabel('Probability')
title('0.75 e_{s0}')
print('-dpng','vp_pdf_075.png')

figure
[counts_100,centers_100] = hist(reshape(vN_ed_100_ll,[1,numel(vN_ed_100_ll)]),xbins);
bar(centers_100,counts_100./sum(counts_100));
ylim([0 1])
xlim([-40 40])
xlabel('v'', m/s')
ylabel('Probability')
title('1.0 e_{s0}')
print('-dpng','vp_pdf_100.png')


xbins=-20:1:20;
figure
[counts_000,centers_000] = hist(reshape(t_ed_000_ll,[1,numel(t_ed_000_ll)]),xbins);
bar(centers_000,counts_000./sum(counts_000));
ylim([0 1])
xlim([-20 20])
xlabel('T'', K')
ylabel('Probability')
title('0.0 e_{s0}')
print('-dpng','tp_pdf_000.png')

figure
[counts_010,centers_010] = hist(reshape(t_ed_010_ll,[1,numel(t_ed_010_ll)]),xbins);
bar(centers_010,counts_010./sum(counts_010));
ylim([0 1])
xlim([-20 20])
xlabel('T'', K')
ylabel('Probability')
title('0.1 e_{s0}')
print('-dpng','tp_pdf_010.png')

figure
[counts_025,centers_025] = hist(reshape(t_ed_025_ll,[1,numel(t_ed_025_ll)]),xbins);
bar(centers_025,counts_025./sum(counts_025));
ylim([0 1])
xlim([-20 20])
xlabel('T'', K')
ylabel('Probability')
title('0.25 e_{s0}')
print('-dpng','tp_pdf_025.png')

figure
[counts_050,centers_050] = hist(reshape(t_ed_050_ll,[1,numel(t_ed_050_ll)]),xbins);
bar(centers_050,counts_050./sum(counts_050));
ylim([0 1])
xlim([-20 20])
xlabel('T'', K')
ylabel('Probability')
title('0.5 e_{s0}')
print('-dpng','tp_pdf_050.png')

figure
[counts_075,centers_075] = hist(reshape(t_ed_075_ll,[1,numel(t_ed_075_ll)]),xbins);
bar(centers_075,counts_075./sum(counts_075));
ylim([0 1])
xlim([-20 20])
xlabel('T'', K')
ylabel('Probability')
title('0.75 e_{s0}')
print('-dpng','tp_pdf_075.png')

figure
[counts_100,centers_100] = hist(reshape(t_ed_100_ll,[1,numel(t_ed_100_ll)]),xbins);
bar(centers_100,counts_100./sum(counts_100));
ylim([0 1])
xlim([-20 20])
xlabel('T'', K')
ylabel('Probability')
title('1.0 e_{s0}')
print('-dpng','tp_pdf_100.png')

return

for i=1:90
v_ed_dTdy_000_cos(:,i,:) = v_ed_dTdy_000(:,i,:).*cos(yi(i).*pi./180);
v_ed_dTdy_010_cos(:,i,:) = v_ed_dTdy_010(:,i,:).*cos(yi(i).*pi./180);
v_ed_dTdy_025_cos(:,i,:) = v_ed_dTdy_025(:,i,:).*cos(yi(i).*pi./180);
v_ed_dTdy_050_cos(:,i,:) = v_ed_dTdy_050(:,i,:).*cos(yi(i).*pi./180);
v_ed_dTdy_075_cos(:,i,:) = v_ed_dTdy_075(:,i,:).*cos(yi(i).*pi./180);
v_ed_dTdy_100_cos(:,i,:) = v_ed_dTdy_100(:,i,:).*cos(yi(i).*pi./180);
end


