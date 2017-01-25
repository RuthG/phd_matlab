%load in snapshots of temperature and relative vorticity. 
%calculate the magnitiude of the temperature gradient and multiply with vorticity, see if we see fronts..

load('/project/rg312/mat_files/snapshot_data/t_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/uE_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/vN_snapshots.mat')
load('/project/rg312/mat_files/snapshot_data/w_snapshots.mat')
load('/project/rg312/mat_files/vorticity_data.mat')


%transfer t to ll
xi=-179:2:180;yi=-89:2:90;

w_000_ll = cube2latlon(xc,yc,w_000(:,:,:,360),xi,yi);
w_010_ll = cube2latlon(xc,yc,w_010(:,:,:,360),xi,yi);
w_025_ll = cube2latlon(xc,yc,w_025(:,:,:,360),xi,yi);
w_050_ll = cube2latlon(xc,yc,w_050(:,:,:,360),xi,yi);
w_075_ll = cube2latlon(xc,yc,w_075(:,:,:,360),xi,yi);
w_100_ll = cube2latlon(xc,yc,w_100(:,:,:,360),xi,yi);

w_ed_000_ll = cube2latlon(xc,yc,w_000(:,:,:,360),xi,yi) - cube2latlon(xc,yc,mean(w_000,4),xi,yi);
w_ed_010_ll = cube2latlon(xc,yc,w_010(:,:,:,360),xi,yi) - cube2latlon(xc,yc,mean(w_010,4),xi,yi);
w_ed_025_ll = cube2latlon(xc,yc,w_025(:,:,:,360),xi,yi) - cube2latlon(xc,yc,mean(w_025,4),xi,yi);
w_ed_050_ll = cube2latlon(xc,yc,w_050(:,:,:,360),xi,yi) - cube2latlon(xc,yc,mean(w_050,4),xi,yi);
w_ed_075_ll = cube2latlon(xc,yc,w_075(:,:,:,360),xi,yi) - cube2latlon(xc,yc,mean(w_075,4),xi,yi);
w_ed_100_ll = cube2latlon(xc,yc,w_100(:,:,:,360),xi,yi) - cube2latlon(xc,yc,mean(w_100,4),xi,yi);
clear('w_000','w_010','w_025','w_050','w_075','w_100')

t_000_ll = cube2latlon(xc,yc,t_000(:,:,:,360),xi,yi);
t_010_ll = cube2latlon(xc,yc,t_010(:,:,:,360),xi,yi);
t_025_ll = cube2latlon(xc,yc,t_025(:,:,:,360),xi,yi);
t_050_ll = cube2latlon(xc,yc,t_050(:,:,:,360),xi,yi);
t_075_ll = cube2latlon(xc,yc,t_075(:,:,:,360),xi,yi);
t_100_ll = cube2latlon(xc,yc,t_100(:,:,:,360),xi,yi);

t_ed_000_ll = cube2latlon(xc,yc,t_000(:,:,:,360),xi,yi) - cube2latlon(xc,yc,mean(t_000,4),xi,yi);
t_ed_010_ll = cube2latlon(xc,yc,t_010(:,:,:,360),xi,yi) - cube2latlon(xc,yc,mean(t_010,4),xi,yi);
t_ed_025_ll = cube2latlon(xc,yc,t_025(:,:,:,360),xi,yi) - cube2latlon(xc,yc,mean(t_025,4),xi,yi);
t_ed_050_ll = cube2latlon(xc,yc,t_050(:,:,:,360),xi,yi) - cube2latlon(xc,yc,mean(t_050,4),xi,yi);
t_ed_075_ll = cube2latlon(xc,yc,t_075(:,:,:,360),xi,yi) - cube2latlon(xc,yc,mean(t_075,4),xi,yi);
t_ed_100_ll = cube2latlon(xc,yc,t_100(:,:,:,360),xi,yi) - cube2latlon(xc,yc,mean(t_100,4),xi,yi);
clear('t_000','t_010','t_025','t_050','t_075','t_100')

uE_000_ll = cube2latlon(xc,yc,uE_000(:,:,:,360),xi,yi);
uE_010_ll = cube2latlon(xc,yc,uE_010(:,:,:,360),xi,yi);
uE_025_ll = cube2latlon(xc,yc,uE_025(:,:,:,360),xi,yi);
uE_050_ll = cube2latlon(xc,yc,uE_050(:,:,:,360),xi,yi);
uE_075_ll = cube2latlon(xc,yc,uE_075(:,:,:,360),xi,yi);
uE_100_ll = cube2latlon(xc,yc,uE_100(:,:,:,360),xi,yi);

uE_ed_000_ll = cube2latlon(xc,yc,uE_000(:,:,:,360),xi,yi) - cube2latlon(xc,yc,mean(uE_000,4),xi,yi);
uE_ed_010_ll = cube2latlon(xc,yc,uE_010(:,:,:,360),xi,yi) - cube2latlon(xc,yc,mean(uE_010,4),xi,yi);
uE_ed_025_ll = cube2latlon(xc,yc,uE_025(:,:,:,360),xi,yi) - cube2latlon(xc,yc,mean(uE_025,4),xi,yi);
uE_ed_050_ll = cube2latlon(xc,yc,uE_050(:,:,:,360),xi,yi) - cube2latlon(xc,yc,mean(uE_050,4),xi,yi);
uE_ed_075_ll = cube2latlon(xc,yc,uE_075(:,:,:,360),xi,yi) - cube2latlon(xc,yc,mean(uE_075,4),xi,yi);
uE_ed_100_ll = cube2latlon(xc,yc,uE_100(:,:,:,360),xi,yi) - cube2latlon(xc,yc,mean(uE_100,4),xi,yi);
clear('uE_000','uE_010','uE_025','uE_050','uE_075','uE_100')

