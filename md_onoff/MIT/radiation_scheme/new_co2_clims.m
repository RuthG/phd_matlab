%read in data for different co2 concs and see if the code worked plus how the climate changes...

rDir='/project/rg312/final_runs/run_100_rad_on_1co2/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));
drC=squeeze(rdmds([rDir,'DRC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
xi=-179:2:179;
yi=-89:2:89;

nit = 172800;

rDir='/project/rg312/final_runs/run_100_rad_on_1co2/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
u_1co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
v_1co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVEL    '));
w_1co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q_1co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_1co2 = dyn(:,:,:,J);

[uE_1co2,vN_1co2] = rotate_uv2uvEN(u_1co2,v_1co2,AngleCS,AngleSN,Grid);

    convthetatoT=(rC/100000.0).^(2./7.);
    for k=1:size(rC)
      t_1co2(:,:,k)=theta_1co2(:,:,k).*convthetatoT(k,1);
    end

uE_1co2_ll=cube2latlon(xc,yc,uE_1co2,xi,yi);
t_1co2_ll=cube2latlon(xc,yc,t_1co2,xi,yi);

uE_1co2_zav(:,:) = mean(uE_1co2_ll,1);
t_1co2_zav(:,:) = mean(t_1co2_ll,1);



rDir='/project/rg312/final_runs/run_rad_on_4co2/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
u_4co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
v_4co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVEL    '));
w_4co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q_4co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_4co2 = dyn(:,:,:,J);

[uE_4co2,vN_4co2] = rotate_uv2uvEN(u_4co2,v_4co2,AngleCS,AngleSN,Grid);

    convthetatoT=(rC/100000.0).^(2./7.);
    for k=1:size(rC)
      t_4co2(:,:,k)=theta_4co2(:,:,k).*convthetatoT(k,1);
    end

uE_4co2_ll=cube2latlon(xc,yc,uE_4co2,xi,yi);
t_4co2_ll=cube2latlon(xc,yc,t_4co2,xi,yi);

uE_4co2_zav(:,:) = mean(uE_4co2_ll,1);
t_4co2_zav(:,:) = mean(t_4co2_ll,1);




rDir='/project/rg312/final_runs/run_100_rad_on_10co2/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
u_10co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
v_10co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVEL    '));
w_10co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q_10co2 = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_10co2 = dyn(:,:,:,J);

[uE_10co2,vN_10co2] = rotate_uv2uvEN(u_10co2,v_10co2,AngleCS,AngleSN,Grid);

    convthetatoT=(rC/100000.0).^(2./7.);
    for k=1:size(rC)
      t_10co2(:,:,k)=theta_10co2(:,:,k).*convthetatoT(k,1);
    end

uE_10co2_ll=cube2latlon(xc,yc,uE_10co2,xi,yi);
t_10co2_ll=cube2latlon(xc,yc,t_10co2,xi,yi);

uE_10co2_zav(:,:) = mean(uE_10co2_ll,1);
t_10co2_zav(:,:) = mean(t_10co2_ll,1);






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 29.7;                  %# A4 paper size
X = 21;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 1*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 0*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.2625; 
xSize_sub = 0.6; 

pos1x = 0.1 ; 	pos1y = 0.7; 

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-20:5:45;
label = 200:20:300;

[C,h] = contourf(yi,rC./100,uE_1co2_zav',v); set(h,'LineStyle','none');
hold on
originalSize = get(gca, 'Position');
colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-20,45));
[C,h] = contour(yi,rC./100,uE_1co2_zav',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
[C,h] = contour(yi,rC./100,t_1co2_zav','k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)

print('-dpdf','ut_1co2.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-20:5:45;
label = 200:20:300;

[C,h] = contourf(yi,rC./100,uE_4co2_zav',v); set(h,'LineStyle','none');
hold on
originalSize = get(gca, 'Position');
colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-20,45));
[C,h] = contour(yi,rC./100,uE_4co2_zav',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
[C,h] = contour(yi,rC./100,t_4co2_zav','k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)

print('-dpdf','ut_4co2.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-20:5:45;
label = 200:20:300;

[C,h] = contourf(yi,rC./100,uE_10co2_zav',v); set(h,'LineStyle','none');
hold on
originalSize = get(gca, 'Position');
colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-20,45));
[C,h] = contour(yi,rC./100,uE_10co2_zav',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
[C,h] = contour(yi,rC./100,t_10co2_zav','k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)

print('-dpdf','ut_10co2.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-20:1:45;

[C,h] = contourf(yi,rC./100,uE_4co2_zav' - uE_1co2_zav',v); set(h,'LineStyle','none');
hold on
originalSize = get(gca, 'Position');
colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-10,10));
[C,h] = contour(yi,rC./100,uE_4co2_zav' - uE_1co2_zav',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)

print('-dpdf','u_4m1co2.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-20:1:45;

[C,h] = contourf(yi,rC./100,uE_10co2_zav' - uE_1co2_zav',v); set(h,'LineStyle','none');
hold on
originalSize = get(gca, 'Position');
colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-10,10));
[C,h] = contour(yi,rC./100,uE_10co2_zav' - uE_1co2_zav',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)

print('-dpdf','u_10m1co2.pdf')




hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-40:1:5;

[C,h] = contourf(yi,rC./100,t_4co2_zav' - t_1co2_zav',v); set(h,'LineStyle','none');
hold on
originalSize = get(gca, 'Position');
colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-40,5));
[C,h] = contour(yi,rC./100,t_4co2_zav' - t_1co2_zav',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)

print('-dpdf','t_4m1co2.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-40:1:5;

[C,h] = contourf(yi,rC./100,t_10co2_zav' - t_1co2_zav',v); set(h,'LineStyle','none');
hold on
originalSize = get(gca, 'Position');
colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-40,5));
[C,h] = contour(yi,rC./100,t_10co2_zav' - t_1co2_zav',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)

print('-dpdf','t_10m1co2.pdf')





