%plot up absolute vorticity for eqm runs
%f - du/dy
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%We need: u

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

i=0;
for nit = 432000:86400:604800; 
i=i+1

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE_w(:,:,:,i),vN(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv/';

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE_h(:,:,:,i),vN(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_quarterwv/';

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE_q(:,:,:,i),vN(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_5year_c/';

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE_d(:,:,:,i),vN(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv_tropheat3eq/';

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit+518400);  
eval(M);
J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE_th(:,:,:,i),vN(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);


end

uE_w_av = mean(uE_w,4);
uE_h_av = mean(uE_h,4);
uE_q_av = mean(uE_q,4);
uE_d_av = mean(uE_d,4);
uE_th_av = mean(uE_th,4);
[uE_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_w_av,ny,yc,ar,hc);
[uE_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_h_av,ny,yc,ar,hc);
[uE_q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_q_av,ny,yc,ar,hc);
[uE_d_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_d_av,ny,yc,ar,hc);
[uE_th_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_th_av,ny,yc,ar,hc);

a = 6371000; % radius of earth
omeg = 2.*pi./(24.*60.*60);  %rotation rate of earth
f = 2.*omeg.*sin(ylat.*pi./180);

ylat_arr = zeros(90,25);
for i=1:90
ylat_arr(i,:) = ylat(i).*pi./180;
end
bottom = a.*cos(ylat_arr);

[b,top_w] = gradient(uE_w_zav.*cos(ylat_arr),pi./90);
[b,top_h] = gradient(uE_h_zav.*cos(ylat_arr),pi./90);
[b,top_q] = gradient(uE_q_zav.*cos(ylat_arr),pi./90);
[b,top_d] = gradient(uE_d_zav.*cos(ylat_arr),pi./90);
[b,top_th] = gradient(uE_th_zav.*cos(ylat_arr),pi./90);

dudy_w = top_w./bottom;
dudy_h = top_h./bottom;
dudy_q = top_q./bottom;
dudy_d = top_d./bottom;
dudy_th = top_th./bottom;

for i=1:90
vort_w(i,:) = f(i) - dudy_w(i,:);
vort_h(i,:) = f(i) - dudy_h(i,:);
vort_q(i,:) = f(i) - dudy_q(i,:);
vort_d(i,:) = f(i) - dudy_d(i,:);
vort_th(i,:) = f(i) - dudy_th(i,:);
end

vort(:,:,1) = vort_d;
vort(:,:,2) = vort_q;
vort(:,:,3) = vort_h;
vort(:,:,4) = vort_th;
vort(:,:,5) = vort_w;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
X = 21.0;                  %# A4 paper size
Y = 29.7;                  %# A4 paper size
xMargin = 0.75;               %# left/right margins from page borders
yMargin = 1;               %# bottom/top margins from page borders
xSize = X - 2*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 2*yMargin;     %# figure size on paper (widht & hieght)
xSize_sub = 0.4;
ySize_sub = 1./3-0.1;

posx = [0.1,0.55,0.1,0.55,0.1,0.55];
posy = [2/3+0.05,2/3+0.05,1/3+0.05,1/3+0.05,0.05,0.05];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

for i=1:5
axes('position',[posx(i) posy(i) xSize_sub ySize_sub])

v=-0.5e-5:1e-5:0.5e-5;
[C,h]=contour(ylat(30:61),rC./100,vort(30:61,:,i)',v,'k');
set(gca,'YDir','reverse')
xlabel('Latitude')
if rem(i,2) == 0 ; 
set(gca, 'YTickLabel', []);
else
ylabel('Pressure, hPa')
end

end

print('-dpdf','abs_vort.pdf')


figure

plot(ylat(30:61),vort(30:61,15,1),'r');
hold on
plot(ylat(30:61),vort(30:61,15,2),'g');
plot(ylat(30:61),vort(30:61,15,3),'m');
plot(ylat(30:61),vort(30:61,15,4),'k');
plot(ylat(30:61),vort(30:61,15,5),'b');
xlabel('Latitude')
ylabel('Abs Vort at 420 hPa')
legend('Dry','Quarter','Half','Tropheat','Wet')

print('-dpdf','abs_vort_420.pdf')




