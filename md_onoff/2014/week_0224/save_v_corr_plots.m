load('v_correlation_wvoff.mat')

vhcovar_off = vhcovar;
vlcovar_off = vlcovar; 
vvthcovar_off = vvthcovar;
b1_off = b1;
b2_off = b2;
b3_off = b3;

load('v_correlation_wvon.mat')

vhcovar_on = vhcovar;
vlcovar_on = vlcovar; 
vvthcovar_on = vvthcovar;
b1_on = b1;
b2_on = b2;
b3_on = b3;

load('v_correlation_wvhf.mat')

vhcovar_h = vhcovar;
vlcovar_h = vlcovar; 
vvthcovar_h = vvthcovar;
b1_h = b1;
b2_h = b2;
b3_h = b3;

v=-16:2:16;
figure
[C,h] = contourf(b1_off',v);
colorbar
figure
[C,h] = contourf(b1_on',v);
colorbar
figure
[C,h] = contourf(b1_h',v);
colorbar

figure
[C,h] = contourf(b2_off',v);
colorbar
figure
[C,h] = contourf(b2_on',v);
colorbar
figure
[C,h] = contourf(b2_h',v);
colorbar

figure
[C,h] = contourf(b3_off');
colorbar
figure
[C,h] = contourf(b3_on');
colorbar
figure
[C,h] = contourf(b3_h');
colorbar
