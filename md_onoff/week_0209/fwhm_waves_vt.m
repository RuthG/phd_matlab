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

load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')

vN_000_ll = cube2latlon(xc,yc,vN_000(:,:,5,:),xi,yi);
vN_010_ll = cube2latlon(xc,yc,vN_010(:,:,5,:),xi,yi);
vN_025_ll = cube2latlon(xc,yc,vN_025(:,:,5,:),xi,yi);
vN_050_ll = cube2latlon(xc,yc,vN_050(:,:,5,:),xi,yi);
vN_075_ll = cube2latlon(xc,yc,vN_075(:,:,5,:),xi,yi);
vN_100_ll = cube2latlon(xc,yc,vN_100(:,:,5,:),xi,yi);

vN_ed_000_ll = vN_000_ll - repmat(cube2latlon(xc,yc,mean(vN_000(:,:,5,:),4),xi,yi),[1,1,1,720]);
vN_ed_010_ll = vN_010_ll - repmat(cube2latlon(xc,yc,mean(vN_010(:,:,5,:),4),xi,yi),[1,1,1,720]);
vN_ed_025_ll = vN_025_ll - repmat(cube2latlon(xc,yc,mean(vN_025(:,:,5,:),4),xi,yi),[1,1,1,720]);
vN_ed_050_ll = vN_050_ll - repmat(cube2latlon(xc,yc,mean(vN_050(:,:,5,:),4),xi,yi),[1,1,1,720]);
vN_ed_075_ll = vN_075_ll - repmat(cube2latlon(xc,yc,mean(vN_075(:,:,5,:),4),xi,yi),[1,1,1,720]);
vN_ed_100_ll = vN_100_ll - repmat(cube2latlon(xc,yc,mean(vN_100(:,:,5,:),4),xi,yi),[1,1,1,720]);

clear('vN_000','vN_010','vN_025','vN_050','vN_075','vN_100')

load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat')

t_000_ll_tav = cube2latlon(xc,yc,mean(t_000(:,:,5,:),4),xi,yi);
t_010_ll_tav = cube2latlon(xc,yc,mean(t_010(:,:,5,:),4),xi,yi);
t_025_ll_tav = cube2latlon(xc,yc,mean(t_025(:,:,5,:),4),xi,yi);
t_050_ll_tav = cube2latlon(xc,yc,mean(t_050(:,:,5,:),4),xi,yi);
t_075_ll_tav = cube2latlon(xc,yc,mean(t_075(:,:,5,:),4),xi,yi);
t_100_ll_tav = cube2latlon(xc,yc,mean(t_100(:,:,5,:),4),xi,yi);

clear('t_000','t_010','t_025','t_050','t075','t_100')


[dTdy_000,dTdx_000] = gradient(t_000_ll_tav,pi./90);
dTdy_000 = repmat(dTdy_000./radius,[1,1,1,720]);
[dTdy_010,dTdx_010] = gradient(t_010_ll_tav,pi./90);
dTdy_010 = repmat(dTdy_010./radius,[1,1,1,720]);
[dTdy_025,dTdx_025] = gradient(t_025_ll_tav,pi./90);
dTdy_025 = repmat(dTdy_025./radius,[1,1,1,720]);
[dTdy_050,dTdx_050] = gradient(t_050_ll_tav,pi./90);
dTdy_050 = repmat(dTdy_050./radius,[1,1,1,720]);
[dTdy_075,dTdx_075] = gradient(t_075_ll_tav,pi./90);
dTdy_075 = repmat(dTdy_075./radius,[1,1,1,720]);
[dTdy_100,dTdx_100] = gradient(t_100_ll_tav,pi./90);
dTdy_100 = repmat(dTdy_100./radius,[1,1,1,720]);

v_ed_dTdy_000 = dTdy_000.*vN_ed_000_ll.*86400;
v_ed_dTdy_010 = dTdy_010.*vN_ed_010_ll.*86400;
v_ed_dTdy_025 = dTdy_025.*vN_ed_025_ll.*86400;
v_ed_dTdy_050 = dTdy_050.*vN_ed_050_ll.*86400;
v_ed_dTdy_075 = dTdy_075.*vN_ed_075_ll.*86400;
v_ed_dTdy_100 = dTdy_100.*vN_ed_100_ll.*86400;

load('/project/rg312/mat_files/vt_lats.mat')

v_ed_dTdy_000n = squeeze(v_ed_dTdy_000(:,x000n-7:x000n+7,1,:));
v_ed_dTdy_000s = squeeze(v_ed_dTdy_000(:,x000s-7:x000s+7,1,:));

v_ed_dTdy_010n = squeeze(v_ed_dTdy_010(:,x010n-7:x010n+7,1,:));
v_ed_dTdy_010s = squeeze(v_ed_dTdy_010(:,x010s-7:x010s+7,1,:));

v_ed_dTdy_025n = squeeze(v_ed_dTdy_025(:,x025n-7:x025n+7,1,:));
v_ed_dTdy_025s = squeeze(v_ed_dTdy_025(:,x025s-7:x025s+7,1,:));

