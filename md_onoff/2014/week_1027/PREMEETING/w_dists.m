%load in w data for the wet run
%bin w
%calculate area covered by each bin
%plot an area weighted distribution for the velocities on a log scale, taking abs values 



% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_doshallower10/';
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

w = zeros(192,32,25,720);

i=0
for nit = 86640:240:259200;
i=i+1

rDir='/project/rg312/wv_on_rad_off/run_doshallower00/';
w_00(:,:,:,i)=rdmds([rDir,'W'],nit);

rDir='/project/rg312/wv_on_rad_off/run_doshallower10/';
w_10(:,:,:,i)=rdmds([rDir,'W'],nit);

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

latmaskar = repmat(latmask.*corner_cover.*ar,[1,1,300,720]);

%values of w generally lie between -3 and +3
%use 0.02 width bins
%next calculate areas occupied. use level 11 for now

w_bins = -1.5:0.01:1.5;
w_bins_c = -1.495:0.01:1.5;

n_bins = size(w_bins,2)-1;

%find where w lies in a given bin at each timestep

w_regions_binned_00 = single(zeros(192,32,n_bins,720));
w_regions_binned_10 = single(zeros(192,32,n_bins,720));
'w bin matrix allocated'

for i=1:n_bins./2
i

w_regions_binned_00(:,:,i,:) = (w_00(:,:,11,:) >= w_bins(i) & w_00(:,:,11,:) < w_bins(i+1));
w_regions_binned_00(:,:,n_bins+1 - i,:) = (w_00(:,:,11,:) > w_bins(n_bins +1 - (i)) & w_00(:,:,11,:) <= w_bins(n_bins +1 - (i-1)));

w_regions_binned_10(:,:,i,:) = (w_10(:,:,11,:) >= w_bins(i) & w_10(:,:,11,:) < w_bins(i+1));
w_regions_binned_10(:,:,n_bins+1 - i,:) = (w_10(:,:,11,:) > w_bins(n_bins +1 - (i)) & w_10(:,:,11,:) <= w_bins(n_bins +1 - (i-1)));

end

w_areas_binned_00 = squeeze(mean(sum(sum(w_regions_binned_00.*latmaskar,1),2),4));
w_areas_binned_10 = squeeze(mean(sum(sum(w_regions_binned_10.*latmaskar,1),2),4));
