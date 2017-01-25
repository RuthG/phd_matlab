

x=-34:2:34;
y= 980:-40:20;


load('difht_composites.mat')
v = -2: 0.25: 2.5;

figure

[C,h] = contourf(x,y,difht_comp_000'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2.5));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','difht_comp_000.png')

figure

[C,h] = contourf(x,y,difht_comp_010'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2.5));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','difht_comp_010.png')

figure

[C,h] = contourf(x,y,difht_comp_025'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2.5));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','difht_comp_025.png')

figure

[C,h] = contourf(x,y,difht_comp_050'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2.5));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','difht_comp_050.png')

figure

[C,h] = contourf(x,y,difht_comp_075'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2.5));
print('-dpng','difht_comp_075.png')

figure

[C,h] = contourf(x,y,difht_comp_100'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2.5));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','difht_comp_100.png')



load('difht_composites_desc.mat')

figure

[C,h] = contourf(x,y,difht_comp_000'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2.5));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','difht_comp_000_desc.png')

figure

[C,h] = contourf(x,y,difht_comp_010'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2.5));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','difht_comp_010_desc.png')

figure

[C,h] = contourf(x,y,difht_comp_025'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2.5));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','difht_comp_025_desc.png')

figure

[C,h] = contourf(x,y,difht_comp_050'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2.5));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','difht_comp_050_desc.png')

figure

[C,h] = contourf(x,y,difht_comp_075'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2.5));
print('-dpng','difht_comp_075_desc.png')

figure

[C,h] = contourf(x,y,difht_comp_100'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2.5));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','difht_comp_100_desc.png')
