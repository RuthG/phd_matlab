%plot heat composites for the w events

load('~/md_onoff/week_1027/PREMEETING/w_snapshots_saved.mat')

%load up w profiles
xi=-179:2:180;yi=-89:2:90;
w_000_ll = cube2latlon(xc,yc,w_000,xi,yi);
w_010_ll = cube2latlon(xc,yc,w_010,xi,yi);
w_025_ll = cube2latlon(xc,yc,w_025,xi,yi);
w_050_ll = cube2latlon(xc,yc,w_050,xi,yi);
w_075_ll = cube2latlon(xc,yc,w_075,xi,yi);
w_100_ll = cube2latlon(xc,yc,w_100,xi,yi);

%look at 580hPa level
w_000_29_11(:,1:720) = squeeze(w_000_ll(:,60,11,:));
w_000_29_11(:,721:1440) = -squeeze(w_000_ll(:,31,11,:));

w_010_29_11(:,1:720) = squeeze(w_010_ll(:,60,11,:));
w_010_29_11(:,721:1440) = -squeeze(w_010_ll(:,31,11,:));

w_025_29_11(:,1:720) = squeeze(w_025_ll(:,60,11,:));
w_025_29_11(:,721:1440) = -squeeze(w_025_ll(:,31,11,:));

w_050_29_11(:,1:720) = squeeze(w_050_ll(:,60,11,:));
w_050_29_11(:,721:1440) = -squeeze(w_050_ll(:,31,11,:));

w_075_29_11(:,1:720) = squeeze(w_075_ll(:,60,11,:));
w_075_29_11(:,721:1440) = -squeeze(w_075_ll(:,31,11,:));

w_100_29_11(:,1:720) = squeeze(w_100_ll(:,60,11,:));
w_100_29_11(:,721:1440) = -squeeze(w_100_ll(:,31,11,:));

%load in heating data; only keep the relevant parts
load('heat_rates.mat')

clear('radht_000','radht_010','radht_025','radht_050','radht_075','radht_100', ...
'htrt_000','htrt_010','htrt_025','htrt_050','htrt_075','htrt_100', ...
'difht_000','difht_010','difht_025','difht_050','difht_075','difht_100')

%add up the latent heating terms
xi=-179:2:180;yi=-89:2:90;
latht_000_ll = cube2latlon(xc,yc,cndht_000,xi,yi) + cube2latlon(xc,yc,cnvht_000,xi,yi);
latht_010_ll = cube2latlon(xc,yc,cndht_010,xi,yi) + cube2latlon(xc,yc,cnvht_010,xi,yi);
latht_025_ll = cube2latlon(xc,yc,cndht_025,xi,yi) + cube2latlon(xc,yc,cnvht_025,xi,yi);
latht_050_ll = cube2latlon(xc,yc,cndht_050,xi,yi) + cube2latlon(xc,yc,cnvht_050,xi,yi);
latht_075_ll = cube2latlon(xc,yc,cndht_075,xi,yi) + cube2latlon(xc,yc,cnvht_075,xi,yi);
latht_100_ll = cube2latlon(xc,yc,cndht_100,xi,yi) + cube2latlon(xc,yc,cnvht_100,xi,yi);


%find the relevant latitudes in both hemispheres
latht_000_29(:,:,1:720) = squeeze(latht_000_ll(:,60,:,:));
latht_000_29(:,:,721:1440) = squeeze(latht_000_ll(:,31,:,:));

latht_010_29(:,:,1:720) = squeeze(latht_010_ll(:,60,:,:));
latht_010_29(:,:,721:1440) = squeeze(latht_010_ll(:,31,:,:));

latht_025_29(:,:,1:720) = squeeze(latht_025_ll(:,60,:,:));
latht_025_29(:,:,721:1440) = squeeze(latht_025_ll(:,31,:,:));

latht_050_29(:,:,1:720) = squeeze(latht_050_ll(:,60,:,:));
latht_050_29(:,:,721:1440) = squeeze(latht_050_ll(:,31,:,:));

latht_075_29(:,:,1:720) = squeeze(latht_075_ll(:,60,:,:));
latht_075_29(:,:,721:1440) = squeeze(latht_075_ll(:,31,:,:));

latht_100_29(:,:,1:720) = squeeze(latht_100_ll(:,60,:,:));
latht_100_29(:,:,721:1440) = squeeze(latht_100_ll(:,31,:,:));

%load in the w masks

load('w_masks.mat')

%find the masked w values

w_masked_000 = w_000_29_11.*w_mask_000;
w_masked_010 = w_010_29_11.*w_mask_010;
w_masked_025 = w_025_29_11.*w_mask_025;
w_masked_050 = w_050_29_11.*w_mask_050;
w_masked_075 = w_075_29_11.*w_mask_075;
w_masked_100 = w_100_29_11.*w_mask_100;


'starting loops'



windex = 0;

for i=1:720

%look for the locations of the highest values of the masked data to avoid counting events twice

[a,peak_pos] = findpeaks(-w_masked_000(:,i));

