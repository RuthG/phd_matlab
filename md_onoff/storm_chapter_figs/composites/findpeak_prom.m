%self written function to locate prominent peaks

function [mag,loc] = findpeak_prom(vec,prom);

[a,b] = findpeaks(vec);

%for a given b, find where vec next goes equal to or greater than the mag of peak b
mag = [];
loc = [];

j=0;
for i = 1:size(b) 

%find where vec is bigger than the magnitude of the peak to be checked
c = find( vec >= a(i) );

%locate the position of the peak to be checked in the c vector of locations
pos = find(c == b(i));

%check if the peak is the first peak in the large peak vector
if pos-1 == 0
%if so, the nearest larger peak on the left hand side is that at the other end of the vector
  nearest_l = c( size(c,1) );
else
%otherwise, it's the next peak to the left :)
  nearest_l = c( pos-1 );
end

%check if the peak is the last peak in the large peak vector
if pos+1 > size(c,1)
%if so, the nearest larger peak on the right hand side is the first peak of the vector
  nearest_r = c(1);
else
%otherwise, it's the next peak to the right :)
  nearest_r = c( pos+1 );
end

%check if we need to wrap around to get the nearest larger peak to the right
if nearest_r > b(i)
%if not, the prominence is the magnitude of the peak in question minus the minimum between this peak and the next larger one.
prom_r = a(i) - min( vec (b(i):nearest_r) ) ;
else
%otherwise, work out the minimum value in gap to the top of the vector
min_gap_t = min( vec(b(i):max(size(vec))) );
%and the minimum between 1 and the larger right hand peak at the other end
min_gap_b = min( vec(1:nearest_r));
%and take the minimum between these
min_gap = min([min_gap_t,min_gap_b]);
%then calculate the prominence as before
prom_r = a(i) - min_gap  ;

end

%check if we need to wrap around to get the nearest larger peak to the left
if nearest_l < b(i)
%if not, the prominence is the magnitude of the peak in question minus the minimum between this peak and the next larger one.
prom_l = a(i) - min( vec (nearest_l:b(i)) ) ;
else
%otherwise, work out the minimum value in gap between 1 and the peak looked at
min_gap_t = min( vec(1:b(i)) );
%and the minimum between the larger left and peak and the top of the vector
min_gap_b = min( vec(nearest_l : max(size(vec))));
%and take the minimum between these
min_gap = min([min_gap_t,min_gap_b]);
%then calculate the prominence as before
prom_l = a(i) - min_gap  ;

end

%check if the prominences found are greater than the prominence threshold given
if prom_r >= prom & prom_l >= prom
  j=j+1;
%if so, save peak position to output
  mag(j) = a(i);
  loc(j) = b(i);
end

end


