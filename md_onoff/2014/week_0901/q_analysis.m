%load in heat budget terms and try to understand balance globally and in descending branch

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5year/';
rC=squeeze(rdmds([rDir,'RC']));
yi = 1:2:89;
g=9.81;
cp=1004.64;
intfac = 4000.*cp./g;

load('heat_budg_vars.mat')

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

%first lets plot htrt vs es0 vertically integrated at cell end again...

htrt_edge(1) = intfac.*sum(htrtll_w_hzav(y_wid_w,:),2);
htrt_edge(2) = intfac.*sum(htrtll_h_hzav(y_wid_h,:),2);
htrt_edge(3) = intfac.*sum(htrtll_q_hzav(y_wid_q,:),2);
htrt_edge(4) = intfac.*sum(htrtll_d_hzav(y_wid_d,:),2);
htrt_edge(5) = intfac.*sum(htrtll_th_hzav(y_wid_th,:),2);

es0(1) = 610.78;
es0(2) = 305.39;
es0(3) = 305.39./2;
es0(4) = 0;
es0(5) = 305.39;


cosphi = cos(yi.*pi./180);


htrt_w_vint = intfac.*sum(htrtll_w_hzav,2);
htrt_h_vint = intfac.*sum(htrtll_h_hzav,2);
htrt_q_vint = intfac.*sum(htrtll_q_hzav,2);
htrt_d_vint = intfac.*sum(htrtll_d_hzav,2);
htrt_th_vint = intfac.*sum(htrtll_th_hzav,2);

latht_w_vint = intfac.*(sum(cndhtll_w_hzav,2) + sum(cnvhtll_w_hzav,2));
latht_h_vint = intfac.*(sum(cndhtll_h_hzav,2) + sum(cnvhtll_h_hzav,2));
latht_q_vint = intfac.*(sum(cndhtll_q_hzav,2) + sum(cnvhtll_q_hzav,2));
latht_d_vint = intfac.*(sum(cndhtll_d_hzav,2) + sum(cnvhtll_d_hzav,2));
latht_th_vint = intfac.*(sum(cndhtll_th_hzav,2) + sum(cnvhtll_th_hzav,2));

radht_w_vint = intfac.*sum(radhtll_w_hzav,2);
radht_h_vint = intfac.*sum(radhtll_h_hzav,2);
radht_q_vint = intfac.*sum(radhtll_q_hzav,2);
radht_d_vint = intfac.*sum(radhtll_d_hzav,2);
radht_th_vint = intfac.*sum(radhtll_th_hzav,2);

difht_w_vint = intfac.*sum(difhtll_w_hzav,2);
difht_h_vint = intfac.*sum(difhtll_h_hzav,2);
difht_q_vint = intfac.*sum(difhtll_q_hzav,2);
difht_d_vint = intfac.*sum(difhtll_d_hzav,2);
difht_th_vint = intfac.*sum(difhtll_th_hzav,2);

t_w_vav = mean(t_w_hzav,2);
t_h_vav = mean(t_h_hzav,2);
t_q_vav = mean(t_q_hzav,2);
t_d_vav = mean(t_d_hzav,2);
t_th_vav = mean(t_th_hzav,2);

