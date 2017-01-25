rDir='/project/rg312/final_runs/run_100_final/';
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

L = 2.500e6;
cp = 287.04./(2./7.);

for year=1:10;
load(['/project/rg312/mat_files/storm_chapter_data/run_150/vN_150_comp_' num2str(year) '.mat'])
vN_comp(:,:,year) = nanmean(comp_data,3);
load(['/project/rg312/mat_files/storm_chapter_data/run_150/H_150_comp_' num2str(year) '.mat'])
H_comp(:,:,year) = nanmean(comp_data,3);
load(['/project/rg312/mat_files/storm_chapter_data/run_150/vNH_150_comp_' num2str(year) '.mat'])
vNH_comp(:,:,year) = nanmean(comp_data,3);
end

vN_comp = mean(vN_comp,3);
H_comp = mean(H_comp,3);
vNH_comp = mean(vNH_comp,3);



x= -34:2:34;

figure
[C,h] = contourf(x, rC./100, vNH_comp');
set(h,'LineColor','none')
set(gca,'YDir','reverse');
colormap(b2r(-2e4,10e4));
colorbar
hold on
v= -20:5:0;
[C,h] = contour(x, rC./100, vN_comp', v, 'k');
clabel(C,h,0)
v= 5:5:20;
[C,h] = contour(x, rC./100, vN_comp', v, 'k', 'LineWidth', 2);
v= -15:3:0;
[C,h] = contour(x, rC./100, H_comp'./cp , v, 'k--');
clabel(C,h,0)
v= 3:3:15;
[C,h] = contour(x, rC./100, H_comp'./cp , v, 'k--', 'LineWidth', 2);

print('-dpng','gabs_comp_150.png')
