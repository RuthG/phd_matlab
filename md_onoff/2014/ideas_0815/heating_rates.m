%load in heating rates and have a think. Is Arnaud's idea that they're sinmilar in the subtropics between runs right?


% choose directory, load grid
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
ny=90;

%read files
i=0;
for nit = 259200:86400:604800;
i=i+1

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';

%heating rates
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_w(:,:,:,i)=dyn(:,:,:,J).*86400;
J=find(strcmp(fldList,'AtPhdTdf'));
difht_w(:,:,:,i)=dyn(:,:,:,J).*86400;
J=find(strcmp(fldList,'AtPhdTrd'));
radht_w(:,:,:,i)=dyn(:,:,:,J).*86400;
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_w(:,:,:,i)=dyn(:,:,:,J).*86400;
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_w(:,:,:,i)=dyn(:,:,:,J).*86400;


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv/';

%heating rates
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhdTdt'));
htrt_h(:,:,:,i)=dyn(:,:,:,J).*86400;
J=find(strcmp(fldList,'AtPhdTdf'));
difht_h(:,:,:,i)=dyn(:,:,:,J).*86400;
J=find(strcmp(fldList,'AtPhdTrd'));
radht_h(:,:,:,i)=dyn(:,:,:,J).*86400;
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_h(:,:,:,i)=dyn(:,:,:,J).*86400;
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_h(:,:,:,i)=dyn(:,:,:,J).*86400;

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_quarterwv/';

%heating rates
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);


J=find(strcmp(fldList,'AtPhdTdt'));
htrt_q(:,:,:,i)=dyn(:,:,:,J).*86400;
J=find(strcmp(fldList,'AtPhdTdf'));
difht_q(:,:,:,i)=dyn(:,:,:,J).*86400;
J=find(strcmp(fldList,'AtPhdTrd'));
radht_q(:,:,:,i)=dyn(:,:,:,J).*86400;
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_q(:,:,:,i)=dyn(:,:,:,J).*86400;
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_q(:,:,:,i)=dyn(:,:,:,J).*86400;

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_5year_c/';

%heating rates
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);


J=find(strcmp(fldList,'AtPhdTdt'));
htrt_d(:,:,:,i)=dyn(:,:,:,J).*86400;
J=find(strcmp(fldList,'AtPhdTdf'));
difht_d(:,:,:,i)=dyn(:,:,:,J).*86400;
J=find(strcmp(fldList,'AtPhdTrd'));
radht_d(:,:,:,i)=dyn(:,:,:,J).*86400;
J=find(strcmp(fldList,'AtPhdTcd'));
cndht_d(:,:,:,i)=dyn(:,:,:,J).*86400;
J=find(strcmp(fldList,'AtPhdTcv'));
cnvht_d(:,:,:,i)=dyn(:,:,:,J).*86400;

end

%take time means
htrt_w_mean = mean(htrt_w,4);
difht_w_mean = mean(difht_w,4);
radht_w_mean = mean(radht_w,4);
cndht_w_mean = mean(cndht_w,4);
cnvht_w_mean = mean(cnvht_w,4);

htrt_h_mean = mean(htrt_h,4);
difht_h_mean = mean(difht_h,4);
radht_h_mean = mean(radht_h,4);
cndht_h_mean = mean(cndht_h,4);
cnvht_h_mean = mean(cnvht_h,4);

htrt_q_mean = mean(htrt_q,4);
difht_q_mean = mean(difht_q,4);
radht_q_mean = mean(radht_q,4);
cndht_q_mean = mean(cndht_q,4);
cnvht_q_mean = mean(cnvht_q,4);

htrt_d_mean = mean(htrt_d,4);
difht_d_mean = mean(difht_d,4);
radht_d_mean = mean(radht_d,4);
cndht_d_mean = mean(cndht_d,4);
cnvht_d_mean = mean(cnvht_d,4);

xi=-179:2:180;yi=-89:2:90;
htrtll_w=cube2latlon(xc,yc,htrt_w_mean,xi,yi);
difhtll_w=cube2latlon(xc,yc,difht_w_mean,xi,yi);
radhtll_w=cube2latlon(xc,yc,radht_w_mean,xi,yi);
cnvhtll_w=cube2latlon(xc,yc,cnvht_w_mean,xi,yi);
cndhtll_w=cube2latlon(xc,yc,cndht_w_mean,xi,yi);

