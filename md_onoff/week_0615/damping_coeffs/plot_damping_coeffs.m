load('/project/rg312/mat_files/damping_coeffs.mat')

dcoeff_htrt_n(1) = dcoeff_htrt_n_000(1);
dcoeff_htrt_n(2) = dcoeff_htrt_n_010(1);
dcoeff_htrt_n(3) = dcoeff_htrt_n_025(1);
dcoeff_htrt_n(4) = dcoeff_htrt_n_050(1);
dcoeff_htrt_n(5) = dcoeff_htrt_n_075(1);
dcoeff_htrt_n(6) = dcoeff_htrt_n_100(1);

dcoeff_cnvht_n(1) = dcoeff_cnvht_n_000(1);
dcoeff_cnvht_n(2) = dcoeff_cnvht_n_010(1);
dcoeff_cnvht_n(3) = dcoeff_cnvht_n_025(1);
dcoeff_cnvht_n(4) = dcoeff_cnvht_n_050(1);
dcoeff_cnvht_n(5) = dcoeff_cnvht_n_075(1);
dcoeff_cnvht_n(6) = dcoeff_cnvht_n_100(1);

dcoeff_cndht_n(1) = dcoeff_cndht_n_000(1);
dcoeff_cndht_n(2) = dcoeff_cndht_n_010(1);
dcoeff_cndht_n(3) = dcoeff_cndht_n_025(1);
dcoeff_cndht_n(4) = dcoeff_cndht_n_050(1);
dcoeff_cndht_n(5) = dcoeff_cndht_n_075(1);
dcoeff_cndht_n(6) = dcoeff_cndht_n_100(1);

dcoeff_radht_n(1) = dcoeff_radht_n_000(1);
dcoeff_radht_n(2) = dcoeff_radht_n_010(1);
dcoeff_radht_n(3) = dcoeff_radht_n_025(1);
dcoeff_radht_n(4) = dcoeff_radht_n_050(1);
dcoeff_radht_n(5) = dcoeff_radht_n_075(1);
dcoeff_radht_n(6) = dcoeff_radht_n_100(1);

dcoeff_difht_n(1) = dcoeff_difht_n_000(1);
dcoeff_difht_n(2) = dcoeff_difht_n_010(1);
dcoeff_difht_n(3) = dcoeff_difht_n_025(1);
dcoeff_difht_n(4) = dcoeff_difht_n_050(1);
dcoeff_difht_n(5) = dcoeff_difht_n_075(1);
dcoeff_difht_n(6) = dcoeff_difht_n_100(1);


dcoeff_htrt_p(1) = dcoeff_htrt_p_000(1);
dcoeff_htrt_p(2) = dcoeff_htrt_p_010(1);
dcoeff_htrt_p(3) = dcoeff_htrt_p_025(1);
dcoeff_htrt_p(4) = dcoeff_htrt_p_050(1);
dcoeff_htrt_p(5) = dcoeff_htrt_p_075(1);
dcoeff_htrt_p(6) = dcoeff_htrt_p_100(1);

dcoeff_cnvht_p(1) = dcoeff_cnvht_p_000(1);
dcoeff_cnvht_p(2) = dcoeff_cnvht_p_010(1);
dcoeff_cnvht_p(3) = dcoeff_cnvht_p_025(1);
dcoeff_cnvht_p(4) = dcoeff_cnvht_p_050(1);
dcoeff_cnvht_p(5) = dcoeff_cnvht_p_075(1);
dcoeff_cnvht_p(6) = dcoeff_cnvht_p_100(1);

dcoeff_cndht_p(1) = dcoeff_cndht_p_000(1);
dcoeff_cndht_p(2) = dcoeff_cndht_p_010(1);
dcoeff_cndht_p(3) = dcoeff_cndht_p_025(1);
dcoeff_cndht_p(4) = dcoeff_cndht_p_050(1);
dcoeff_cndht_p(5) = dcoeff_cndht_p_075(1);
dcoeff_cndht_p(6) = dcoeff_cndht_p_100(1);

