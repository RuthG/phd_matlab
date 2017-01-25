%load up w for each run
%bin w
%calculate areas occupied by each bin for each run
%bin, count, normalise, plot these

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

w_00 = zeros(192,32,25,720);
w_01 = zeros(192,32,25,720);
w_75 = zeros(192,32,25,720);
w_10 = zeros(192,32,25,720);

i=0
for nit = 86640:240:259200;
i=i+1

%rDir='/project/rg312/wv_on_rad_off/run_doshallower00/';
%w_00(:,:,:,i)=rdmds([rDir,'W'],nit);

%rDir='/project/rg312/wv_on_rad_off/run_doshallower01/';
%w_01(:,:,:,i)=rdmds([rDir,'W'],nit);

rDir='/project/rg312/wv_on_rad_off/run_doshallower05/';
w_05(:,:,:,i)=rdmds([rDir,'W'],nit);

rDir='/project/rg312/wv_on_rad_off/run_doshallower75/';
w_75(:,:,:,i)=rdmds([rDir,'W'],nit);

rDir='/project/rg312/wv_on_rad_off/run_doshallower10/';
w_10(:,:,:,i)=rdmds([rDir,'W'],nit);


end

%blank out tropics to check w range needed
latmask = (abs(yc(:,:)) > 20); % & abs(yc(:,:) < 60));


%values of w generally lie between -3 and +3
%use 0.02 width bins
%next calculate areas occupied. use level 11 for now

w_bins = -1.5:0.01:1.5;
w_bins_c = -1.495:0.01:1.5;

n_bins = size(w_bins,2)-1;

%find where w lies in a given bin at each timestep

%w_regions_binned_00 = single(zeros(192,32,n_bins,720));
%w_regions_binned_01 = single(zeros(192,32,n_bins,720));
w_regions_binned_05 = single(zeros(192,32,n_bins,720));
w_regions_binned_75 = single(zeros(192,32,n_bins,720));
w_regions_binned_10 = single(zeros(192,32,n_bins,720));
'w bin matrices allocated'

for i=1:n_bins./2
i
%w_regions_binned_00(:,:,i,:) = (w_00(:,:,11,:) >= w_bins(i) & w_00(:,:,11,:) < w_bins(i+1));
%w_regions_binned_00(:,:,n_bins+1 - i,:) = (w_00(:,:,11,:) > w_bins(n_bins +1 - (i)) & w_00(:,:,11,:) <= w_bins(n_bins +1 - (i-1)));

%w_regions_binned_01(:,:,i,:) = (w_01(:,:,11,:) >= w_bins(i) & w_01(:,:,11,:) < w_bins(i+1));
%w_regions_binned_01(:,:,n_bins+1 - i,:) = (w_01(:,:,11,:) > w_bins(n_bins +1 - (i)) & w_01(:,:,11,:) <= w_bins(n_bins +1 - (i-1)));

w_regions_binned_05(:,:,i,:) = (w_05(:,:,11,:) >= w_bins(i) & w_05(:,:,11,:) < w_bins(i+1));
w_regions_binned_05(:,:,n_bins+1 - i,:) = (w_05(:,:,11,:) > w_bins(n_bins +1 - (i)) & w_05(:,:,11,:) <= w_bins(n_bins +1 - (i-1)));

w_regions_binned_75(:,:,i,:) = (w_75(:,:,11,:) >= w_bins(i) & w_75(:,:,11,:) < w_bins(i+1));
w_regions_binned_75(:,:,n_bins+1 - i,:) = (w_75(:,:,11,:) > w_bins(n_bins +1 - (i)) & w_75(:,:,11,:) <= w_bins(n_bins +1 - (i-1)));

w_regions_binned_10(:,:,i,:) = (w_10(:,:,11,:) >= w_bins(i) & w_10(:,:,11,:) < w_bins(i+1));
w_regions_binned_10(:,:,n_bins+1 - i,:) = (w_10(:,:,11,:) > w_bins(n_bins +1 - (i)) & w_10(:,:,11,:) <= w_bins(n_bins +1 - (i-1)));

