%load up w for each run
%bin w
%calculate areas occupied by each bin for each run
%bin, count, normalise, plot these

%include corners for now to get theory, can exclude them after...



% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_doshallower_5year/';
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run %%%%%%%%%%%%%%%%

i=0
for nit = 86640:240:259200;
i=i+1

rDir='/project/rg312/wv_on_rad_off/run_doshallower00/';
w_00(:,:,:,i)=rdmds([rDir,'W'],nit);

rDir='/project/rg312/wv_on_rad_off/run_doshallower01/';
w_01(:,:,:,i)=rdmds([rDir,'W'],nit);

rDir='/project/rg312/wv_on_rad_off/run_doshallower75/';
w_75(:,:,:,i)=rdmds([rDir,'W'],nit);

rDir='/project/rg312/wv_on_rad_off/run_doshallower10/';
w_10(:,:,:,i)=rdmds([rDir,'W'],nit);


end

%blank out tropics to check w range needed
latmask = (abs(yc(:,:)) > 20); % & abs(yc(:,:) < 60));

%for i=1:32
%for j=1:192

%w_ml_01(j,i,1,:) = w_01(j,i,11,:).* latmask(j,i);
%w_ml_75(j,i,1,:) = w_75(j,i,11,:).* latmask(j,i);
%w_ml_10(j,i,1,:) = w_10(j,i,11,:).* latmask(j,i);

%end
%end


%max(max(max(max(w_01))))
%max(max(max(max(w_75))))
%max(max(max(max(w_10))))

%min(min(min(min(w_01))))
%min(min(min(min(w_75))))
%min(min(min(min(w_10))))

%values of w generally lie between -3 and +3
%use 0.02 width bins
%next calculate areas occupied. use level 11 for now

w_bins = -1.5:0.01:1.5;
w_bins_c = -1.495:0.01:1.5;

n_bins = size(w_bins,2)-1;

%find where w lies in a given bin at each timestep

w_regions_binned_00 = single(zeros(192,32,n_bins,720));
w_regions_binned_01 = single(zeros(192,32,n_bins,720));
w_regions_binned_75 = single(zeros(192,32,n_bins,720));
w_regions_binned_10 = single(zeros(192,32,n_bins,720));
'w bin matrices allocated'

for i=1:n_bins
i
w_regions_binned_00(:,:,i,:) = (w_00(:,:,11,:) >= w_bins(i) & w_00(:,:,11,:) < w_bins(i+1));
w_regions_binned_01(:,:,i,:) = (w_01(:,:,11,:) >= w_bins(i) & w_01(:,:,11,:) < w_bins(i+1));
w_regions_binned_75(:,:,i,:) = (w_75(:,:,11,:) >= w_bins(i) & w_75(:,:,11,:) < w_bins(i+1));
w_regions_binned_10(:,:,i,:) = (w_10(:,:,11,:) >= w_bins(i) & w_10(:,:,11,:) < w_bins(i+1));
end

%blank out tropics
latmask = (abs(yc(:,:)) > 20); % & abs(yc(:,:) < 60));

%also blank out corners (y = 1:3, 30:32, x = 1:3, 30:35, 62:67, 94:99, 126:131, 158:163, 190:192)

corner_cover = ones(192,32);
corner_cover(1:3,1:3) = 0; corner_cover(1:3,30:32) = 0;
corner_cover(30:35,1:3) = 0; corner_cover(30:35,30:32) = 0;
corner_cover(62:67,1:3) = 0; corner_cover(62:67,30:32) = 0;
corner_cover(94:99,1:3) = 0; corner_cover(94:99,30:32) = 0;
corner_cover(126:131,1:3) = 0; corner_cover(126:131,30:32) = 0;
corner_cover(158:163,1:3) = 0; corner_cover(158:163,30:32) = 0;
corner_cover(190:192,1:3) = 0; corner_cover(190:192,30:32) = 0;

latmask = latmask.*corner_cover;

%find area covered by each bin at each time step

w_area_00 = zeros(192,32,n_bins,720);
w_area_01 = zeros(192,32,n_bins,720);
w_area_75 = zeros(192,32,n_bins,720);
w_area_10 = zeros(192,32,n_bins,720);