v_ed_dTdy_050n = squeeze(v_ed_dTdy_050(:,x050n-7:x050n+7,1,:));
v_ed_dTdy_050s = squeeze(v_ed_dTdy_050(:,x050s-7:x050s+7,1,:));

v_ed_dTdy_075n = squeeze(v_ed_dTdy_075(:,x075n-7:x075n+7,1,:));
v_ed_dTdy_075s = squeeze(v_ed_dTdy_075(:,x075s-7:x075s+7,1,:));

v_ed_dTdy_100n = squeeze(v_ed_dTdy_100(:,x100n-7:x100n+7,1,:));
v_ed_dTdy_100s = squeeze(v_ed_dTdy_100(:,x100s-7:x100s+7,1,:));


%locate peaks of prominence above half of their own maximum 

for i=1:15
  for j=1:720
  %locate peaks in v't'
[i j]
  [a_000n,b_000n,fwhm_000n] = findpeak_prom_halfmax(v_ed_dTdy_000n(:,i,j));
  [a_000s,b_000s,fwhm_000s] = findpeak_prom_halfmax(v_ed_dTdy_000s(:,i,j));
  %save peak magnitudes and locations in a cell array
  peaks_000{i,j,1} = a_000n;
  peaks_000{i,j,2} = b_000n;
  peaks_000{i,j,3} = fwhm_000n.*pi.*radius.* cos(yi(x000n-8+i).*pi./180) ./90;
  peaks_000{i,j,4} = a_000s;
  peaks_000{i,j,5} = b_000s;
  peaks_000{i,j,6} = fwhm_000s.*pi.*radius.* cos(yi(x000s-8+i).*pi./180) ./90;

  [a_010n,b_010n,fwhm_010n] = findpeak_prom_halfmax(v_ed_dTdy_010n(:,i,j));
  [a_010s,b_010s,fwhm_010s] = findpeak_prom_halfmax(v_ed_dTdy_010s(:,i,j));
  %save peak magnitudes and locations in a cell array
  peaks_010{i,j,1} = a_010n;
  peaks_010{i,j,2} = b_010n;
  peaks_010{i,j,3} = fwhm_010n.*pi.*radius.* cos(yi(x010n-8+i).*pi./180) ./90;
  peaks_010{i,j,4} = a_010s;
  peaks_010{i,j,5} = b_010s;
  peaks_010{i,j,6} = fwhm_010s.*pi.*radius.* cos(yi(x010s-8+i).*pi./180) ./90;

  [a_025n,b_025n,fwhm_025n] = findpeak_prom_halfmax(v_ed_dTdy_025n(:,i,j));
  [a_025s,b_025s,fwhm_025s] = findpeak_prom_halfmax(v_ed_dTdy_025s(:,i,j));
  %save peak magnitudes and locations in a cell array
  peaks_025{i,j,1} = a_025n;
  peaks_025{i,j,2} = b_025n;
  peaks_025{i,j,3} = fwhm_025n.*pi.*radius.* cos(yi(x025n-8+i).*pi./180) ./90;
  peaks_025{i,j,4} = a_025s;
  peaks_025{i,j,5} = b_025s;
  peaks_025{i,j,6} = fwhm_025s.*pi.*radius.* cos(yi(x025s-8+i).*pi./180) ./90;

  [a_050n,b_050n,fwhm_050n] = findpeak_prom_halfmax(v_ed_dTdy_050n(:,i,j));
  [a_050s,b_050s,fwhm_050s] = findpeak_prom_halfmax(v_ed_dTdy_050s(:,i,j));
  %save peak magnitudes and locations in a cell array
  peaks_050{i,j,1} = a_050n;
  peaks_050{i,j,2} = b_050n;
  peaks_050{i,j,3} = fwhm_050n.*pi.*radius.* cos(yi(x050n-8+i).*pi./180) ./90;
  peaks_050{i,j,4} = a_050s;
  peaks_050{i,j,5} = b_050s;
  peaks_050{i,j,6} = fwhm_050s.*pi.*radius.* cos(yi(x050s-8+i).*pi./180) ./90;

  [a_075n,b_075n,fwhm_075n] = findpeak_prom_halfmax(v_ed_dTdy_075n(:,i,j));
  [a_075s,b_075s,fwhm_075s] = findpeak_prom_halfmax(v_ed_dTdy_075s(:,i,j));
  %save peak magnitudes and locations in a cell array
  peaks_075{i,j,1} = a_075n;
  peaks_075{i,j,2} = b_075n;
  peaks_075{i,j,3} = fwhm_075n.*pi.*radius.* cos(yi(x075n-8+i).*pi./180) ./90;
  peaks_075{i,j,4} = a_075s;
  peaks_075{i,j,5} = b_075s;
  peaks_075{i,j,6} = fwhm_075s.*pi.*radius.* cos(yi(x075s-8+i).*pi./180) ./90;


  [a_100n,b_100n,fwhm_100n] = findpeak_prom_halfmax(v_ed_dTdy_100n(:,i,j));
  [a_100s,b_100s,fwhm_100s] = findpeak_prom_halfmax(v_ed_dTdy_100s(:,i,j));
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

