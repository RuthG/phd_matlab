%function  to plot time series of pressure averaged longitudinal fourier transform
%take lat-lon snapshots as input


function [fftx_ss] = fourier_transform_tseries(vN_ll);

fftx_ts = mean(abs(fft(vN_ll)),3)./180;

points = size(fftx_ts,1);

%single sides series
fftx_ss(1,:,:) = fftx_ts(1,:,:);
fftx_ss(2:points./2+1,:,:) = fftx_ts(2:points./2+1,:,:).*2;


return