vN_000_ll = cube2latlon(xc,yc,vN_000(:,:,:,360),xi,yi);
vN_010_ll = cube2latlon(xc,yc,vN_010(:,:,:,360),xi,yi);
vN_025_ll = cube2latlon(xc,yc,vN_025(:,:,:,360),xi,yi);
vN_050_ll = cube2latlon(xc,yc,vN_050(:,:,:,360),xi,yi);
vN_075_ll = cube2latlon(xc,yc,vN_075(:,:,:,360),xi,yi);
vN_100_ll = cube2latlon(xc,yc,vN_100(:,:,:,360),xi,yi);

vN_ed_000_ll = cube2latlon(xc,yc,vN_000(:,:,:,360),xi,yi) - cube2latlon(xc,yc,mean(vN_000,4),xi,yi);
vN_ed_010_ll = cube2latlon(xc,yc,vN_010(:,:,:,360),xi,yi) - cube2latlon(xc,yc,mean(vN_010,4),xi,yi);
vN_ed_025_ll = cube2latlon(xc,yc,vN_025(:,:,:,360),xi,yi) - cube2latlon(xc,yc,mean(vN_025,4),xi,yi);
vN_ed_050_ll = cube2latlon(xc,yc,vN_050(:,:,:,360),xi,yi) - cube2latlon(xc,yc,mean(vN_050,4),xi,yi);
vN_ed_075_ll = cube2latlon(xc,yc,vN_075(:,:,:,360),xi,yi) - cube2latlon(xc,yc,mean(vN_075,4),xi,yi);
vN_ed_100_ll = cube2latlon(xc,yc,vN_100(:,:,:,360),xi,yi) - cube2latlon(xc,yc,mean(vN_100,4),xi,yi);
clear('vN_000','vN_010','vN_025','vN_050','vN_075','vN_100')

vort_000_ll = cube2latlon(xg,yg,vort_000(:,:,:,360),xi,yi);
vort_010_ll = cube2latlon(xg,yg,vort_010(:,:,:,360),xi,yi);
vort_025_ll = cube2latlon(xg,yg,vort_025(:,:,:,360),xi,yi);
vort_050_ll = cube2latlon(xg,yg,vort_050(:,:,:,360),xi,yi);
vort_075_ll = cube2latlon(xg,yg,vort_075(:,:,:,360),xi,yi);
vort_100_ll = cube2latlon(xg,yg,vort_100(:,:,:,360),xi,yi);
clear('vort_000','vort_010','vort_025','vort_050','vort_075','vort_100')

uEt_ed_000_ll = uE_ed_000_ll.*t_ed_000_ll;
uEt_ed_010_ll = uE_ed_010_ll.*t_ed_010_ll;
uEt_ed_025_ll = uE_ed_025_ll.*t_ed_025_ll;
uEt_ed_050_ll = uE_ed_050_ll.*t_ed_050_ll;
uEt_ed_075_ll = uE_ed_075_ll.*t_ed_075_ll;
uEt_ed_100_ll = uE_ed_100_ll.*t_ed_100_ll;

vNt_ed_000_ll = vN_ed_000_ll.*t_ed_000_ll;
vNt_ed_010_ll = vN_ed_010_ll.*t_ed_010_ll;
vNt_ed_025_ll = vN_ed_025_ll.*t_ed_025_ll;
vNt_ed_050_ll = vN_ed_050_ll.*t_ed_050_ll;
vNt_ed_075_ll = vN_ed_075_ll.*t_ed_075_ll;
vNt_ed_100_ll = vN_ed_100_ll.*t_ed_100_ll;

wt_ed_000_ll = w_ed_000_ll.*t_ed_000_ll;
wt_ed_010_ll = w_ed_010_ll.*t_ed_010_ll;
wt_ed_025_ll = w_ed_025_ll.*t_ed_025_ll;
wt_ed_050_ll = w_ed_050_ll.*t_ed_050_ll;
wt_ed_075_ll = w_ed_075_ll.*t_ed_075_ll;
wt_ed_100_ll = w_ed_100_ll.*t_ed_100_ll;

convtheta(1,1,:)=(rC/101325.0).^(2./7.);
convthetatoT=repmat(convtheta,[180,90,1]);

load('/project/rg312/mat_files/heat_rates.mat')
htrt_000_ll = cube2latlon(xc,yc,htrt_000(:,:,:,360),xi,yi).*86400.*convthetatoT;
htrt_010_ll = cube2latlon(xc,yc,htrt_010(:,:,:,360),xi,yi).*86400.*convthetatoT;
htrt_025_ll = cube2latlon(xc,yc,htrt_025(:,:,:,360),xi,yi).*86400.*convthetatoT;
htrt_050_ll = cube2latlon(xc,yc,htrt_050(:,:,:,360),xi,yi).*86400.*convthetatoT;
htrt_075_ll = cube2latlon(xc,yc,htrt_075(:,:,:,360),xi,yi).*86400.*convthetatoT;
htrt_100_ll = cube2latlon(xc,yc,htrt_100(:,:,:,360),xi,yi).*86400.*convthetatoT;

