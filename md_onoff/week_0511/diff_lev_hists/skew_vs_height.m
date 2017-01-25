%load in T and plot histogram of skewness of T vs height

rDir='/project/rg312/wv_on_rad_off/run_000_best/';
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


load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_000')
t_000_ll = squeeze(cube2latlon(xc,yc,t_000(:,:,:,1:719),xi,yi));
t_000_ll_tav = repmat(mean(t_000_ll,4),[1 1 1 719]);
t_ed_000_ll = t_000_ll - t_000_ll_tav;
clear('t_000','t_000_ll_tav','t_000_ll')

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_010')
t_010_ll = squeeze(cube2latlon(xc,yc,t_010(:,:,:,1:719),xi,yi));
t_010_ll_tav = repmat(mean(t_010_ll,4),[1 1 1 719]);
t_ed_010_ll = t_010_ll - t_010_ll_tav;
clear('t_010','t_010_ll_tav','t_010_ll')

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_025')
t_025_ll = squeeze(cube2latlon(xc,yc,t_025(:,:,:,1:719),xi,yi));
t_025_ll_tav = repmat(mean(t_025_ll,4),[1 1 1 719]);
t_ed_025_ll = t_025_ll - t_025_ll_tav;
clear('t_025','t_025_ll_tav','t_025_ll')

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_050')
t_050_ll = squeeze(cube2latlon(xc,yc,t_050(:,:,:,1:719),xi,yi));
t_050_ll_tav = repmat(mean(t_050_ll,4),[1 1 1 719]);
t_ed_050_ll = t_050_ll - t_050_ll_tav;
clear('t_050','t_050_ll_tav','t_050_ll')

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_075')
t_075_ll = squeeze(cube2latlon(xc,yc,t_075(:,:,:,1:719),xi,yi));
t_075_ll_tav = repmat(mean(t_075_ll,4),[1 1 1 719]);
t_ed_075_ll = t_075_ll - t_075_ll_tav;
clear('t_075','t_075_ll_tav','t_075_ll')

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_100')
t_100_ll = squeeze(cube2latlon(xc,yc,t_100(:,:,:,1:719),xi,yi));
t_100_ll_tav = repmat(mean(t_100_ll,4),[1 1 1 719]);
t_ed_100_ll = t_100_ll - t_100_ll_tav;
clear('t_100','t_100_ll_tav','t_100_ll')

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_125')
t_125_ll = squeeze(cube2latlon(xc,yc,t_125(:,:,:,1:719),xi,yi));
t_125_ll_tav = repmat(mean(t_125_ll,4),[1 1 1 719]);
t_ed_125_ll = t_125_ll - t_125_ll_tav;
clear('t_125','t_125_ll_tav','t_125_ll')

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_150')
t_150_ll = squeeze(cube2latlon(xc,yc,t_150(:,:,:,1:719),xi,yi));
t_150_ll_tav = repmat(mean(t_150_ll,4),[1 1 1 719]);
t_ed_150_ll = t_150_ll - t_150_ll_tav;
clear('t_150','t_150_ll_tav','t_150_ll')


for i=1:25
t_ed_000_lin(:,i) = reshape(t_ed_000_ll(:,2:89,i,:),[numel(t_ed_000_ll(:,2:89,i,:)),1]);
t_ed_010_lin(:,i) = reshape(t_ed_010_ll(:,2:89,i,:),[numel(t_ed_010_ll(:,2:89,i,:)),1]);
t_ed_025_lin(:,i) = reshape(t_ed_025_ll(:,2:89,i,:),[numel(t_ed_025_ll(:,2:89,i,:)),1]);
t_ed_050_lin(:,i) = reshape(t_ed_050_ll(:,2:89,i,:),[numel(t_ed_050_ll(:,2:89,i,:)),1]);
t_ed_075_lin(:,i) = reshape(t_ed_075_ll(:,2:89,i,:),[numel(t_ed_075_ll(:,2:89,i,:)),1]);
t_ed_100_lin(:,i) = reshape(t_ed_100_ll(:,2:89,i,:),[numel(t_ed_100_ll(:,2:89,i,:)),1]);
t_ed_125_lin(:,i) = reshape(t_ed_125_ll(:,2:89,i,:),[numel(t_ed_125_ll(:,2:89,i,:)),1]);
t_ed_150_lin(:,i) = reshape(t_ed_150_ll(:,2:89,i,:),[numel(t_ed_150_ll(:,2:89,i,:)),1]);
end

%clear('t_ed_000_ll', 't_ed_010_ll', 't_ed_025_ll', 't_ed_050_ll', 't_ed_075_ll', 't_ed_100_ll', 't_ed_125_ll', 't_ed_150_ll')

t_skew_000 = skewness(t_ed_000_lin,1);
t_skew_010 = skewness(t_ed_010_lin,1);
t_skew_025 = skewness(t_ed_025_lin,1);
t_skew_050 = skewness(t_ed_050_lin,1);
t_skew_075 = skewness(t_ed_075_lin,1);
t_skew_100 = skewness(t_ed_100_lin,1);
t_skew_125 = skewness(t_ed_125_lin,1);
t_skew_150 = skewness(t_ed_150_lin,1);

t_max_000 = squeeze(mean(max(max(t_ed_000_ll)),4));
t_min_000 = squeeze(mean(min(min(t_ed_000_ll)),4));

t_max_010 = squeeze(mean(max(max(t_ed_010_ll)),4));
t_min_010 = squeeze(mean(min(min(t_ed_010_ll)),4));

t_max_025 = squeeze(mean(max(max(t_ed_025_ll)),4));
t_min_025 = squeeze(mean(min(min(t_ed_025_ll)),4));

t_max_050 = squeeze(mean(max(max(t_ed_050_ll)),4));
t_min_050 = squeeze(mean(min(min(t_ed_050_ll)),4));

t_max_075 = squeeze(mean(max(max(t_ed_075_ll)),4));
t_min_075 = squeeze(mean(min(min(t_ed_075_ll)),4));

t_max_100 = squeeze(mean(max(max(t_ed_100_ll)),4));
t_min_100 = squeeze(mean(min(min(t_ed_100_ll)),4));

plot(t_skew_000,rC)
hold on
plot(t_skew_010,rC,'r')
plot(t_skew_025,rC,'g')
plot(t_skew_050,rC,'k')
plot(t_skew_075,rC,'c')
plot(t_skew_100,rC,'m')
plot(t_skew_125,rC,'y')
plot(t_skew_150,rC,'--')
set(gca,'YDir','reverse')


