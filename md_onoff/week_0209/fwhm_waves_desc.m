%load up a dataset (start with w) and calculate the mean full width at half maximum of the positive and negative regions around a longitude circle


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
xi = -179:2:179;
radius = 6371.0e3;

load('/project/rg312/mat_files/snapshot_data/w_snapshots.mat')

w_000_ll = cube2latlon(xc,yc,w_000,xi,yi);
w_010_ll = cube2latlon(xc,yc,w_010,xi,yi);
w_025_ll = cube2latlon(xc,yc,w_025,xi,yi);
w_050_ll = cube2latlon(xc,yc,w_050,xi,yi);
w_075_ll = cube2latlon(xc,yc,w_075,xi,yi);
w_100_ll = cube2latlon(xc,yc,w_100,xi,yi);

clear('w_000','w_010','w_025','w_050','w_075','w_100')

load('/project/rg312/mat_files/vt_lats.mat')

w_000n = squeeze(w_000_ll(:,x000n-7:x000n+7,5,:));
w_000s = squeeze(w_000_ll(:,x000s-7:x000s+7,5,:));

w_010n = squeeze(w_010_ll(:,x010n-7:x010n+7,5,:));
w_010s = squeeze(w_010_ll(:,x010s-7:x010s+7,5,:));

w_025n = squeeze(w_025_ll(:,x025n-7:x025n+7,5,:));
w_025s = squeeze(w_025_ll(:,x025s-7:x025s+7,5,:));

w_050n = squeeze(w_050_ll(:,x050n-7:x050n+7,5,:));
w_050s = squeeze(w_050_ll(:,x050s-7:x050s+7,5,:));

w_075n = squeeze(w_075_ll(:,x075n-7:x075n+7,5,:));
w_075s = squeeze(w_075_ll(:,x075s-7:x075s+7,5,:));

w_100n = squeeze(w_100_ll(:,x100n-7:x100n+7,5,:));
w_100s = squeeze(w_100_ll(:,x100s-7:x100s+7,5,:));


clear('w_000_ll','w_010_ll','w_025_ll','w_050_ll','w_075_ll','w_100_ll')

%locate peaks of prominence above half of their own maximum 

for i=1:15
  for j=1:720
  %locate peaks in v't'
