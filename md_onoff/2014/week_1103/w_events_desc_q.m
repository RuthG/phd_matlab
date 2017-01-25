load('~/md_onoff/week_1027/PREMEETING/w_snapshots_saved.mat')


xi=-179:2:180;yi=-89:2:90;
w_000_ll = cube2latlon(xc,yc,w_000,xi,yi);
w_010_ll = cube2latlon(xc,yc,w_010,xi,yi);
w_025_ll = cube2latlon(xc,yc,w_025,xi,yi);
w_050_ll = cube2latlon(xc,yc,w_050,xi,yi);
w_075_ll = cube2latlon(xc,yc,w_075,xi,yi);
w_100_ll = cube2latlon(xc,yc,w_100,xi,yi);


w_000_29_11(:,1:720) = squeeze(w_000_ll(:,60,11,:));

w_010_29_11(:,1:720) = squeeze(w_010_ll(:,60,11,:));

w_025_29_11(:,1:720) = squeeze(w_025_ll(:,60,11,:));

w_050_29_11(:,1:720) = squeeze(w_050_ll(:,60,11,:));

w_075_29_11(:,1:720) = squeeze(w_075_ll(:,60,11,:));

w_100_29_11(:,1:720) = squeeze(w_100_ll(:,60,11,:));



load('/project/rg312/mat_files/thetaq.mat')

clear('theta_000','theta_010','theta_025','theta_050','theta_075','theta_100')

xi=-179:2:180;yi=-89:2:90;
q_000_ll = cube2latlon(xc,yc,q_000,xi,yi);
q_010_ll = cube2latlon(xc,yc,q_010,xi,yi);
q_025_ll = cube2latlon(xc,yc,q_025,xi,yi);
q_050_ll = cube2latlon(xc,yc,q_050,xi,yi);
q_075_ll = cube2latlon(xc,yc,q_075,xi,yi);
q_100_ll = cube2latlon(xc,yc,q_100,xi,yi);



q_000_29(:,:,1:720) = squeeze(q_000_ll(:,60,:,:));
q_000_29(:,:,721:1440) = squeeze(q_000_ll(:,31,:,:));

q_010_29(:,:,1:720) = squeeze(q_010_ll(:,60,:,:));
q_010_29(:,:,721:1440) = squeeze(q_010_ll(:,31,:,:));

q_025_29(:,:,1:720) = squeeze(q_025_ll(:,60,:,:));
q_025_29(:,:,721:1440) = squeeze(q_025_ll(:,31,:,:));

q_050_29(:,:,1:720) = squeeze(q_050_ll(:,60,:,:));
q_050_29(:,:,721:1440) = squeeze(q_050_ll(:,31,:,:));

q_075_29(:,:,1:720) = squeeze(q_075_ll(:,60,:,:));
q_075_29(:,:,721:1440) = squeeze(q_075_ll(:,31,:,:));

q_100_29(:,:,1:720) = squeeze(q_100_ll(:,60,:,:));
q_100_29(:,:,721:1440) = squeeze(q_100_ll(:,31,:,:));

load('/project/rg312/mat_files/w_masks_desc.mat')



w_masked_000 = w_000_29_11.*w_mask_000_desc;
w_masked_010 = w_010_29_11.*w_mask_010_desc;
w_masked_025 = w_025_29_11.*w_mask_025_desc;
w_masked_050 = w_050_29_11.*w_mask_050_desc;
w_masked_075 = w_075_29_11.*w_mask_075_desc;
w_masked_100 = w_100_29_11.*w_mask_100_desc;




'starting loops'


windex = 0;

for i=1:720
[a,peak_pos] = findpeaks(w_masked_000(:,i));

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
    q_sec_000(:,:,windex) = q_000_29(lower:upper,:,i);
    else

    length = 181 - lower;

    q_sec_000(1:length,:,windex) = q_000_29(lower:180,:,i);
    q_sec_000(length+1:35,:,windex) = q_000_29(1:upper,:,i);
 
    end

  end

end

q_comp_000 = mean(q_sec_000,3);

'dry loop done'

save('/project/rg312/mat_files/q_composites_desc.mat','q_comp_000')

windex = 0;
for i=1:720
[a,peak_pos] = findpeaks(w_masked_010(:,i));

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
    q_sec_010(:,:,windex) = q_010_29(lower:upper,:,i);
    else

    length = 181 - lower;

    q_sec_010(1:length,:,windex) = q_010_29(lower:180,:,i);
    q_sec_010(length+1:35,:,windex) = q_010_29(1:upper,:,i);
 
    end

  end

end

q_comp_010 = mean(q_sec_010,3);

'0.1 loop done'

save('/project/rg312/mat_files/q_composites_desc.mat','q_comp_010','-append')


windex = 0;
for i=1:720
[a,peak_pos] = findpeaks(w_masked_025(:,i));

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
    q_sec_025(:,:,windex) = q_025_29(lower:upper,:,i);
    else

    length = 181 - lower;

    q_sec_025(1:length,:,windex) = q_025_29(lower:180,:,i);
    q_sec_025(length+1:35,:,windex) = q_025_29(1:upper,:,i);
 
    end

  end

end

q_comp_025 = mean(q_sec_025,3);

'0.25 loop done'

save('/project/rg312/mat_files/q_composites_desc.mat','q_comp_025','-append')

windex = 0;
for i=1:720
[a,peak_pos] = findpeaks(w_masked_050(:,i));

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
    q_sec_050(:,:,windex) = q_050_29(lower:upper,:,i);
    else

    length = 181 - lower;

    q_sec_050(1:length,:,windex) = q_050_29(lower:180,:,i);
    q_sec_050(length+1:35,:,windex) = q_050_29(1:upper,:,i);
 
    end

  end

end


q_comp_050 = mean(q_sec_050,3);

'0.5 loop done'

save('/project/rg312/mat_files/q_composites_desc.mat','q_comp_050','-append')


windex = 0;
for i=1:720
[a,peak_pos] = findpeaks(w_masked_075(:,i));

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
    q_sec_075(:,:,windex) = q_075_29(lower:upper,:,i);
    else

    length = 181 - lower;

    q_sec_075(1:length,:,windex) = q_075_29(lower:180,:,i);
    q_sec_075(length+1:35,:,windex) = q_075_29(1:upper,:,i);
 
    end

  end

end

q_comp_075 = mean(q_sec_075,3);

'0.75 loop done'

save('/project/rg312/mat_files/q_composites_desc.mat','q_comp_075','-append')


windex = 0;
for i=1:720
[a,peak_pos] = findpeaks(w_masked_100(:,i));

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
    q_sec_100(:,:,windex) = q_100_29(lower:upper,:,i);
    else

    length = 181 - lower;

    q_sec_100(1:length,:,windex) = q_100_29(lower:180,:,i);
    q_sec_100(length+1:35,:,windex) = q_100_29(1:upper,:,i);
 
    end

  end

end


q_comp_100 = mean(q_sec_100,3);

'1 loop done'

save('/project/rg312/mat_files/q_composites_desc.mat','q_comp_100','-append')


