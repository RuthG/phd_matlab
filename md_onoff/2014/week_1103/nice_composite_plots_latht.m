

x=-34:2:34;
y= 980:-40:20;


load('latht_composites.mat')
v = -2: 0.25: 2.5;

figure

[C,h] = contourf(x,y,latht_comp_000'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2.5));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','latht_comp_000.png')

figure

[C,h] = contourf(x,y,latht_comp_010'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2.5));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','latht_comp_010.png')

figure

[C,h] = contourf(x,y,latht_comp_025'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2.5));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','latht_comp_025.png')

figure

[C,h] = contourf(x,y,latht_comp_050'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2.5));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','latht_comp_050.png')

figure

[C,h] = contourf(x,y,latht_comp_075'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2.5));
print('-dpng','latht_comp_075.png')

figure

[C,h] = contourf(x,y,latht_comp_100'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2.5));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','latht_comp_100.png')




load('latht_composites_desc.mat')

figure

[C,h] = contourf(x,y,latht_comp_000_desc'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2.5));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','latht_comp_000_desc.png')

figure

[C,h] = contourf(x,y,latht_comp_010_desc'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2.5));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','latht_comp_010_desc.png')

figure

[C,h] = contourf(x,y,latht_comp_025_desc'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2.5));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','latht_comp_025_desc.png')

figure

[C,h] = contourf(x,y,latht_comp_050_desc'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2.5));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','latht_comp_050_desc.png')

figure

[C,h] = contourf(x,y,latht_comp_075_desc'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2.5));
print('-dpng','latht_comp_075_desc.png')

figure

[C,h] = contourf(x,y,latht_comp_100_desc'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2.5));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','latht_comp_100_desc.png')
