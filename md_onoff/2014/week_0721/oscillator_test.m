%oscillator_test

%load up daily data for a year and see if we can figure out the oscillator style thing

% choose directory, load grid
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_1yeardaily_c/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
ny=90;

%read files
i=0;
for nit = 605040:240:691200;
i=i+1

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_1yeardaily_c/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
ucs_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_w(:,:,:,i)=dyn(:,:,:,J);
[uE_w(:,:,:,i),vN_w(:,:,:,i)] = rotate_uv2uvEN(ucs_w(:,:,:,i),vcs_w(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'UVELTH  '));
utcs_w(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vtcs_w(:,:,:,i)=dyn(:,:,:,J);
[uEth_w(:,:,:,i),vNth_w(:,:,:,i)] = rotate_uv2uvEN(utcs_w(:,:,:,i),vtcs_w(:,:,:,i),AngleCS,AngleSN,Grid);


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_halfwv_daily/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'UVEL    '));
ucs_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_h(:,:,:,i)=dyn(:,:,:,J);
[uE_h(:,:,:,i),vN_h(:,:,:,i)] = rotate_uv2uvEN(ucs_h(:,:,:,i),vcs_h(:,:,:,i),AngleCS,AngleSN,Grid);
J=find(strcmp(fldList,'UVELTH  '));
utcs_h(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELTH  '));
vtcs_h(:,:,:,i)=dyn(:,:,:,J);
[uEth_h(:,:,:,i),vNth_h(:,:,:,i)] = rotate_uv2uvEN(utcs_h(:,:,:,i),vtcs_h(:,:,:,i),AngleCS,AngleSN,Grid);

end

%transform to latlon grid

xi=-179:2:180;yi=-89:2:90;
vNthll_w=cube2latlon(xc,yc,vNth_w,xi,yi);
uEll_w=cube2latlon(xc,yc,uE_w,xi,yi);
vNll_w=cube2latlon(xc,yc,vN_w,xi,yi);
thetall_w=cube2latlon(xc,yc,theta_w,xi,yi);

vNthll_h=cube2latlon(xc,yc,vNth_h,xi,yi);
uEll_h=cube2latlon(xc,yc,uE_h,xi,yi);
vNll_h=cube2latlon(xc,yc,vN_h,xi,yi);
thetall_h=cube2latlon(xc,yc,theta_h,xi,yi);

thetall_w_zav(:,:,:) = mean(thetall_w,1);
vNll_w_zav(:,:,:) = mean(vNll_w,1);
vNthll_w_zav(:,:,:) = mean(vNthll_w,1);

thetall_h_zav(:,:,:) = mean(thetall_h,1);
vNll_h_zav(:,:,:) = mean(vNll_h,1);
vNthll_h_zav(:,:,:) = mean(vNthll_h,1);

thetall_w_tzav(:,:) = mean(thetall_w_zav,3);
vNll_w_tzav(:,:) = mean(vNll_w_zav,3);
vNthll_w_tzav(:,:) = mean(vNthll_w_zav,3);
vNthll_w_ed_tzav = vNthll_w_tzav - thetall_w_tzav.*vNll_w_tzav;

thetall_h_tzav(:,:) = mean(thetall_h_zav,3);
vNll_h_tzav(:,:) = mean(vNll_h_zav,3);
vNthll_h_tzav(:,:) = mean(vNthll_h_zav,3);
vNthll_h_ed_tzav = vNthll_h_tzav - thetall_h_tzav.*vNll_h_tzav;

vNthll_w_zon = zeros(180,90,25,360);
vNthll_h_zon = zeros(180,90,25,360);
for i=1:90
for j=1:25
vNthll_w_zon(:,i,j,:) = thetall_w_tzav(i,j).*vNll_w_tzav(i,j);
vNthll_h_zon(:,i,j,:) = thetall_h_tzav(i,j).*vNll_h_tzav(i,j);
end
end

vNthll_w_zon_mean(:,:) = mean(mean(vNthll_w_zon,4),1);
vNthll_h_zon_mean(:,:) = mean(mean(vNthll_h_zon,4),1);

% vNthll_ed to use for eddy heat flux diag!
vNthll_w_ed = vNthll_w - vNthll_w_zon;
vNthll_w_ed_mean(:,:) = mean(mean(vNthll_w_ed,4),1);
vNthll_h_ed = vNthll_h - vNthll_h_zon;
vNthll_h_ed_mean(:,:) = mean(mean(vNthll_h_ed,4),1);

%now want to calculate s (baroclinicity). Need: f, N, dudZ

f=zeros(180,90,25,360);
omega = 2.*pi./24./60./60;
rd = 287;
g=9.81;
for i=1:90
f(:,i,:,:) = 2.*omega.*sin(yi(i).*pi./180);
end

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
tll_w(:,:,j,:)=thetall_w(:,:,j,:).*convthetatoT(j,1);
tll_h(:,:,j,:)=thetall_h(:,:,j,:).*convthetatoT(j,1);
end

for k=1:25
rholl_w(:,:,k,:) = rC(k)./(rd.*tll_w(:,:,k,:));
rholl_h(:,:,k,:) = rC(k)./(rd.*tll_h(:,:,k,:));
end

%take vertical derivatives...

[no,mo,dudp_w,oo] = gradient(uEll_w,-4000);
[no,mo,dlnthetadp_w,oo] = gradient(log(thetall_w),-4000);
[no,mo,dthetadp_w,oo] = gradient(thetall_w,-4000);

[no,mo,dudp_h,oo] = gradient(uEll_h,-4000);
[no,mo,dlnthetadp_h,oo] = gradient(log(thetall_h),-4000);
[no,mo,dthetadp_h,oo] = gradient(thetall_h,-4000);

for k=1:25
dudZ_w(:,:,k,:) = -rholl_w(:,:,k,:).*dudp_w(:,:,k,:);
dlnthetadZ_w(:,:,k,:) = -rholl_w(:,:,k,:).*dlnthetadp_w(:,:,k,:);
dthetadZ_w(:,:,k,:) = -rholl_w(:,:,k,:).*dthetadp_w(:,:,k,:);

dudZ_h(:,:,k,:) = -rholl_h(:,:,k,:).*dudp_h(:,:,k,:);
dlnthetadZ_h(:,:,k,:) = -rholl_h(:,:,k,:).*dlnthetadp_h(:,:,k,:);
dthetadZ_h(:,:,k,:) = -rholl_h(:,:,k,:).*dthetadp_h(:,:,k,:);
end

N_w = sqrt(g.*dlnthetadZ_w);
%N_alt = sqrt(g.*dthetadZ./thetall);
s_w = 0.31.*f./N_w.*dudZ_w;
N_h = sqrt(g.*dlnthetadZ_h);
%N_alt = sqrt(g.*dthetadZ./thetall);
s_h = 0.31.*f./N_h.*dudZ_h;

%N_mean(:,:) = mean(mean(N,4),1);
%N_alt_mean(:,:) = mean(mean(N_alt,4),1);
s_w_mean(:,:) = mean(mean(s_w,4),1);
dudZ_w_mean(:,:) = mean(mean(dudZ_w,4),1);
uE_w_mean(:,:) = mean(mean(uEll_w,4),1);
s_h_mean(:,:) = mean(mean(s_h,4),1);
dudZ_h_mean(:,:) = mean(mean(dudZ_h,4),1);
uE_h_mean(:,:) = mean(mean(uEll_h,4),1);


%average over region 30-50N and a 50 degree lon band
%first need to weight by costheta

cosphi = zeros(180,90,25,360);
for i=1:90
cosphi(:,i,:,:) = cos(yi(i).*pi./180);
end

s_w_weight = s_w.*cosphi;
vNthll_w_ed_weight = vNthll_w_ed.*cosphi;
s_h_weight = s_h.*cosphi;
vNthll_h_ed_weight = vNthll_h_ed.*cosphi;

%integrate!
%lon first
s_w_int_lon(:,:,:) = sum(s_w_weight(1:25,:,:,:),1).*pi./90;
vNthll_w_ed_int_lon(:,:,:) = sum(vNthll_w_ed_weight(1:25,:,:,:),1).*pi./90;
s_h_int_lon(:,:,:) = sum(s_h_weight(1:25,:,:,:),1).*pi./90;
vNthll_h_ed_int_lon(:,:,:) = sum(vNthll_h_ed_weight(1:25,:,:,:),1).*pi./90;
cosphi_int_lon(:,:,:) = sum(cosphi(1:25,:,:,:),1);

%now lat!
s_w_int_lat(:,:) = sum(s_w_int_lon(61:76,:,:),1).*pi./90;
vNthll_w_ed_int_lat(:,:) = sum(vNthll_w_ed_int_lon(61:76,:,:),1).*pi./90;
s_h_int_lat(:,:) = sum(s_h_int_lon(61:76,:,:),1).*pi./90;
vNthll_h_ed_int_lat(:,:) = sum(vNthll_h_ed_int_lon(61:76,:,:),1).*pi./90;
cosphi_int_lat(:,:) = sum(cosphi_int_lon(61:76,:,:),1).*pi./90;

%now take av

s_w_int = s_w_int_lat./cosphi_int_lat;
vNthll_w_ed_int = vNthll_w_ed_int_lat./cosphi_int_lat;

vNthll_w_ed_av = sum(vNthll_w_ed_int(2:8,:),1).*4000./g;

s_h_int = s_h_int_lat./cosphi_int_lat;
vNthll_h_ed_int = vNthll_h_ed_int_lat./cosphi_int_lat;

vNthll_h_ed_av = sum(vNthll_h_ed_int(2:8,:),1).*4000./g;



%now try taking ten day averages?

for i=1:36

vNthll_w_ed_tav(i) = mean(vNthll_w_ed_av((i-1).*10 +1 : i.*10));
vNthll_h_ed_tav(i) = mean(vNthll_h_ed_av((i-1).*10 +1 : i.*10));

s_w_int_tav(i) = mean(s_w_int(6,(i-1).*10 +1 : i.*10));
s_h_int_tav(i) = mean(s_h_int(6,(i-1).*10 +1 : i.*10));

end


%ok... try running mean!

for i=1:351

vNthll_w_ed_rm(i) = mean(vNthll_w_ed_av(i:i+9));
vNthll_h_ed_rm(i) = mean(vNthll_h_ed_av(i:i+9));

s_w_int_rm(i) = mean(s_w_int(6,i:i+9));
s_h_int_rm(i) = mean(s_h_int(6,i:i+9));

end

s_w_int_fft = fft(real(s_w_int(6,:)));
s_h_int_fft = fft(real(s_h_int(6,:)));
vNthll_w_ed_fft = fft(real(vNthll_w_ed_av));
vNthll_h_ed_fft = fft(real(vNthll_h_ed_av));


figure

plot(vNthll_w_ed_av,s_w_int(6,:));
xlabel('Eddy heat flux');
ylabel('Baroclinicity');
title('1xwv, daily means');
print('-dpng','osc_wet.png');

figure

plot(vNthll_h_ed_av,s_h_int(6,:));
xlabel('Eddy heat flux');
ylabel('Baroclinicity');
title('0.5xwv, daily means');
print('-dpng','osc_half.png');

figure

plot(vNthll_w_ed_tav,s_w_int_tav);
xlabel('Eddy heat flux');
ylabel('Baroclinicity');
title('1xwv, ten day means');
print('-dpng','osc_wet_tav.png');

figure

plot(vNthll_h_ed_tav,s_h_int_tav);
xlabel('Eddy heat flux');
ylabel('Baroclinicity');
title('0.5xwv, ten day means');
print('-dpng','osc_half_tav.png');

figure

plot(vNthll_w_ed_rm,s_w_int_rm);
xlabel('Eddy heat flux');
ylabel('Baroclinicity');
title('1xwv, ten day running means');
print('-dpng','osc_wet_rm.png');

figure

plot(vNthll_h_ed_rm,s_h_int_rm);
xlabel('Eddy heat flux');
ylabel('Baroclinicity');
title('0.5xwv, ten day running means');
print('-dpng','osc_half_rm.png');

figure
plot(vNthll_w_ed_rm);
hold on
plot(vNthll_h_ed_rm,'r');
xlabel('Time, days');
ylabel('Eddy heat flux');
title('Eddy heat flux time series, running means');
legend('Wet','Half');
print('-dpng','vt.png');


figure
plot(real(s_w_int_rm));
hold on
plot(real(s_h_int_rm),'r');
xlabel('Time, days');
ylabel('Baroclinicity');
title('Baroclinicity time series, running means');
legend('Wet','Half');
print('-dpng','s.png');

figure
plot(real(s_w_int_fft));
hold on
plot(real(s_h_int_fft),'r');
legend('Wet','Half');
title('s ft')
print('-dpng','sfft.png');


figure
plot(real(vNthll_w_ed_fft));
hold on
plot(real(vNthll_h_ed_fft),'r');
legend('Wet','Half');
title('vtheta ft')
print('-dpng','vtfft.png');

return

