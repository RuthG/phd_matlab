load('/project/rg312/mat_files/vorticity_data_best.mat','vort_100')

% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_100_best/';
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
yi = -89:2:89; xi=-179:2:179;

vort_100_ll = cube2latlon(xg,yg,vort_100(:,:,4,:),xi,yi);


return

v = -9e-5:1e-5:9e-5;

xbins=-2.7e-4:0.02e-4:2.7e-4;

vort_100_ll_counts = hist(reshape(vort_100_ll,[numel(vort_100_ll),1]),xbins);
a=cumsum(vort_100_ll_counts)./sum(vort_100_ll_counts);  
thresh = xbins(min(find(a>0.95)));

vort_mask = +(vort_100_ll(:,46:90,1,:) > thresh);

mapper=zeros(180,1,10);

for i=1:10
test=FastPeakFind(vort_100_ll(:,46:90,1,i).*vort_mask(:,:,:,i)); 

for j=1:max(size(test))./2
mapper(test(j.*2),1,i) = test(j.*2-1);
end

end

contourf(vort_100_ll(:,46:90,1,1)');
hold on
for i=1:max(size(test))./2
plot(test(i.*2),test(i.*2-1),'x')
end

return

for i=1:30

[C,h] = contourf(xi,yi,vort_100_ll(:,:,1,i)',v);
colorbar
xlabel('Longitude')
ylabel('Latitude')
caxis([-9e-5 9e-5])
print('-dpng',['vort_860hpa_' num2str(i) '.png'])
close all

end

