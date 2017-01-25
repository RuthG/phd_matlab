%load up v and plot fourier series vs lat

% choose directory, load grid
rDir='/project/rg312/final_runs/run_150_final/';
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

load(['/project/rg312/mat_files/snapshot_data_final/run_150/vN_150_' num2str(i) '.mat'])

vN_150_ll = cube2latlon(xc,yc,vN_150,xi,yi);

%two sided fourier series
fftx_150_ts(:,:,i) = mean(mean(abs(fft(vN_150_ll)),3),4)./180;

end

fftx_150_ts = mean(fftx_150_ts,3);

clear('vN_150','vN_150_ll')

points = size(fftx_150_ts,1);

%single sides series
fftx_150_ss(1,:) = fftx_150_ts(1,:);
fftx_150_ss(2:points./2+1,:) = fftx_150_ts(2:points./2+1,:).*2;

for i = 1:45

fftx_150_ss_hzav(:,i) = (fftx_150_ss(:,45+i) + fftx_150_ss(:,46-i))./2;

end

wavenos = [0:points-1]./points.*180;


save('/project/rg312/mat_files/chapter2_variables/fft_150.mat', 'fftx_150_ss_hzav', 'wavenos')


