%self written function to locate prominent peaks

function [mag,loc,fwhm] = findpeak_prom_halfmax(vec);

[a,b] = findpeaks(vec);

%for a given b, find where vec next goes equal to or greater than the mag of peak b
mag = [];
loc = [];

j=0;
for i = 1:size(b) 

c = find( vec >= a(i) );

pos = find(c == b(i));

if pos-1 == 0
  nearest_l = c( size(c,1) );
else
  nearest_l = c( pos-1 );
end

if pos+1 > size(c,1)
  nearest_r = c(1);
else
  nearest_r = c( pos+1 );
end

if nearest_r > b(i)
prom_r = a(i) - min( vec (b(i):nearest_r) ) ;
else
min_gap_t = min( vec(b(i):max(size(vec))) );
min_gap_b = min( vec(1:nearest_r));
min_gap = min([min_gap_t,min_gap_b]);
prom_r = a(i) - min_gap  ;

end

if nearest_l < b(i)
prom_l = a(i) - min( vec (nearest_l:b(i)) ) ;
else
min_gap_t = min( vec(1:b(i)) );
min_gap_b = min( vec(nearest_l : max(size(vec))));
min_gap = min([min_gap_t,min_gap_b]);
prom_l = a(i) - min_gap  ;

end


if prom_r >= 0.5.*a(i) & prom_l >= 0.5.*a(i) & a(i) >= 0.01;
  j=j+1;
  mag(j) = a(i);
  loc(j) = b(i);

%find crossing points where the vector passes the half maximum value of the peak
  crossing = find(abs(diff( (vec > a(i).*0.5) )))+0.5;

%subtract the actual peak position from these to locate where the relevant half max values are, and subtract their positions to get the number of indices between them

  checkends_u = isempty(find(crossing > b(i) ));
  checkends_l = isempty(find(crossing < b(i) ));

  if checkends_l 

  fwhm(j) = crossing(min(find(crossing > b(i)))) + numel(vec) - max( find(vec < a(i).*0.5) ) +0.5;

  elseif checkends_u

  fwhm(j) = min( find(vec < a(i).*0.5) ) - 0.5 + numel(vec) - crossing(max(find(crossing < b(i))));

  else

  fwhm(j) = crossing(min(find(crossing > b(i)))) - crossing(max(find(crossing < b(i))));

  end

end

end


