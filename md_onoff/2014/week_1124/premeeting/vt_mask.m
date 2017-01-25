%create mask using data from vt_extremes

%load in data

load('/project/rg312/mat_files/vt_extreme_data.mat')
load('/project/rg312/mat_files/vt_lats.mat')
load('/project/rg312/mat_files/w_snapshots_saved.mat')

%transfer w to ll
xi=-179:2:180;yi=-89:2:90;
w_000_ll = cube2latlon(xc,yc,w_000,xi,yi);
w_010_ll = cube2latlon(xc,yc,w_010,xi,yi);
w_025_ll = cube2latlon(xc,yc,w_025,xi,yi);
w_050_ll = cube2latlon(xc,yc,w_050,xi,yi);
w_075_ll = cube2latlon(xc,yc,w_075,xi,yi);
w_100_ll = cube2latlon(xc,yc,w_100,xi,yi);

%locate region of interest
w_000_lev = squeeze(w_000_ll(:,x000-7:x000+7,:,:));
w_010_lev = squeeze(w_010_ll(:,x010-7:x010+7,:,:));
w_025_lev = squeeze(w_025_ll(:,x025-7:x025+7,:,:));
w_050_lev = squeeze(w_050_ll(:,x050-7:x050+7,:,:));
w_075_lev = squeeze(w_075_ll(:,x075-7:x075+7,:,:));
w_100_lev = squeeze(w_100_ll(:,x100-7:x100+7,:,:));

%clear large matrices
clear('w_000_ll','w_010_ll','w_025_ll','w_050_ll','w_075_ll','w_100_ll','w_000','w_010','w_025','w_050','w_075','w_100')

vtindex=0;
w_sec_000 = zeros(35,25,10);

%start loops over lat and time
for i=1:15
  for j=1:720

  %read peak positions
  b = peaks_000{i,j,2};

  %find peaks that are above threshold
  positions = b(find([peaks_000{i,j,1}] > vt_thresh_000));
check(i,j) = size(positions,1);
  %loop over extremes at a given lat and time
    for k=1:size(positions,1)
        vtindex = vtindex + 1;
  %find longitudinal separation of extremes
    if k==1 
     sep(1) = positions(k)+180 - positions(size(positions,1)); 
    else
     sep(1) = positions(k) - positions(k-1);
    end

    if k==size(positions,1)
     sep(2) = positions(1)+180 - positions(k); 
    else
     sep(2) = positions(k+1) - positions(k);
    end

  %if two extremes are less than 34 gridpoints apart, then assign half to each event, otherwise retain 17 gridpoints either side

    if (sep(1) < 34) lowlim = floor(sep(1)./2); else lowlim = 17; end;
    if (sep(2) < 34)  uplim = floor(sep(2)./2); else  uplim = 17; end;


  %lower bound position is the modulo wrt 180 of the peak position minus the distance to the lower peak 
    lower = mod(positions(k)-lowlim,180);
  %if we get 0, set the lower index to 180
    if (lower ==0) lower = 180; end

  %upper bound position is the modulo wrt 180 of the peak position plus the distance to the upper peak 
    upper = mod(positions(k)+uplim,180);
  %if we get 0, set the upper index to 180
    if (upper ==0) upper = 180; end


  %for the iteration in question set the cross section initially to NaNs so we can use NaN mean to exclude values
      w_sec_000(:,:,vtindex) = NaN;

  %for the 'normal' case, where the upper bound is bigger than the lower bound, fill in cross sec from centre outwards
      if upper > lower

      w_sec_000(18:18+uplim,:,vtindex) = squeeze(w_000_lev(positions(k):upper,i,:,j));
      w_sec_000(18-lowlim:18,:,vtindex) = squeeze(w_000_lev(lower:positions(k),i,:,j));

      else
  %for the more complex wrap around case, where the upper bound is smaller than the lower bound, fill in cross sec from centre outwards

    length_below = 181 - lower;

  %test peak position; if the lower limit is less than the upper limit, and the centre of the composite is closer to the edge of the longitude series than the lower limit + 1 (e.g. 18) then we know that it's the lower edge of the composite that crosses to the other side. 

     if positions(k) < lowlim+1

%we can then do the upper portion as normal...
      w_sec_000(18:18+uplim,:,vtindex) = squeeze(w_000_lev(positions(k):upper,i,:,j));

%and split the lower portion into the half that is from 1 to the peak centre
      w_sec_000(19-positions(k):18,:,vtindex) = squeeze(w_000_lev(1:positions(k),i,:,j));
%and the half that is from the lower bound to 180
      w_sec_000(18-lowlim:18-positions(k),:,vtindex) = squeeze(w_000_lev(lower:180,i,:,j));

 %otherwise, then it must the the upper part of the composite that crosses over
     else

 %so allocate the lower part as usual
      w_sec_000(18-lowlim:18,:,vtindex) = squeeze(w_000_lev(lower:positions(k),i,:,j));

 %and split the upper portion into the half that is from the peak centre to 180
      w_sec_000(18:18+(180 - positions(k)),:,vtindex) = squeeze(w_000_lev(positions(k):180,i,:,j));
 %and the half that is from 1 to the upper limit
      w_sec_000(19+(180-positions(k)):18+uplim,:,vtindex) = squeeze(w_000_lev(1:upper,i,:,j));


      end
      end

end
end
end

save('w_comp_gabsmet.mat','w_sec_000')









