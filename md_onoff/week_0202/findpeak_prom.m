%self written function to locate prominent peaks

function [mag,loc] = findpeak_prom(vec,prom);

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


if prom_r >= prom & prom_l >= prom
  j=j+1;
  mag(j) = a(i);
  loc(j) = b(i);
end

end


