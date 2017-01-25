%load vpdtdy data and plot up histogram of heating and cooling


% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_100_best/';
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


load('/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat')

vN_000_ll = cube2latlon(xc,yc,vN_000(:,:,5,:),xi,yi);
vN_010_ll = cube2latlon(xc,yc,vN_010(:,:,5,:),xi,yi);
vN_025_ll = cube2latlon(xc,yc,vN_025(:,:,5,:),xi,yi);
vN_050_ll = cube2latlon(xc,yc,vN_050(:,:,5,:),xi,yi);
vN_075_ll = cube2latlon(xc,yc,vN_075(:,:,5,:),xi,yi);
vN_100_ll = cube2latlon(xc,yc,vN_100(:,:,5,:),xi,yi);

vN_000_ll_tav = cube2latlon(xc,yc,mean(vN_000(:,:,5,:),4),xi,yi);
vN_010_ll_tav = cube2latlon(xc,yc,mean(vN_010(:,:,5,:),4),xi,yi);
vN_025_ll_tav = cube2latlon(xc,yc,mean(vN_025(:,:,5,:),4),xi,yi);
vN_050_ll_tav = cube2latlon(xc,yc,mean(vN_050(:,:,5,:),4),xi,yi);
vN_075_ll_tav = cube2latlon(xc,yc,mean(vN_075(:,:,5,:),4),xi,yi);
vN_100_ll_tav = cube2latlon(xc,yc,mean(vN_100(:,:,5,:),4),xi,yi);

vN_ed_000_ll = vN_000_ll - repmat(vN_000_ll_tav,[1,1,1,720]);
vN_ed_010_ll = vN_010_ll - repmat(vN_010_ll_tav,[1,1,1,720]);
vN_ed_025_ll = vN_025_ll - repmat(vN_025_ll_tav,[1,1,1,720]);
vN_ed_050_ll = vN_050_ll - repmat(vN_050_ll_tav,[1,1,1,720]);
vN_ed_075_ll = vN_075_ll - repmat(vN_075_ll_tav,[1,1,1,720]);
vN_ed_100_ll = vN_100_ll - repmat(vN_100_ll_tav,[1,1,1,720]);

clear('vN_000_ll','vN_010_ll','vN_025_ll','vN_050_ll','vN_075_ll','vN_100_ll')
clear('vN_000_ll_tav','vN_010_ll_tav','vN_025_ll_tav','vN_050_ll_tav','vN_075_ll_tav','vN_100_ll_tav')
clear('vN_000','vN_010','vN_025','vN_050','vN_075','vN_100')



load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat')

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

clear('t_000_ll','t_010_ll','t_025_ll','t_050_ll','t_075_ll','t_100_ll')
clear('t_000_ll_tav','t_010_ll_tav','t_025_ll_tav','t_050_ll_tav','t075_ll_tav','t_100_ll_tav')
clear('t_000','t_010','t_025','t_050','t075','t_100')



load('/project/rg312/mat_files/snapshot_data/q_snapshots_best.mat')

q_000_ll = cube2latlon(xc,yc,q_000(:,:,5,:),xi,yi);
q_010_ll = cube2latlon(xc,yc,q_010(:,:,5,:),xi,yi);
q_025_ll = cube2latlon(xc,yc,q_025(:,:,5,:),xi,yi);
q_050_ll = cube2latlon(xc,yc,q_050(:,:,5,:),xi,yi);
q_075_ll = cube2latlon(xc,yc,q_075(:,:,5,:),xi,yi);
q_100_ll = cube2latlon(xc,yc,q_100(:,:,5,:),xi,yi);

q_000_ll_tav = cube2latlon(xc,yc,mean(q_000(:,:,5,:),4),xi,yi);
q_010_ll_tav = cube2latlon(xc,yc,mean(q_010(:,:,5,:),4),xi,yi);
q_025_ll_tav = cube2latlon(xc,yc,mean(q_025(:,:,5,:),4),xi,yi);
q_050_ll_tav = cube2latlon(xc,yc,mean(q_050(:,:,5,:),4),xi,yi);
q_075_ll_tav = cube2latlon(xc,yc,mean(q_075(:,:,5,:),4),xi,yi);
q_100_ll_tav = cube2latlon(xc,yc,mean(q_100(:,:,5,:),4),xi,yi);