dcoeff_radht_p(1) = dcoeff_radht_p_000(1);
dcoeff_radht_p(2) = dcoeff_radht_p_010(1);
dcoeff_radht_p(3) = dcoeff_radht_p_025(1);
dcoeff_radht_p(4) = dcoeff_radht_p_050(1);
dcoeff_radht_p(5) = dcoeff_radht_p_075(1);
dcoeff_radht_p(6) = dcoeff_radht_p_100(1);

dcoeff_difht_p(1) = dcoeff_difht_p_000(1);
dcoeff_difht_p(2) = dcoeff_difht_p_010(1);
dcoeff_difht_p(3) = dcoeff_difht_p_025(1);
dcoeff_difht_p(4) = dcoeff_difht_p_050(1);
dcoeff_difht_p(5) = dcoeff_difht_p_075(1);
dcoeff_difht_p(6) = dcoeff_difht_p_100(1);

fileID = fopen('dcoeff_blayer.txt','w');
fprintf(fileID,'\n%s','htrt')
fprintf(fileID,'\n%s',num2str(dcoeff_htrt_n))
fprintf(fileID,'\n%s',num2str(dcoeff_htrt_p))
fprintf(fileID,'\n%s','cnvht')
fprintf(fileID,'\n%s',num2str(dcoeff_cnvht_n))
fprintf(fileID,'\n%s',num2str(dcoeff_cnvht_p))
fprintf(fileID,'\n%s','cndht')
fprintf(fileID,'\n%s',num2str(dcoeff_cndht_n))
fprintf(fileID,'\n%s',num2str(dcoeff_cndht_p))
fprintf(fileID,'\n%s','difht')
fprintf(fileID,'\n%s',num2str(dcoeff_difht_n))
fprintf(fileID,'\n%s',num2str(dcoeff_difht_p))
fprintf(fileID,'\n%s','radht')
fprintf(fileID,'\n%s',num2str(dcoeff_radht_n))
fprintf(fileID,'\n%s',num2str(dcoeff_radht_p))
fclose(fileID)

es0 = [0,0.1,0.25,0.5,0.75,1];

figure
plot(es0,dcoeff_htrt_n,'LineWidth',2)
set(gca,'FontSize',15)
hold on
ylim([-1 0.5])
plot(es0,dcoeff_htrt_p,'r','LineWidth',2)
title('Total diabatic heating')
xlabel('Saturation vapour pressure fraction','FontSize',15)
ylabel('Damping coefficient estimate, day^{-1}','FontSize',15)
print('-depsc2','-r300','damping_coeff_blayer_htrt.eps')


figure
plot(es0,dcoeff_difht_n,'LineWidth',2)
set(gca,'FontSize',15)
hold on
ylim([-1 0.5])
plot(es0,dcoeff_difht_p,'r','LineWidth',2)
title('Diffusive heating')
xlabel('Saturation vapour pressure fraction','FontSize',15)
ylabel('Damping coefficient estimate, day^{-1}','FontSize',15)
print('-depsc2','-r300','damping_coeff_blayer_difht.eps')


figure
plot(es0,dcoeff_cnvht_n,'LineWidth',2)
set(gca,'FontSize',15)
hold on
ylim([-1 0.5])
plot(es0,dcoeff_cnvht_p,'r','LineWidth',2)
title('Convective heating')
xlabel('Saturation vapour pressure fraction','FontSize',15)
ylabel('Damping coefficient estimate, day^{-1}','FontSize',15)
print('-depsc2','-r300','damping_coeff_blayer_cnvht.eps')


figure
plot(es0,dcoeff_radht_n,'LineWidth',2)
set(gca,'FontSize',15)
hold on
ylim([-1 0.5])
plot(es0,dcoeff_radht_p,'r','LineWidth',2)
title('Radiative heating')
xlabel('Saturation vapour pressure fraction','FontSize',15)
ylabel('Damping coefficient estimate, day^{-1}','FontSize',15)
print('-depsc2','-r300','damping_coeff_blayer_radht.eps')


figure
plot(es0,dcoeff_cndht_n,'LineWidth',2)
set(gca,'FontSize',15)
hold on
ylim([-1 0.5])
plot(es0,dcoeff_cndht_p,'r','LineWidth',2)
title('Condensational heating')
xlabel('Saturation vapour pressure fraction','FontSize',15)
ylabel('Damping coefficient estimate, day^{-1}','FontSize',15)
print('-depsc2','-r300','damping_coeff_blayer_cndht.eps')

