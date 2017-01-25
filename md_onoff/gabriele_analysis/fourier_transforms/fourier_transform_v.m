%load up v and plot fourier series vs lat

% choose directory, load grid
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
xi=-179:2:180;yi=-89:2:90;


load('/project/rg312/gabriele/vN_H_ed_detrended.mat')
load('/project/rg312/gabriele/vNH_ed.mat')


%two sided fourier series
vN_860_fftx_ts = (mean(abs(fft(vN_ed_860_n_dt)),3)./180  +  flipdim( mean(abs(fft(vN_ed_860_s_dt)),3)./180 ,2) )./2;
vN_300_fftx_ts = (mean(abs(fft(vN_ed_300_n_dt)),3)./180  +  flipdim( mean(abs(fft(vN_ed_300_s_dt)),3)./180 ,2) )./2;

H_860_fftx_ts = (mean(abs(fft(H_ed_860_n_dt)),3)./180  +  flipdim( mean(abs(fft(H_ed_860_s_dt)),3)./180 ,2) )./2;
H_300_fftx_ts = (mean(abs(fft(H_ed_300_n_dt)),3)./180  +  flipdim( mean(abs(fft(H_ed_300_s_dt)),3)./180 ,2) )./2;

vNH_860_fftx_ts = (mean(abs(fft(vNH_ed_860n)),3)./180  +  flipdim( mean(abs(fft(vNH_ed_860s)),3)./180 ,2) )./2;
vNH_300_fftx_ts = (mean(abs(fft(vNH_ed_300n)),3)./180  +  flipdim( mean(abs(fft(vNH_ed_300s)),3)./180 ,2) )./2;

points = size(vN_860_fftx_ts,1);
wavenos = [0:points-1]./points.*180;


%single sided series

vN_860_fftx_ss(1,:) = vN_860_fftx_ts(1,:);
vN_860_fftx_ss(2:points./2+1,:) = vN_860_fftx_ts(2:points./2+1,:).*2;
vN_300_fftx_ss(1,:) = vN_300_fftx_ts(1,:);
vN_300_fftx_ss(2:points./2+1,:) = vN_300_fftx_ts(2:points./2+1,:).*2;

H_860_fftx_ss(1,:) = H_860_fftx_ts(1,:);
H_860_fftx_ss(2:points./2+1,:) = H_860_fftx_ts(2:points./2+1,:).*2;
H_300_fftx_ss(1,:) = H_300_fftx_ts(1,:);
H_300_fftx_ss(2:points./2+1,:) = H_300_fftx_ts(2:points./2+1,:).*2;

vNH_860_fftx_ss(1,:) = vNH_860_fftx_ts(1,:);
vNH_860_fftx_ss(2:points./2+1,:) = vNH_860_fftx_ts(2:points./2+1,:).*2;
vNH_300_fftx_ss(1,:) = vNH_300_fftx_ts(1,:);
vNH_300_fftx_ss(2:points./2+1,:) = vNH_300_fftx_ts(2:points./2+1,:).*2;


save('/project/rg312/gabriele/ffts.mat', 'vN_860_fftx_ss', 'vN_300_fftx_ss', 'H_860_fftx_ss', 'H_300_fftx_ss', 'vNH_860_fftx_ss', 'vNH_300_fftx_ss', 'wavenos')