htrt_000_ll_tav = cube2latlon(xc,yc,mean(htrt_000,4),xi,yi).*86400.*convthetatoT;
htrt_010_ll_tav = cube2latlon(xc,yc,mean(htrt_010,4),xi,yi).*86400.*convthetatoT;
htrt_025_ll_tav = cube2latlon(xc,yc,mean(htrt_025,4),xi,yi).*86400.*convthetatoT;
htrt_050_ll_tav = cube2latlon(xc,yc,mean(htrt_050,4),xi,yi).*86400.*convthetatoT;
htrt_075_ll_tav = cube2latlon(xc,yc,mean(htrt_075,4),xi,yi).*86400.*convthetatoT;
htrt_100_ll_tav = cube2latlon(xc,yc,mean(htrt_100,4),xi,yi).*86400.*convthetatoT;

htrt_ed_000_ll = htrt_000_ll - htrt_000_ll_tav;
htrt_ed_010_ll = htrt_010_ll - htrt_010_ll_tav;
htrt_ed_025_ll = htrt_025_ll - htrt_025_ll_tav;
htrt_ed_050_ll = htrt_050_ll - htrt_050_ll_tav;
htrt_ed_075_ll = htrt_075_ll - htrt_075_ll_tav;
htrt_ed_100_ll = htrt_100_ll - htrt_100_ll_tav;

clear('htrt_000','htrt_010','htrt_025','htrt_050','htrt_075','htrt_100')

radht_000_ll = cube2latlon(xc,yc,radht_000(:,:,:,360),xi,yi).*86400.*convthetatoT;
radht_010_ll = cube2latlon(xc,yc,radht_010(:,:,:,360),xi,yi).*86400.*convthetatoT;
radht_025_ll = cube2latlon(xc,yc,radht_025(:,:,:,360),xi,yi).*86400.*convthetatoT;
radht_050_ll = cube2latlon(xc,yc,radht_050(:,:,:,360),xi,yi).*86400.*convthetatoT;
radht_075_ll = cube2latlon(xc,yc,radht_075(:,:,:,360),xi,yi).*86400.*convthetatoT;
radht_100_ll = cube2latlon(xc,yc,radht_100(:,:,:,360),xi,yi).*86400.*convthetatoT;

radht_000_ll_tav = cube2latlon(xc,yc,mean(radht_000,4),xi,yi).*86400.*convthetatoT;
radht_010_ll_tav = cube2latlon(xc,yc,mean(radht_010,4),xi,yi).*86400.*convthetatoT;
radht_025_ll_tav = cube2latlon(xc,yc,mean(radht_025,4),xi,yi).*86400.*convthetatoT;
radht_050_ll_tav = cube2latlon(xc,yc,mean(radht_050,4),xi,yi).*86400.*convthetatoT;
radht_075_ll_tav = cube2latlon(xc,yc,mean(radht_075,4),xi,yi).*86400.*convthetatoT;
radht_100_ll_tav = cube2latlon(xc,yc,mean(radht_100,4),xi,yi).*86400.*convthetatoT;

radht_ed_000_ll = radht_000_ll - radht_000_ll_tav;
radht_ed_010_ll = radht_010_ll - radht_010_ll_tav;
radht_ed_025_ll = radht_025_ll - radht_025_ll_tav;
radht_ed_050_ll = radht_050_ll - radht_050_ll_tav;
radht_ed_075_ll = radht_075_ll - radht_075_ll_tav;
radht_ed_100_ll = radht_100_ll - radht_100_ll_tav;

clear('radht_000','radht_010','radht_025','radht_050','radht_075','radht_100')


difht_000_ll = cube2latlon(xc,yc,difht_000(:,:,:,360),xi,yi).*86400.*convthetatoT;
difht_010_ll = cube2latlon(xc,yc,difht_010(:,:,:,360),xi,yi).*86400.*convthetatoT;
difht_025_ll = cube2latlon(xc,yc,difht_025(:,:,:,360),xi,yi).*86400.*convthetatoT;
difht_050_ll = cube2latlon(xc,yc,difht_050(:,:,:,360),xi,yi).*86400.*convthetatoT;
difht_075_ll = cube2latlon(xc,yc,difht_075(:,:,:,360),xi,yi).*86400.*convthetatoT;
difht_100_ll = cube2latlon(xc,yc,difht_100(:,:,:,360),xi,yi).*86400.*convthetatoT;

difht_000_ll_tav = cube2latlon(xc,yc,mean(difht_000,4),xi,yi).*86400.*convthetatoT;
difht_010_ll_tav = cube2latlon(xc,yc,mean(difht_010,4),xi,yi).*86400.*convthetatoT;
difht_025_ll_tav = cube2latlon(xc,yc,mean(difht_025,4),xi,yi).*86400.*convthetatoT;
difht_050_ll_tav = cube2latlon(xc,yc,mean(difht_050,4),xi,yi).*86400.*convthetatoT;
difht_075_ll_tav = cube2latlon(xc,yc,mean(difht_075,4),xi,yi).*86400.*convthetatoT;
difht_100_ll_tav = cube2latlon(xc,yc,mean(difht_100,4),xi,yi).*86400.*convthetatoT;

difht_ed_000_ll = difht_000_ll - difht_000_ll_tav;
difht_ed_010_ll = difht_010_ll - difht_010_ll_tav;
difht_ed_025_ll = difht_025_ll - difht_025_ll_tav;
difht_ed_050_ll = difht_050_ll - difht_050_ll_tav;
difht_ed_075_ll = difht_075_ll - difht_075_ll_tav;
difht_ed_100_ll = difht_100_ll - difht_100_ll_tav;