close all






load('/project/rg312/mat_files/damping_coeffs_trop.mat')



dcoeff_htrt_n(1) = dcoeff_htrt_n_000(1);
dcoeff_htrt_n(2) = dcoeff_htrt_n_010(1);
dcoeff_htrt_n(3) = dcoeff_htrt_n_025(1);
dcoeff_htrt_n(4) = dcoeff_htrt_n_050(1);
dcoeff_htrt_n(5) = dcoeff_htrt_n_075(1);
dcoeff_htrt_n(6) = dcoeff_htrt_n_100(1);

dcoeff_cnvht_n(1) = dcoeff_cnvht_n_000(1);
dcoeff_cnvht_n(2) = dcoeff_cnvht_n_010(1);
dcoeff_cnvht_n(3) = dcoeff_cnvht_n_025(1);
dcoeff_cnvht_n(4) = dcoeff_cnvht_n_050(1);
dcoeff_cnvht_n(5) = dcoeff_cnvht_n_075(1);
dcoeff_cnvht_n(6) = dcoeff_cnvht_n_100(1);

dcoeff_cndht_n(1) = dcoeff_cndht_n_000(1);
dcoeff_cndht_n(2) = dcoeff_cndht_n_010(1);
dcoeff_cndht_n(3) = dcoeff_cndht_n_025(1);
dcoeff_cndht_n(4) = dcoeff_cndht_n_050(1);
dcoeff_cndht_n(5) = dcoeff_cndht_n_075(1);
dcoeff_cndht_n(6) = dcoeff_cndht_n_100(1);

dcoeff_radht_n(1) = dcoeff_radht_n_000(1);
dcoeff_radht_n(2) = dcoeff_radht_n_010(1);
dcoeff_radht_n(3) = dcoeff_radht_n_025(1);
dcoeff_radht_n(4) = dcoeff_radht_n_050(1);
dcoeff_radht_n(5) = dcoeff_radht_n_075(1);
dcoeff_radht_n(6) = dcoeff_radht_n_100(1);

dcoeff_difht_n(1) = dcoeff_difht_n_000(1);
dcoeff_difht_n(2) = dcoeff_difht_n_010(1);
dcoeff_difht_n(3) = dcoeff_difht_n_025(1);
dcoeff_difht_n(4) = dcoeff_difht_n_050(1);
dcoeff_difht_n(5) = dcoeff_difht_n_075(1);
dcoeff_difht_n(6) = dcoeff_difht_n_100(1);


dcoeff_htrt_p(1) = dcoeff_htrt_p_000(1);
dcoeff_htrt_p(2) = dcoeff_htrt_p_010(1);
dcoeff_htrt_p(3) = dcoeff_htrt_p_025(1);
dcoeff_htrt_p(4) = dcoeff_htrt_p_050(1);
dcoeff_htrt_p(5) = dcoeff_htrt_p_075(1);
dcoeff_htrt_p(6) = dcoeff_htrt_p_100(1);

dcoeff_cnvht_p(1) = dcoeff_cnvht_p_000(1);
dcoeff_cnvht_p(2) = dcoeff_cnvht_p_010(1);
dcoeff_cnvht_p(3) = dcoeff_cnvht_p_025(1);
dcoeff_cnvht_p(4) = dcoeff_cnvht_p_050(1);
dcoeff_cnvht_p(5) = dcoeff_cnvht_p_075(1);
dcoeff_cnvht_p(6) = dcoeff_cnvht_p_100(1);

dcoeff_cndht_p(1) = dcoeff_cndht_p_000(1);
dcoeff_cndht_p(2) = dcoeff_cndht_p_010(1);
dcoeff_cndht_p(3) = dcoeff_cndht_p_025(1);
dcoeff_cndht_p(4) = dcoeff_cndht_p_050(1);
dcoeff_cndht_p(5) = dcoeff_cndht_p_075(1);
dcoeff_cndht_p(6) = dcoeff_cndht_p_100(1);