q_ed_000_ll = q_000_ll - repmat(q_000_ll_tav,[1,1,1,720]);
q_ed_010_ll = q_010_ll - repmat(q_010_ll_tav,[1,1,1,720]);
q_ed_025_ll = q_025_ll - repmat(q_025_ll_tav,[1,1,1,720]);
q_ed_050_ll = q_050_ll - repmat(q_050_ll_tav,[1,1,1,720]);
q_ed_075_ll = q_075_ll - repmat(q_075_ll_tav,[1,1,1,720]);
q_ed_100_ll = q_100_ll - repmat(q_100_ll_tav,[1,1,1,720]);

clear('q_000_ll','q_010_ll','q_025_ll','q_050_ll','q_075_ll','q_100_ll')
clear('q_000_ll_tav','q_010_ll_tav','q_025_ll_tav','q_050_ll_tav','q_075_ll_tav','q_100_ll_tav')
clear('q_000','q_010','q_025','q_050','q_075','q_100')


cpd = 1005;
L = 2.5e6;

vH_ed_000_ll = (t_ed_000_ll.*cpd + q_ed_000_ll.*L).*vN_ed_000_ll;
vH_ed_010_ll = (t_ed_010_ll.*cpd + q_ed_010_ll.*L).*vN_ed_010_ll;
vH_ed_025_ll = (t_ed_025_ll.*cpd + q_ed_025_ll.*L).*vN_ed_025_ll;
vH_ed_050_ll = (t_ed_050_ll.*cpd + q_ed_050_ll.*L).*vN_ed_050_ll;
vH_ed_075_ll = (t_ed_075_ll.*cpd + q_ed_075_ll.*L).*vN_ed_075_ll;
vH_ed_100_ll = (t_ed_100_ll.*cpd + q_ed_100_ll.*L).*vN_ed_100_ll;

vH_ed_000_ll(:,1:45,:,:) = -vH_ed_000_ll(:,1:45,:,:);
vH_ed_010_ll(:,1:45,:,:) = -vH_ed_010_ll(:,1:45,:,:);
vH_ed_025_ll(:,1:45,:,:) = -vH_ed_025_ll(:,1:45,:,:);
vH_ed_050_ll(:,1:45,:,:) = -vH_ed_050_ll(:,1:45,:,:);
vH_ed_075_ll(:,1:45,:,:) = -vH_ed_075_ll(:,1:45,:,:);
vH_ed_100_ll(:,1:45,:,:) = -vH_ed_100_ll(:,1:45,:,:);


vH_ed_vec_000 = reshape(vH_ed_000_ll,[1,numel(vH_ed_000_ll)]);
vH_ed_vec_000(isnan(vH_ed_vec_000))=[];
vH_ed_mean_000 = mean(vH_ed_vec_000)
vH_ed_var_000 = var(vH_ed_vec_000)
vH_ed_skew_000 = skewness(vH_ed_vec_000)
vH_ed_kurt_000 = kurtosis(vH_ed_vec_000)

vH_ed_vec_010 = reshape(vH_ed_010_ll,[1,numel(vH_ed_010_ll)]);
vH_ed_vec_010(isnan(vH_ed_vec_010))=[];
vH_ed_mean_010 = mean(vH_ed_vec_010)
vH_ed_var_010 = var(vH_ed_vec_010)
vH_ed_skew_010 = skewness(vH_ed_vec_010)
vH_ed_kurt_010 = kurtosis(vH_ed_vec_010)

vH_ed_vec_025 = reshape(vH_ed_025_ll,[1,numel(vH_ed_025_ll)]);
vH_ed_vec_025(isnan(vH_ed_vec_025))=[];
vH_ed_mean_025 = mean(vH_ed_vec_025)
vH_ed_var_025 = var(vH_ed_vec_025)
vH_ed_skew_025 = skewness(vH_ed_vec_025)
vH_ed_kurt_025 = kurtosis(vH_ed_vec_025)

vH_ed_vec_050 = reshape(vH_ed_050_ll,[1,numel(vH_ed_050_ll)]);
vH_ed_vec_050(isnan(vH_ed_vec_050))=[];
vH_ed_mean_050 = mean(vH_ed_vec_050)
vH_ed_var_050 = var(vH_ed_vec_050)
vH_ed_skew_050 = skewness(vH_ed_vec_050)
vH_ed_kurt_050 = kurtosis(vH_ed_vec_050)

vH_ed_vec_075 = reshape(vH_ed_075_ll,[1,numel(vH_ed_075_ll)]);
vH_ed_vec_075(isnan(vH_ed_vec_075))=[];
vH_ed_mean_075 = mean(vH_ed_vec_075)
vH_ed_var_075 = var(vH_ed_vec_075)
vH_ed_skew_075 = skewness(vH_ed_vec_075)
vH_ed_kurt_075 = kurtosis(vH_ed_vec_075)

