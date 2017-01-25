%load in theta data for a year of daily data, try to get a rough idea of how theta'^3/theta^3 compares with theta'^2/theta^2


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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run) %%%%%%%%%%%%%%%%

i=0;
for nit = 605040:240:691200;
i=i+1
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta(:,:,:,i) = dyn(:,:,:,J);
end

thetasq = theta.^2;
thetacu = theta.^3;

theta_mean = mean(theta,4);
thetasq_mean = mean(thetasq,4);
thetacu_mean = mean(thetacu,4);

xi=-179:2:180;yi=-89:2:90;
thetall = cube2latlon(xc,yc,theta_mean,xi,yi);
thetasqll = cube2latlon(xc,yc,thetasq_mean,xi,yi);
thetacull = cube2latlon(xc,yc,thetacu_mean,xi,yi);

theta_zav(:,:) = mean(thetall,1);
thetasq_zav(:,:) = mean(thetasqll,1);
thetacu_zav(:,:) = mean(thetacull,1);

thetasq_ed_zav = (thetasq_zav - theta_zav.^2)./theta_zav.^2;
thetacu_ed_zav = (thetacu_zav - theta_zav.^3)./theta_zav.^3;




