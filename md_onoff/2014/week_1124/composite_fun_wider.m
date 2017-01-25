%take vt peaks, a variable (180x15x25x720 array), and a filename as an input, and save data for composite plus some data about its production for a given experiment


function [comp_data] = composite_fun_wider(vt_peaks,vt_thresh,var_n,var_s,filename);


vtindex=0;
comp_data = zeros(73,25,1);

%start loops over lat and time
for hem = 1:2
if (hem==1) var = var_n; elseif (hem==2) var = var_s; end;

for i=1:15
  for j=1:720

  %read peak positions
  b = vt_peaks{i,j,hem.*2};

  %find peaks that are above threshold
  positions = b(find([vt_peaks{i,j,hem.*2-1}] > vt_thresh));
%check(i,j) = max(size(positions));

%if no peaks are above the threshold then
if(min(size(positions)) == 0)
vtindex = vtindex + 1;
comp_data(:,:,vtindex) = NaN;
else 

  %loop over extremes at a given lat and time
    for k=1:max(size(positions))
        vtindex = vtindex + 1;
  %find longitudinal separation of extremes
    if k==1 
     sep(1) = positions(k)+180 - positions(max(size(positions))); 
    else
     sep(1) = positions(k) - positions(k-1);
    end

    if k==max(size(positions))
     sep(2) = positions(1)+180 - positions(k); 
    else
     sep(2) = positions(k+1) - positions(k);
    end

  %if two extremes are less than 72 gridpoints apart, then assign half to each event, otherwise retain 36 gridpoints either side

    if (sep(1) < 72) lowlim = floor(sep(1)./2); else lowlim = 36; end;
    if (sep(2) < 72)  uplim = floor(sep(2)./2); else  uplim = 36; end;


  %lower bound position is the modulo wrt 180 of the peak position minus the distance to the lower peak 
    lower = mod(positions(k)-lowlim,180);
  %if we get 0, set the lower index to 180
    if (lower ==0) lower = 180; end

  %upper bound position is the modulo wrt 180 of the peak position plus the distance to the upper peak 
    upper = mod(positions(k)+uplim,180);
  %if we get 0, set the upper index to 180
    if (upper ==0) upper = 180; end


  %for the iteration in question set the cross section initially to NaNs so we can use NaN mean to exclude values
      comp_data(:,:,vtindex) = NaN;

  %for the 'normal' case, where the upper bound is bigger than the lower bound, fill in cross sec from centre outwards
      if upper > lower

      comp_data(37:37+uplim,:,vtindex) = squeeze(var(positions(k):upper,i,:,j));
      comp_data(37-lowlim:37,:,vtindex) = squeeze(var(lower:positions(k),i,:,j));

      else
  %for the more complex wrap around case, where the upper bound is smaller than the lower bound, fill in cross sec from centre outwards

    length_below = 181 - lower;

  %test peak position; if the lower limit is less than the upper limit, and the centre of the composite is closer to the edge of the longitude series than the lower limit + 1 (e.g. 37) then we know that it's the lower edge of the composite that crosses to the other side. 

     if positions(k) < lowlim+1

%we can then do the upper portion as normal...
      comp_data(37:37+uplim,:,vtindex) = squeeze(var(positions(k):upper,i,:,j));

%and split the lower portion into the half that is from 1 to the peak centre
      comp_data(38-positions(k):37,:,vtindex) = squeeze(var(1:positions(k),i,:,j));
%and the half that is from the lower bound to 180
      comp_data(37-lowlim:37-positions(k),:,vtindex) = squeeze(var(lower:180,i,:,j));

 %otherwise, then it must the the upper part of the composite that crosses over
     else

 %so allocate the lower part as usual
      comp_data(37-lowlim:37,:,vtindex) = squeeze(var(lower:positions(k),i,:,j));

 %and split the upper portion into the half that is from the peak centre to 180
      comp_data(37:37+(180 - positions(k)),:,vtindex) = squeeze(var(positions(k):180,i,:,j));
 %and the half that is from 1 to the upper limit
      comp_data(38+(180-positions(k)):37+uplim,:,vtindex) = squeeze(var(1:upper,i,:,j));


      end
      end
end
end
end
end
end


save(filename,'comp_data')

