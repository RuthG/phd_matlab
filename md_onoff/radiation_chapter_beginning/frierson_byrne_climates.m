% read in T and u for Frierson and Byrne runs
% plot climate of both nicely


rDir='/project/rg312/final_runs/run_100_byrne/';
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

nit = 129600;

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
u_byrne = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
v_byrne = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
th_byrne = dyn(:,:,:,J);

rDir='/project/rg312/final_runs/run_100_frierson/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
u_frierson = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
v_frierson = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
th_frierson = dyn(:,:,:,J);

[uE_byrne,vN_byrne] = rotate_uv2uvEN(u_byrne,v_byrne,AngleCS,AngleSN,Grid);
[uE_frierson,vN_frierson] = rotate_uv2uvEN(u_frierson,v_frierson,AngleCS,AngleSN,Grid);


    convthetatoT=(rC/100000.0).^(2./7.);
    for k=1:size(rC)
      t_byrne(:,:,k)=th_byrne(:,:,k).*convthetatoT(k,1);
      t_frierson(:,:,k)=th_frierson(:,:,k).*convthetatoT(k,1);
    end


uE_byrne_ll=cube2latlon(xc,yc,uE_byrne,xi,yi);
t_byrne_ll=cube2latlon(xc,yc,t_byrne,xi,yi);

uE_frierson_ll=cube2latlon(xc,yc,uE_frierson,xi,yi);
t_frierson_ll=cube2latlon(xc,yc,t_frierson,xi,yi);

uE_byrne_zav(:,:) = mean(uE_byrne_ll,1);
t_byrne_zav(:,:) = mean(t_byrne_ll,1);

uE_frierson_zav(:,:) = mean(uE_frierson_ll,1);
t_frierson_zav(:,:) = mean(t_frierson_ll,1);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 29.7;                  %# A4 paper size
X = 21;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 1*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 0*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.225; %0.4;
xSize_sub = 0.375;

pos1x = 0.07 ; 	pos1y = 0.7; 
pos2x = 0.5;	pos2y = 0.7; 
pos3x = 0.1; 	pos3y = 0.05;
pos4x = 0.55; 	pos4y = 0.05;



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')



axes('position',[pos1x pos1y xSize_sub ySize_sub])
v=-20:5:45;
label = 200:20:300;

[C,h] = contourf(yi,rC./100,uE_frierson_zav',v); set(h,'LineStyle','none');
hold on
%colorbar('FontSize',10)
colormap(b2r(-20,45));
[C,h] = contour(yi,rC./100,uE_frierson_zav',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
[C,h] = contour(yi,rC./100,t_frierson_zav','k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
ylabel('Pressure, hPa','FontSize',12)



axes('position',[pos2x pos2y xSize_sub ySize_sub])
v=-20:5:45;
label = 200:20:300;

[C,h] = contourf(yi,rC./100,uE_byrne_zav',v); set(h,'LineStyle','none');
hold on
originalSize = get(gca, 'Position');
colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-20,45));
[C,h] = contour(yi,rC./100,uE_byrne_zav',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
[C,h] = contour(yi,rC./100,t_byrne_zav','k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
%ylabel('Pressure, hPa','FontSize',12)


print('-dpdf','fb_climates.pdf')