dcoeff_radht_p(1) = dcoeff_radht_p_000(1);
dcoeff_radht_p(2) = dcoeff_radht_p_010(1);
dcoeff_radht_p(3) = dcoeff_radht_p_025(1);
dcoeff_radht_p(4) = dcoeff_radht_p_050(1);
dcoeff_radht_p(5) = dcoeff_radht_p_075(1);
dcoeff_radht_p(6) = dcoeff_radht_p_100(1);

dcoeff_difht_p(1) = dcoeff_difht_p_000(1);
dcoeff_difht_p(2) = dcoeff_difht_p_010(1);
dcoeff_difht_p(3) = dcoeff_difht_p_025(1);
dcoeff_difht_p(4) = dcoeff_difht_p_050(1);
dcoeff_difht_p(5) = dcoeff_difht_p_075(1);
dcoeff_difht_p(6) = dcoeff_difht_p_100(1);


fileID = fopen('dcoeff_trop.txt','w');
fprintf(fileID,'\n%s','htrt')
fprintf(fileID,'\n%s',num2str(dcoeff_htrt_n))
fprintf(fileID,'\n%s',num2str(dcoeff_htrt_p))
fprintf(fileID,'\n%s','cnvht')
fprintf(fileID,'\n%s',num2str(dcoeff_cnvht_n))
fprintf(fileID,'\n%s',num2str(dcoeff_cnvht_p))
fprintf(fileID,'\n%s','cndht')
fprintf(fileID,'\n%s',num2str(dcoeff_cndht_n))
fprintf(fileID,'\n%s',num2str(dcoeff_cndht_p))
fprintf(fileID,'\n%s','difht')
fprintf(fileID,'\n%s',num2str(dcoeff_difht_n))
fprintf(fileID,'\n%s',num2str(dcoeff_difht_p))
fprintf(fileID,'\n%s','radht')
fprintf(fileID,'\n%s',num2str(dcoeff_radht_n))
fprintf(fileID,'\n%s',num2str(dcoeff_radht_p))
fclose(fileID)


figure
plot(es0,dcoeff_htrt_n,'LineWidth',2)
set(gca,'FontSize',15)
hold on
ylim([-1 0.5])
plot(es0,dcoeff_htrt_p,'r','LineWidth',2)
title('Total diabatic heating')
xlabel('Saturation vapour pressure fraction','FontSize',15)
ylabel('Damping coefficient estimate, day^{-1}','FontSize',15)
print('-depsc2','-r300','damping_coeff_trop_htrt.eps')


figure
plot(es0,dcoeff_difht_n,'LineWidth',2)
set(gca,'FontSize',15)
hold on
ylim([-1 0.5])
plot(es0,dcoeff_difht_p,'r','LineWidth',2)
title('Diffusive heating')
xlabel('Saturation vapour pressure fraction','FontSize',15)
ylabel('Damping coefficient estimate, day^{-1}','FontSize',15)
print('-depsc2','-r300','damping_coeff_trop_difht.eps')


figure
plot(es0,dcoeff_cnvht_n,'LineWidth',2)
set(gca,'FontSize',15)
hold on
ylim([-1 0.5])
plot(es0,dcoeff_cnvht_p,'r','LineWidth',2)
title('Convective heating')
xlabel('Saturation vapour pressure fraction','FontSize',15)
ylabel('Damping coefficient estimate, day^{-1}','FontSize',15)
print('-depsc2','-r300','damping_coeff_trop_cnvht.eps')


figure
plot(es0,dcoeff_radht_n,'LineWidth',2)
set(gca,'FontSize',15)
hold on
ylim([-1 0.5])
plot(es0,dcoeff_radht_p,'r','LineWidth',2)
title('Radiative heating')
xlabel('Saturation vapour pressure fraction','FontSize',15)
ylabel('Damping coefficient estimate, day^{-1}','FontSize',15)
print('-depsc2','-r300','damping_coeff_trop_radht.eps')


figure
plot(es0,dcoeff_cndht_n,'LineWidth',2)
set(gca,'FontSize',15)
hold on
ylim([-1 0.5])
plot(es0,dcoeff_cndht_p,'r','LineWidth',2)
title('Condensational heating')
xlabel('Saturation vapour pressure fraction','FontSize',15)
ylabel('Damping coefficient estimate, day^{-1}','FontSize',15)
print('-depsc2','-r300','damping_coeff_trop_cndht.eps')