end

%clear w_00;
%clear w_01;
clear w_05;
clear w_75;
clear w_10;

%blank out tropics
latmask = (abs(yc(:,:) > 20)); %& abs(yc(:,:) < 60));

%also blank out corners (y = 1:3, 30:32, x = 1:3, 30:35, 62:67, 94:99, 126:131, 158:163, 190:192)

corner_cover = ones(192,32);
corner_cover(1:3,1:3) = 0; corner_cover(1:3,30:32) = 0;
corner_cover(30:35,1:3) = 0; corner_cover(30:35,30:32) = 0;
corner_cover(62:67,1:3) = 0; corner_cover(62:67,30:32) = 0;
corner_cover(94:99,1:3) = 0; corner_cover(94:99,30:32) = 0;
corner_cover(126:131,1:3) = 0; corner_cover(126:131,30:32) = 0;
corner_cover(158:163,1:3) = 0; corner_cover(158:163,30:32) = 0;
corner_cover(190:192,1:3) = 0; corner_cover(190:192,30:32) = 0;

%corner_cover = ones(192,32);
%corner_cover(1:5,1:5) = 0; corner_cover(1:5,28:32) = 0;
%corner_cover(28:37,1:5) = 0; corner_cover(28:37,28:32) = 0;
%corner_cover(60:69,1:5) = 0; corner_cover(60:69,28:32) = 0;
%corner_cover(92:101,1:5) = 0; corner_cover(92:101,28:32) = 0;
%corner_cover(124:133,1:5) = 0; corner_cover(124:133,28:32) = 0;
%corner_cover(156:165,1:5) = 0; corner_cover(156:165,28:32) = 0;
%corner_cover(188:192,1:5) = 0; corner_cover(188:192,28:32) = 0;


latmask = latmask.*corner_cover;

%find area covered by each bin at each time step

%w_area_00 = zeros(192,32,n_bins,720);
%w_area_01 = zeros(192,32,n_bins,720);
w_area_05 = zeros(192,32,n_bins,720);
w_area_75 = zeros(192,32,n_bins,720);
w_area_10 = zeros(192,32,n_bins,720);


latmaskar = ar.*latmask;


for i=1:32
i
for j=1:192

%w_area_00(j,i,:,:) = w_regions_binned_00(j,i,:,:) .* latmaskar(j,i);
%w_area_01(j,i,:,:) = w_regions_binned_01(j,i,:,:) .* latmaskar(j,i);
w_area_05(j,i,:,:) = w_regions_binned_05(j,i,:,:) .* latmaskar(j,i);
w_area_75(j,i,:,:) = w_regions_binned_75(j,i,:,:) .* latmaskar(j,i);
w_area_10(j,i,:,:) = w_regions_binned_10(j,i,:,:) .* latmaskar(j,i);

end
end


%sum area for each bin at each time step so we have w_area_tot(w bin,time )

%w_area_00_tot = zeros(n_bins,720);
%w_area_01_tot = zeros(n_bins,720);
w_area_05_tot = zeros(n_bins,720);
w_area_75_tot = zeros(n_bins,720);
w_area_10_tot = zeros(n_bins,720);

%w_area_00_tot = squeeze(sum(sum(w_area_00,1),2));
%w_area_01_tot = squeeze(sum(sum(w_area_01,1),2));
w_area_05_tot = squeeze(sum(sum(w_area_05,1),2));
w_area_75_tot = squeeze(sum(sum(w_area_75,1),2));
w_area_10_tot = squeeze(sum(sum(w_area_10,1),2));

%find maximum area in each bin (min is zero)
%max(max(w_area_00_tot))
%max(max(w_area_01_tot))
max(max(w_area_05_tot))
max(max(w_area_75_tot))
max(max(w_area_10_tot))