clear('difht_000','difht_010','difht_025','difht_050','difht_075','difht_100')

cnvht_000_ll = cube2latlon(xc,yc,cnvht_000(:,:,:,360),xi,yi).*86400.*convthetatoT;
cnvht_010_ll = cube2latlon(xc,yc,cnvht_010(:,:,:,360),xi,yi).*86400.*convthetatoT;
cnvht_025_ll = cube2latlon(xc,yc,cnvht_025(:,:,:,360),xi,yi).*86400.*convthetatoT;
cnvht_050_ll = cube2latlon(xc,yc,cnvht_050(:,:,:,360),xi,yi).*86400.*convthetatoT;
cnvht_075_ll = cube2latlon(xc,yc,cnvht_075(:,:,:,360),xi,yi).*86400.*convthetatoT;
cnvht_100_ll = cube2latlon(xc,yc,cnvht_100(:,:,:,360),xi,yi).*86400.*convthetatoT;

cnvht_000_ll_tav = cube2latlon(xc,yc,mean(cnvht_000,4),xi,yi).*86400.*convthetatoT;
cnvht_010_ll_tav = cube2latlon(xc,yc,mean(cnvht_010,4),xi,yi).*86400.*convthetatoT;
cnvht_025_ll_tav = cube2latlon(xc,yc,mean(cnvht_025,4),xi,yi).*86400.*convthetatoT;
cnvht_050_ll_tav = cube2latlon(xc,yc,mean(cnvht_050,4),xi,yi).*86400.*convthetatoT;
cnvht_075_ll_tav = cube2latlon(xc,yc,mean(cnvht_075,4),xi,yi).*86400.*convthetatoT;
cnvht_100_ll_tav = cube2latlon(xc,yc,mean(cnvht_100,4),xi,yi).*86400.*convthetatoT;

cnvht_ed_000_ll = cnvht_000_ll - cnvht_000_ll_tav;
cnvht_ed_010_ll = cnvht_010_ll - cnvht_010_ll_tav;
cnvht_ed_025_ll = cnvht_025_ll - cnvht_025_ll_tav;
cnvht_ed_050_ll = cnvht_050_ll - cnvht_050_ll_tav;
cnvht_ed_075_ll = cnvht_075_ll - cnvht_075_ll_tav;
cnvht_ed_100_ll = cnvht_100_ll - cnvht_100_ll_tav;

clear('cnvht_000','cnvht_010','cnvht_025','cnvht_050','cnvht_075','cnvht_100')

cndht_000_ll = cube2latlon(xc,yc,cndht_000(:,:,:,360),xi,yi).*86400.*convthetatoT;
cndht_010_ll = cube2latlon(xc,yc,cndht_010(:,:,:,360),xi,yi).*86400.*convthetatoT;
cndht_025_ll = cube2latlon(xc,yc,cndht_025(:,:,:,360),xi,yi).*86400.*convthetatoT;
cndht_050_ll = cube2latlon(xc,yc,cndht_050(:,:,:,360),xi,yi).*86400.*convthetatoT;
cndht_075_ll = cube2latlon(xc,yc,cndht_075(:,:,:,360),xi,yi).*86400.*convthetatoT;
cndht_100_ll = cube2latlon(xc,yc,cndht_100(:,:,:,360),xi,yi).*86400.*convthetatoT;

cndht_000_ll_tav = cube2latlon(xc,yc,mean(cndht_000,4),xi,yi).*86400.*convthetatoT;
cndht_010_ll_tav = cube2latlon(xc,yc,mean(cndht_010,4),xi,yi).*86400.*convthetatoT;
cndht_025_ll_tav = cube2latlon(xc,yc,mean(cndht_025,4),xi,yi).*86400.*convthetatoT;
cndht_050_ll_tav = cube2latlon(xc,yc,mean(cndht_050,4),xi,yi).*86400.*convthetatoT;
cndht_075_ll_tav = cube2latlon(xc,yc,mean(cndht_075,4),xi,yi).*86400.*convthetatoT;
cndht_100_ll_tav = cube2latlon(xc,yc,mean(cndht_100,4),xi,yi).*86400.*convthetatoT;

cndht_ed_000_ll = cndht_000_ll - cndht_000_ll_tav;
cndht_ed_010_ll = cndht_010_ll - cndht_010_ll_tav;
cndht_ed_025_ll = cndht_025_ll - cndht_025_ll_tav;
cndht_ed_050_ll = cndht_050_ll - cndht_050_ll_tav;
cndht_ed_075_ll = cndht_075_ll - cndht_075_ll_tav;
cndht_ed_100_ll = cndht_100_ll - cndht_100_ll_tav;

clear('cndht_000','cndht_010','cndht_025','cndht_050','cndht_075','cndht_100')

radius = 6371.0e3;
omega = 2.*pi./24./60./60;
f = 10^-4; %2.*omega.*sin(yi.*pi./180);