close all









load('/project/rg312/mat_files/damping_coeffs_troplid.mat')


dcoeff_htrt_n(1) = dcoeff_htrt_n_000(1);
dcoeff_htrt_n(2) = dcoeff_htrt_n_010(1);
dcoeff_htrt_n(3) = dcoeff_htrt_n_025(1);
dcoeff_htrt_n(4) = dcoeff_htrt_n_050(1);
dcoeff_htrt_n(5) = dcoeff_htrt_n_075(1);
dcoeff_htrt_n(6) = dcoeff_htrt_n_100(1);

dcoeff_cnvht_n(1) = dcoeff_cnvht_n_000(1);
dcoeff_cnvht_n(2) = dcoeff_cnvht_n_010(1);
dcoeff_cnvht_n(3) = dcoeff_cnvht_n_025(1);
dcoeff_cnvht_n(4) = dcoeff_cnvht_n_050(1);
dcoeff_cnvht_n(5) = dcoeff_cnvht_n_075(1);
dcoeff_cnvht_n(6) = dcoeff_cnvht_n_100(1);

dcoeff_cndht_n(1) = dcoeff_cndht_n_000(1);
dcoeff_cndht_n(2) = dcoeff_cndht_n_010(1);
dcoeff_cndht_n(3) = dcoeff_cndht_n_025(1);
dcoeff_cndht_n(4) = dcoeff_cndht_n_050(1);
dcoeff_cndht_n(5) = dcoeff_cndht_n_075(1);
dcoeff_cndht_n(6) = dcoeff_cndht_n_100(1);

dcoeff_radht_n(1) = dcoeff_radht_n_000(1);
dcoeff_radht_n(2) = dcoeff_radht_n_010(1);
dcoeff_radht_n(3) = dcoeff_radht_n_025(1);
dcoeff_radht_n(4) = dcoeff_radht_n_050(1);
dcoeff_radht_n(5) = dcoeff_radht_n_075(1);
dcoeff_radht_n(6) = dcoeff_radht_n_100(1);

dcoeff_difht_n(1) = dcoeff_difht_n_000(1);
dcoeff_difht_n(2) = dcoeff_difht_n_010(1);
dcoeff_difht_n(3) = dcoeff_difht_n_025(1);
dcoeff_difht_n(4) = dcoeff_difht_n_050(1);
dcoeff_difht_n(5) = dcoeff_difht_n_075(1);
dcoeff_difht_n(6) = dcoeff_difht_n_100(1);


dcoeff_htrt_p(1) = dcoeff_htrt_p_000(1);
dcoeff_htrt_p(2) = dcoeff_htrt_p_010(1);
dcoeff_htrt_p(3) = dcoeff_htrt_p_025(1);
dcoeff_htrt_p(4) = dcoeff_htrt_p_050(1);
dcoeff_htrt_p(5) = dcoeff_htrt_p_075(1);
dcoeff_htrt_p(6) = dcoeff_htrt_p_100(1);

dcoeff_cnvht_p(1) = dcoeff_cnvht_p_000(1);
dcoeff_cnvht_p(2) = dcoeff_cnvht_p_010(1);
dcoeff_cnvht_p(3) = dcoeff_cnvht_p_025(1);
dcoeff_cnvht_p(4) = dcoeff_cnvht_p_050(1);
dcoeff_cnvht_p(5) = dcoeff_cnvht_p_075(1);
dcoeff_cnvht_p(6) = dcoeff_cnvht_p_100(1);

dcoeff_cndht_p(1) = dcoeff_cndht_p_000(1);
dcoeff_cndht_p(2) = dcoeff_cndht_p_010(1);
dcoeff_cndht_p(3) = dcoeff_cndht_p_025(1);
dcoeff_cndht_p(4) = dcoeff_cndht_p_050(1);
dcoeff_cndht_p(5) = dcoeff_cndht_p_075(1);
dcoeff_cndht_p(6) = dcoeff_cndht_p_100(1);

