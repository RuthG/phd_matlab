% integrate Q, dtheta'v'dy, dthetadp, and wdthetadp over the ascending and descending branches of the Hadley cell
% Think about controls on each term


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5year/';
rC=squeeze(rdmds([rDir,'RC']));
yi = 1:2:89;
g=9.81;
cp=1004.64;
intfac = 4000.*cp./g;
es0(1) = 610.78;
es0(2) = 305.39;
es0(3) = 305.39./2;
es0(4) = 0;
es0(5) = 305.39;

load('heat_budg_vars.mat')
load('lapse_rates.mat')

%define the Hadley cell width as the latitude where psi becomes negative at 500hPa

psi_width(1) = yi(min(find(psi_w_hzav(:,13)<=0)));
psi_width(2) = yi(min(find(psi_h_hzav(:,13)<=0)));
psi_width(3) = yi(min(find(psi_q_hzav(:,13)<=0)));
psi_width(4) = yi(min(find(psi_d_hzav(:,13)<=0)));
psi_width(5) = yi(min(find(psi_th_hzav(:,13)<=0)));

y_wid_w = min(find(psi_w_hzav(:,13)<=0));
y_wid_h = min(find(psi_h_hzav(:,13)<=0));
y_wid_q = min(find(psi_q_hzav(:,13)<=0));
y_wid_d = min(find(psi_d_hzav(:,13)<=0));
y_wid_th = min(find(psi_th_hzav(:,13)<=0));

%to find start of descent, find maximum
psi_max(1) = yi(find(psi_w_hzav(:,13)==max(psi_w_hzav(:,13))));
psi_max(2) = yi(find(psi_h_hzav(:,13)==max(psi_h_hzav(:,13))));
psi_max(3) = yi(find(psi_q_hzav(:,13)==max(psi_q_hzav(:,13))));
psi_max(4) = yi(find(psi_d_hzav(:,13)==max(psi_d_hzav(:,13))));
psi_max(5) = yi(find(psi_th_hzav(:,13)==max(psi_th_hzav(:,13))));

y_max_w = find(psi_w_hzav(:,13)==max(psi_w_hzav(:,13)));
y_max_h = find(psi_h_hzav(:,13)==max(psi_h_hzav(:,13)));
y_max_q = find(psi_q_hzav(:,13)==max(psi_q_hzav(:,13)));
y_max_d = find(psi_d_hzav(:,13)==max(psi_d_hzav(:,13)));
y_max_th = find(psi_th_hzav(:,13)==max(psi_th_hzav(:,13)));

psi_peak(1) = max(psi_w_hzav(:,13));
psi_peak(2) = max(psi_h_hzav(:,13));
psi_peak(3) = max(psi_q_hzav(:,13));
psi_peak(4) = max(psi_d_hzav(:,13));
psi_peak(5) = max(psi_th_hzav(:,13));

%take vertical integrals


htrt_w_vint = intfac.*sum(htrtll_w_hzav,2);
htrt_h_vint = intfac.*sum(htrtll_h_hzav,2);
htrt_q_vint = intfac.*sum(htrtll_q_hzav,2);
htrt_d_vint = intfac.*sum(htrtll_d_hzav,2);
htrt_th_vint = intfac.*sum(htrtll_th_hzav,2);

wdthetadp_w_vint = intfac.*sum(wdthetadp_w_hzav,2);
wdthetadp_h_vint = intfac.*sum(wdthetadp_h_hzav,2);
wdthetadp_q_vint = intfac.*sum(wdthetadp_q_hzav,2);
wdthetadp_d_vint = intfac.*sum(wdthetadp_d_hzav,2);
wdthetadp_th_vint = intfac.*sum(wdthetadp_th_hzav,2);

dvNthdy_ed_w_vint = intfac.*sum(dvNthdy_ed_w_hzav,2);
dvNthdy_ed_h_vint = intfac.*sum(dvNthdy_ed_h_hzav,2);
dvNthdy_ed_q_vint = intfac.*sum(dvNthdy_ed_q_hzav,2);
dvNthdy_ed_d_vint = intfac.*sum(dvNthdy_ed_d_hzav,2);
dvNthdy_ed_th_vint = intfac.*sum(dvNthdy_ed_th_hzav,2);

