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

load('/project/rg312/mat_files/climatology_vars.mat','theta_000_zav','theta_010_zav','theta_025_zav','theta_050_zav','theta_075_zav','theta_100_zav')

theta_pred_000 = -nanmean(theta_000_zav(:,5)'-theta_000_zav(:,1)');
theta_pred_010 = -nanmean(theta_010_zav(:,5)'-theta_010_zav(:,1)');
theta_pred_025 = -nanmean(theta_025_zav(:,5)'-theta_025_zav(:,1)');
theta_pred_050 = -nanmean(theta_050_zav(:,5)'-theta_050_zav(:,1)');
theta_pred_075 = -nanmean(theta_075_zav(:,5)'-theta_075_zav(:,1)');
theta_pred_100 = -nanmean(theta_100_zav(:,5)'-theta_100_zav(:,1)');

figure
plot(yi,theta_000_zav(:,5)'-theta_000_zav(:,1)')
hold on
plot(yi,theta_010_zav(:,5)'-theta_010_zav(:,1)','r')
plot(yi,theta_025_zav(:,5)'-theta_025_zav(:,1)','g')
plot(yi,theta_050_zav(:,5)'-theta_050_zav(:,1)','m')
plot(yi,theta_075_zav(:,5)'-theta_075_zav(:,1)','c')
plot(yi,theta_100_zav(:,5)'-theta_100_zav(:,1)','k')
xlabel('Latitude')
ylabel('\Theta_{820hPa} - \Theta_{980hPa}, K')
print('-dpng','thetastab.png')

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
hold on 
plot([theta_pred_000,theta_pred_000],[0 1],'-k')
ylim([0 1])
xlim([-20 20])
xlabel('T'', K')
ylabel('Probability')
title('0.0 e_{s0}')
print('-dpng','tpcos_pdf_000.png')

xbins=-20:1:20;
figure
bar(xbins,counts_010_hist);
hold on 
plot([theta_pred_010,theta_pred_010],[0 1],'-k')
ylim([0 1])
xlim([-20 20])
xlabel('T'', K')
ylabel('Probability')
title('0.1 e_{s0}')
print('-dpng','tpcos_pdf_010.png')

xbins=-20:1:20;
figure
bar(xbins,counts_025_hist);
hold on 
plot([theta_pred_025,theta_pred_025],[0 1],'-k')
ylim([0 1])
xlim([-20 20])
xlabel('T'', K')
ylabel('Probability')
title('0.25 e_{s0}')
print('-dpng','tpcos_pdf_025.png')

xbins=-20:1:20;
figure
bar(xbins,counts_050_hist);
hold on 
plot([theta_pred_050,theta_pred_050],[0 1],'-k')
ylim([0 1])
xlim([-20 20])
xlabel('T'', K')
ylabel('Probability')
title('0.5 e_{s0}')
print('-dpng','tpcos_pdf_050.png')

xbins=-20:1:20;
figure
bar(xbins,counts_075_hist);
hold on 
plot([theta_pred_075,theta_pred_075],[0 1],'-k')
ylim([0 1])
xlim([-20 20])
xlabel('T'', K')
ylabel('Probability')
title('0.75 e_{s0}')
print('-dpng','tpcos_pdf_075.png')

xbins=-20:1:20;
figure
bar(xbins,counts_100_hist);
hold on 
plot([theta_pred_100,theta_pred_100],[0 1],'-k')
ylim([0 1])
xlim([-20 20])
xlabel('T'', K')
ylabel('Probability')
title('1.0 e_{s0}')
print('-dpng','tpcos_pdf_100.png')



