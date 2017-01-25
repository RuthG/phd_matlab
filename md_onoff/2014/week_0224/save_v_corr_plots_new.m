load('v_correlation_new_off.mat')

b1_off = b1;
b2_off = b2;
b3_off = b3;

load('v_correlation_new_on.mat')

b1_on = b1;
b2_on = b2;
b3_on = b3;

load('v_correlation_new_on_p.mat')

b1_onp = b1;
b2_onp = b2;
b3_onp = b3;

load('v_correlation_new_off_p.mat')

b1_offp = b1;
b2_offp = b2;
b3_offp = b3;


load('v_correlation_new_hf.mat')

b1_h = b1;
b2_h = b2;
b3_h = b3;

v=-16:2:16;
figure
[C,h] = contour(xi(40:141),yi(46:90),b1_off(40:141,46:90)',v,'k');
clabel(C,h);
xlabel('Longitude')
ylabel('Latitude')
title('260 v`, Dry')
print('-dpng','260vdry.png')

figure
[C,h] = contour(xi(40:141),yi(46:90),b1_on(40:141,46:90)',v,'k');
clabel(C,h);
xlabel('Longitude')
ylabel('Latitude')
title('260 v`, Wet')
print('-dpng','260vwet.png')

figure
[C,h] = contour(xi(40:141),yi(46:90),b1_h(40:141,46:90)',v,'k');
clabel(C,h);
xlabel('Longitude')
ylabel('Latitude')
title('260 v`, Half')
print('-dpng','260vhalf.png')

figure
[C,h] = contour(xi(40:141),yi(46:90),b1_onp(40:141,46:90)',v,'k');
clabel(C,h);
xlabel('Longitude')
ylabel('Latitude')
title('260 v`, Wet, pert')
print('-dpng','260vwet_pert.png')

figure
[C,h] = contour(xi(40:141),yi(46:90),b1_offp(40:141,46:90)',v,'k');
clabel(C,h);
xlabel('Longitude')
ylabel('Latitude')
title('260 v`, Dry, pert')
print('-dpng','260vdry_pert.png')

figure
[C,h] = contour(xi(40:141),yi(46:90),b2_off(40:141,46:90)',v,'k');
clabel(C,h);
xlabel('Longitude')
ylabel('Latitude')
title('860 v`, Dry')
print('-dpng','860vdry.png')

figure
[C,h] = contour(xi(40:141),yi(46:90),b2_on(40:141,46:90)',v,'k');
clabel(C,h);
xlabel('Longitude')
ylabel('Latitude')
title('860 v`, Wet')
print('-dpng','860vwet.png')

figure
[C,h] = contour(xi(40:141),yi(46:90),b2_h(40:141,46:90)',v,'k');
clabel(C,h);
xlabel('Longitude')
ylabel('Latitude')
title('860 v`, Half')
print('-dpng','860vhalf.png')

figure
[C,h] = contour(xi(40:141),yi(46:90),b2_onp(40:141,46:90)',v,'k');
clabel(C,h);
xlabel('Longitude')
ylabel('Latitude')
title('860 v`, Wet, pert')
print('-dpng','860vwet_pert.png')

figure
[C,h] = contour(xi(40:141),yi(46:90),b2_offp(40:141,46:90)',v,'k');
clabel(C,h);
xlabel('Longitude')
ylabel('Latitude')
title('860 v`, Dry, pert')
print('-dpng','860vdry_pert.png')

figure
v=-1500:250:1500;
[C,h] = contour(xi(40:141),yi(46:90),b3_off(40:141,46:90)',v,'k');
clabel(C,h);
xlabel('Longitude')
ylabel('Latitude')
title('860 v`th`, Dry')
print('-dpng','860vtdry.png')

figure
[C,h] = contour(xi(40:141),yi(46:90),b3_on(40:141,46:90)',v,'k');
clabel(C,h);
xlabel('Longitude')
ylabel('Latitude')
title('860 v`th`, Wet')
print('-dpng','860vtwet.png')

figure
[C,h] = contour(xi(40:141),yi(46:90),b3_h(40:141,46:90)',v,'k');
clabel(C,h);
xlabel('Longitude')
ylabel('Latitude')
title('860 v`th`, Half')
print('-dpng','860vthalf.png')

figure
[C,h] = contour(xi(40:141),yi(46:90),b3_onp(40:141,46:90)',v,'k');
clabel(C,h);
xlabel('Longitude')
ylabel('Latitude')
title('860 v`th`, Wet, pert')
print('-dpng','860vtwet_pert.png')

figure
[C,h] = contour(xi(40:141),yi(46:90),b3_offp(40:141,46:90)',v,'k');
clabel(C,h);
xlabel('Longitude')
ylabel('Latitude')
title('860 v`th`, Dry, pert')
print('-dpng','860vtdry_pert.png')

close all
