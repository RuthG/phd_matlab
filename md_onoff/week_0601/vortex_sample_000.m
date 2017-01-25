%pick a vortex manually based on 860hPa relative vorticity, find its centre, follow for a few days, plot fields, see what we get...


% choose directory, load grid
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
yi = -89:2:89; xi=-179:2:179;

load('/project/rg312/mat_files/vorticity_data_best.mat','vort_000')
vort_000_ll = cube2latlon(xg,yg,vort_000,xi,yi);


load('/project/rg312/mat_files/snapshot_data/uE_snapshots_best.mat','uE_000')
uE_000_ll = cube2latlon(xg,yg,uE_000,xi,yi);
uE_ed_000_ll = uE_000_ll - repmat(mean(uE_000_ll,4),[1 1 1 720]);

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_000')
t_000_ll = cube2latlon(xg,yg,t_000,xi,yi);
t_ed_000_ll = t_000_ll - repmat(mean(t_000_ll,4),[1 1 1 720]);

coords(1,:) = [79,64,357];
coords(2,:) = [87,64,358];
coords(3,:) = [92,67,359];
coords(4,:) = [97,69,360];
coords(5,:) = [99,70,361];
coords(6,:) = [99,70,362];
coords(7,:) = [99,71,363];

vort_000_ll(79,64,4,357)
vort_000_ll(87,64,4,358)
vort_000_ll(92,67,4,359)
vort_000_ll(97,69,4,360)
vort_000_ll(99,70,4,361)
vort_000_ll(99,70,4,362)
vort_000_ll(99,71,4,363)

for i=1:7
figure
v= -8e-5:1e-5:8e-5;
[C,h]=contourf(xi(coords(i,1)-20: coords(i,1)+20) ,yi(coords(i,2)-10:coords(i,2)+10) , vort_000_ll( coords(i,1)-20: coords(i,1)+20 , coords(i,2)-10:coords(i,2)+10 , 4 ,coords(i,3))',v);
xlabel('Longitude')
ylabel('Latitude')
colorbar
caxis([-8e-5 8e-5])
print('-dpng',['vort_ll_000_' num2str(i) '.png'])

figure
v=-10e-5:1e-5:12e-5;
[C,h]=contourf(xi(coords(i,1)-20: coords(i,1)+20) ,rC , squeeze(vort_000_ll( coords(i,1)-20: coords(i,1)+20 , coords(i,2), : ,coords(i,3)))',v);
set(gca,'YDir','reverse')
xlabel('Longitude')
ylabel('Pressure, Pa')
colorbar
caxis([-10e-5 12e-5])
print('-dpng',['vort_lp_000_' num2str(i) '.png'])

figure
v=-24:2:24;
[C,h]=contourf(xi(coords(i,1)-20: coords(i,1)+20) ,yi(coords(i,2)-10:coords(i,2)+10) , uE_000_ll( coords(i,1)-20: coords(i,1)+20 , coords(i,2)-10:coords(i,2)+10 , 4 ,coords(i,3))',v);
xlabel('Longitude')
ylabel('Latitude')
colorbar
caxis([-24 24])
print('-dpng',['u_ll_000_' num2str(i) '.png'])

figure
v=-20:5:50;
[C,h]=contourf(xi(coords(i,1)-20: coords(i,1)+20) ,rC , squeeze(uE_000_ll( coords(i,1)-20: coords(i,1)+20 , coords(i,2), : ,coords(i,3)))',v);
set(gca,'YDir','reverse')
xlabel('Longitude')
ylabel('Pressure, Pa')
colorbar
caxis([-20 50])
print('-dpng',['u_lp_000_' num2str(i) '.png'])

close all

figure
v=262:2:286;
[C,h]=contourf(xi(coords(i,1)-20: coords(i,1)+20) ,yi(coords(i,2)-10:coords(i,2)+10) , t_000_ll( coords(i,1)-20: coords(i,1)+20 , coords(i,2)-10:coords(i,2)+10 , 4 ,coords(i,3))',v);
xlabel('Longitude')
ylabel('Latitude')
colorbar
caxis([262 286])
print('-dpng',['t_ll_000_' num2str(i) '.png'])

figure
v=205:5:280;
[C,h]=contourf(xi(coords(i,1)-20: coords(i,1)+20) ,rC , squeeze(t_000_ll( coords(i,1)-20: coords(i,1)+20 , coords(i,2), : ,coords(i,3)))',v);
set(gca,'YDir','reverse')
xlabel('Longitude')
ylabel('Pressure, Pa')
colorbar
caxis([205 280])
print('-dpng',['t_lp_000_' num2str(i) '.png'])


figure
v=-20:2:20;
[C,h]=contourf(xi(coords(i,1)-20: coords(i,1)+20) ,yi(coords(i,2)-10:coords(i,2)+10) , uE_ed_000_ll( coords(i,1)-20: coords(i,1)+20 , coords(i,2)-10:coords(i,2)+10 , 4 ,coords(i,3))',v);
xlabel('Longitude')
ylabel('Latitude')
colorbar
caxis([-20 20])
print('-dpng',['ued_ll_000_' num2str(i) '.png'])

figure
v=-30:2:30;
[C,h]=contourf(xi(coords(i,1)-20: coords(i,1)+20) ,rC , squeeze(uE_ed_000_ll( coords(i,1)-20: coords(i,1)+20 , coords(i,2), : ,coords(i,3)))',v);
set(gca,'YDir','reverse')
xlabel('Longitude')
ylabel('Pressure, Pa')
colorbar
caxis([-30 30])
print('-dpng',['ued_lp_000_' num2str(i) '.png'])


figure
v=-8:1:8;
[C,h]=contourf(xi(coords(i,1)-20: coords(i,1)+20) ,yi(coords(i,2)-10:coords(i,2)+10) , t_ed_000_ll( coords(i,1)-20: coords(i,1)+20 , coords(i,2)-10:coords(i,2)+10 , 4 ,coords(i,3))',v);
xlabel('Longitude')
ylabel('Latitude')
colorbar
caxis([-8 8])
print('-dpng',['ted_ll_000_' num2str(i) '.png'])

figure
v=-15:1:15;
[C,h]=contourf(xi(coords(i,1)-20: coords(i,1)+20) ,rC , squeeze(t_ed_000_ll( coords(i,1)-20: coords(i,1)+20 , coords(i,2), : ,coords(i,3)))',v);
set(gca,'YDir','reverse')
xlabel('Longitude')
ylabel('Pressure, Pa')
colorbar
caxis([-15 15])
print('-dpng',['ted_lp_000_' num2str(i) '.png'])

close all
end