[dTdy_000,dTdx_000] = gradient(t_000_ll,pi./90);
dTdy_000 = dTdy_000./radius;
[dTdy_010,dTdx_010] = gradient(t_010_ll,pi./90);
dTdy_010 = dTdy_010./radius;
[dTdy_025,dTdx_025] = gradient(t_025_ll,pi./90);
dTdy_025 = dTdy_025./radius;
[dTdy_050,dTdx_050] = gradient(t_050_ll,pi./90);
dTdy_050 = dTdy_050./radius;
[dTdy_075,dTdx_075] = gradient(t_075_ll,pi./90);
dTdy_075 = dTdy_075./radius;
[dTdy_100,dTdx_100] = gradient(t_100_ll,pi./90);
dTdy_100 = dTdy_100./radius;
for i=1:90
dTdx_000(:,i,:) = dTdx_000(:,i,:)./cos(yi(i).*pi./180)./radius;
u_cos_000(:,i,:) = uE_000_ll(:,i,:).*cos(yi(i).*pi./180);
dTdx_010(:,i,:) = dTdx_010(:,i,:)./cos(yi(i).*pi./180)./radius;
u_cos_010(:,i,:) = uE_010_ll(:,i,:).*cos(yi(i).*pi./180);
dTdx_025(:,i,:) = dTdx_025(:,i,:)./cos(yi(i).*pi./180)./radius;
u_cos_025(:,i,:) = uE_025_ll(:,i,:).*cos(yi(i).*pi./180);
dTdx_050(:,i,:) = dTdx_050(:,i,:)./cos(yi(i).*pi./180)./radius;
u_cos_050(:,i,:) = uE_050_ll(:,i,:).*cos(yi(i).*pi./180);
dTdx_075(:,i,:) = dTdx_075(:,i,:)./cos(yi(i).*pi./180)./radius;
u_cos_075(:,i,:) = uE_075_ll(:,i,:).*cos(yi(i).*pi./180);
dTdx_100(:,i,:) = dTdx_100(:,i,:)./cos(yi(i).*pi./180)./radius;
u_cos_100(:,i,:) = uE_100_ll(:,i,:).*cos(yi(i).*pi./180);
end

[a,dvdx_000] = gradient(vN_000_ll,pi./90);
dudy_cos_000 = gradient(u_cos_000,pi./90);
[a,dvdx_010] = gradient(vN_010_ll,pi./90);
dudy_cos_010 = gradient(u_cos_010,pi./90);
[a,dvdx_025] = gradient(vN_025_ll,pi./90);
dudy_cos_025 = gradient(u_cos_025,pi./90);
[a,dvdx_050] = gradient(vN_050_ll,pi./90);
dudy_cos_050 = gradient(u_cos_050,pi./90);
[a,dvdx_075] = gradient(vN_075_ll,pi./90);
dudy_cos_075 = gradient(u_cos_075,pi./90);
[a,dvdx_100] = gradient(vN_100_ll,pi./90);
dudy_cos_100 = gradient(u_cos_100,pi./90);

dTgrad_000 = sqrt(dTdy_000.^2 + dTdx_000.^2);
dTgrad_010 = sqrt(dTdy_010.^2 + dTdx_010.^2);
dTgrad_025 = sqrt(dTdy_025.^2 + dTdx_025.^2);
dTgrad_050 = sqrt(dTdy_050.^2 + dTdx_050.^2);
dTgrad_075 = sqrt(dTdy_075.^2 + dTdx_075.^2);
dTgrad_100 = sqrt(dTdy_100.^2 + dTdx_100.^2);

for i=1:90
if i<=45 
f=-10^-4;
else
f=10^-4;
end

dudy_000(:,i,:) = dudy_cos_000(:,i,:)./cos(yi(i).*pi./180);
arnaud_diag_000(:,i,:) = dTgrad_000(:,i,:).*vort_000_ll(:,i,:)./(f./100./1000);
%arnaud_diag_snap_000(:,i,:) = dTgrad_000(:,i,:).*vort_000_snap(:,i,:)./(f./100./1000);
dudy_010(:,i,:) = dudy_cos_010(:,i,:)./cos(yi(i).*pi./180);
arnaud_diag_010(:,i,:) = dTgrad_010(:,i,:).*vort_010_ll(:,i,:)./(f./100./1000);
%arnaud_diag_snap_010(:,i,:) = dTgrad_010(:,i,:).*vort_010_snap(:,i,:)./(f./100./1000);
dudy_025(:,i,:) = dudy_cos_025(:,i,:)./cos(yi(i).*pi./180);
arnaud_diag_025(:,i,:) = dTgrad_025(:,i,:).*vort_025_ll(:,i,:)./(f./100./1000);
%arnaud_diag_snap_025(:,i,:) = dTgrad_025(:,i,:).*vort_025_snap(:,i,:)./(f./100./1000);
dudy_050(:,i,:) = dudy_cos_050(:,i,:)./cos(yi(i).*pi./180);
arnaud_diag_050(:,i,:) = dTgrad_050(:,i,:).*vort_050_ll(:,i,:)./(f./100./1000);
%arnaud_diag_snap_050(:,i,:) = dTgrad_050(:,i,:).*vort_050_snap(:,i,:)./(f./100./1000);
dudy_075(:,i,:) = dudy_cos_075(:,i,:)./cos(yi(i).*pi./180);
arnaud_diag_075(:,i,:) = dTgrad_075(:,i,:).*vort_075_ll(:,i,:)./(f./100./1000);
%arnaud_diag_snap_075(:,i,:) = dTgrad_075(:,i,:).*vort_075_snap(:,i,:)./(f./100./1000);
dudy_100(:,i,:) = dudy_cos_100(:,i,:)./cos(yi(i).*pi./180);
arnaud_diag_100(:,i,:) = dTgrad_100(:,i,:).*vort_100_ll(:,i,:)./(f./100./1000);
%arnaud_diag_snap_100(:,i,:) = dTgrad_100(:,i,:).*vort_100_snap(:,i,:)./(f./100./1000);