[i j]
  [a_000n,b_000n,fwhm_000n] = findpeak_prom_halfmax(w_000n(:,i,j));
  [a_000s,b_000s,fwhm_000s] = findpeak_prom_halfmax(w_000s(:,i,j));
  %save peak magnitudes and locations in a cell array
  peaks_000{i,j,1} = a_000n;
  peaks_000{i,j,2} = b_000n;
  peaks_000{i,j,3} = fwhm_000n.*pi.*radius.* cos(yi(x000n-8+i).*pi./180) ./90;
  peaks_000{i,j,4} = a_000s;
  peaks_000{i,j,5} = b_000s;
  peaks_000{i,j,6} = fwhm_000s.*pi.*radius.* cos(yi(x000s-8+i).*pi./180) ./90;

  [a_010n,b_010n,fwhm_010n] = findpeak_prom_halfmax(w_010n(:,i,j));
  [a_010s,b_010s,fwhm_010s] = findpeak_prom_halfmax(w_010s(:,i,j));
  %save peak magnitudes and locations in a cell array
  peaks_010{i,j,1} = a_010n;
  peaks_010{i,j,2} = b_010n;
  peaks_010{i,j,3} = fwhm_010n.*pi.*radius.* cos(yi(x010n-8+i).*pi./180) ./90;
  peaks_010{i,j,4} = a_010s;
  peaks_010{i,j,5} = b_010s;
  peaks_010{i,j,6} = fwhm_010s.*pi.*radius.* cos(yi(x010s-8+i).*pi./180) ./90;

  [a_025n,b_025n,fwhm_025n] = findpeak_prom_halfmax(w_025n(:,i,j));
  [a_025s,b_025s,fwhm_025s] = findpeak_prom_halfmax(w_025s(:,i,j));
  %save peak magnitudes and locations in a cell array
  peaks_025{i,j,1} = a_025n;
  peaks_025{i,j,2} = b_025n;
  peaks_025{i,j,3} = fwhm_025n.*pi.*radius.* cos(yi(x025n-8+i).*pi./180) ./90;
  peaks_025{i,j,4} = a_025s;
  peaks_025{i,j,5} = b_025s;
  peaks_025{i,j,6} = fwhm_025s.*pi.*radius.* cos(yi(x025s-8+i).*pi./180) ./90;

  [a_050n,b_050n,fwhm_050n] = findpeak_prom_halfmax(w_050n(:,i,j));
  [a_050s,b_050s,fwhm_050s] = findpeak_prom_halfmax(w_050s(:,i,j));
  %save peak magnitudes and locations in a cell array
  peaks_050{i,j,1} = a_050n;
  peaks_050{i,j,2} = b_050n;
  peaks_050{i,j,3} = fwhm_050n.*pi.*radius.* cos(yi(x050n-8+i).*pi./180) ./90;
  peaks_050{i,j,4} = a_050s;
  peaks_050{i,j,5} = b_050s;
  peaks_050{i,j,6} = fwhm_050s.*pi.*radius.* cos(yi(x050s-8+i).*pi./180) ./90;

  [a_075n,b_075n,fwhm_075n] = findpeak_prom_halfmax(w_075n(:,i,j));
  [a_075s,b_075s,fwhm_075s] = findpeak_prom_halfmax(w_075s(:,i,j));
  %save peak magnitudes and locations in a cell array
  peaks_075{i,j,1} = a_075n;
  peaks_075{i,j,2} = b_075n;
  peaks_075{i,j,3} = fwhm_075n.*pi.*radius.* cos(yi(x075n-8+i).*pi./180) ./90;
  peaks_075{i,j,4} = a_075s;
  peaks_075{i,j,5} = b_075s;
  peaks_075{i,j,6} = fwhm_075s.*pi.*radius.* cos(yi(x075s-8+i).*pi./180) ./90;


  [a_100n,b_100n,fwhm_100n] = findpeak_prom_halfmax(w_100n(:,i,j));
  [a_100s,b_100s,fwhm_100s] = findpeak_prom_halfmax(w_100s(:,i,j));
  %save peak magnitudes and locations in a cell array
  peaks_100{i,j,1} = a_100n;
  peaks_100{i,j,2} = b_100n;
  peaks_100{i,j,3} = fwhm_100n.*pi.*radius.* cos(yi(x100n-8+i).*pi./180) ./90;
  peaks_100{i,j,4} = a_100s;
  peaks_100{i,j,5} = b_100s;
  peaks_100{i,j,6} = fwhm_100s.*pi.*radius.* cos(yi(x100s-8+i).*pi./180) ./90;

  end
end


