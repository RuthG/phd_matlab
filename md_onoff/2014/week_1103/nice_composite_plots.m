

x=-34:2:34;
y= 980:-40:20;


load('/project/rg312/mat_files/w_composites.mat')
v = -0.5: 0.05: 0.5;

figure

[C,h] = contourf(x,y,w_comp_000',v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-0.5,0.2));
clabel(C,h);
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','w_comp_000.png')

figure

[C,h] = contourf(x,y,w_comp_010',v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-0.5,0.2));
clabel(C,h);
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','w_comp_010.png')

figure

[C,h] = contourf(x,y,w_comp_025',v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-0.5,0.2));
clabel(C,h);
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','w_comp_025.png')

figure

[C,h] = contourf(x,y,w_comp_050',v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-0.5,0.2));
clabel(C,h);
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','w_comp_050.png')

figure

[C,h] = contourf(x,y,w_comp_075',v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-0.5,0.2));
clabel(C,h);
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','w_comp_075.png')

figure

[C,h] = contourf(x,y,w_comp_100',v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-0.5,0.2));
clabel(C,h);
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','w_comp_100.png')





load('/project/rg312/mat_files/w_composites_desc.mat')

figure

[C,h] = contourf(x,y,w_comp_000',v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-0.2,0.5));
clabel(C,h);
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','w_comp_000_desc.png')

figure

[C,h] = contourf(x,y,w_comp_010',v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-0.2,0.5));
clabel(C,h);
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','w_comp_010_desc.png')

figure

[C,h] = contourf(x,y,w_comp_025',v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-0.2,0.5));
clabel(C,h);
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','w_comp_025_desc.png')

figure

[C,h] = contourf(x,y,w_comp_050',v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-0.2,0.5));
clabel(C,h);
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','w_comp_050_desc.png')

figure

[C,h] = contourf(x,y,w_comp_075',v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-0.2,0.5));
clabel(C,h);
print('-dpng','w_comp_075_desc.png')

figure

[C,h] = contourf(x,y,w_comp_100',v);
set(gca,'yDir','reverse')
colorbar
colormap(b2r(-0.2,0.5));
clabel(C,h);
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','w_comp_100_desc.png')
