%thoff_000 = t_hoff_fun('000');
'000'
%thoff_010 = t_hoff_fun('010');
'010'
%thoff_025 = t_hoff_fun('025');
'025'
%thoff_050 = t_hoff_fun('050');
'050'
%thoff_075 = t_hoff_fun('075');
'075'
%thoff_100 = t_hoff_fun('100');
'100'

%vhoff_000 = v_hoff_fun('000');
'000'
%vhoff_010 = v_hoff_fun('010');
'010'
%vhoff_025 = v_hoff_fun('025');
'025'
%vhoff_050 = v_hoff_fun('050');
'050'
%vhoff_075 = v_hoff_fun('075');
'075'
%vhoff_100 = v_hoff_fun('100');
'100'

%save('/project/rg312/mat_files/hoffmuller.mat')

load('/project/rg312/mat_files/hoffmuller.mat')
xi=-179:2:179;
time=1:720;

figure
v=-10:2:10;
[C,h] = contourf(xi,time(1:75),thoff_000(:,1:75)',v);
set(gca,'FontSize',15);
xlabel('Longitude','FontSize',15);
ylabel('Time, days','FontSize',15);
title('0.0 es0','FontSize',15);
colorbar
colormap(b2r(-10,10));
print('-dpng','t_hoff_000.png')

figure
v=-10:2:10;
[C,h] = contourf(xi,time(1:75),thoff_010(:,1:75)',v);
set(gca,'FontSize',15);
xlabel('Longitude','FontSize',15);
ylabel('Time, days','FontSize',15);
title('0.1 es0','FontSize',15);
colorbar
colormap(b2r(-10,10));
print('-dpng','t_hoff_010.png')

figure
v=-10:2:10;
[C,h] = contourf(xi,time(1:75),thoff_025(:,1:75)',v);
set(gca,'FontSize',15);
xlabel('Longitude','FontSize',15);
ylabel('Time, days','FontSize',15);
title('0.25 es0','FontSize',15);
colorbar
colormap(b2r(-10,10));
print('-dpng','t_hoff_025.png')

figure
v=-10:2:10;
[C,h] = contourf(xi,time(1:75),thoff_050(:,1:75)',v);
set(gca,'FontSize',15);
xlabel('Longitude','FontSize',15);
ylabel('Time, days','FontSize',15);
title('0.5 es0','FontSize',15);
colorbar
colormap(b2r(-10,10));
print('-dpng','t_hoff_050.png')

figure
v=-10:2:10;
[C,h] = contourf(xi,time(1:75),thoff_075(:,1:75)',v);
set(gca,'FontSize',15);
xlabel('Longitude','FontSize',15);
ylabel('Time, days','FontSize',15);
title('0.75 es0','FontSize',15);
colorbar
colormap(b2r(-10,10));
print('-dpng','t_hoff_075.png')

figure
v=-10:2:10;
[C,h] = contourf(xi,time(1:75),thoff_100(:,1:75)',v);
set(gca,'FontSize',15);
xlabel('Longitude','FontSize',15);
ylabel('Time, days','FontSize',15);
title('1.0 es0','FontSize',15);
colorbar
colormap(b2r(-10,10));
print('-dpng','t_hoff_100.png')





figure
v=-28:4:28;
[C,h] = contourf(xi,time(1:75),vhoff_000(:,1:75)',v);
set(gca,'FontSize',15);
xlabel('Longitude','FontSize',15);
ylabel('Time, days','FontSize',15);
title('0.0 es0','FontSize',15);
colorbar
colormap(b2r(-26,26));
print('-dpng','v_hoff_000.png')

figure
v=-28:4:28;
[C,h] = contourf(xi,time(1:75),vhoff_010(:,1:75)',v);
set(gca,'FontSize',15);
xlabel('Longitude','FontSize',15);
ylabel('Time, days','FontSize',15);
title('0.1 es0','FontSize',15);
colorbar
colormap(b2r(-26,26));
print('-dpng','v_hoff_010.png')

figure
v=-28:4:28;
[C,h] = contourf(xi,time(1:75),vhoff_025(:,1:75)',v);
set(gca,'FontSize',15);
xlabel('Longitude','FontSize',15);
ylabel('Time, days','FontSize',15);
title('0.25 es0','FontSize',15);
colorbar
colormap(b2r(-26,26));
print('-dpng','v_hoff_025.png')

figure
v=-28:4:28;
[C,h] = contourf(xi,time(1:75),vhoff_050(:,1:75)',v);
set(gca,'FontSize',15);
xlabel('Longitude','FontSize',15);
ylabel('Time, days','FontSize',15);
title('0.5 es0','FontSize',15);
colorbar
colormap(b2r(-26,26));
print('-dpng','v_hoff_050.png')

figure
v=-28:4:28;
[C,h] = contourf(xi,time(1:75),vhoff_075(:,1:75)',v);
set(gca,'FontSize',15);
xlabel('Longitude','FontSize',15);
ylabel('Time, days','FontSize',15);
title('0.75 es0','FontSize',15);
colorbar
colormap(b2r(-26,26));
print('-dpng','v_hoff_075.png')

figure
v=-28:4:28;
[C,h] = contourf(xi,time(1:75),vhoff_100(:,1:75)',v);
set(gca,'FontSize',15);
xlabel('Longitude','FontSize',15);
ylabel('Time, days','FontSize',15);
title('1.0 es0','FontSize',15);
colorbar
colormap(b2r(-26,26));
print('-dpng','v_hoff_100.png')