%define area bins
area_bins = 0.0:0.01e13:1e13;
area_bins_c = 0.005e13:0.01e13:1e13;

%for each area bin define a mask to find how many times over time a given w occupies a given area 

%areas_binned_00 = zeros(n_bins,720,100);
%areas_binned_01 = zeros(n_bins,720,100);
areas_binned_05 = zeros(n_bins,720,100);
areas_binned_75 = zeros(n_bins,720,100);
areas_binned_10 = zeros(n_bins,720,100);

for i=1:100
i
%areas_binned_00(:,:,i) = (w_area_00_tot > area_bins(i) & w_area_00_tot <= area_bins(i+1)) ;
%areas_binned_01(:,:,i) = (w_area_01_tot > area_bins(i) & w_area_01_tot <= area_bins(i+1)) ;
areas_binned_05(:,:,i) = (w_area_05_tot > area_bins(i) & w_area_05_tot <= area_bins(i+1)) ;
areas_binned_75(:,:,i) = (w_area_75_tot > area_bins(i) & w_area_75_tot <= area_bins(i+1)) ;
areas_binned_10(:,:,i) = (w_area_10_tot > area_bins(i) & w_area_10_tot <= area_bins(i+1)) ;

end

%maybe_pdf_00 = zeros(n_bins,100);
%maybe_pdf_01 = zeros(n_bins,100);
maybe_pdf_05 = zeros(n_bins,100);
maybe_pdf_75 = zeros(n_bins,100);
maybe_pdf_10 = zeros(n_bins,100);

%maybe_pdf_00 = squeeze(sum(areas_binned_00,2));
%maybe_pdf_01 = squeeze(sum(areas_binned_01,2));
maybe_pdf_05 = squeeze(sum(areas_binned_05,2));
maybe_pdf_75 = squeeze(sum(areas_binned_75,2));
maybe_pdf_10 = squeeze(sum(areas_binned_10,2));


%take a dubious mean of postive and negative velocity distributions so we can look at the differences

for i=1:150

%maybe_pdf_00_wav(150+i,:) = (maybe_pdf_00(150 + i,:) + maybe_pdf_00(151 - i, :))./2; 
%maybe_pdf_00_wav(151-i,:) = (maybe_pdf_00(150 + i,:) + maybe_pdf_00(151 - i, :))./2; 
%maybe_pdf_01_wav(150+i,:) = (maybe_pdf_01(150 + i,:) + maybe_pdf_01(151 - i, :))./2; 
%maybe_pdf_01_wav(151-i,:) = (maybe_pdf_01(150 + i,:) + maybe_pdf_01(151 - i, :))./2; 
maybe_pdf_05_wav(150+i,:) = (maybe_pdf_05(150 + i,:) + maybe_pdf_05(151 - i, :))./2; 
maybe_pdf_05_wav(151-i,:) = (maybe_pdf_05(150 + i,:) + maybe_pdf_05(151 - i, :))./2; 
maybe_pdf_75_wav(150+i,:) = (maybe_pdf_75(150 + i,:) + maybe_pdf_75(151 - i, :))./2; 
maybe_pdf_75_wav(151-i,:) = (maybe_pdf_75(150 + i,:) + maybe_pdf_75(151 - i, :))./2; 
maybe_pdf_10_wav(150+i,:) = (maybe_pdf_10(150 + i,:) + maybe_pdf_10(151 - i, :))./2; 
maybe_pdf_10_wav(151-i,:) = (maybe_pdf_10(150 + i,:) + maybe_pdf_10(151 - i, :))./2; 

end

save('w_area_bits.mat','maybe_pdf_05','maybe_pdf_75','maybe_pdf_10','-append')

