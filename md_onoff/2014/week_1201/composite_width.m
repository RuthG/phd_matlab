%look at ratio of ascent and descent in composites

load('/project/rg312/mat_files/composite_data_ssw/w_compdata_000.mat')
comp_w_000 = nanmean(comp_data,3);
load('/project/rg312/mat_files/composite_data_ssw/w_compdata_010.mat')
comp_w_010 = nanmean(comp_data,3);
load('/project/rg312/mat_files/composite_data_ssw/w_compdata_025.mat')
comp_w_025 = nanmean(comp_data,3);
load('/project/rg312/mat_files/composite_data_ssw/w_compdata_050.mat')
comp_w_050 = nanmean(comp_data,3);
load('/project/rg312/mat_files/composite_data_ssw/w_compdata_075.mat')
comp_w_075 = nanmean(comp_data,3);
load('/project/rg312/mat_files/composite_data_ssw/w_compdata_100.mat')
comp_w_100 = nanmean(comp_data,3);

w_ascmask_000 = +(comp_w_000 <=0 );
w_ascmask_010 = +(comp_w_010 <=0 );
w_ascmask_025 = +(comp_w_025 <=0 );
w_ascmask_050 = +(comp_w_050 <=0 );
w_ascmask_075 = +(comp_w_075 <=0 );
w_ascmask_100 = +(comp_w_100 <=0 );

w_zeroline_000 = abs(diff(w_ascmask_000,1));
w_zeroline_010 = abs(diff(w_ascmask_010,1));
w_zeroline_025 = abs(diff(w_ascmask_025,1));
w_zeroline_050 = abs(diff(w_ascmask_050,1));
w_zeroline_075 = abs(diff(w_ascmask_075,1));
w_zeroline_100 = abs(diff(w_ascmask_100,1));

[a,b] = findpeaks(w_zeroline_000(:,13))
c = diff(b)

[a,b] = findpeaks(w_zeroline_010(:,13))
c = diff(b)

[a,b] = findpeaks(w_zeroline_025(:,13))
c = diff(b)

[a,b] = findpeaks(w_zeroline_050(:,13))
c = diff(b)

[a,b] = findpeaks(w_zeroline_075(:,13))
c = diff(b)

[a,b] = findpeaks(w_zeroline_100(:,13))
c = diff(b)


[a,b] = findpeaks(w_zeroline_000(:,4))
c = diff(b)

[a,b] = findpeaks(w_zeroline_010(:,4))
c = diff(b)

[a,b] = findpeaks(w_zeroline_025(:,4))
c = diff(b)

[a,b] = findpeaks(w_zeroline_050(:,4))
c = diff(b)

[a,b] = findpeaks(w_zeroline_075(:,4))
c = diff(b)

[a,b] = findpeaks(w_zeroline_100(:,4))
c = diff(b)