edges{1} = 0:1:20;
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
xlabel('v''dTdy peak strength, K/day')
ylabel('v''dTdy peak fwhm, km')
title('v''dTdy Peak Strength vs FWHM, 0.0e_{s0}')
print('-dpng','v_ed_dTdy_fwhm_mag_000.png')

figure
pcolor(edges{1},edges{2},N_010'./sum(sum(N_010)));
colormap(flipud(hot)) 
colorbar
caxis([0 0.04])
xlim([0 0.5])
ylim([0 2000])
xlabel('v''dTdy peak strength, K/day')
ylabel('v''dTdy peak fwhm, km')
title('v''dTdy Peak Strength vs FWHM, 0.1e_{s0}')
print('-dpng','v_ed_dTdy_fwhm_mag_010.png')

figure
pcolor(edges{1},edges{2},N_025'./sum(sum(N_025)));
colormap(flipud(hot)) 
colorbar
caxis([0 0.04])
xlim([0 0.5])
ylim([0 2000])
xlabel('v''dTdy peak strength, K/day')
ylabel('v''dTdy peak fwhm, km')
title('v''dTdy Peak Strength vs FWHM, 0.25e_{s0}')
print('-dpng','v_ed_dTdy_fwhm_mag_025.png')

figure
pcolor(edges{1},edges{2},N_050'./sum(sum(N_050)));
colormap(flipud(hot)) 
colorbar
caxis([0 0.04])
xlim([0 0.5])
ylim([0 2000])
xlabel('v''dTdy peak strength, K/day')
ylabel('v''dTdy peak fwhm, km')
title('v''dTdy Peak Strength vs FWHM, 0.5e_{s0}')
print('-dpng','v_ed_dTdy_fwhm_mag_050.png')

figure
pcolor(edges{1},edges{2},N_075'./sum(sum(N_075)));
colormap(flipud(hot)) 
colorbar
caxis([0 0.04])
xlim([0 0.5])
ylim([0 2000])
xlabel('v''dTdy peak strength, K/day')
ylabel('v''dTdy peak fwhm, km')
title('v''dTdy Peak Strength vs FWHM, 0.75e_{s0}')
print('-dpng','v_ed_dTdy_fwhm_mag_075.png')

figure
pcolor(edges{1},edges{2},N_100'./sum(sum(N_100)));
colormap(flipud(hot)) 
colorbar
caxis([0 0.04])
xlim([0 0.5])
ylim([0 2000])
xlabel('v''dTdy peak strength, K/day')
ylabel('v''dTdy peak fwhm, km')
title('v''dTdy Peak Strength vs FWHM, 1.0e_{s0}')
print('-dpng','v_ed_dTdy_fwhm_mag_100.png')

save('/project/rg312/mat_files/v_ed_dTdy_fwhm_mag_hist_asc.mat')

return


figure
pcolor(edges{1},edges{2},N_100'./sum(sum(N_100)) - N_000'./sum(sum(N_000)));
colormap(b2r(-4e-3, 9e-3)) 
colorbar
%caxis([0 0.04])
xlim([0 0.5])
ylim([0 2000])
xlabel('v''dTdy peak strength, K/day')
ylabel('v''dTdy peak fwhm, km')
title('v''dTdy Peak Strength vs FWHM, 1.0 - 0.0e_{s0}')
print('-dpng','v_ed_dTdy_fwhm_mag_wetmdry.png')

figure
pcolor(edges{1},edges{2},N_100'./sum(sum(N_100)) - N_050'./sum(sum(N_050)));
colormap(b2r(-4e-3, 9e-3)) 
colorbar
%caxis([0 0.04])
xlim([0 0.5])
ylim([0 2000])
xlabel('v''dTdy peak strength, K/day')
ylabel('v''dTdy peak fwhm, km')
title('v''dTdy Peak Strength vs FWHM, 1.0 - 0.5e_{s0}')
print('-dpng','v_ed_dTdy_fwhm_mag_wetm05.png')

figure
pcolor(edges{1},edges{2},N_050'./sum(sum(N_050)) - N_000'./sum(sum(N_000)));
colormap(b2r(-4e-3, 9e-3)) 
colorbar
%caxis([0 0.04])
xlim([0 0.5])
ylim([0 2000])
xlabel('v''dTdy peak strength, K/day')
ylabel('v''dTdy peak fwhm, km')
title('v''dTdy Peak Strength vs FWHM, 0.5 - 0e_{s0}')
print('-dpng','v_ed_dTdy_fwhm_mag_05mdry.png')



figure
pcolor(edges{1},edges{2},N_010'./sum(sum(N_010)) - N_000'./sum(sum(N_000)));
colormap(b2r(-4e-3, 9e-3)) 
colorbar
%caxis([0 0.04])
xlim([0 0.5])
ylim([0 2000])
xlabel('v''dTdy peak strength, K/day')
ylabel('v''dTdy peak fwhm, km')
title('v''dTdy Peak Strength vs FWHM, 0.5 - 0e_{s0}')
print('-dpng','v_ed_dTdy_fwhm_mag_01mdry.png')

