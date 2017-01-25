%load up v and plot fourier series vs lat

% choose directory, load grid
rDir='/project/rg312/final_runs/run_000_final_noshallow/';
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
xi=-179:2:180;yi=-89:2:90;

for i=1:10
i

load(['/project/rg312/mat_files/snapshot_data_final/run_000_ns/vN_000_' num2str(i) '.mat'])

vN_000_ll = cube2latlon(xc,yc,vN_000,xi,yi);

%two sided fourier series
fftx_000_ts(:,:,i) = mean(mean(abs(fft(vN_000_ll)),3),4)./180;

end

fftx_000_ts = mean(fftx_000_ts,3);

clear('vN_000','vN_000_ll')

points = size(fftx_000_ts,1);

%single sides series
fftx_000_ss(1,:) = fftx_000_ts(1,:);
fftx_000_ss(2:points./2+1,:) = fftx_000_ts(2:points./2+1,:).*2;

for i = 1:45

fftx_000_ss_hzav(:,i) = (fftx_000_ss(:,45+i) + fftx_000_ss(:,46-i))./2;

end

wavenos = [0:points-1]./points.*180;


save('/project/rg312/mat_files/chapter2_variables/fft_000.mat', 'fftx_000_ss_hzav', 'wavenos')


