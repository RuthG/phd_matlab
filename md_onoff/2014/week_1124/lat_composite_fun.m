%take vt peaks, a variable (180x15x25x720 array), and a filename as an input, and save data for composite plus some data about its production for a given experiment


function [comp_data] = lat_composite_fun(vt_peaks,vt_thresh,var,filename);


vtindex=0;
comp_data = zeros(15,25,10);

%start loops over lat and time
  for j=1:720

  %read peak positions
  b = vt_peaks{8,j,2};

  %find peaks that are above threshold
  positions = b(find([vt_peaks{8,j,1}] > vt_thresh));
check(j) = size(positions,1);
  %loop over extremes at a given lat and time
    for k=1:size(positions,1)
        vtindex = vtindex + 1;

  %we can then do the upper portion as normal...
      comp_data(:,:,vtindex) = squeeze(var(positions(k),:,:,j));


end
end


save(filename,'comp_data')

