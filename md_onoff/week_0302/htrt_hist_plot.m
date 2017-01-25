%load up the histogram data and plot up for comparison

load('/project/rg312/mat_files/htrt_t_pdfs_000.mat')
htrt_t_000 = htrt_t./sum(sum(htrt_t));
cnvht_t_000 = cnvht_t./sum(sum(cnvht_t));
cndht_t_000 = cndht_t./sum(sum(cndht_t));
radht_t_000 = radht_t./sum(sum(radht_t));
difht_t_000 = difht_t./sum(sum(difht_t));

load('/project/rg312/mat_files/htrt_t_pdfs_010.mat')
htrt_t_010 = htrt_t./sum(sum(htrt_t));
cnvht_t_010 = cnvht_t./sum(sum(cnvht_t));
cndht_t_010 = cndht_t./sum(sum(cndht_t));
radht_t_010 = radht_t./sum(sum(radht_t));
difht_t_010 = difht_t./sum(sum(difht_t));

load('/project/rg312/mat_files/htrt_t_pdfs_025.mat')
htrt_t_025 = htrt_t./sum(sum(htrt_t));
cnvht_t_025 = cnvht_t./sum(sum(cnvht_t));
cndht_t_025 = cndht_t./sum(sum(cndht_t));
radht_t_025 = radht_t./sum(sum(radht_t));
difht_t_025 = difht_t./sum(sum(difht_t));

load('/project/rg312/mat_files/htrt_t_pdfs_050.mat')
htrt_t_050 = htrt_t./sum(sum(htrt_t));
cnvht_t_050 = cnvht_t./sum(sum(cnvht_t));
cndht_t_050 = cndht_t./sum(sum(cndht_t));
radht_t_050 = radht_t./sum(sum(radht_t));
difht_t_050 = difht_t./sum(sum(difht_t));

load('/project/rg312/mat_files/htrt_t_pdfs_075.mat')
htrt_t_075 = htrt_t./sum(sum(htrt_t));
cnvht_t_075 = cnvht_t./sum(sum(cnvht_t));
cndht_t_075 = cndht_t./sum(sum(cndht_t));
radht_t_075 = radht_t./sum(sum(radht_t));
difht_t_075 = difht_t./sum(sum(difht_t));

load('/project/rg312/mat_files/htrt_t_pdfs_100.mat')
htrt_t_100 = htrt_t./sum(sum(htrt_t));
cnvht_t_100 = cnvht_t./sum(sum(cnvht_t));
cndht_t_100 = cndht_t./sum(sum(cndht_t));
radht_t_100 = radht_t./sum(sum(radht_t));
difht_t_100 = difht_t./sum(sum(difht_t));

figure
h=pcolor(htrt_t_000);
colorbar
caxis([0 0.1])
colormap(flipud(hot));
set(h,'EdgeColor','none')

figure
h=pcolor(htrt_t_100);
colorbar
caxis([0 0.1])
colormap(flipud(hot));
set(h,'EdgeColor','none')

figure
h=pcolor(difht_t_000);
colorbar
caxis([0 0.1])
colormap(flipud(hot));
set(h,'EdgeColor','none')

figure
h=pcolor(difht_t_100);
colorbar
caxis([0 0.1])
colormap(flipud(hot));
set(h,'EdgeColor','none')


