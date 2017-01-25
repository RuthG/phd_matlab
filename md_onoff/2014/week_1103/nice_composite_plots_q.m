

x=-34:2:34;
y= 980:-40:20;


load('/project/rg312/mat_files/q_composites.mat')
v = 0:0.5:10;

figure

[C,h] = contourf(x,y,q_comp_000'.*1000,v);
set(gca,'yDir','reverse')
colorbar
caxis([0 10])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','q_comp_000.png')

figure

[C,h] = contourf(x,y,q_comp_010'.*1000,v);
set(gca,'yDir','reverse')
colorbar
caxis([0 10])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','q_comp_010.png')

figure

[C,h] = contourf(x,y,q_comp_025'.*1000,v);
set(gca,'yDir','reverse')
colorbar
caxis([0 10])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','q_comp_025.png')

figure

[C,h] = contourf(x,y,q_comp_050'.*1000,v);
set(gca,'yDir','reverse')
colorbar
caxis([0 10])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','q_comp_050.png')

figure

[C,h] = contourf(x,y,q_comp_075'.*1000,v);
set(gca,'yDir','reverse')
colorbar
caxis([0 10])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','q_comp_075.png')

figure

[C,h] = contourf(x,y,q_comp_100'.*1000,v);
set(gca,'yDir','reverse')
colorbar
caxis([0 10])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','q_comp_100.png')





load('/project/rg312/mat_files/q_composites_desc.mat')

figure

[C,h] = contourf(x,y,q_comp_000'.*1000,v);
set(gca,'yDir','reverse')
colorbar
caxis([0 10])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','q_comp_000_desc.png')

figure

[C,h] = contourf(x,y,q_comp_010'.*1000,v);
set(gca,'yDir','reverse')
colorbar
caxis([0 10])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','q_comp_010_desc.png')

figure

[C,h] = contourf(x,y,q_comp_025'.*1000,v);
set(gca,'yDir','reverse')
colorbar
caxis([0 10])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','q_comp_025_desc.png')

figure

[C,h] = contourf(x,y,q_comp_050'.*1000,v);
set(gca,'yDir','reverse')
colorbar
caxis([0 10])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','q_comp_050_desc.png')

figure

[C,h] = contourf(x,y,q_comp_075'.*1000,v);
set(gca,'yDir','reverse')
colorbar
caxis([0 10])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','q_comp_075_desc.png')

figure

[C,h] = contourf(x,y,q_comp_100'.*1000,v);
set(gca,'yDir','reverse')
colorbar
caxis([0 10])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','q_comp_100_desc.png')
