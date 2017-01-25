%check mape calculation step by step using es=610.78 case


load('mape_data.mat')

[theta_f_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_f,ny,yc,ar,hc);
theta_f_tzav = mean(theta_f_zav,3);
contourf(ylat,rC,theta_f_tzav',20);
colorbar
set(gca,'YDir','reverse')
print('-dpng','mape_check/theta.png')

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp_f_tzav(:,j)=theta_f_tzav(:,j).*convthetatoT(j,1);
end

contourf(ylat,rC,temp_f_tzav',20);
colorbar
set(gca,'YDir','reverse')
print('-dpng','mape_check/temp.png')

[dthetadp_f,junk] = gradient(theta_f_tzav,-4000.);
contourf(ylat,rC,dthetadp_f',20);
colorbar
set(gca,'YDir','reverse')
print('-dpng','mape_check/dthetadp.png')

for i=1:90
weighted_dthdp_f(i,:) = dthetadp_f(i,:).*cos(ylat(i).*pi./180);
end

dthetadp_f_bzav = (mean(dthetadp_f(max_no_f(1):min_no_f(1),:),1) + mean(dthetadp_f(min_no_f(2):max_no_f(2),:),1))./2;
plot(dthetadp_f_bzav,rC)
set(gca,'YDir','reverse')
print('-dpng','mape_check/dthetadp_bzav.png')

dthetadp_f_bzavw = (sum(weighted_dthdp_f(max_no_f(1):min_no_f(1),:),1)./sum(cos(ylat(max_no_f(1):min_no_f(1)).*pi./180)) + sum(weighted_dthdp_f(min_no_f(2):max_no_f(2),:),1)./sum(cos(ylat(min_no_f(2):max_no_f(2)).*pi./180)))./2;

%dthetadp_f_bzavw = (mean(weighted_dthdp_f(max_no_f(1):min_no_f(1),:),1) + mean(weighted_dthdp_f(min_no_f(2):max_no_f(2),:),1))./2;

plot(dthetadp_f_bzavw,rC)
set(gca,'YDir','reverse')
print('-dpng','mape_check/dthetadp_bzavw.png')


gamma_f = -2./(7.*rC.*dthetadp_f_bzav');
plot(gamma_f,rC)
set(gca,'YDir','reverse')
print('-dpng','mape_check/gamma.png')


gamma_fw = -2./(7.*rC.*dthetadp_f_bzavw');
plot(gamma_fw,rC)
set(gca,'YDir','reverse')
print('-dpng','mape_check/gammaw.png')



%weighted gamma mayyybeee better? Try same for theta variance

%square of tzav theta
thsq_f_zav = theta_f_tzav.^2;

for i=1:90
weighted_thsq_f(i,:) = thsq_f_zav(i,:).*cos(ylat(i).*pi./180);
weighted_theta_f(i,:) = theta_f_tzav(i,:).*cos(ylat(i).*pi./180);
end

%average theta^2 and theta over baroclinic zone

thsq_f_bzavw = (sum(weighted_thsq_f(max_no_f(1):min_no_f(1),:),1)./sum(cos(ylat(max_no_f(1):min_no_f(1)).*pi./180)) + sum(weighted_thsq_f(min_no_f(2):max_no_f(2),:),1)./sum(cos(ylat(min_no_f(2):max_no_f(2)).*pi./180)))./2;

theta_f_bzavw = (sum(weighted_theta_f(max_no_f(1):min_no_f(1),:),1)./sum(cos(ylat(max_no_f(1):min_no_f(1)).*pi./180)) + sum(weighted_theta_f(min_no_f(2):max_no_f(2),:),1)./sum(cos(ylat(min_no_f(2):max_no_f(2)).*pi./180)))./2;


theta_f_bzavsqw = theta_f_bzavw.^2;

%calculate variance of thetasq around average over baroclinic zone

thsq_f_edw = thsq_f_bzavw - theta_f_bzavsqw;
