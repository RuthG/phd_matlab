%produce tidy version of the heat budget terms

%calculate advective heat transport terms carefully on the lat-lon grid
%take run no as input and load up relevant heatrates
function out = diabatic_eddies_fun(run)

% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_000_best/';
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
yi = -89:2:89;
xi = -179:2:179;

radius = 6371.0e3;

%load heat rates

htrt_var = ['htrt_' run];
difht_var = ['difht_' run];
radht_var = ['radht_' run];
cndht_var = ['cndht_' run];
cnvht_var = ['cnvht_' run];

fields = load('/project/rg312/mat_files/heat_rates_best.mat',htrt_var,radht_var,difht_var,cndht_var,cnvht_var);

htrt_cs = fields.(htrt_var);
htrt_ll = cube2latlon(xc,yc,htrt_cs(:,:,:,360),xi,yi).*86400;
htrt_ll_tav = cube2latlon(xc,yc,mean(htrt_cs,4),xi,yi).*86400;
htrt_ed_ll = htrt_ll - htrt_ll_tav;
clear htrt_cs

radht_cs = fields.(radht_var);
radht_ll = cube2latlon(xc,yc,radht_cs(:,:,:,360),xi,yi).*86400;
radht_ll_tav = cube2latlon(xc,yc,mean(radht_cs,4),xi,yi).*86400;
radht_ed_ll = radht_ll - radht_ll_tav;
clear radht_cs

difht_cs = fields.(difht_var);
difht_ll = cube2latlon(xc,yc,difht_cs(:,:,:,360),xi,yi).*86400;
difht_ll_tav = cube2latlon(xc,yc,mean(difht_cs,4),xi,yi).*86400;
difht_ed_ll = difht_ll - difht_ll_tav;
clear difht_cs

cndht_cs = fields.(cndht_var);
cndht_ll = cube2latlon(xc,yc,cndht_cs(:,:,:,360),xi,yi).*86400;
cndht_ll_tav = cube2latlon(xc,yc,mean(cndht_cs,4),xi,yi).*86400;
cndht_ed_ll = cndht_ll - cndht_ll_tav;
clear cndht_cs

cnvht_cs = fields.(cnvht_var);
cnvht_ll = cube2latlon(xc,yc,cnvht_cs(:,:,:,360),xi,yi).*86400;
cnvht_ll_tav = cube2latlon(xc,yc,mean(cnvht_cs,4),xi,yi).*86400;
cnvht_ed_ll = cnvht_ll - cnvht_ll_tav;
clear cnvht_cs

clear fields

frontdiag_file = ['/project/rg312/mat_files/front_diag_full_' run '_best.mat'];
fdiagname = ['arnaud_diag_' run];
fdiag = load(frontdiag_file);
arnaud_diag = fdiag.(fdiagname);

figure
v=-10:1:10;
[C,h] = contourf(xi,yi,htrt_ed_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag(:,:,360)',v,'k','LineWidth',2);
caxis([-10 10]);
%xlim([-90 90])
%ylim([0 90])
colorbar
title(['Total Diabatic Heating, eddy part, K/day, ' num2str(str2num(run)./100) 'es0']);
ylabel('Latitude')
xlabel('Longitude')
print('-dpng',['htrt_ed_' run '.png'])

figure
v=-10:1:10;
[C,h] = contourf(xi,yi,radht_ed_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag(:,:,360)',v,'k','LineWidth',2);
caxis([-10 10]);
%xlim([-90 90])
%ylim([0 90])
colorbar
title(['Radiative Heating, eddy part, K/day, ' num2str(str2num(run)./100) 'es0']);
ylabel('Latitude')
xlabel('Longitude')
print('-dpng',['radht_ed_' run '.png'])

figure
v=-10:1:10;
[C,h] = contourf(xi,yi,difht_ed_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag(:,:,360)',v,'k','LineWidth',2);
caxis([-10 10]);
%xlim([-90 90])
%ylim([0 90])
colorbar
title(['Diffusive Heating, eddy part, K/day, ' num2str(str2num(run)./100) 'es0']);
ylabel('Latitude')
xlabel('Longitude')
print('-dpng',['difht_ed_' run '.png'])

figure
v=-10:1:10;
[C,h] = contourf(xi,yi,cndht_ed_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag(:,:,360)',v,'k','LineWidth',2);
caxis([-10 10]);
%xlim([-90 90])
%ylim([0 90])
colorbar
title(['Large Scale Heating, eddy part, K/day, ' num2str(str2num(run)./100) 'es0']);
ylabel('Latitude')
xlabel('Longitude')
print('-dpng',['cndht_ed_' run '.png'])

figure
v=-10:1:10;
[C,h] = contourf(xi,yi,cnvht_ed_ll(:,:,5)',v);
set(h,'LineColor','none')
set(gca,'FontSize',15)
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag(:,:,360)',v,'k','LineWidth',2);
caxis([-10 10]);
%xlim([-90 90])
%ylim([0 90])
colorbar
title(['Convective Heating, eddy part, K/day, ' num2str(str2num(run)./100) 'es0']);
ylabel('Latitude')
xlabel('Longitude')
print('-dpng',['cnvht_ed_' run '.png'])

out = 'wahey!';

end
