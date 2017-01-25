%Calculate vint heat budget for spin-up experiments


load('heat_budg_bits.mat')

ylat = 1:2:89;

a=6371.0e3;

'eddy heat trans calculated'

dthetadp_c = gradient(theta_c_thzav,-4000);
dthetadp_th = gradient(theta_th_thzav,-4000);
dthetadp_w = gradient(theta_w_thzav,-4000);

'dtdp calculated'

vert_c_adv = -1.*w_c_thzav.*dthetadp_c;
vert_th_adv = -1.*w_th_thzav.*dthetadp_th;
vert_w_adv = -1.*w_w_thzav.*dthetadp_w;

'vert adv all done, start eddy gradient'

for i=1:45
vNt_c_ed_thzav_wt(i,:,:) = vNt_c_thzav(i,:,:).*cos(ylat(i).*pi./180);
vNt_th_ed_thzav_wt(i,:,:) = vNt_th_thzav(i,:,:).*cos(ylat(i).*pi./180);
vNt_w_ed_thzav_wt(i,:,:) = vNt_w_thzav(i,:,:).*cos(ylat(i).*pi./180);
end

[moo,vNt_c_conv_s,boo] = gradient(vNt_c_ed_thzav_wt,pi./90);
[moo,vNt_th_conv_s,boo] = gradient(vNt_th_ed_thzav_wt,pi./90);
[moo,vNt_w_conv_s,boo] = gradient(vNt_w_ed_thzav_wt,pi./90);

for i=1:45
vNt_c_conv(i,:,:) = -1.*vNt_c_conv_s(i,:,:)./cos(ylat(i).*pi./180)./a;
vNt_th_conv(i,:,:) = -1.*vNt_th_conv_s(i,:,:)./cos(ylat(i).*pi./180)./a;
vNt_w_conv(i,:,:) = -1.*vNt_w_conv_s(i,:,:)./cos(ylat(i).*pi./180)./a;
end

'eddy gradients done! Integrate!'


vNt_c_conv_vint(:,:) = sum(vNt_c_conv,2).*4000./9.81;
vert_c_adv_vint(:,:) = sum(vert_c_adv,2).*4000./9.81;
htrt_c_vint(:,:) = sum(htrt_c_thzav,2).*4000./9.81;

vNt_th_conv_vint(:,:) = sum(vNt_th_conv,2).*4000./9.81;
vert_th_adv_vint(:,:) = sum(vert_th_adv,2).*4000./9.81;
htrt_th_vint(:,:) = sum(htrt_th_thzav,2).*4000./9.81;

vNt_w_conv_vint(:,:) = sum(vNt_w_conv,2).*4000./9.81;
vert_w_adv_vint(:,:) = sum(vert_w_adv,2).*4000./9.81;
htrt_w_vint(:,:) = sum(htrt_w_thzav,2).*4000./9.81;

'vertical integral done'




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


for i=1:6
axes('position',[posx(i) posy(i) xSize_sub ySize_sub])
plot(ylat,vNt_th_conv_vint(:,i)-vNt_c_conv_vint(:,i),'k')
hold on
plot(ylat,-1.*(vert_th_adv_vint(:,i) - vert_c_adv_vint(:,i)),'k--')
plot(ylat,htrt_th_vint(:,i) - htrt_c_vint(:,i),'k-.')
plot(ylat,(htrt_th_vint(:,i)+vert_th_adv_vint(:,i)+vNt_th_conv_vint(:,i)) - (htrt_c_vint(:,i)+vert_c_adv_vint(:,i)+vNt_c_conv_vint(:,i)),'k:')
xlabel('Latitude')

ylim([-0.2 0.8])
%legend('Eddy heat term','(-1)x Vertical advection term','Diabatic heating','Residual')
xlabel('Latitude')
if rem(i,2) == 0 ; 
set(gca, 'YTickLabel', []);
else
ylabel('Vertically integrated heating rate')
end
if i ==1;
legend('Eddy heat term','(-1)x Vertical advection term','Diabatic heating','Residual')
end
hold off
end
print('-dpdf','vert_heat_spinup_th.pdf')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PAGE 2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


for i=1:6
axes('position',[posx(i) posy(i) xSize_sub ySize_sub])
plot(ylat,vNt_w_conv_vint(:,i)-vNt_c_conv_vint(:,i),'k')
hold on
plot(ylat,-1.*(vert_w_adv_vint(:,i) - vert_c_adv_vint(:,i)),'k--')
plot(ylat,htrt_w_vint(:,i) - htrt_c_vint(:,i),'k-.')
plot(ylat,(htrt_w_vint(:,i)+vert_w_adv_vint(:,i)+vNt_w_conv_vint(:,i)) - (htrt_c_vint(:,i)+vert_c_adv_vint(:,i)+vNt_c_conv_vint(:,i)),'k:')
xlabel('Latitude')

ylim([-0.2 0.8])
%legend('Eddy heat term','(-1)x Vertical advection term','Diabatic heating','Residual')
xlabel('Latitude')
if rem(i,2) == 0 ; 
set(gca, 'YTickLabel', []);
else
ylabel('Vertically integrated heating rate')
end

if i ==1;
legend('Eddy heat term','(-1)x Vertical advection term','Diabatic heating','Residual')
end

hold off
end
print('-dpdf','vert_heat_spinup_w.pdf')
