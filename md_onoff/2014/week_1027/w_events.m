load('~/md_onoff/week_1027/PREMEETING/w_snapshots_saved.mat')


xi=-179:2:180;yi=-89:2:90;
w_000_ll = cube2latlon(xc,yc,w_000,xi,yi);
w_010_ll = cube2latlon(xc,yc,w_010,xi,yi);
w_025_ll = cube2latlon(xc,yc,w_025,xi,yi);
w_050_ll = cube2latlon(xc,yc,w_050,xi,yi);
w_075_ll = cube2latlon(xc,yc,w_075,xi,yi);
w_100_ll = cube2latlon(xc,yc,w_100,xi,yi);


w_000_29(:,:,1:720) = squeeze(w_000_ll(:,60,:,:));
w_000_29(:,:,721:1440) = squeeze(w_000_ll(:,31,:,:));

w_010_29(:,:,1:720) = squeeze(w_010_ll(:,60,:,:));
w_010_29(:,:,721:1440) = squeeze(w_010_ll(:,31,:,:));

w_025_29(:,:,1:720) = squeeze(w_025_ll(:,60,:,:));
w_025_29(:,:,721:1440) = squeeze(w_025_ll(:,31,:,:));

w_050_29(:,:,1:720) = squeeze(w_050_ll(:,60,:,:));
w_050_29(:,:,721:1440) = squeeze(w_050_ll(:,31,:,:));

w_075_29(:,:,1:720) = squeeze(w_075_ll(:,60,:,:));
w_075_29(:,:,721:1440) = squeeze(w_075_ll(:,31,:,:));

w_100_29(:,:,1:720) = squeeze(w_100_ll(:,60,:,:));
w_100_29(:,:,721:1440) = squeeze(w_100_ll(:,31,:,:));

load('w_masks.mat')


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

w_masked_000 = w_000_29_11.*w_mask_000;
w_masked_010 = w_010_29_11.*w_mask_010;
w_masked_025 = w_025_29_11.*w_mask_025;
w_masked_050 = w_050_29_11.*w_mask_050;
w_masked_075 = w_075_29_11.*w_mask_075;
w_masked_100 = w_100_29_11.*w_mask_100;


'starting loops'


windex = 0;

for i=1:720
[a,peak_pos] = findpeaks(-w_masked_000(:,i));

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
    w_sec_000(:,:,windex) = w_000_29(lower:upper,:,i);
    else

    length = 181 - lower;

    w_sec_000(1:length,:,windex) = w_000_29(lower:180,:,i);
    w_sec_000(length+1:35,:,windex) = w_000_29(1:upper,:,i);
 
    end

  end

end

w_comp_000 = mean(w_sec_000,3);

'dry loop done'

save('w_composites.mat','w_comp_000')

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
    w_sec_010(:,:,windex) = w_010_29(lower:upper,:,i);
    else

    length = 181 - lower;

    w_sec_010(1:length,:,windex) = w_010_29(lower:180,:,i);
    w_sec_010(length+1:35,:,windex) = w_010_29(1:upper,:,i);
 
    end

  end

end

w_comp_010 = mean(w_sec_010,3);

'0.1 loop done'

save('w_composites.mat','w_comp_010','-append')


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
    w_sec_025(:,:,windex) = w_025_29(lower:upper,:,i);
    else

    length = 181 - lower;

    w_sec_025(1:length,:,windex) = w_025_29(lower:180,:,i);
    w_sec_025(length+1:35,:,windex) = w_025_29(1:upper,:,i);
 
    end

  end

end

w_comp_025 = mean(w_sec_025,3);

'0.25 loop done'

save('w_composites.mat','w_comp_025','-append')

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
    w_sec_050(:,:,windex) = w_050_29(lower:upper,:,i);
    else

    length = 181 - lower;

    w_sec_050(1:length,:,windex) = w_050_29(lower:180,:,i);
    w_sec_050(length+1:35,:,windex) = w_050_29(1:upper,:,i);
 
    end

  end

end


w_comp_050 = mean(w_sec_050,3);

'0.5 loop done'

save('w_composites.mat','w_comp_050','-append')


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
    w_sec_075(:,:,windex) = w_075_29(lower:upper,:,i);
    else

    length = 181 - lower;

    w_sec_075(1:length,:,windex) = w_075_29(lower:180,:,i);
    w_sec_075(length+1:35,:,windex) = w_075_29(1:upper,:,i);
 
    end

  end

end

w_comp_075 = mean(w_sec_075,3);

'0.75 loop done'

save('w_composites.mat','w_comp_075','-append')


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
    w_sec_100(:,:,windex) = w_100_29(lower:upper,:,i);
    else

    length = 181 - lower;

    w_sec_100(1:length,:,windex) = w_100_29(lower:180,:,i);
    w_sec_100(length+1:35,:,windex) = w_100_29(1:upper,:,i);
 
    end

  end

end


w_comp_100 = mean(w_sec_100,3);

'1 loop done'

save('w_composites.mat','w_comp_100','-append')


