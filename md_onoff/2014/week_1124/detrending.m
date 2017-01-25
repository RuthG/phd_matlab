%load in vt_ed as fn of lat, lon, pres, time
%produce linear fits to time in days at each grid point at 4th pressure level and plot gradients. If small, don't worry about it!

load('/project/rg312/mat_files/snapshot_data/vt_ed_data.mat')

x(:,1)=(1:720)./360;

for i = 1:15
for j=1:180

tseries_000 = squeeze(vt_ed_000(j,i,4,:));
tseries_010 = squeeze(vt_ed_010(j,i,4,:));
tseries_025 = squeeze(vt_ed_025(j,i,4,:));
tseries_050 = squeeze(vt_ed_050(j,i,4,:));
tseries_075 = squeeze(vt_ed_075(j,i,4,:));
tseries_100 = squeeze(vt_ed_100(j,i,4,:));

p_000(j,i,:) = polyfit(x,tseries_000,1);
p_010(j,i,:) = polyfit(x,tseries_010,1);
p_025(j,i,:) = polyfit(x,tseries_025,1);
p_050(j,i,:) = polyfit(x,tseries_050,1);
p_075(j,i,:) = polyfit(x,tseries_075,1);
p_100(j,i,:) = polyfit(x,tseries_100,1);

end
end
