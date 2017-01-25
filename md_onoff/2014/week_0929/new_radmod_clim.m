%check climate produced by new radiation_mod versions


rDir='/disk1/MITgcm/verification/atm_gray_ruth/run_radon_varyingwin/';
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
ny=90;

%read files
i=0;
for nit = 62640:240:86400;
i=i+1

rDir='/disk1/MITgcm/verification/atm_gray_ruth/run_radon_varyingwin/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'SALT    '));
q_vw(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_vw(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_th_vw(:,:,:,i)=dyn(:,:,:,J).*86400;
J=find(strcmp(fldList,'AtPhdTdt'));
htrt_th_vw(:,:,:,i)=dyn(:,:,:,J).*86400;

    convthetatoT=(rC/101325.0).^(2./7.);
    for k=1:size(rC)
      t_vw(:,:,k,i)=theta_vw(:,:,k,i).*convthetatoT(k,1);
      radht_vw(:,:,k,i)=radht_th_vw(:,:,k,i).*convthetatoT(k,1);
      htrt_vw(:,:,k,i)=htrt_th_vw(:,:,k,i).*convthetatoT(k,1);
    end

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE_vw(:,:,:,i),vN_vw(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);


rDir='/disk1/MITgcm/verification/atm_gray_ruth/run_radon_cwnp/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'SALT    '));
q_np(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_np(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_th_np(:,:,:,i)=dyn(:,:,:,J).*86400;
J=find(strcmp(fldList,'AtPhdTdt'));
htrt_th_np(:,:,:,i)=dyn(:,:,:,J).*86400;

    convthetatoT=(rC/101325.0).^(2./7.);
    for k=1:size(rC)
      t_np(:,:,k,i)=theta_np(:,:,k,i).*convthetatoT(k,1);
      radht_np(:,:,k,i)=radht_th_np(:,:,k,i).*convthetatoT(k,1);
      htrt_np(:,:,k,i)=htrt_th_np(:,:,k,i).*convthetatoT(k,1);
    end

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE_np(:,:,:,i),vN_np(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);


end

rDir='/disk1/MITgcm/verification/atm_gray_ruth/run_radon_doshallower/';
nit = 432000;
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'SALT    '));
q_orig = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_orig = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhdTrd'));
radht_th_orig = dyn(:,:,:,J).*86400;
J=find(strcmp(fldList,'AtPhdTdt'));
htrt_th_orig = dyn(:,:,:,J).*86400;

    convthetatoT=(rC/101325.0).^(2./7.);
    for k=1:size(rC)
      t_orig(:,:,k)     = theta_orig(:,:,k).*convthetatoT(k,1);
      radht_orig(:,:,k) = radht_th_orig(:,:,k).*convthetatoT(k,1);
      htrt_orig(:,:,k)  = htrt_th_orig(:,:,k).*convthetatoT(k,1);
    end

J=find(strcmp(fldList,'UVEL    '));
ucs = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs = dyn(:,:,:,J);
[uE_orig,vN_orig] = rotate_uv2uvEN(ucs,vcs,AngleCS,AngleSN,Grid);


q_vw_mean = mean(q_vw,4);
theta_vw_mean = mean(theta_vw,4);
t_vw_mean = mean(t_vw,4);
uE_vw_mean = mean(uE_vw,4);
vN_vw_mean = mean(vN_vw,4);
htrt_vw_mean = mean(htrt_vw,4);
radht_vw_mean = mean(radht_vw,4);

q_np_mean = mean(q_np,4);
theta_np_mean = mean(theta_np,4);
t_np_mean = mean(t_np,4);
uE_np_mean = mean(uE_np,4);
vN_np_mean = mean(vN_np,4);
htrt_np_mean = mean(htrt_np,4);
radht_np_mean = mean(radht_np,4);

xi=-179:2:180;yi=-89:2:90;
qll_vw=cube2latlon(xc,yc,q_vw_mean,xi,yi);
thetall_vw=cube2latlon(xc,yc,theta_vw_mean,xi,yi);
tll_vw=cube2latlon(xc,yc,t_vw_mean,xi,yi);
uEll_vw=cube2latlon(xc,yc,uE_vw_mean,xi,yi);
vNll_vw=cube2latlon(xc,yc,vN_vw_mean,xi,yi);
htrtll_vw=cube2latlon(xc,yc,htrt_vw_mean,xi,yi);
radhtll_vw=cube2latlon(xc,yc,radht_vw_mean,xi,yi);

xi=-179:2:180;yi=-89:2:90;
qll_np=cube2latlon(xc,yc,q_np_mean,xi,yi);
thetall_np=cube2latlon(xc,yc,theta_np_mean,xi,yi);
tll_np=cube2latlon(xc,yc,t_np_mean,xi,yi);
uEll_np=cube2latlon(xc,yc,uE_np_mean,xi,yi);
vNll_np=cube2latlon(xc,yc,vN_np_mean,xi,yi);
htrtll_np=cube2latlon(xc,yc,htrt_np_mean,xi,yi);
radhtll_np=cube2latlon(xc,yc,radht_np_mean,xi,yi);

xi=-179:2:180;yi=-89:2:90;
qll_orig=cube2latlon(xc,yc,q_orig,xi,yi);
thetall_orig=cube2latlon(xc,yc,theta_orig,xi,yi);
tll_orig=cube2latlon(xc,yc,t_orig,xi,yi);
uEll_orig=cube2latlon(xc,yc,uE_orig,xi,yi);
vNll_orig=cube2latlon(xc,yc,vN_orig,xi,yi);
htrtll_orig=cube2latlon(xc,yc,htrt_orig,xi,yi);
radhtll_orig=cube2latlon(xc,yc,radht_orig,xi,yi);

q_vw_zav(:,:) = mean(qll_vw,1);
theta_vw_zav(:,:) = mean(thetall_vw,1);
t_vw_zav(:,:) = mean(tll_vw,1);
uE_vw_zav(:,:) = mean(uEll_vw,1);
vN_vw_zav(:,:) = mean(vNll_vw,1);
htrt_vw_zav(:,:) = mean(htrtll_vw,1);
radht_vw_zav(:,:) = mean(radhtll_vw,1);

q_np_zav(:,:) = mean(qll_np,1);
theta_np_zav(:,:) = mean(thetall_np,1);
t_np_zav(:,:) = mean(tll_np,1);
uE_np_zav(:,:) = mean(uEll_np,1);
vN_np_zav(:,:) = mean(vNll_np,1);
htrt_np_zav(:,:) = mean(htrtll_np,1);
radht_np_zav(:,:) = mean(radhtll_np,1);

q_orig_zav(:,:) = mean(qll_orig,1);
theta_orig_zav(:,:) = mean(thetall_orig,1);
t_orig_zav(:,:) = mean(tll_orig,1);
uE_orig_zav(:,:) = mean(uEll_orig,1);
vN_orig_zav(:,:) = mean(vNll_orig,1);
htrt_orig_zav(:,:) = mean(htrtll_orig,1);
radht_orig_zav(:,:) = mean(radhtll_orig,1);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 21.0;                  %# A4 paper size
X = 29.7;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 2*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 2*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.3; %0.4;
xSize_sub = 1./2-0.1;

pos1x = 0.1 ; 	pos1y = 0.45; %1/2+0.05;
pos2x = 0.55;	pos2y = 0.45; %1/2+0.05;
pos3x = 0.1; 	pos3y = 0.05;
pos4x = 0.55; 	pos4y = 0.05;


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v = - 20:5:50;
[C,h] = contour(yi,rC./100,uE_orig_zav',v,'k');
set(gca,'YDir','reverse')
clabel(C,h);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('orig')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi,rC./100,uE_vw_zav',v,'k');
set(gca,'YDir','reverse')
clabel(C,h);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('Varying Window Frac')


axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi,rC./100,uE_np_zav',v,'k');
set(gca,'YDir','reverse')
clabel(C,h);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('Const Window, Improved Fit')


print('-dpdf','uE_comparison.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v = - 6:1:6;
[C,h] = contour(yi,rC./100,vN_orig_zav',v,'k');
set(gca,'YDir','reverse')
clabel(C,h);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('orig')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi,rC./100,vN_vw_zav',v,'k');
set(gca,'YDir','reverse')
clabel(C,h);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('Varying Window Frac')


axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi,rC./100,vN_np_zav',v,'k');
set(gca,'YDir','reverse')
clabel(C,h);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('Const Window, Improved Fit')


print('-dpdf','vN_comparison.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v = 190:10:300;
[C,h] = contour(yi,rC./100,t_orig_zav',v,'k');
set(gca,'YDir','reverse')
clabel(C,h);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('orig')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi,rC./100,t_vw_zav',v,'k');
set(gca,'YDir','reverse')
clabel(C,h);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('Varying Window Frac')


axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi,rC./100,t_np_zav',v,'k');
set(gca,'YDir','reverse')
clabel(C,h);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('Const Window, Improved Fit')


print('-dpdf','t_comparison.pdf')


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v = - 2.6:0.2:0.6;
[C,h] = contour(yi,rC./100,radht_orig_zav',v,'k');
set(gca,'YDir','reverse')
clabel(C,h);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('orig')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi,rC./100,radht_vw_zav',v,'k');
set(gca,'YDir','reverse')
clabel(C,h);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('Varying Window Frac')


axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi,rC./100,radht_np_zav',v,'k');
set(gca,'YDir','reverse')
clabel(C,h);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('Const Window, Improved Fit')


print('-dpdf','radht_comparison.pdf')



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


axes('position',[pos1x pos1y xSize_sub ySize_sub])
v = - 2:0.5:4.5;
[C,h] = contour(yi,rC./100,htrt_orig_zav',v,'k');
set(gca,'YDir','reverse')
clabel(C,h);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('orig')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contour(yi,rC./100,htrt_vw_zav',v,'k');
set(gca,'YDir','reverse')
clabel(C,h);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('Varying Window Frac')


axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contour(yi,rC./100,htrt_np_zav',v,'k');
set(gca,'YDir','reverse')
clabel(C,h);
xlabel('Latitude')
ylabel('Pressure, hPa')
title('Const Window, Improved Fit')


print('-dpdf','htrt_comparison.pdf')