htrtll_h=cube2latlon(xc,yc,htrt_h_mean,xi,yi);
difhtll_h=cube2latlon(xc,yc,difht_h_mean,xi,yi);
radhtll_h=cube2latlon(xc,yc,radht_h_mean,xi,yi);
cnvhtll_h=cube2latlon(xc,yc,cnvht_h_mean,xi,yi);
cndhtll_h=cube2latlon(xc,yc,cndht_h_mean,xi,yi);

htrtll_q=cube2latlon(xc,yc,htrt_q_mean,xi,yi);
difhtll_q=cube2latlon(xc,yc,difht_q_mean,xi,yi);
radhtll_q=cube2latlon(xc,yc,radht_q_mean,xi,yi);
cnvhtll_q=cube2latlon(xc,yc,cnvht_q_mean,xi,yi);
cndhtll_q=cube2latlon(xc,yc,cndht_q_mean,xi,yi);

htrtll_d=cube2latlon(xc,yc,htrt_d_mean,xi,yi);
difhtll_d=cube2latlon(xc,yc,difht_d_mean,xi,yi);
radhtll_d=cube2latlon(xc,yc,radht_d_mean,xi,yi);
cnvhtll_d=cube2latlon(xc,yc,cnvht_d_mean,xi,yi);
cndhtll_d=cube2latlon(xc,yc,cndht_d_mean,xi,yi);

htrtll_w_zav(:,:) = mean(htrtll_w,1);
difhtll_w_zav(:,:) = mean(difhtll_w,1);
radhtll_w_zav(:,:) = mean(radhtll_w,1);
cnvhtll_w_zav(:,:) = mean(cnvhtll_w,1);
cndhtll_w_zav(:,:) = mean(cndhtll_w,1);

htrtll_h_zav(:,:) = mean(htrtll_h,1);
difhtll_h_zav(:,:) = mean(difhtll_h,1);
radhtll_h_zav(:,:) = mean(radhtll_h,1);
cnvhtll_h_zav(:,:) = mean(cnvhtll_h,1);
cndhtll_h_zav(:,:) = mean(cndhtll_h,1);

htrtll_q_zav(:,:) = mean(htrtll_q,1);
difhtll_q_zav(:,:) = mean(difhtll_q,1);
radhtll_q_zav(:,:) = mean(radhtll_q,1);
cnvhtll_q_zav(:,:) = mean(cnvhtll_q,1);
cndhtll_q_zav(:,:) = mean(cndhtll_q,1);

htrtll_d_zav(:,:) = mean(htrtll_d,1);
difhtll_d_zav(:,:) = mean(difhtll_d,1);
radhtll_d_zav(:,:) = mean(radhtll_d,1);
cnvhtll_d_zav(:,:) = mean(cnvhtll_d,1);
cndhtll_d_zav(:,:) = mean(cndhtll_d,1);



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

v=-2:0.5:6.5;
axes('position',[pos4x pos4y xSize_sub ySize_sub])
[C,h] = contourf(yi,rC, htrtll_w_zav',v);
xlabel('Latitude')
colorbar
colormap(b2r(-2,6.5));
title('1xwv')
freezeColors
cbfreeze(colorbar);
set(gca,'YDir','reverse')

axes('position',[pos3x pos3y xSize_sub ySize_sub])
[C,h] = contourf(yi,rC, htrtll_h_zav',v);
xlabel('Latitude')
ylabel('Pressure, hPa')
colorbar
colormap(b2r(-2,6.5));
title('0.5xwv')
freezeColors
cbfreeze(colorbar);
set(gca,'YDir','reverse')

axes('position',[pos2x pos2y xSize_sub ySize_sub])
[C,h] = contourf(yi,rC, htrtll_q_zav',v);
colorbar
colormap(b2r(-2,6.5));
title(['0.25xwv'])
freezeColors
cbfreeze(colorbar);
set(gca,'YDir','reverse')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contourf(yi,rC, htrtll_d_zav',v);
ylabel('Pressure, hPa')
colorbar
colormap(b2r(-2,6.5));
title('0xwv')
freezeColors
cbfreeze(colorbar);
set(gca,'YDir','reverse')

print('-dpdf','htrt.pdf')

