
vtindex=0;
w_sec_000 = zeros(35,25,10);

%start loops over lat and time
for i=1:15
  for j=1:720

  %read peak positions
  b = peaks_000{i,j,2};

  %find peaks that are above threshold
  positions = b(find([peaks_000{i,j,1}] > vt_thresh_000));

  %create mask based on these
  %vt_mask_000(positions,i,j) = 1;

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

     if positions(k) < lowlim+1

      w_sec_000(18:18+uplim,:,vtindex) = squeeze(w_000_lev(positions(k):upper,i,:,j));

      w_sec_000(19-positions(k):18,:,vtindex) = squeeze(w_000_lev(1:positions(k),i,:,j));
      w_sec_000(18-lowlim:18-positions(k),:,vtindex) = squeeze(w_000_lev(lower:180,i,:,j));

     else

      w_sec_000(18-lowlim:18,:,vtindex) = squeeze(w_000_lev(lower:positions(k),i,:,j));

      w_sec_000(18:18+(180 - positions(k)),:,vtindex) = squeeze(w_000_lev(positions(k):180,i,:,j));

      w_sec_000(19+(180-positions(k)):18+uplim,:,vtindex) = squeeze(w_000_lev(1:upper,i,:,j));


      end
      end

end
end
end