latmaskar = ar.*latmask;

for i=1:32
i
for j=1:192

w_area_00(j,i,:,:) = w_regions_binned_00(j,i,:,:) .* latmaskar(j,i);
w_area_01(j,i,:,:) = w_regions_binned_01(j,i,:,:) .* latmaskar(j,i);
w_area_75(j,i,:,:) = w_regions_binned_75(j,i,:,:) .* latmaskar(j,i);
w_area_10(j,i,:,:) = w_regions_binned_10(j,i,:,:) .* latmaskar(j,i);

end
end

%sum area for each bin at each time step so we have w_area_tot(w bin,time )

w_area_00_tot = zeros(n_bins,720);
w_area_01_tot = zeros(n_bins,720);
w_area_75_tot = zeros(n_bins,720);
w_area_10_tot = zeros(n_bins,720);

w_area_00_tot = squeeze(sum(sum(w_area_00,1),2));
w_area_01_tot = squeeze(sum(sum(w_area_01,1),2));
w_area_75_tot = squeeze(sum(sum(w_area_75,1),2));
w_area_10_tot = squeeze(sum(sum(w_area_10,1),2));

%find maximum area in each bin (min is zero)
max(max(w_area_00_tot))
max(max(w_area_01_tot))
max(max(w_area_75_tot))
max(max(w_area_10_tot))

%define area bins
area_bins = 0.0000000001:0.01e13:1e13;
area_bins_c = 0.005e13:0.01e13:1e13;

%for each area bin define a mask to find how many times over time a given w occupies a given area 

areas_binned_00 = zeros(n_bins,720,100);
areas_binned_01 = zeros(n_bins,720,100);
areas_binned_75 = zeros(n_bins,720,100);
areas_binned_10 = zeros(n_bins,720,100);

for i=1:100
i
areas_binned_00(:,:,i) = (w_area_00_tot >= area_bins(i) & w_area_00_tot < area_bins(i+1)) ;
areas_binned_01(:,:,i) = (w_area_01_tot >= area_bins(i) & w_area_01_tot < area_bins(i+1)) ;
areas_binned_75(:,:,i) = (w_area_75_tot >= area_bins(i) & w_area_75_tot < area_bins(i+1)) ;
areas_binned_10(:,:,i) = (w_area_10_tot >= area_bins(i) & w_area_10_tot < area_bins(i+1)) ;

end

maybe_pdf_00 = zeros(n_bins,100);
maybe_pdf_01 = zeros(n_bins,100);
maybe_pdf_75 = zeros(n_bins,100);
maybe_pdf_10 = zeros(n_bins,100);

maybe_pdf_00 = squeeze(sum(areas_binned_00,2));
maybe_pdf_01 = squeeze(sum(areas_binned_01,2));
maybe_pdf_75 = squeeze(sum(areas_binned_75,2));
maybe_pdf_10 = squeeze(sum(areas_binned_10,2));


%take a dubious mean of postive and negative velocity distributions so we can look at the differences

for i=1:150

maybe_pdf_00_wav(150+i,:) = (maybe_pdf_00(150 + i,:) + maybe_pdf_00(151 - i, :))./2; 
maybe_pdf_00_wav(151-i,:) = (maybe_pdf_00(150 + i,:) + maybe_pdf_00(151 - i, :))./2; 
maybe_pdf_01_wav(150+i,:) = (maybe_pdf_01(150 + i,:) + maybe_pdf_01(151 - i, :))./2; 
maybe_pdf_01_wav(151-i,:) = (maybe_pdf_01(150 + i,:) + maybe_pdf_01(151 - i, :))./2; 
maybe_pdf_75_wav(150+i,:) = (maybe_pdf_75(150 + i,:) + maybe_pdf_75(151 - i, :))./2; 
maybe_pdf_75_wav(151-i,:) = (maybe_pdf_75(150 + i,:) + maybe_pdf_75(151 - i, :))./2; 
maybe_pdf_10_wav(150+i,:) = (maybe_pdf_10(150 + i,:) + maybe_pdf_10(151 - i, :))./2; 
maybe_pdf_10_wav(151-i,:) = (maybe_pdf_10(150 + i,:) + maybe_pdf_10(151 - i, :))./2; 