vH_ed_vec_100 = reshape(vH_ed_100_ll,[1,numel(vH_ed_100_ll)]);
vH_ed_vec_100(isnan(vH_ed_vec_100))=[];
vH_ed_mean_100 = mean(vH_ed_vec_100)
vH_ed_var_100 = var(vH_ed_vec_100)
vH_ed_skew_100 = skewness(vH_ed_vec_100)
vH_ed_kurt_100 = kurtosis(vH_ed_vec_100)


xbins=-7e4:2e3:1.6e5;
for i=1:90
counts_000(i,:) = hist(reshape(vH_ed_000_ll(:,i,:),[1,numel(vH_ed_000_ll(:,i,:))]),xbins);
counts_000_cos(i,:) = counts_000(i,:).*cos(yi(i).*pi./180);

counts_010(i,:) = hist(reshape(vH_ed_010_ll(:,i,:),[1,numel(vH_ed_010_ll(:,i,:))]),xbins);
counts_010_cos(i,:) = counts_010(i,:).*cos(yi(i).*pi./180);

counts_025(i,:) = hist(reshape(vH_ed_025_ll(:,i,:),[1,numel(vH_ed_025_ll(:,i,:))]),xbins);
counts_025_cos(i,:) = counts_025(i,:).*cos(yi(i).*pi./180);

counts_050(i,:) = hist(reshape(vH_ed_050_ll(:,i,:),[1,numel(vH_ed_050_ll(:,i,:))]),xbins);
counts_050_cos(i,:) = counts_050(i,:).*cos(yi(i).*pi./180);

counts_075(i,:) = hist(reshape(vH_ed_075_ll(:,i,:),[1,numel(vH_ed_075_ll(:,i,:))]),xbins);
counts_075_cos(i,:) = counts_075(i,:).*cos(yi(i).*pi./180);

counts_100(i,:) = hist(reshape(vH_ed_100_ll(:,i,:),[1,numel(vH_ed_100_ll(:,i,:))]),xbins);
counts_100_cos(i,:) = counts_100(i,:).*cos(yi(i).*pi./180);
end

counts_000_hist = sum(counts_000_cos,1)./sum(sum(counts_000_cos));
counts_010_hist = sum(counts_010_cos,1)./sum(sum(counts_010_cos));
counts_025_hist = sum(counts_025_cos,1)./sum(sum(counts_025_cos));
counts_050_hist = sum(counts_050_cos,1)./sum(sum(counts_050_cos));
counts_075_hist = sum(counts_075_cos,1)./sum(sum(counts_075_cos));
counts_100_hist = sum(counts_100_cos,1)./sum(sum(counts_100_cos));


figure
h=bar(xbins,counts_000_hist);
set(gca,'FontSize',15);
hold on 
ylim([0 0.3])
xlim([-7e4 1.6e5])
xlabel('v''H'', K')
ylabel('Probability')
title('0.0 e_{s0}')
print('-dpng','vHpcos_pdf_000.png')


figure
h=bar(xbins,counts_010_hist);
set(gca,'FontSize',15);
hold on 
ylim([0 0.3])
xlim([-7e4 1.6e5])
xlabel('v''H'', K')
ylabel('Probability')
title('0.1 e_{s0}')
print('-dpng','vHpcos_pdf_010.png')


figure
h=bar(xbins,counts_025_hist);
set(gca,'FontSize',15);
hold on 
ylim([0 0.3])
xlim([-7e4 1.6e5])
xlabel('v''H'', K')
ylabel('Probability')
title('0.25 e_{s0}')
print('-dpng','vHpcos_pdf_025.png')


figure
h=bar(xbins,counts_050_hist);
set(gca,'FontSize',15);
hold on 
ylim([0 0.3])
xlim([-7e4 1.6e5])
xlabel('v''H'', K')
ylabel('Probability')
title('0.5 e_{s0}')
print('-dpng','vHpcos_pdf_050.png')


figure
h=bar(xbins,counts_075_hist);
set(gca,'FontSize',15);
hold on 
ylim([0 0.3])
xlim([-7e4 1.6e5])
xlabel('v''H'', K')
ylabel('Probability')
title('0.75 e_{s0}')
print('-dpng','vHpcos_pdf_075.png')


figure
h=bar(xbins,counts_100_hist);
set(gca,'FontSize',15);
hold on 
ylim([0 0.3])
xlim([-7e4 1.6e5])
xlabel('v''H'', K')
ylabel('Probability')
title('1.0 e_{s0}')
print('-dpng','vHpcos_pdf_100.png')



