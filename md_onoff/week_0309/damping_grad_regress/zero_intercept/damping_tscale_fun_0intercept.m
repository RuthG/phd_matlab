%take in 2 data series: t' and some htrt', and calculate the squared distance from a line fit described with m and c

function sqdiff = damping_tscale_fun(m,tser,htrtser);

%y = mx   x = y/m

htrt_pred = m(1).*tser;
t_pred = htrtser./m(1);

sqdiff = sum( (htrtser - htrt_pred).^2 + (tser - t_pred).^2 );
