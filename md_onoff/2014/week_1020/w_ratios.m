%compare fractions of descent to ascent in snapshots


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
rDir='/project/rg312/wv_on_rad_off/run_doshallower01/';
w_01(:,:,:,i)=rdmds([rDir,'W'],nit);

rDir='/project/rg312/wv_on_rad_off/run_doshallower75/';
w_75(:,:,:,i)=rdmds([rDir,'W'],nit);

rDir='/project/rg312/wv_on_rad_off/run_doshallower10/';
w_10(:,:,:,i)=rdmds([rDir,'W'],nit);


end


latmask = (abs(yc(:,:)) > 20 & abs(yc(:,:) < 60));

for i=1:720
area_asc_01(:,:,i) = latmask.*(w_01(:,:,11,i) < 0).*ar;
area_asc_75(:,:,i) = latmask.*(w_75(:,:,11,i) < 0).*ar;
area_asc_10(:,:,i) = latmask.*(w_10(:,:,11,i) < 0).*ar;
end

total_area(1,:) = squeeze(sum(sum(area_asc_01,1),2))./sum(sum(ar));
total_area(2,:) = squeeze(sum(sum(area_asc_75,1),2))./sum(sum(ar));
total_area(3,:) = squeeze(sum(sum(area_asc_10,1),2))./sum(sum(ar));


mean_area = mean(total_area,2)