dcoeff_radht_p(1) = dcoeff_radht_p_000(1);
dcoeff_radht_p(2) = dcoeff_radht_p_010(1);
dcoeff_radht_p(3) = dcoeff_radht_p_025(1);
dcoeff_radht_p(4) = dcoeff_radht_p_050(1);
dcoeff_radht_p(5) = dcoeff_radht_p_075(1);
dcoeff_radht_p(6) = dcoeff_radht_p_100(1);

dcoeff_difht_p(1) = dcoeff_difht_p_000(1);
dcoeff_difht_p(2) = dcoeff_difht_p_010(1);
dcoeff_difht_p(3) = dcoeff_difht_p_025(1);
dcoeff_difht_p(4) = dcoeff_difht_p_050(1);
dcoeff_difht_p(5) = dcoeff_difht_p_075(1);
dcoeff_difht_p(6) = dcoeff_difht_p_100(1);



fileID = fopen('dcoeff_troplid.txt','w');
fprintf(fileID,'\n%s','htrt')
fprintf(fileID,'\n%s',num2str(dcoeff_htrt_n))
fprintf(fileID,'\n%s',num2str(dcoeff_htrt_p))
fprintf(fileID,'\n%s','cnvht')
fprintf(fileID,'\n%s',num2str(dcoeff_cnvht_n))
fprintf(fileID,'\n%s',num2str(dcoeff_cnvht_p))
fprintf(fileID,'\n%s','cndht')
fprintf(fileID,'\n%s',num2str(dcoeff_cndht_n))
fprintf(fileID,'\n%s',num2str(dcoeff_cndht_p))
fprintf(fileID,'\n%s','difht')
fprintf(fileID,'\n%s',num2str(dcoeff_difht_n))
fprintf(fileID,'\n%s',num2str(dcoeff_difht_p))
fprintf(fileID,'\n%s','radht')
fprintf(fileID,'\n%s',num2str(dcoeff_radht_n))
fprintf(fileID,'\n%s',num2str(dcoeff_radht_p))
fclose(fileID)


figure
plot(es0,dcoeff_htrt_n,'LineWidth',2)
set(gca,'FontSize',15)
hold on
ylim([-1 0.5])
plot(es0,dcoeff_htrt_p,'r','LineWidth',2)
title('Total diabatic heating')
xlabel('Saturation vapour pressure fraction','FontSize',15)
ylabel('Damping coefficient estimate, day^{-1}','FontSize',15)
print('-depsc2','-r300','damping_coeff_troplid_htrt.eps')


figure
plot(es0,dcoeff_difht_n,'LineWidth',2)
set(gca,'FontSize',15)
hold on
ylim([-1 0.5])
plot(es0,dcoeff_difht_p,'r','LineWidth',2)
title('Diffusive heating')
xlabel('Saturation vapour pressure fraction','FontSize',15)
ylabel('Damping coefficient estimate, day^{-1}','FontSize',15)
print('-depsc2','-r300','damping_coeff_troplid_difht.eps')


figure
plot(es0,dcoeff_cnvht_n,'LineWidth',2)
set(gca,'FontSize',15)
hold on
ylim([-1 0.5])
plot(es0,dcoeff_cnvht_p,'r','LineWidth',2)
title('Convective heating')
xlabel('Saturation vapour pressure fraction','FontSize',15)
ylabel('Damping coefficient estimate, day^{-1}','FontSize',15)
print('-depsc2','-r300','damping_coeff_troplid_cnvht.eps')


figure
plot(es0,dcoeff_radht_n,'LineWidth',2)
set(gca,'FontSize',15)
hold on
ylim([-1 0.5])
plot(es0,dcoeff_radht_p,'r','LineWidth',2)
title('Radiative heating')
xlabel('Saturation vapour pressure fraction','FontSize',15)
ylabel('Damping coefficient estimate, day^{-1}','FontSize',15)
print('-depsc2','-r300','damping_coeff_troplid_radht.eps')


figure
plot(es0,dcoeff_cndht_n,'LineWidth',2)
set(gca,'FontSize',15)
hold on
ylim([-1 0.5])
plot(es0,dcoeff_cndht_p,'r','LineWidth',2)
title('Condensational heating')
xlabel('Saturation vapour pressure fraction','FontSize',15)
ylabel('Damping coefficient estimate, day^{-1}','FontSize',15)
print('-depsc2','-r300','damping_coeff_troplid_cndht.eps')

close all