k000=0;
l000=0;
k010=0;
l010=0;
k025=0;
l025=0;
k050=0;
l050=0;
k075=0;
l075=0;
k100=0;
l100=0;
for i = 1:15
 for j=1:720
   l000 = k000+1;
   k000 = k000 + numel(peaks_000{i,j,1});
   mags_000(l000:k000) = peaks_000{i,j,1};
   fwhms_000(l000:k000) = peaks_000{i,j,3};
   l000 = k000+1;
   k000 = k000 + numel(peaks_000{i,j,4});
   mags_000(l000:k000) = peaks_000{i,j,4};
   fwhms_000(l000:k000) = peaks_000{i,j,6};

   l010 = k010+1;
   k010 = k010 + numel(peaks_010{i,j,1});
   mags_010(l010:k010) = peaks_010{i,j,1};
   fwhms_010(l010:k010) = peaks_010{i,j,3};
   l010 = k010+1;
   k010 = k010 + numel(peaks_010{i,j,4});
   mags_010(l010:k010) = peaks_010{i,j,4};
   fwhms_010(l010:k010) = peaks_010{i,j,6};

   l025 = k025+1;
   k025 = k025 + numel(peaks_025{i,j,1});
   mags_025(l025:k025) = peaks_025{i,j,1};
   fwhms_025(l025:k025) = peaks_025{i,j,3};
   l025 = k025+1;
   k025 = k025 + numel(peaks_025{i,j,4});
   mags_025(l025:k025) = peaks_025{i,j,4};
   fwhms_025(l025:k025) = peaks_025{i,j,6};

   l050 = k050+1;
   k050 = k050 + numel(peaks_050{i,j,1});
   mags_050(l050:k050) = peaks_050{i,j,1};
   fwhms_050(l050:k050) = peaks_050{i,j,3};
   l050 = k050+1;
   k050 = k050 + numel(peaks_050{i,j,4});
   mags_050(l050:k050) = peaks_050{i,j,4};
   fwhms_050(l050:k050) = peaks_050{i,j,6};

   l075 = k075+1;
   k075 = k075 + numel(peaks_075{i,j,1});
   mags_075(l075:k075) = peaks_075{i,j,1};
   fwhms_075(l075:k075) = peaks_075{i,j,3};
   l075 = k075+1;
   k075 = k075 + numel(peaks_075{i,j,4});
   mags_075(l075:k075) = peaks_075{i,j,4};
   fwhms_075(l075:k075) = peaks_075{i,j,6};

   l100 = k100+1;
   k100 = k100 + numel(peaks_100{i,j,1});
   mags_100(l100:k100) = peaks_100{i,j,1};
   fwhms_100(l100:k100) = peaks_100{i,j,3};
   l100 = k100+1;
   k100 = k100 + numel(peaks_100{i,j,4});
   mags_100(l100:k100) = peaks_100{i,j,4};
   fwhms_100(l100:k100) = peaks_100{i,j,6};
 end
end

X_000(:,1) = mags_000;
X_000(:,2) = fwhms_000./1000;
X_010(:,1) = mags_010;
X_010(:,2) = fwhms_010./1000;
X_025(:,1) = mags_025;
X_025(:,2) = fwhms_025./1000;
X_050(:,1) = mags_050;
X_050(:,2) = fwhms_050./1000;
X_075(:,1) = mags_075;
X_075(:,2) = fwhms_075./1000;
X_100(:,1) = mags_100;
X_100(:,2) = fwhms_100./1000;

edges{1} = 0.01:0.01:1;
edges{2} = 0:200:4000;

N_000 = hist3(X_000,'Edges',edges);
N_010 = hist3(X_010,'Edges',edges);
N_025 = hist3(X_025,'Edges',edges);
N_050 = hist3(X_050,'Edges',edges);
N_075 = hist3(X_075,'Edges',edges);
N_100 = hist3(X_100,'Edges',edges);