dthetadp_w_vint = intfac.*sum(dthetadp_w_hzav,2);
dthetadp_h_vint = intfac.*sum(dthetadp_h_hzav,2);
dthetadp_q_vint = intfac.*sum(dthetadp_q_hzav,2);
dthetadp_d_vint = intfac.*sum(dthetadp_d_hzav,2);
dthetadp_th_vint = intfac.*sum(dthetadp_th_hzav,2);

t_w_vav = mean(t_w_hzav,2);
t_h_vav = mean(t_h_hzav,2);
t_q_vav = mean(t_q_hzav,2);
t_d_vav = mean(t_d_hzav,2);
t_th_vav = mean(t_th_hzav,2);

cosphi = cos(yi.*pi./180);

t_w_sum = sum(t_w_vav(1:44).*cosphi(1:44)');
t_h_sum = sum(t_h_vav(1:44).*cosphi(1:44)');
t_q_sum = sum(t_q_vav(1:44).*cosphi(1:44)');
t_d_sum = sum(t_d_vav(1:44).*cosphi(1:44)');
t_th_sum = sum(t_th_vav(1:44).*cosphi(1:44)');

cosphi_w_asc = sum(cosphi(1:y_max_w));
cosphi_h_asc = sum(cosphi(1:y_max_h));
cosphi_q_asc = sum(cosphi(1:y_max_q));
cosphi_d_asc = sum(cosphi(1:y_max_d));
cosphi_th_asc = sum(cosphi(1:y_max_th));

cosphi_w_desc = sum(cosphi(y_max_w:y_wid_w));
cosphi_h_desc = sum(cosphi(y_max_h:y_wid_h));
cosphi_q_desc = sum(cosphi(y_max_q:y_wid_q));
cosphi_d_desc = sum(cosphi(y_max_d:y_wid_d));
cosphi_th_desc = sum(cosphi(y_max_th:y_wid_th));

htrt_w_sum = sum(htrt_w_vint(y_max_w:y_wid_w).*cosphi(y_max_w:y_wid_w)');
htrt_h_sum = sum(htrt_h_vint(y_max_h:y_wid_h).*cosphi(y_max_h:y_wid_h)');
htrt_q_sum = sum(htrt_q_vint(y_max_q:y_wid_q).*cosphi(y_max_q:y_wid_q)');
htrt_d_sum = sum(htrt_d_vint(y_max_d:y_wid_d).*cosphi(y_max_d:y_wid_d)');
htrt_th_sum = sum(htrt_th_vint(y_max_th:y_wid_th).*cosphi(y_max_th:y_wid_th)');

htrt_desc(1) = htrt_w_sum./cosphi_w_desc;
htrt_desc(2) = htrt_h_sum./cosphi_h_desc;
htrt_desc(3) = htrt_q_sum./cosphi_q_desc;
htrt_desc(4) = htrt_d_sum./cosphi_d_desc;
htrt_desc(5) = htrt_th_sum./cosphi_th_desc;

htrt_w_sum = sum(htrt_w_vint(1:y_max_w).*cosphi(1:y_max_w)');
htrt_h_sum = sum(htrt_h_vint(1:y_max_h).*cosphi(1:y_max_h)');
htrt_q_sum = sum(htrt_q_vint(1:y_max_q).*cosphi(1:y_max_q)');
htrt_d_sum = sum(htrt_d_vint(1:y_max_d).*cosphi(1:y_max_d)');
htrt_th_sum = sum(htrt_th_vint(1:y_max_th).*cosphi(1:y_max_th)');

htrt_asc(1) = htrt_w_sum./cosphi_w_asc;
htrt_asc(2) = htrt_h_sum./cosphi_h_asc;
htrt_asc(3) = htrt_q_sum./cosphi_q_asc;
htrt_asc(4) = htrt_d_sum./cosphi_d_asc;
htrt_asc(5) = htrt_th_sum./cosphi_th_asc;

wdthetadp_w_sum = sum(wdthetadp_w_vint(y_max_w:y_wid_w).*cosphi(y_max_w:y_wid_w)');
wdthetadp_h_sum = sum(wdthetadp_h_vint(y_max_h:y_wid_h).*cosphi(y_max_h:y_wid_h)');
wdthetadp_q_sum = sum(wdthetadp_q_vint(y_max_q:y_wid_q).*cosphi(y_max_q:y_wid_q)');
wdthetadp_d_sum = sum(wdthetadp_d_vint(y_max_d:y_wid_d).*cosphi(y_max_d:y_wid_d)');
wdthetadp_th_sum = sum(wdthetadp_th_vint(y_max_th:y_wid_th).*cosphi(y_max_th:y_wid_th)');

wdthetadp_desc(1) = wdthetadp_w_sum./cosphi_w_desc;
wdthetadp_desc(2) = wdthetadp_h_sum./cosphi_h_desc;
wdthetadp_desc(3) = wdthetadp_q_sum./cosphi_q_desc;
wdthetadp_desc(4) = wdthetadp_d_sum./cosphi_d_desc;
wdthetadp_desc(5) = wdthetadp_th_sum./cosphi_th_desc;

wdthetadp_w_sum = sum(wdthetadp_w_vint(1:y_max_w).*cosphi(1:y_max_w)');
wdthetadp_h_sum = sum(wdthetadp_h_vint(1:y_max_h).*cosphi(1:y_max_h)');
wdthetadp_q_sum = sum(wdthetadp_q_vint(1:y_max_q).*cosphi(1:y_max_q)');
wdthetadp_d_sum = sum(wdthetadp_d_vint(1:y_max_d).*cosphi(1:y_max_d)');
wdthetadp_th_sum = sum(wdthetadp_th_vint(1:y_max_th).*cosphi(1:y_max_th)');

wdthetadp_asc(1) = wdthetadp_w_sum./cosphi_w_asc;
wdthetadp_asc(2) = wdthetadp_h_sum./cosphi_h_asc;
wdthetadp_asc(3) = wdthetadp_q_sum./cosphi_q_asc;
wdthetadp_asc(4) = wdthetadp_d_sum./cosphi_d_asc;
wdthetadp_asc(5) = wdthetadp_th_sum./cosphi_th_asc;


dthetadp_w_sum = sum(dthetadp_w_vint(y_max_w:y_wid_w).*cosphi(y_max_w:y_wid_w)');
dthetadp_h_sum = sum(dthetadp_h_vint(y_max_h:y_wid_h).*cosphi(y_max_h:y_wid_h)');
dthetadp_q_sum = sum(dthetadp_q_vint(y_max_q:y_wid_q).*cosphi(y_max_q:y_wid_q)');
dthetadp_d_sum = sum(dthetadp_d_vint(y_max_d:y_wid_d).*cosphi(y_max_d:y_wid_d)');
dthetadp_th_sum = sum(dthetadp_th_vint(y_max_th:y_wid_th).*cosphi(y_max_th:y_wid_th)');

dthetadp_desc(1) = dthetadp_w_sum./cosphi_w_desc;
dthetadp_desc(2) = dthetadp_h_sum./cosphi_h_desc;
dthetadp_desc(3) = dthetadp_q_sum./cosphi_q_desc;
dthetadp_desc(4) = dthetadp_d_sum./cosphi_d_desc;
dthetadp_desc(5) = dthetadp_th_sum./cosphi_th_desc;

dthetadp_w_sum = sum(dthetadp_w_vint(1:y_max_w).*cosphi(1:y_max_w)');
dthetadp_h_sum = sum(dthetadp_h_vint(1:y_max_h).*cosphi(1:y_max_h)');
dthetadp_q_sum = sum(dthetadp_q_vint(1:y_max_q).*cosphi(1:y_max_q)');
dthetadp_d_sum = sum(dthetadp_d_vint(1:y_max_d).*cosphi(1:y_max_d)');
dthetadp_th_sum = sum(dthetadp_th_vint(1:y_max_th).*cosphi(1:y_max_th)');

dthetadp_asc(1) = dthetadp_w_sum./cosphi_w_asc;
dthetadp_asc(2) = dthetadp_h_sum./cosphi_h_asc;
dthetadp_asc(3) = dthetadp_q_sum./cosphi_q_asc;
dthetadp_asc(4) = dthetadp_d_sum./cosphi_d_asc;
dthetadp_asc(5) = dthetadp_th_sum./cosphi_th_asc;


dvNthdy_ed_w_sum = sum(dvNthdy_ed_w_vint(y_max_w:y_wid_w).*cosphi(y_max_w:y_wid_w)');
dvNthdy_ed_h_sum = sum(dvNthdy_ed_h_vint(y_max_h:y_wid_h).*cosphi(y_max_h:y_wid_h)');
dvNthdy_ed_q_sum = sum(dvNthdy_ed_q_vint(y_max_q:y_wid_q).*cosphi(y_max_q:y_wid_q)');
dvNthdy_ed_d_sum = sum(dvNthdy_ed_d_vint(y_max_d:y_wid_d).*cosphi(y_max_d:y_wid_d)');
dvNthdy_ed_th_sum = sum(dvNthdy_ed_th_vint(y_max_th:y_wid_th).*cosphi(y_max_th:y_wid_th)');

dvNthdy_ed_desc(1) = dvNthdy_ed_w_sum./cosphi_w_desc;
dvNthdy_ed_desc(2) = dvNthdy_ed_h_sum./cosphi_h_desc;
dvNthdy_ed_desc(3) = dvNthdy_ed_q_sum./cosphi_q_desc;
dvNthdy_ed_desc(4) = dvNthdy_ed_d_sum./cosphi_d_desc;
dvNthdy_ed_desc(5) = dvNthdy_ed_th_sum./cosphi_th_desc;

dvNthdy_ed_w_sum = sum(dvNthdy_ed_w_vint(1:y_max_w).*cosphi(1:y_max_w)');
dvNthdy_ed_h_sum = sum(dvNthdy_ed_h_vint(1:y_max_h).*cosphi(1:y_max_h)');
dvNthdy_ed_q_sum = sum(dvNthdy_ed_q_vint(1:y_max_q).*cosphi(1:y_max_q)');
dvNthdy_ed_d_sum = sum(dvNthdy_ed_d_vint(1:y_max_d).*cosphi(1:y_max_d)');
dvNthdy_ed_th_sum = sum(dvNthdy_ed_th_vint(1:y_max_th).*cosphi(1:y_max_th)');

dvNthdy_ed_asc(1) = dvNthdy_ed_w_sum./cosphi_w_asc;
dvNthdy_ed_asc(2) = dvNthdy_ed_h_sum./cosphi_h_asc;
dvNthdy_ed_asc(3) = dvNthdy_ed_q_sum./cosphi_q_asc;
dvNthdy_ed_asc(4) = dvNthdy_ed_d_sum./cosphi_d_asc;
dvNthdy_ed_asc(5) = dvNthdy_ed_th_sum./cosphi_th_asc;

t_gav(1) = t_w_sum./sum(cosphi(1:44));
t_gav(2) = t_h_sum./sum(cosphi(1:44));
t_gav(3) = t_q_sum./sum(cosphi(1:44));
t_gav(4) = t_d_sum./sum(cosphi(1:44));
t_gav(5) = t_th_sum./sum(cosphi(1:44));

figure
plot(wdthetadp_asc,htrt_asc,'x') 
hold on
plot([0 300],[0 300])
xlabel('wd\theta/dp') 
ylabel('Diabatic heating')
title('Vertically integrated heat budget averaged over the ascending branch')
print('-dpdf','heat_budg_asc.pdf')


figure
plot(wdthetadp_desc,htrt_desc-dvNthdy_ed_desc,'x') 
hold on
plot([-90 10],[-90 10])
xlabel('wd\theta/dp') 
ylabel('Diabatic heating - dv''\theta''/dy')
title('Vertically integrated heat budget averaged over the descending branch')
print('-dpdf','heat_budg_desc.pdf')

figure
plot(t_gav,htrt_desc,'x')
xlabel('Global mean temperature, K')
ylabel('Diabatic heating rate over descending branch (potential temperature), Ks^{-1}')
print('-dpdf','gta_vs_htrt.pdf')
