%mape_checker2.m
% Go through mape calculation step by step but BETTER than yesterdays code!!!
% Use the year we have with theta2 properly too!


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_thetasq/';
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Load data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=system('find mape_sens_data.mat');

if a > 0

nit = 691200;

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_thetasq/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta_f(:,:,:) = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETASQ '));
thetasq_f(:,:,:) = dyn(:,:,:,J);

save('mape_sens_data.mat')
else
load('mape_sens_data.mat')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% Start calculation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Take zonal average theta to calculate eddy theta^2 and dthetadp

[theta_f_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_f,ny,yc,ar,hc);
[thetasq_f_zav,mskzon,ylat,areazon]=calcZonalAvgCube(thetasq_f,ny,yc,ar,hc);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp_f_zav(:,j)=theta_f_zav(:,j).*convthetatoT(j,1);
end


%load up details of baroclinic zones
load('bc_box.mat')

% identify edges of baroclinic zone

if(mod(barzon_lats_f(1),2)==0)
min_no_f = find(abs(ylat) == barzon_lats_f(1)+1);
max_no_f = find(abs(ylat) == barzon_lats_f(2)-1);
else
min_no_f = find(abs(ylat) == barzon_lats_f(1));
max_no_f = find(abs(ylat) == barzon_lats_f(2));
end

%average theta^2 and theta over baroclinic zone

for i=1:90
weighted_theta_f(i,:) = theta_f_zav(i,:).*cos(ylat(i).*pi./180);
weighted_thetasq_f(i,:) = thetasq_f_zav(i,:).*cos(ylat(i).*pi./180);
end

thetasq_f_bzav = (sum(weighted_thetasq_f(max_no_f(1):min_no_f(1),:),1)./sum(cos(ylat(max_no_f(1):min_no_f(1)).*pi./180)) ...
               +  sum(weighted_thetasq_f(min_no_f(2):max_no_f(2),:),1)./sum(cos(ylat(min_no_f(2):max_no_f(2)).*pi./180)) ) ./2;

theta_f_bzav = (sum(weighted_theta_f(max_no_f(1):min_no_f(1),:),1)./sum(cos(ylat(max_no_f(1):min_no_f(1)).*pi./180)) ...
             +  sum(weighted_theta_f(min_no_f(2):max_no_f(2),:),1)./sum(cos(ylat(min_no_f(2):max_no_f(2)).*pi./180)) ) ./2;

theta_f_bzavsq = theta_f_bzav.^2;


thetasq_f_ed = thetasq_f_bzav - theta_f_bzavsq;


% differentiate theta w r t p
[dthetadp_f,junk] = gradient(theta_f_zav,-4000.);


for i=1:90
weighted_dthetadp_f(i,:) = dthetadp_f(i,:).*cos(ylat(i).*pi./180);
end

% average this over baroclinic zone too

dthetadp_f_bzav = (sum(weighted_dthetadp_f(max_no_f(1):min_no_f(1),:),1)./sum(cos(ylat(max_no_f(1):min_no_f(1)).*pi./180)) ...
                +  sum(weighted_dthetadp_f(min_no_f(2):max_no_f(2),:),1)./sum(cos(ylat(min_no_f(2):max_no_f(2)).*pi./180)) ) ./2;


% use to calculate gamma factor, see O'Gorman 2008
gamma_f = -2./(7.*rC.*dthetadp_f_bzav');

%calculate integrand for MAPE calculation
integrand_f = gamma_f.*(rC./10^5).^(2./7).*thetasq_f_ed';


%calculate constants for MAPE calculation
cp = 1004;
g = 9.81;
a = 6371.0e3;
prefactor = cp.*10^5./(2.*9.81); 
dsigma = 4000/101325.0;

%MAPE!!!!!!! YAY!!!!!
mape_f = sum(integrand_f(3:level_f)).*dsigma.*prefactor