%figure
%h=pcolor(w_bins_c,area_bins_c./(1000^2),maybe_pdf_00');
% set(h,'EdgeColor','none')
%caxis([0 300])                                 
%colorbar
%set(gca,'yDir','normal')
%title('Velocity/Area Distribution, 0.es0')
%xlabel('Vertical Velocity, Pa/s')
%ylabel('Area Occupied, km^{2}')
%print('-dpng','w_area_00.png')

%figure
%h=pcolor(w_bins_c,area_bins_c./(1000^2),maybe_pdf_01');
% set(h,'EdgeColor','none')
%caxis([0 300])                                 
%colorbar
%set(gca,'yDir','normal')
%title('Velocity/Area Distribution, 0.1es0')
%xlabel('Vertical Velocity, Pa/s')
%ylabel('Area Occupied, km^{2}')
%print('-dpng','w_area_01.png')

figure
h=pcolor(w_bins_c,area_bins_c./(1000^2),maybe_pdf_05');
 set(h,'EdgeColor','none')
caxis([0 300])                                 
colorbar
set(gca,'yDir','normal')
title('Velocity/Area Distribution, 0.5es0')
xlabel('Vertical Velocity, Pa/s')
ylabel('Area Occupied, km^{2}')
print('-dpng','w_area_05.png')

figure
h=pcolor(w_bins_c,area_bins_c./(1000^2),maybe_pdf_75');
 set(h,'EdgeColor','none')
caxis([0 300])                                 
colorbar
set(gca,'yDir','normal')
title('Velocity/Area Distribution, 0.75es0')
xlabel('Vertical Velocity, Pa/s')
ylabel('Area Occupied, km^{2}')
print('-dpng','w_area_75.png')

figure
h=pcolor(w_bins_c,area_bins_c./(1000^2),maybe_pdf_10');
 set(h,'EdgeColor','none')
colorbar
caxis([0 300])
set(gca,'yDir','normal')
title('Velocity/Area Distribution, 1.0es0')
xlabel('Vertical Velocity, Pa/s')
ylabel('Area Occupied, km^{2}')
print('-dpng','w_area_10.png')


%v=-35:5:35;
%figure
%h=pcolor(w_bins_c,area_bins_c./(1000^2),maybe_pdf_00'-maybe_pdf_00_wav'); 
% set(h,'EdgeColor','none')
%caxis([-35 35])
%colorbar
%xlabel('Vertical Velocity, Pa/s')
%ylabel('Area Occupied, km^{2}')
%print('-dpng','w_area_00_assym.png')

%v=-35:5:35;
%figure
%h=pcolor(w_bins_c,area_bins_c./(1000^2),maybe_pdf_01'-maybe_pdf_01_wav');
% set(h,'EdgeColor','none')
%caxis([-35 35])
%colorbar
%xlabel('Vertical Velocity, Pa/s')
%ylabel('Area Occupied, km^{2}')
%print('-dpng','w_area_01_assym.png')

v=-35:5:35;
figure
h=pcolor(w_bins_c,area_bins_c./(1000^2),maybe_pdf_05'-maybe_pdf_05_wav');
 set(h,'EdgeColor','none')
caxis([-35 35])
colorbar
xlabel('Vertical Velocity, Pa/s')
ylabel('Area Occupied, km^{2}')
print('-dpng','w_area_05_assym.png')

v=-35:5:35;
figure
h=pcolor(w_bins_c,area_bins_c./(1000^2),maybe_pdf_75'-maybe_pdf_75_wav');
 set(h,'EdgeColor','none')
caxis([-35 35])
colorbar
xlabel('Vertical Velocity, Pa/s')
ylabel('Area Occupied, km^{2}')
print('-dpng','w_area_75_assym.png')

v=-35:5:35;
figure
h=pcolor(w_bins_c,area_bins_c./(1000^2),maybe_pdf_10'-maybe_pdf_10_wav');
 set(h,'EdgeColor','none')
caxis([-35 35])
colorbar
xlabel('Vertical Velocity, Pa/s')
ylabel('Area Occupied, km^{2}')
print('-dpng','w_area_10_assym.png')


return

