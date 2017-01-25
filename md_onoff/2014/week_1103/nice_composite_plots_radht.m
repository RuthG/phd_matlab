

x=-34:2:34;
y= 980:-40:20;


load('radht_composites.mat')
v = -2: 0.25: 2.5;

figure

[C,h] = contourf(x,y,radht_comp_000'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','radht_comp_000.png')

figure

[C,h] = contourf(x,y,radht_comp_010'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','radht_comp_010.png')

figure

[C,h] = contourf(x,y,radht_comp_025'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','radht_comp_025.png')

figure

[C,h] = contourf(x,y,radht_comp_050'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','radht_comp_050.png')

figure

[C,h] = contourf(x,y,radht_comp_075'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2));
print('-dpng','radht_comp_075.png')

figure

[C,h] = contourf(x,y,radht_comp_100'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','radht_comp_100.png')





load('radht_composites_desc.mat')

figure

[C,h] = contourf(x,y,radht_comp_000'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','radht_comp_000_desc.png')

figure

[C,h] = contourf(x,y,radht_comp_010'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','radht_comp_010_desc.png')

figure

[C,h] = contourf(x,y,radht_comp_025'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','radht_comp_025_desc.png')

figure

[C,h] = contourf(x,y,radht_comp_050'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','radht_comp_050_desc.png')

figure

[C,h] = contourf(x,y,radht_comp_075'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2));
print('-dpng','radht_comp_075_desc.png')

figure

[C,h] = contourf(x,y,radht_comp_100'.*86400,v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-2,2));
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','radht_comp_100_desc.png')