%take these peak positions and look 30 degrees longitude to either side

  for j=1:size(peak_pos,1)
    
    windex = windex + 1;

  lower = mod(peak_pos(j)-17,180);
  if lower ==0 
  lower = 180;
  end
  upper = mod(peak_pos(j)+17,180);
  if upper ==0 
  upper = 180;
  end
    if upper > lower
    latht_sec_000(:,:,windex) = latht_000_29(lower:upper,:,i);
    else

    length = 181 - lower;

    latht_sec_000(1:length,:,windex) = latht_000_29(lower:180,:,i);
    latht_sec_000(length+1:35,:,windex) = latht_000_29(1:upper,:,i);
 
    end

  end

end

%average over these cross-sections to get the composite, and save
latht_comp_000 = mean(latht_sec_000,3);

'dry loop done'

save('latht_composites.mat','latht_comp_000')


%repeat for each run!
windex = 0;
for i=1:720
[a,peak_pos] = findpeaks(-w_masked_010(:,i));

  for j=1:size(peak_pos,1)
    
    windex = windex + 1;

  lower = mod(peak_pos(j)-17,180);
  if lower ==0 
  lower = 180;
  end
  upper = mod(peak_pos(j)+17,180);
  if upper ==0 
  upper = 180;
  end
    if upper > lower
    latht_sec_010(:,:,windex) = latht_010_29(lower:upper,:,i);
    else

    length = 181 - lower;

    latht_sec_010(1:length,:,windex) = latht_010_29(lower:180,:,i);
    latht_sec_010(length+1:35,:,windex) = latht_010_29(1:upper,:,i);
 
    end

  end

end

latht_comp_010 = mean(latht_sec_010,3);

'0.1 loop done'

save('latht_composites.mat','latht_comp_010','-append')


windex = 0;
for i=1:720
[a,peak_pos] = findpeaks(-w_masked_025(:,i));

  for j=1:size(peak_pos,1)
    
    windex = windex + 1;

  lower = mod(peak_pos(j)-17,180);
  if lower ==0 
  lower = 180;
  end
  upper = mod(peak_pos(j)+17,180);
  if upper ==0 
  upper = 180;
  end
    if upper > lower
    latht_sec_025(:,:,windex) = latht_025_29(lower:upper,:,i);
    else

    length = 181 - lower;

    latht_sec_025(1:length,:,windex) = latht_025_29(lower:180,:,i);
    latht_sec_025(length+1:35,:,windex) = latht_025_29(1:upper,:,i);
 
    end

  end

end

latht_comp_025 = mean(latht_sec_025,3);

'0.25 loop done'

save('latht_composites.mat','latht_comp_025','-append')

windex = 0;
for i=1:720
[a,peak_pos] = findpeaks(-w_masked_050(:,i));

  for j=1:size(peak_pos,1)
    
    windex = windex + 1;

  lower = mod(peak_pos(j)-17,180);
  if lower ==0 
  lower = 180;
  end
  upper = mod(peak_pos(j)+17,180);
  if upper ==0 
  upper = 180;
  end
    if upper > lower
    latht_sec_050(:,:,windex) = latht_050_29(lower:upper,:,i);
    else

    length = 181 - lower;

    latht_sec_050(1:length,:,windex) = latht_050_29(lower:180,:,i);
    latht_sec_050(length+1:35,:,windex) = latht_050_29(1:upper,:,i);
 
    end

  end

end


latht_comp_050 = mean(latht_sec_050,3);

'0.5 loop done'

save('latht_composites.mat','latht_comp_050','-append')


windex = 0;
for i=1:720
[a,peak_pos] = findpeaks(-w_masked_075(:,i));

  for j=1:size(peak_pos,1)
    
    windex = windex + 1;

  lower = mod(peak_pos(j)-17,180);
  if lower ==0 
  lower = 180;
  end
  upper = mod(peak_pos(j)+17,180);
  if upper ==0 
  upper = 180;
  end
    if upper > lower
    latht_sec_075(:,:,windex) = latht_075_29(lower:upper,:,i);
    else

    length = 181 - lower;

    latht_sec_075(1:length,:,windex) = latht_075_29(lower:180,:,i);
    latht_sec_075(length+1:35,:,windex) = latht_075_29(1:upper,:,i);
 
    end

  end

end

latht_comp_075 = mean(latht_sec_075,3);

'0.75 loop done'

save('latht_composites.mat','latht_comp_075','-append')


windex = 0;
for i=1:720
[a,peak_pos] = findpeaks(-w_masked_100(:,i));

  for j=1:size(peak_pos,1)
    
    windex = windex + 1;

  lower = mod(peak_pos(j)-17,180);
  if lower ==0 
  lower = 180;
  end
  upper = mod(peak_pos(j)+17,180);
  if upper ==0 
  upper = 180;
  end
    if upper > lower
    latht_sec_100(:,:,windex) = latht_100_29(lower:upper,:,i);
    else

    length = 181 - lower;

    latht_sec_100(1:length,:,windex) = latht_100_29(lower:180,:,i);
    latht_sec_100(length+1:35,:,windex) = latht_100_29(1:upper,:,i);
 
    end

  end

end


latht_comp_100 = mean(latht_sec_100,3);

'1 loop done'

save('latht_composites.mat','latht_comp_100','-append')