figure
pcolor(edges{1},edges{2},N_000'./sum(sum(N_000)));
colormap(flipud(hot)) 
colorbar
caxis([0 0.04])
xlim([0 0.5])
ylim([0 2000])
xlabel('w peak strength, Pa/s')
ylabel('w peak fwhm, km')
title('w Peak Strength vs FWHM, 0.0e_{s0}')
print('-dpng','w_fwhm_mag_000_desc.png')

figure
pcolor(edges{1},edges{2},N_010'./sum(sum(N_010)));
colormap(flipud(hot)) 
colorbar
caxis([0 0.04])
xlim([0 0.5])
ylim([0 2000])
xlabel('w peak strength, Pa/s')
ylabel('w peak fwhm, km')
title('w Peak Strength vs FWHM, 0.1e_{s0}')
print('-dpng','w_fwhm_mag_010_desc.png')

figure
pcolor(edges{1},edges{2},N_025'./sum(sum(N_025)));
colormap(flipud(hot)) 
colorbar
caxis([0 0.04])
xlim([0 0.5])
ylim([0 2000])
xlabel('w peak strength, Pa/s')
ylabel('w peak fwhm, km')
title('w Peak Strength vs FWHM, 0.25e_{s0}')
print('-dpng','w_fwhm_mag_025_desc.png')

figure
pcolor(edges{1},edges{2},N_050'./sum(sum(N_050)));
colormap(flipud(hot)) 
colorbar
caxis([0 0.04])
xlim([0 0.5])
ylim([0 2000])
xlabel('w peak strength, Pa/s')
ylabel('w peak fwhm, km')
title('w Peak Strength vs FWHM, 0.5e_{s0}')
print('-dpng','w_fwhm_mag_050_desc.png')

figure
pcolor(edges{1},edges{2},N_075'./sum(sum(N_075)));
colormap(flipud(hot)) 
colorbar
caxis([0 0.04])
xlim([0 0.5])
ylim([0 2000])
xlabel('w peak strength, Pa/s')
ylabel('w peak fwhm, km')
title('w Peak Strength vs FWHM, 0.75e_{s0}')
print('-dpng','w_fwhm_mag_075_desc.png')

figure
pcolor(edges{1},edges{2},N_100'./sum(sum(N_100)));
colormap(flipud(hot)) 
colorbar
caxis([0 0.04])
xlim([0 0.5])
ylim([0 2000])
xlabel('w peak strength, Pa/s')
ylabel('w peak fwhm, km')
title('w Peak Strength vs FWHM, 1.0e_{s0}')
print('-dpng','w_fwhm_mag_100_desc.png')

save('/project/rg312/mat_files/w_fwhm_mag_hist_desc.mat')

return



figure
pcolor(edges{1},edges{2},N_100'./sum(sum(N_100)) - N_000'./sum(sum(N_000)));
colormap(b2r(-4e-3, 9e-3)) 
colorbar
%caxis([0 0.04])
xlim([0 0.5])
ylim([0 2000])
xlabel('w peak strength, Pa/s')
ylabel('w peak fwhm, km')
title('w Peak Strength vs FWHM, 1.0 - 0.0e_{s0}')
print('-dpng','w_fwhm_mag_wetmdry_desc.png')

figure
pcolor(edges{1},edges{2},N_100'./sum(sum(N_100)) - N_050'./sum(sum(N_050)));
colormap(b2r(-4e-3, 9e-3)) 
colorbar
%caxis([0 0.04])
xlim([0 0.5])
ylim([0 2000])
xlabel('w peak strength, Pa/s')
ylabel('w peak fwhm, km')
title('w Peak Strength vs FWHM, 1.0 - 0.5e_{s0}')
print('-dpng','w_fwhm_mag_wetm05_desc.png')

figure
pcolor(edges{1},edges{2},N_050'./sum(sum(N_050)) - N_000'./sum(sum(N_000)));
colormap(b2r(-4e-3, 9e-3)) 
colorbar
%caxis([0 0.04])
xlim([0 0.5])
ylim([0 2000])
xlabel('w peak strength, Pa/s')
ylabel('w peak fwhm, km')
title('w Peak Strength vs FWHM, 0.5 - 0e_{s0}')
print('-dpng','w_fwhm_mag_05mdry_desc.png')



figure
pcolor(edges{1},edges{2},N_010'./sum(sum(N_010)) - N_000'./sum(sum(N_000)));
colormap(b2r(-4e-3, 9e-3)) 
colorbar
%caxis([0 0.04])
xlim([0 0.5])
ylim([0 2000])
xlabel('w peak strength, Pa/s')
ylabel('w peak fwhm, km')
title('w Peak Strength vs FWHM, 0.5 - 0e_{s0}')
print('-dpng','w_fwhm_mag_01mdry_desc.png')