htrt_w_sum = sum(htrt_w_vint(y_max_w:y_wid_w).*cosphi(y_max_w:y_wid_w)');
htrt_h_sum = sum(htrt_h_vint(y_max_h:y_wid_h).*cosphi(y_max_h:y_wid_h)');
htrt_q_sum = sum(htrt_q_vint(y_max_q:y_wid_q).*cosphi(y_max_q:y_wid_q)');
htrt_d_sum = sum(htrt_d_vint(y_max_d:y_wid_d).*cosphi(y_max_d:y_wid_d)');
htrt_th_sum = sum(htrt_th_vint(y_max_th:y_wid_th).*cosphi(y_max_th:y_wid_th)');

cosphi_w_sum = sum(cosphi(y_max_w:y_wid_w));
cosphi_h_sum = sum(cosphi(y_max_h:y_wid_h));
cosphi_q_sum = sum(cosphi(y_max_q:y_wid_q));
cosphi_d_sum = sum(cosphi(y_max_d:y_wid_d));
cosphi_th_sum = sum(cosphi(y_max_th:y_wid_th));

htrt_desc(1) = htrt_w_sum./cosphi_w_sum;
htrt_desc(2) = htrt_h_sum./cosphi_h_sum;
htrt_desc(3) = htrt_q_sum./cosphi_q_sum;
htrt_desc(4) = htrt_d_sum./cosphi_d_sum;
htrt_desc(5) = htrt_th_sum./cosphi_th_sum;

latht_w_sum = sum(latht_w_vint(1:44).*cosphi(1:44)');
latht_h_sum = sum(latht_h_vint(1:44).*cosphi(1:44)');
latht_q_sum = sum(latht_q_vint(1:44).*cosphi(1:44)');
latht_d_sum = sum(latht_d_vint(1:44).*cosphi(1:44)');
latht_th_sum = sum(latht_th_vint(1:44).*cosphi(1:44)');

radht_w_sum = sum(radht_w_vint(1:44).*cosphi(1:44)');
radht_h_sum = sum(radht_h_vint(1:44).*cosphi(1:44)');
radht_q_sum = sum(radht_q_vint(1:44).*cosphi(1:44)');
radht_d_sum = sum(radht_d_vint(1:44).*cosphi(1:44)');
radht_th_sum = sum(radht_th_vint(1:44).*cosphi(1:44)');

difht_w_sum = sum(difht_w_vint(1:44).*cosphi(1:44)');
difht_h_sum = sum(difht_h_vint(1:44).*cosphi(1:44)');
difht_q_sum = sum(difht_q_vint(1:44).*cosphi(1:44)');
difht_d_sum = sum(difht_d_vint(1:44).*cosphi(1:44)');
difht_th_sum = sum(difht_th_vint(1:44).*cosphi(1:44)');

t_w_sum = sum(t_w_vav(1:44).*cosphi(1:44)');
t_h_sum = sum(t_h_vav(1:44).*cosphi(1:44)');
t_q_sum = sum(t_q_vav(1:44).*cosphi(1:44)');
t_d_sum = sum(t_d_vav(1:44).*cosphi(1:44)');
t_th_sum = sum(t_th_vav(1:44).*cosphi(1:44)');

latht_gav(1) = latht_w_sum./sum(cosphi(1:44));
latht_gav(2) = latht_h_sum./sum(cosphi(1:44));
latht_gav(3) = latht_q_sum./sum(cosphi(1:44));
latht_gav(4) = latht_d_sum./sum(cosphi(1:44));
latht_gav(5) = latht_th_sum./sum(cosphi(1:44));

latht_desc(1) = sum(latht_w_vint(y_max_w:y_wid_w).*cosphi(y_max_w:y_wid_w)')./sum(cosphi(y_max_w:y_wid_w));
latht_desc(2) = sum(latht_h_vint(y_max_h:y_wid_h).*cosphi(y_max_h:y_wid_h)')./sum(cosphi(y_max_h:y_wid_h));
latht_desc(3) = sum(latht_q_vint(y_max_q:y_wid_q).*cosphi(y_max_q:y_wid_q)')./sum(cosphi(y_max_q:y_wid_q));
latht_desc(4) = sum(latht_d_vint(y_max_d:y_wid_d).*cosphi(y_max_d:y_wid_d)')./sum(cosphi(y_max_d:y_wid_d));
latht_desc(5) = sum(latht_th_vint(y_max_th:y_wid_th).*cosphi(y_max_th:y_wid_th)')./sum(cosphi(y_max_th:y_wid_th));

radht_gav(1) = radht_w_sum./sum(cosphi(1:44));
radht_gav(2) = radht_h_sum./sum(cosphi(1:44));
radht_gav(3) = radht_q_sum./sum(cosphi(1:44));
radht_gav(4) = radht_d_sum./sum(cosphi(1:44));
radht_gav(5) = radht_th_sum./sum(cosphi(1:44));

difht_gav(1) = difht_w_sum./sum(cosphi(1:44));
difht_gav(2) = difht_h_sum./sum(cosphi(1:44));
difht_gav(3) = difht_q_sum./sum(cosphi(1:44));
difht_gav(4) = difht_d_sum./sum(cosphi(1:44));
difht_gav(5) = difht_th_sum./sum(cosphi(1:44));

t_gav(1) = t_w_sum./sum(cosphi(1:44));
t_gav(2) = t_h_sum./sum(cosphi(1:44));
t_gav(3) = t_q_sum./sum(cosphi(1:44));
t_gav(4) = t_d_sum./sum(cosphi(1:44));
t_gav(5) = t_th_sum./sum(cosphi(1:44));
