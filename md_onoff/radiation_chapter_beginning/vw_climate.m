% read in T and u for vw run
% plot climate of both nicely


rDir='/project/rg312/final_runs/run_100_vw/';
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
u_vw = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
v_vw = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
th_vw = dyn(:,:,:,J);

[uE_vw,vN_vw] = rotate_uv2uvEN(u_vw,v_vw,AngleCS,AngleSN,Grid);


    convthetatoT=(rC/100000.0).^(2./7.);
    for k=1:size(rC)
      t_vw(:,:,k)=th_vw(:,:,k).*convthetatoT(k,1);
    end


uE_vw_ll=cube2latlon(xc,yc,uE_vw,xi,yi);
t_vw_ll=cube2latlon(xc,yc,t_vw,xi,yi);

uE_vw_zav(:,:) = mean(uE_vw_ll,1);
t_vw_zav(:,:) = mean(t_vw_ll,1);




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

[C,h] = contourf(yi,rC./100,uE_vw_zav',v); set(h,'LineStyle','none');
hold on
originalSize = get(gca, 'Position');
colorbar('FontSize',10)
set(gca, 'Position', originalSize);
colormap(b2r(-20,45));
[C,h] = contour(yi,rC./100,uE_vw_zav',[-1000:1000:1000],'Color',[0.6 0.6 0.6],'LineWidth',2);
[C,h] = contour(yi,rC./100,t_vw_zav','k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
xlabel('Latitude','FontSize',12)
%ylabel('Pressure, hPa','FontSize',12)


print('-dpdf','vw_climate.pdf')
