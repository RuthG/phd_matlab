%pick a vortex manually based on 860hPa relative vorticity, find its centre, follow for a few days, plot fields, see what we get...


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
yi = -89:2:89; xi=-179:2:179;

load('/project/rg312/mat_files/vorticity_data_best.mat','vort_100')
vort_100_ll = cube2latlon(xg,yg,vort_100,xi,yi);

load('/project/rg312/mat_files/snapshot_data/uE_snapshots_best.mat','uE_100')
uE_100_ll = cube2latlon(xg,yg,uE_100,xi,yi);
uE_ed_100_ll = uE_100_ll - repmat(mean(uE_100_ll,4),[1 1 1 720]);

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_100')
t_100_ll = cube2latlon(xg,yg,t_100,xi,yi);
t_ed_100_ll = t_100_ll - repmat(mean(t_100_ll,4),[1 1 1 720]);

coords(1,:) = [121,66,354];
coords(2,:) = [125,65,355];
coords(3,:) = [130,66,356];
coords(4,:) = [132,68,357];
coords(5,:) = [133,68,358];
coords(6,:) = [138,72,359];
coords(7,:) = [147,76,360];

vort_100_ll(121,66,4,354)
vort_100_ll(125,65,4,355)
vort_100_ll(130,66,4,356)
vort_100_ll(132,68,4,357)
vort_100_ll(133,68,4,358)
vort_100_ll(138,72,4,359)
vort_100_ll(147,76,4,360)

for i=1:7
figure
v= -8e-5:1e-5:8e-5;
[C,h]=contourf(xi(coords(i,1)-20: coords(i,1)+20) ,yi(coords(i,2)-10:coords(i,2)+10) , vort_100_ll( coords(i,1)-20: coords(i,1)+20 , coords(i,2)-10:coords(i,2)+10 , 4 ,coords(i,3))',v);
xlabel('Longitude')
ylabel('Latitude')
colorbar
caxis([-8e-5 8e-5])
print('-dpng',['vort_ll_100_' num2str(i) '.png'])

figure
v=-10e-5:1e-5:12e-5;
[C,h]=contourf(xi(coords(i,1)-20: coords(i,1)+20) ,rC , squeeze(vort_100_ll( coords(i,1)-20: coords(i,1)+20 , coords(i,2), : ,coords(i,3)))',v);
set(gca,'YDir','reverse')
xlabel('Longitude')
ylabel('Pressure, Pa')
colorbar
caxis([-10e-5 12e-5])
print('-dpng',['vort_lp_100_' num2str(i) '.png'])

figure
v=-24:2:24;
[C,h]=contourf(xi(coords(i,1)-20: coords(i,1)+20) ,yi(coords(i,2)-10:coords(i,2)+10) , uE_100_ll( coords(i,1)-20: coords(i,1)+20 , coords(i,2)-10:coords(i,2)+10 , 4 ,coords(i,3))',v);
xlabel('Longitude')
ylabel('Latitude')
colorbar
caxis([-24 24])
print('-dpng',['u_ll_100_' num2str(i) '.png'])

figure
v=-20:5:50;
[C,h]=contourf(xi(coords(i,1)-20: coords(i,1)+20) ,rC , squeeze(uE_100_ll( coords(i,1)-20: coords(i,1)+20 , coords(i,2), : ,coords(i,3)))',v);
set(gca,'YDir','reverse')
xlabel('Longitude')
ylabel('Pressure, Pa')
colorbar
caxis([-20 50])
print('-dpng',['u_lp_100_' num2str(i) '.png'])

close all

figure
v=262:2:286;
[C,h]=contourf(xi(coords(i,1)-20: coords(i,1)+20) ,yi(coords(i,2)-10:coords(i,2)+10) , t_100_ll( coords(i,1)-20: coords(i,1)+20 , coords(i,2)-10:coords(i,2)+10 , 4 ,coords(i,3))',v);
xlabel('Longitude')
ylabel('Latitude')
colorbar
caxis([262 286])
print('-dpng',['t_ll_100_' num2str(i) '.png'])

figure
v=205:5:280;
[C,h]=contourf(xi(coords(i,1)-20: coords(i,1)+20) ,rC , squeeze(t_100_ll( coords(i,1)-20: coords(i,1)+20 , coords(i,2), : ,coords(i,3)))',v);
set(gca,'YDir','reverse')
xlabel('Longitude')
ylabel('Pressure, Pa')
colorbar
caxis([205 280])
print('-dpng',['t_lp_100_' num2str(i) '.png'])


figure
v=-20:2:20;
[C,h]=contourf(xi(coords(i,1)-20: coords(i,1)+20) ,yi(coords(i,2)-10:coords(i,2)+10) , uE_ed_100_ll( coords(i,1)-20: coords(i,1)+20 , coords(i,2)-10:coords(i,2)+10 , 4 ,coords(i,3))',v);
xlabel('Longitude')
ylabel('Latitude')
colorbar
caxis([-20 20])
print('-dpng',['ued_ll_100_' num2str(i) '.png'])

figure
v=-30:2:30;
[C,h]=contourf(xi(coords(i,1)-20: coords(i,1)+20) ,rC , squeeze(uE_ed_100_ll( coords(i,1)-20: coords(i,1)+20 , coords(i,2), : ,coords(i,3)))',v);
set(gca,'YDir','reverse')
xlabel('Longitude')
ylabel('Pressure, Pa')
colorbar
caxis([-30 30])
print('-dpng',['ued_lp_100_' num2str(i) '.png'])


figure
v=-8:1:8;
[C,h]=contourf(xi(coords(i,1)-20: coords(i,1)+20) ,yi(coords(i,2)-10:coords(i,2)+10) , t_ed_100_ll( coords(i,1)-20: coords(i,1)+20 , coords(i,2)-10:coords(i,2)+10 , 4 ,coords(i,3))',v);
xlabel('Longitude')
ylabel('Latitude')
colorbar
caxis([-8 8])
print('-dpng',['ted_ll_100_' num2str(i) '.png'])

figure
v=-15:1:15;
[C,h]=contourf(xi(coords(i,1)-20: coords(i,1)+20) ,rC , squeeze(t_ed_100_ll( coords(i,1)-20: coords(i,1)+20 , coords(i,2), : ,coords(i,3)))',v);
set(gca,'YDir','reverse')
xlabel('Longitude')
ylabel('Pressure, Pa')
colorbar
caxis([-15 15])
print('-dpng',['ted_lp_100_' num2str(i) '.png'])

close all
end


