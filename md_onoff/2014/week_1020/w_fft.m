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
for nit = 259200:86400:432000;
i=i+1
rDir='/project/rg312/wv_on_rad_off/run_doshallower_5year/';
w_w(:,:,:,i)=rdmds([rDir,'W'],nit);

rDir='/project/rg312/wv_on_rad_off/run_doshallower_5yearh/';
w_h(:,:,:,i)=rdmds([rDir,'W'],nit);

rDir='/project/rg312/wv_on_rad_off/run_doshallower_5yearq/';
w_q(:,:,:,i)=rdmds([rDir,'W'],nit);

rDir='/project/rg312/wv_on_rad_off/run_doshallower_5yeard/';
w_d(:,:,:,i)=rdmds([rDir,'W'],nit);

rDir='/project/rg312/wv_on_rad_off/run_doshallower_5yearth/';
w_th(:,:,:,i)=rdmds([rDir,'W'],nit);

end


xi=-179:2:180;yi=-89:2:90;
wll_w = cube2latlon(xc,yc,w_w,xi,yi);
wll_h = cube2latlon(xc,yc,w_h,xi,yi);
wll_q = cube2latlon(xc,yc,w_q,xi,yi);
wll_d = cube2latlon(xc,yc,w_d,xi,yi);
wll_th = cube2latlon(xc,yc,w_th,xi,yi);

latmask = (abs(yc(:,:)) > 20); % & abs(yc(:,:) < 60));

for i=1:3
area_asc_w(:,:,i) = latmask.*(w_w(:,:,13,i) < 0).*ar;
area_asc_h(:,:,i) = latmask.*(w_h(:,:,13,i) < 0).*ar;
area_asc_q(:,:,i) = latmask.*(w_q(:,:,13,i) < 0).*ar;
area_asc_d(:,:,i) = latmask.*(w_d(:,:,13,i) < 0).*ar;
area_asc_th(:,:,i) = latmask.*(w_th(:,:,13,i) < 0).*ar;
end

total_area(1,:) = squeeze(sum(sum(area_asc_w,1),2))./sum(sum(ar));
total_area(2,:) = squeeze(sum(sum(area_asc_h,1),2))./sum(sum(ar));
total_area(3,:) = squeeze(sum(sum(area_asc_q,1),2))./sum(sum(ar));
total_area(4,:) = squeeze(sum(sum(area_asc_d,1),2))./sum(sum(ar));
total_area(5,:) = squeeze(sum(sum(area_asc_th,1),2))./sum(sum(ar));

mean_area = mean(total_area,2)

%FOURIER TRANSFORM START, NEEDS WORK! 
%Need to check waveno comes out correctly and think

x_w = wll_w(:,61,13,1);
x_h = wll_h(:,61,13,1);
x_q = wll_q(:,61,13,1);
x_d = wll_d(:,61,13,1);

fftx_w = fft(x_w);
fftx_h = fft(x_h);
fftx_q = fft(x_q);
fftx_d = fft(x_d);

angle = 1:360;
sinangle = sin(angle.*pi./180);

return

