%load up and print fits for 0 intercept regression

es0fac=[0,0.1,0.25,0.5,0.75,1.0];

load('/project/rg312/mat_files/damping_grad_000_0intregress_best.mat')

htrt_mgrad(1) = m_neg;
htrt_pgrad(1) = m_pos;
difht_mgrad(1) = m_neg_difht;
difht_pgrad(1) = m_pos_difht;
cnvht_mgrad(1) = m_neg_cnvht;
cnvht_pgrad(1) = m_pos_cnvht;
cndht_mgrad(1) = m_neg_cndht;
cndht_pgrad(1) = m_pos_cndht;
radht_mgrad(1) = m_neg_radht;
radht_pgrad(1) = m_pos_radht;
cvdfht_mgrad(1) = m_neg_cvdfht;
cvdfht_pgrad(1) = m_pos_cvdfht;

load('/project/rg312/mat_files/damping_grad_010_0intregress_best.mat')

htrt_mgrad(2) = m_neg;
htrt_pgrad(2) = m_pos;
difht_mgrad(2) = m_neg_difht;
difht_pgrad(2) = m_pos_difht;
cnvht_mgrad(2) = m_neg_cnvht;
cnvht_pgrad(2) = m_pos_cnvht;
cndht_mgrad(2) = m_neg_cndht;
cndht_pgrad(2) = m_pos_cndht;
radht_mgrad(2) = m_neg_radht;
radht_pgrad(2) = m_pos_radht;
cvdfht_mgrad(2) = m_neg_cvdfht;
cvdfht_pgrad(2) = m_pos_cvdfht;

load('/project/rg312/mat_files/damping_grad_025_0intregress_best.mat')

htrt_mgrad(3) = m_neg;
htrt_pgrad(3) = m_pos;
difht_mgrad(3) = m_neg_difht;
difht_pgrad(3) = m_pos_difht;
cnvht_mgrad(3) = m_neg_cnvht;
cnvht_pgrad(3) = m_pos_cnvht;
cndht_mgrad(3) = m_neg_cndht;
cndht_pgrad(3) = m_pos_cndht;
radht_mgrad(3) = m_neg_radht;
radht_pgrad(3) = m_pos_radht;
cvdfht_mgrad(3) = m_neg_cvdfht;
cvdfht_pgrad(3) = m_pos_cvdfht;

load('/project/rg312/mat_files/damping_grad_050_0intregress_best.mat')

htrt_mgrad(4) = m_neg;
htrt_pgrad(4) = m_pos;
difht_mgrad(4) = m_neg_difht;
difht_pgrad(4) = m_pos_difht;
cnvht_mgrad(4) = m_neg_cnvht;
cnvht_pgrad(4) = m_pos_cnvht;
cndht_mgrad(4) = m_neg_cndht;
cndht_pgrad(4) = m_pos_cndht;
radht_mgrad(4) = m_neg_radht;
radht_pgrad(4) = m_pos_radht;
cvdfht_mgrad(4) = m_neg_cvdfht;
cvdfht_pgrad(4) = m_pos_cvdfht;

load('/project/rg312/mat_files/damping_grad_075_0intregress_best.mat')

htrt_mgrad(5) = m_neg;
htrt_pgrad(5) = m_pos;
difht_mgrad(5) = m_neg_difht;
difht_pgrad(5) = m_pos_difht;
cnvht_mgrad(5) = m_neg_cnvht;
cnvht_pgrad(5) = m_pos_cnvht;
cndht_mgrad(5) = m_neg_cndht;
cndht_pgrad(5) = m_pos_cndht;
radht_mgrad(5) = m_neg_radht;
radht_pgrad(5) = m_pos_radht;
cvdfht_mgrad(5) = m_neg_cvdfht;
cvdfht_pgrad(5) = m_pos_cvdfht;

load('/project/rg312/mat_files/damping_grad_100_0intregress_best.mat')

htrt_mgrad(6) = m_neg;
htrt_pgrad(6) = m_pos;
difht_mgrad(6) = m_neg_difht;
difht_pgrad(6) = m_pos_difht;
cnvht_mgrad(6) = m_neg_cnvht;
cnvht_pgrad(6) = m_pos_cnvht;
cndht_mgrad(6) = m_neg_cndht;
cndht_pgrad(6) = m_pos_cndht;
radht_mgrad(6) = m_neg_radht;
radht_pgrad(6) = m_pos_radht;
cvdfht_mgrad(6) = m_neg_cvdfht;
cvdfht_pgrad(6) = m_pos_cvdfht;

figure
plot(es0fac,htrt_mgrad,'k')
hold on
plot(es0fac,htrt_pgrad,'r')
xlabel('Ref es0 factor')
ylabel('Damping factor: all heating, day^{1}')
print('-dpng','htrt_damping.png')

figure
plot(es0fac,difht_mgrad,'k')
hold on
plot(es0fac,difht_pgrad,'r')
xlabel('Ref es0 factor')
ylabel('Damping factor: diffusive heating, day^{1}')
print('-dpng','difht_damping.png')


figure
plot(es0fac,cnvht_mgrad,'k')
hold on
plot(es0fac,cnvht_pgrad,'r')
xlabel('Ref es0 factor')
ylabel('Damping factor: convective heating, day^{1}')
print('-dpng','cnvht_damping.png')


figure
plot(es0fac,cndht_mgrad,'k')
hold on
plot(es0fac,cndht_pgrad,'r')
xlabel('Ref es0 factor')
ylabel('Damping factor: largescale latent heating, day^{1}')
print('-dpng','cndht_damping.png')


figure
plot(es0fac,radht_mgrad,'k')
hold on
plot(es0fac,radht_pgrad,'r')
xlabel('Ref es0 factor')
ylabel('Damping factor: radiative heating, day^{1}')
print('-dpng','radht_damping.png')


figure
plot(es0fac,cvdfht_mgrad,'k')
hold on
plot(es0fac,cvdfht_pgrad,'r')
xlabel('Ref es0 factor')
ylabel('Damping factor: convective + diffusive heating, day^{1}')
print('-dpng','cvdfht_damping.png')



