

x=-34:2:34;
y= 980:-40:20;


load('/project/rg312/mat_files/theta_composites.mat')
v = 250:10:400;

figure

[C,h] = contourf(x,y,theta_comp_000',v);
set(gca,'yDir','reverse')
colorbar
caxis([250 400])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','theta_comp_000.png')

figure

[C,h] = contourf(x,y,theta_comp_010',v);
set(gca,'yDir','reverse')
colorbar
caxis([250 400])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','theta_comp_010.png')

figure

[C,h] = contourf(x,y,theta_comp_025',v);
set(gca,'yDir','reverse')
colorbar
caxis([250 400])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','theta_comp_025.png')

figure

[C,h] = contourf(x,y,theta_comp_050',v);
set(gca,'yDir','reverse')
colorbar
caxis([250 400])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','theta_comp_050.png')

figure

[C,h] = contourf(x,y,theta_comp_075',v);
set(gca,'yDir','reverse')
colorbar
caxis([250 400])
print('-dpng','theta_comp_075.png')

figure

[C,h] = contourf(x,y,theta_comp_100',v);
set(gca,'yDir','reverse')
colorbar
caxis([250 400])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','theta_comp_100.png')

rC = [98000:-4000:2000]';
convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp_comp_000(:,j)=theta_comp_000(:,j).*convthetatoT(j,1);
temp_comp_010(:,j)=theta_comp_010(:,j).*convthetatoT(j,1);
temp_comp_025(:,j)=theta_comp_025(:,j).*convthetatoT(j,1);
temp_comp_050(:,j)=theta_comp_050(:,j).*convthetatoT(j,1);
temp_comp_075(:,j)=theta_comp_075(:,j).*convthetatoT(j,1);
temp_comp_100(:,j)=theta_comp_100(:,j).*convthetatoT(j,1);
end



figure
v=180:5:300;
[C,h] = contourf(x,y,temp_comp_000',v);
set(gca,'yDir','reverse')
colorbar
caxis([180 300])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','temp_comp_000.png')

figure

[C,h] = contourf(x,y,temp_comp_010',v);
set(gca,'yDir','reverse')
colorbar
caxis([180 300])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','temp_comp_010.png')

figure

[C,h] = contourf(x,y,temp_comp_025',v);
set(gca,'yDir','reverse')
colorbar
caxis([180 300])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','temp_comp_025.png')

figure

[C,h] = contourf(x,y,temp_comp_050',v);
set(gca,'yDir','reverse')
colorbar
caxis([180 300])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','temp_comp_050.png')

figure

[C,h] = contourf(x,y,temp_comp_075',v);
set(gca,'yDir','reverse')
colorbar
caxis([180 300])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','temp_comp_075.png')

figure

[C,h] = contourf(x,y,temp_comp_100',v);
set(gca,'yDir','reverse')
colorbar
caxis([180 300])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','temp_comp_100.png')








load('/project/rg312/mat_files/theta_composites_desc.mat')

figure
v = 250:10:400;
[C,h] = contourf(x,y,theta_comp_000',v);
set(gca,'yDir','reverse')
colorbar
caxis([250 400])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','theta_comp_000_desc.png')

figure

[C,h] = contourf(x,y,theta_comp_010',v);
set(gca,'yDir','reverse')
colorbar
caxis([250 400])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','theta_comp_010_desc.png')

figure

[C,h] = contourf(x,y,theta_comp_025',v);
set(gca,'yDir','reverse')
colorbar
caxis([250 400])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','theta_comp_025_desc.png')

figure

[C,h] = contourf(x,y,theta_comp_050',v);
set(gca,'yDir','reverse')
colorbar
caxis([250 400])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','theta_comp_050_desc.png')

figure

[C,h] = contourf(x,y,theta_comp_075',v);
set(gca,'yDir','reverse')
colorbar
caxis([250 400])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','theta_comp_075_desc.png')

figure

[C,h] = contourf(x,y,theta_comp_100',v);
set(gca,'yDir','reverse')
colorbar
caxis([250 400])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','theta_comp_100_desc.png')




for j=1:size(rC)
temp_comp_000(:,j)=theta_comp_000(:,j).*convthetatoT(j,1);
temp_comp_010(:,j)=theta_comp_010(:,j).*convthetatoT(j,1);
temp_comp_025(:,j)=theta_comp_025(:,j).*convthetatoT(j,1);
temp_comp_050(:,j)=theta_comp_050(:,j).*convthetatoT(j,1);
temp_comp_075(:,j)=theta_comp_075(:,j).*convthetatoT(j,1);
temp_comp_100(:,j)=theta_comp_100(:,j).*convthetatoT(j,1);
end





figure
v=180:5:300;
[C,h] = contourf(x,y,temp_comp_000',v);
set(gca,'yDir','reverse')
colorbar
caxis([180 300])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','temp_comp_000_desc.png')

figure

[C,h] = contourf(x,y,temp_comp_010',v);
set(gca,'yDir','reverse')
colorbar
caxis([180 300])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','temp_comp_010_desc.png')

figure

[C,h] = contourf(x,y,temp_comp_025',v);
set(gca,'yDir','reverse')
colorbar
caxis([180 300])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','temp_comp_025_desc.png')

figure

[C,h] = contourf(x,y,temp_comp_050',v);
set(gca,'yDir','reverse')
colorbar
caxis([180 300])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','temp_comp_050_desc.png')

figure

[C,h] = contourf(x,y,temp_comp_075',v);
set(gca,'yDir','reverse')
colorbar
caxis([180 300])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','temp_comp_075_desc.png')

figure

[C,h] = contourf(x,y,temp_comp_100',v);
set(gca,'yDir','reverse')
colorbar
caxis([180 300])
xlabel('Longitude')
ylabel('Pressure, hPa')
print('-dpng','temp_comp_100_desc.png')