end

save('/project/rg312/mat_files/front_diag.mat', 'arnaud_diag_000', 'arnaud_diag_010', 'arnaud_diag_025', 'arnaud_diag_050', 'arnaud_diag_075', 'arnaud_diag_100')

%return



figure
v=-12:2:12;
[C,h] = contourf(xi,yi,htrt_ed_000_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([-12 12]);
colorbar
title('Front diag, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','htrtfrontdiag_000.png')

figure
v=-12:2:12;
[C,h] = contourf(xi,yi,htrt_ed_010_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k');
caxis([-12 12]);
colorbar
title('Front diag, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','htrtfrontdiag_010.png')

figure
v=-12:2:12;
[C,h] = contourf(xi,yi,htrt_ed_025_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k');
caxis([-12 12]);
colorbar
title('Front diag, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','htrtfrontdiag_025.png')

figure
v=-12:2:12;
[C,h] = contourf(xi,yi,htrt_ed_050_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k');
caxis([-12 12]);
colorbar
title('Front diag, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','htrtfrontdiag_050.png')

figure
v=-12:2:12;
[C,h] = contourf(xi,yi,htrt_ed_075_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k');
caxis([-12 12]);
colorbar
title('Front diag, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','htrtfrontdiag_075.png')

figure
v=-12:2:12;
[C,h] = contourf(xi,yi,htrt_ed_100_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-12 12]);
colorbar
title('Front diag, 1.0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','htrtfrontdiag_100.png')






figure
v=-4:1:14;
[C,h] = contourf(xi,yi,cndht_ed_000_ll(:,:,5)'+cnvht_ed_000_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([-4 14]);
colorbar
title('Front diag, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','lathtfrontdiag_000.png')

figure
v=-4:1:14;
[C,h] = contourf(xi,yi,cndht_ed_010_ll(:,:,5)'+cnvht_ed_010_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k');
caxis([-4 14]);
colorbar
title('Front diag, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','lathtfrontdiag_010.png')

figure
v=-4:1:14;
[C,h] = contourf(xi,yi,cndht_ed_025_ll(:,:,5)'+cnvht_ed_025_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k');
caxis([-4 14]);
colorbar
title('Front diag, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','lathtfrontdiag_025.png')

figure
v=-4:1:14;
[C,h] = contourf(xi,yi,cndht_ed_050_ll(:,:,5)'+cnvht_ed_050_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k');
caxis([-4 14]);
colorbar
title('Front diag, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','lathtfrontdiag_050.png')

figure
v=-4:1:14;
[C,h] = contourf(xi,yi,cndht_ed_075_ll(:,:,5)'+cnvht_ed_075_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k');
caxis([-4 14]);
colorbar
title('Front diag, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','lathtfrontdiag_075.png')

figure
v=-4:1:14;
[C,h] = contourf(xi,yi,cndht_ed_100_ll(:,:,5)'+cnvht_ed_100_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-4 14]);
colorbar
title('Front diag, 1.0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','lathtfrontdiag_100.png')






figure
v=-4:1:14
[C,h] = contourf(xi,yi,cnvht_ed_000_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([-4 14]);
colorbar
title('Front diag, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cnvhtfrontdiag_000.png')

figure
v=-4:1:14
[C,h] = contourf(xi,yi,cnvht_ed_010_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k');
caxis([-4 14]);
colorbar
title('Front diag, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cnvhtfrontdiag_010.png')

figure
v=-4:1:14
[C,h] = contourf(xi,yi,cnvht_ed_025_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k');
caxis([-4 14]);
colorbar
title('Front diag, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cnvhtfrontdiag_025.png')

figure
v=-4:1:14
[C,h] = contourf(xi,yi,cnvht_ed_050_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k');
caxis([-4 14]);
colorbar
title('Front diag, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cnvhtfrontdiag_050.png')

figure
v=-4:1:14
[C,h] = contourf(xi,yi,cnvht_ed_075_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k');
caxis([-4 14]);
colorbar
title('Front diag, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cnvhtfrontdiag_075.png')

figure
v=-4:1:14
[C,h] = contourf(xi,yi,cnvht_ed_100_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-4 14]);
colorbar
title('Front diag, 1.0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cnvhtfrontdiag_100.png')






figure
v=-4:1:14;
[C,h] = contourf(xi,yi,cndht_ed_000_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([-4 14]);
colorbar
title('Front diag, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cndhtfrontdiag_000.png')

figure
v=-4:1:14;
[C,h] = contourf(xi,yi,cndht_ed_010_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k');
caxis([-4 14]);
colorbar
title('Front diag, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cndhtfrontdiag_010.png')

figure
v=-4:1:14;
[C,h] = contourf(xi,yi,cndht_ed_025_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k');
caxis([-4 14]);
colorbar
title('Front diag, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cndhtfrontdiag_025.png')

figure
v=-4:1:14;
[C,h] = contourf(xi,yi,cndht_ed_050_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k');
caxis([-4 14]);
colorbar
title('Front diag, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cndhtfrontdiag_050.png')

figure
v=-4:1:14;
[C,h] = contourf(xi,yi,cndht_ed_075_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k');
caxis([-4 14]);
colorbar
title('Front diag, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cndhtfrontdiag_075.png')

figure
v=-4:1:14;
[C,h] = contourf(xi,yi,cndht_ed_100_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-4 14]);
colorbar
title('Front diag, 1.0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','cndhtfrontdiag_100.png')





figure
v=-4:0.5:4;
[C,h] = contourf(xi,yi,radht_ed_000_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([-4 4]);
colorbar
title('Front diag, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','radhtfrontdiag_000.png')

figure
v=-4:0.5:4;
[C,h] = contourf(xi,yi,radht_ed_010_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k');
caxis([-4 4]);
colorbar
title('Front diag, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','radhtfrontdiag_010.png')

figure
v=-4:0.5:4;
[C,h] = contourf(xi,yi,radht_ed_025_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k');
caxis([-4 4]);
colorbar
title('Front diag, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','radhtfrontdiag_025.png')

figure
v=-4:0.5:4;
[C,h] = contourf(xi,yi,radht_ed_050_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k');
caxis([-4 4]);
colorbar
title('Front diag, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','radhtfrontdiag_050.png')

figure
v=-4:0.5:4;
[C,h] = contourf(xi,yi,radht_ed_075_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k');
caxis([-4 4]);
colorbar
title('Front diag, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','radhtfrontdiag_075.png')

figure
v=-4:0.5:4;
[C,h] = contourf(xi,yi,radht_ed_100_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-4 4]);
colorbar
title('Front diag, 1.0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','radhtfrontdiag_100.png')




figure
v=-12:0.5:7;
[C,h] = contourf(xi,yi,difht_ed_000_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([-12 7]);
colorbar
title('Front diag, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','difhtfrontdiag_000.png')

figure
v=-12:0.5:7;
[C,h] = contourf(xi,yi,difht_ed_010_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k');
caxis([-12 7]);
colorbar
title('Front diag, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','difhtfrontdiag_010.png')

figure
v=-12:0.5:7;
[C,h] = contourf(xi,yi,difht_ed_025_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k');
caxis([-12 7]);
colorbar
title('Front diag, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','difhtfrontdiag_025.png')

figure
v=-12:0.5:7;
[C,h] = contourf(xi,yi,difht_ed_050_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k');
caxis([-12 7]);
colorbar
title('Front diag, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','difhtfrontdiag_050.png')

figure
v=-12:0.5:7;
[C,h] = contourf(xi,yi,difht_ed_075_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k');
caxis([-12 7]);
colorbar
title('Front diag, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','difhtfrontdiag_075.png')

figure
v=-12:0.5:7;
[C,h] = contourf(xi,yi,difht_ed_100_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-12 7]);
colorbar
title('Front diag, 1.0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','difhtfrontdiag_100.png')


return


figure
v = -1:0.1:1;
[C,h] = contourf(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([-1 1]);
colorbar
title('Front diag, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','frontdiag_000.png')

[C,h] = contourf(xi,yi,arnaud_diag_010(:,:,1)',v,'k');
caxis([-1 1]);
colorbar
title('Front diag, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','frontdiag_010.png')

[C,h] = contourf(xi,yi,arnaud_diag_025(:,:,1)',v,'k');
caxis([-1 1]);
colorbar
title('Front diag, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','frontdiag_025.png')

v = -1:0.1:1;
[C,h] = contourf(xi,yi,arnaud_diag_050(:,:,1)',v,'k');
caxis([-1 1]);
colorbar
title('Front diag, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','frontdiag_050.png')

[C,h] = contourf(xi,yi,arnaud_diag_075(:,:,1)',v,'k');
caxis([-1 1]);
colorbar
title('Front diag, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','frontdiag_075.png')

[C,h] = contourf(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-1 1]);
colorbar
title('Front diag, 1.0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','frontdiag_100.png')


figure
v=-1:0.1:1;
[C,h] = contourf(xi,yi,w_000_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([-0.8 0.8]);
colorbar
title('Front diag, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','wfrontdiag_000.png')

figure
v=-1:0.1:1;
[C,h] = contourf(xi,yi,w_010_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k');
caxis([-0.8 0.8]);
colorbar
title('Front diag, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','wfrontdiag_010.png')

figure
v=-1:0.1:1;
[C,h] = contourf(xi,yi,w_025_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k');
caxis([-0.8 0.8]);
colorbar
title('Front diag, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','wfrontdiag_025.png')

figure
v=-1:0.1:1;
[C,h] = contourf(xi,yi,w_050_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k');
caxis([-0.8 0.8]);
colorbar
title('Front diag, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','wfrontdiag_050.png')

figure
v=-1:0.1:1;
[C,h] = contourf(xi,yi,w_075_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k');
caxis([-0.8 0.8]);
colorbar
title('Front diag, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','wfrontdiag_075.png')

figure
v=-1:0.1:1;
[C,h] = contourf(xi,yi,w_100_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-0.8 0.8]);
colorbar
title('Front diag, 1.0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','wfrontdiag_100.png')





figure
v=-1:0.1:1;
[C,h] = contourf(xi,yi,w_000_ll(:,:,13)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([-1 1]);
colorbar
title('Front diag, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','wfrontdiag_500hpa_000.png')

figure
v=-1:0.1:1;
[C,h] = contourf(xi,yi,w_010_ll(:,:,13)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k');
caxis([-1 1]);
colorbar
title('Front diag, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','wfrontdiag_500hpa_010.png')

figure
v=-1:0.1:1;
[C,h] = contourf(xi,yi,w_025_ll(:,:,13)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k');
caxis([-1 1]);
colorbar
title('Front diag, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','wfrontdiag_500hpa_025.png')

figure
v=-1:0.1:1;
[C,h] = contourf(xi,yi,w_050_ll(:,:,13)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k');
caxis([-1 1]);
colorbar
title('Front diag, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','wfrontdiag_500hpa_050.png')

figure
v=-1:0.1:1;
[C,h] = contourf(xi,yi,w_075_ll(:,:,13)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k');
caxis([-1 1]);
colorbar
title('Front diag, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','wfrontdiag_500hpa_075.png')

figure
v=-1:0.1:1;
[C,h] = contourf(xi,yi,w_100_ll(:,:,13)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-1 1]);
colorbar
title('Front diag, 1.0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','wfrontdiag_500hpa_100.png')









figure
v=-150:25:150;
[C,h] = contourf(xi,yi,vNt_ed_000_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([-150 150]);
colorbar
title('Front diag, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vtfrontdiag_000.png')

figure
v=-150:25:150;
[C,h] = contourf(xi,yi,vNt_ed_010_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k');
caxis([-150 150]);
colorbar
title('Front diag, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vtfrontdiag_010.png')

figure
v=-150:25:150;
[C,h] = contourf(xi,yi,vNt_ed_025_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k');
caxis([-150 150]);
colorbar
title('Front diag, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vtfrontdiag_025.png')

figure
v=-150:25:150;
[C,h] = contourf(xi,yi,vNt_ed_050_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k');
caxis([-150 150]);
colorbar
title('Front diag, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vtfrontdiag_050.png')

figure
v=-150:25:150;
[C,h] = contourf(xi,yi,vNt_ed_075_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k');
caxis([-150 150]);
colorbar
title('Front diag, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vtfrontdiag_075.png')

figure
v=-150:25:150;
[C,h] = contourf(xi,yi,vNt_ed_100_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-150 150]);
colorbar
title('Front diag, 1.0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vtfrontdiag_100.png')





figure
v=-30:5:30;
[C,h] = contourf(xi,yi,vN_ed_000_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([-30 30]);
colorbar
title('Front diag, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vfrontdiag_000.png')

figure
v=-30:5:30;
[C,h] = contourf(xi,yi,vN_ed_010_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k');
caxis([-30 30]);
colorbar
title('Front diag, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vfrontdiag_010.png')

figure
v=-30:5:30;
[C,h] = contourf(xi,yi,vN_ed_025_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k');
caxis([-30 30]);
colorbar
title('Front diag, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vfrontdiag_025.png')

figure
v=-30:5:30;
[C,h] = contourf(xi,yi,vN_ed_050_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k');
caxis([-30 30]);
colorbar
title('Front diag, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vfrontdiag_050.png')

figure
v=-30:5:30;
[C,h] = contourf(xi,yi,vN_ed_075_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k');
caxis([-30 30]);
colorbar
title('Front diag, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vfrontdiag_075.png')

figure
v=-30:5:30;
[C,h] = contourf(xi,yi,vN_ed_100_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-30 30]);
colorbar
title('Front diag, 1.0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','vfrontdiag_100.png')







figure
v=-10:1:10;
[C,h] = contourf(xi,yi,t_ed_000_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_000(:,:,1)',v,'k');
caxis([-10 10]);
colorbar
title('Front diag, 0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','tfrontdiag_000.png')

figure
v=-10:1:10;
[C,h] = contourf(xi,yi,t_ed_010_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_010(:,:,1)',v,'k');
caxis([-10 10]);
colorbar
title('Front diag, 0.1es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','tfrontdiag_010.png')

figure
v=-10:1:10;
[C,h] = contourf(xi,yi,t_ed_025_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_025(:,:,1)',v,'k');
caxis([-10 10]);
colorbar
title('Front diag, 0.25es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','tfrontdiag_025.png')

figure
v=-10:1:10;
[C,h] = contourf(xi,yi,t_ed_050_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_050(:,:,1)',v,'k');
caxis([-10 10]);
colorbar
title('Front diag, 0.5es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','tfrontdiag_050.png')

figure
v=-10:1:10;
[C,h] = contourf(xi,yi,t_ed_075_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_075(:,:,1)',v,'k');
caxis([-10 10]);
colorbar
title('Front diag, 0.75es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','tfrontdiag_075.png')

figure
v=-10:1:10;
[C,h] = contourf(xi,yi,t_ed_100_ll(:,:,5)',v);
set(h,'LineColor','none')
hold on
v = 0.1:0.1:1;
[C,h] = contour(xi,yi,arnaud_diag_100(:,:,1)',v,'k');
caxis([-10 10]);
colorbar
title('Front diag, 1.0es0');
ylabel('Latitude')
xlabel('Longitude')
print('-dpng','tfrontdiag_100.png')



dudy_000 = dudy_000./radius;
dvdx_000 = dvdx_000./radius;
vort_000_snap = dvdx_000 - dudy_000;
dudy_010 = dudy_010./radius;
dvdx_010 = dvdx_010./radius;
vort_010_snap = dvdx_010 - dudy_010;
dudy_025 = dudy_025./radius;
dvdx_025 = dvdx_025./radius;
vort_025_snap = dvdx_025 - dudy_025;
dudy_050 = dudy_050./radius;
dvdx_050 = dvdx_050./radius;
vort_050_snap = dvdx_050 - dudy_050;
dudy_075 = dudy_075./radius;
dvdx_075 = dvdx_075./radius;
vort_075_snap = dvdx_075 - dudy_075;
dudy_100 = dudy_100./radius;
dvdx_100 = dvdx_100./radius;
vort_100_snap = dvdx_100 - dudy_100;

