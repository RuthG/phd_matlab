load('/project/rg312/mat_files/chapter2_variables/rossby_scale.mat')
load('/project/rg312/mat_files/chapter2_variables/fft_000.mat')
load('/project/rg312/mat_files/chapter2_variables/fft_010.mat')
load('/project/rg312/mat_files/chapter2_variables/fft_025.mat')
load('/project/rg312/mat_files/chapter2_variables/fft_050.mat')
load('/project/rg312/mat_files/chapter2_variables/fft_th.mat')
load('/project/rg312/mat_files/chapter2_variables/fft_075.mat')
load('/project/rg312/mat_files/chapter2_variables/fft_100.mat')
load('/project/rg312/mat_files/chapter2_variables/fft_125.mat')
load('/project/rg312/mat_files/chapter2_variables/fft_150.mat')

for i=1:45
fft_max_000(i) = max(fftx_000_ss_hzav(:,i));
fft_max_010(i) = max(fftx_010_ss_hzav(:,i));
fft_max_025(i) = max(fftx_025_ss_hzav(:,i));
fft_max_050(i) = max(fftx_050_ss_hzav(:,i));
fft_max_075(i) = max(fftx_075_ss_hzav(:,i));
fft_max_100(i) = max(fftx_100_ss_hzav(:,i));
fft_max_125(i) = max(fftx_125_ss_hzav(:,i));
fft_max_150(i) = max(fftx_150_ss_hzav(:,i));
end

