%calculate the meridional heat transport using vT, vq

rDir='/project/rg312/final_runs/run_100_final/';
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
xi=-179:2:179;yi=-89:2:90;
L = 2.500e6;
cp = 287.04./(2./7.);
g=9.8;
a=6371.0e3;

load('/project/rg312/mat_files/snapshot_data_final/run_100/vN_100_5.mat')

vN_ll = squeeze(cube2latlon(xc,yc,vN_100,xi,yi));

load('/project/rg312/mat_files/snapshot_data_final/run_100/t_100_5.mat')
t_ll = squeeze(cube2latlon(xc,yc,t_100,xi,yi));

load('/project/rg312/mat_files/snapshot_data_final/run_100/q_100_5.mat')
q_ll = squeeze(cube2latlon(xc,yc,q_100,xi,yi));

load('/project/rg312/mat_files/snapshot_data_final/run_100/ph_adj_100_5.mat')
ph_ll = squeeze(cube2latlon(xc,yc,ph_adj_100,xi,yi));

vNLq_ll = mean(L.*vN_ll.*q_ll,4);
vNcpT_ll = mean(cp.*vN_ll.*t_ll,4);
vNd_ll = vNcpT_ll + mean(ph_ll.*vN_ll,4);
vNH_ll = vNLq_ll + vNd_ll;

for i=1:90
heat_trans(i) = 2.*pi.*a.*cos(yi(i).*pi./180).*squeeze(mean(sum(vNH_ll(:,i,:),3),1)).*4000./g;
heat_trans_l(i) = 2.*pi.*a.*cos(yi(i).*pi./180).*squeeze(mean(sum(vNLq_ll(:,i,:),3),1)).*4000./g;
heat_trans_cpT(i) = 2.*pi.*a.*cos(yi(i).*pi./180).*squeeze(mean(sum(vNcpT_ll(:,i,:),3),1)).*4000./g;
heat_trans_d(i) = 2.*pi.*a.*cos(yi(i).*pi./180).*squeeze(mean(sum(vNd_ll(:,i,:),3),1)).*4000./g;
end

figure
plot(yi,heat_trans./10^15,'k')
hold on
plot(yi,heat_trans_d./10^15,'r')
plot(yi,heat_trans_l./10^15,'b')
plot(yi,heat_trans_cpT./10^15,'m')
xlabel('Latitude')
ylabel('Meridional heat transport, PW')
legend('MSE','DSE','Latent heat','Sensible heat')
print('-dpng','heat_trans_radoff.png')