end


figure
image(w_bins_c,area_bins_c./(1000^2),maybe_pdf_00','CDataMapping','scaled')
%caxis([0 60])                                 
colorbar
set(gca,'yDir','normal')
title('Velocity/Area Distribution, 0.es0')
xlabel('Vertical Velocity, Pa/s')
ylabel('Area Occupied, km^{2}')
print('-dpng','w_area_00.png')

figure
image(w_bins_c,area_bins_c./(1000^2),maybe_pdf_01','CDataMapping','scaled')
%caxis([0 60])                                 
colorbar
set(gca,'yDir','normal')
title('Velocity/Area Distribution, 0.1es0')
xlabel('Vertical Velocity, Pa/s')
ylabel('Area Occupied, km^{2}')
print('-dpng','w_area_01.png')

figure
image(w_bins_c,area_bins_c./(1000^2),maybe_pdf_75','CDataMapping','scaled')
%caxis([0 60])                                 
colorbar
set(gca,'yDir','normal')
title('Velocity/Area Distribution, 0.75es0')
xlabel('Vertical Velocity, Pa/s')
ylabel('Area Occupied, km^{2}')
print('-dpng','w_area_75.png')

figure
image(w_bins_c,area_bins_c./(1000^2),maybe_pdf_10','CDataMapping','scaled')
colorbar
%caxis([0 60])
set(gca,'yDir','normal')
title('Velocity/Area Distribution, 1.0es0')
xlabel('Vertical Velocity, Pa/s')
ylabel('Area Occupied, km^{2}')
print('-dpng','w_area_10.png')


v=-35:5:35;
figure
contourf(w_bins_c,area_bins_c./(1000^2),maybe_pdf_00'-maybe_pdf_00_wav',v)
caxis([-35 35])
colorbar
xlabel('Vertical Velocity, Pa/s')
ylabel('Area Occupied, km^{2}')
print('-dpdf','w_area_00_assym.pdf')

v=-35:5:35;
figure
contourf(w_bins_c,area_bins_c./(1000^2),maybe_pdf_01'-maybe_pdf_01_wav',v)
caxis([-35 35])
colorbar
xlabel('Vertical Velocity, Pa/s')
ylabel('Area Occupied, km^{2}')
print('-dpdf','w_area_01_assym.pdf')

v=-35:5:35;
figure
contourf(w_bins_c,area_bins_c./(1000^2),maybe_pdf_75'-maybe_pdf_75_wav',v)
caxis([-35 35])
colorbar
xlabel('Vertical Velocity, Pa/s')
ylabel('Area Occupied, km^{2}')
print('-dpdf','w_area_75_assym.pdf')

v=-35:5:35;
figure
contourf(w_bins_c,area_bins_c./(1000^2),maybe_pdf_10'-maybe_pdf_10_wav',v)
caxis([-35 35])
colorbar
xlabel('Vertical Velocity, Pa/s')
ylabel('Area Occupied, km^{2}')
print('-dpdf','w_area_10_assym.pdf')


return
v=0:0.0003:0.003
figure
contourf(w_bins_c,area_bins_c./(1000^2),maybe_pdf_01'./sum(sum(maybe_pdf_01)),v)
caxis([0 0.003])                                 
colorbar
title('Velocity/Area Distribution, 0.1es0')
xlabel('Vertical Velocity, Pa/s')
ylabel('Area Occupied, km^{2}')
print('-dpdf','w_area_01_pdf.pdf')


figure
contourf(w_bins_c,area_bins_c./(1000^2),maybe_pdf_10'./sum(sum(maybe_pdf_01)),v)
colorbar
caxis([0 0.003])
title('Velocity/Area Distribution, 1.0es0')
xlabel('Vertical Velocity, Pa/s')
ylabel('Area Occupied, km^{2}')
print('-dpdf','w_area_10_pdf.pdf')

