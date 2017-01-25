load('sw_sbdart.mat')
load('/project/rg312/mat_files/radiation_chapter/uvwqt_tav_radon.mat','q_tav','theta_tav')

rDir='/project/rg312/final_runs/run_100_rad_on/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));
drC=squeeze(rdmds([rDir,'DRC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
xi=-179:2:179;
yi=-89:2:89;


    convthetatoT=(rC/100000.0).^(2./7.);
    for k=1:size(rC)
      t_tav(:,:,k)=theta_tav(:,:,k).*convthetatoT(k,1);
    end


q_ll=cube2latlon(xc,yc,q_tav,xi,yi);
%theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
t_ll=cube2latlon(xc,yc,t_tav,xi,yi);

q_zav(:,:) = mean(q_ll,1);
%theta_zav(:,:) = mean(theta_ll,1);
t_zav(:,:) = mean(t_ll,1);

t_zav = flipdim(t_zav,2);
q_zav = flipdim(q_zav,2);


for i=1:25
trans(:,i) = fxdn_sw(:,i+1)./fxdn_sw(:,1);
end

tau = -log(trans);

dsigma = 4000./100000;

%dtaudsigma = gradient(tau,dsigma);

for i=1:24
dtaudsigma(:,i) = (tau(:,i+1) - tau(:,i))./dsigma;
q_zav_h(:,i) = (q_zav(:,i) + q_zav(:,i+1))./2;
end

%dtau = gradient(tau);

b = (dtaudsigma - 0.0596)./q_zav_h;
plot(tau(:,1:24),b,'xk');
hold on
b_est = exp(0.01887./(tau + 0.009522) + 1.603./(tau+0.5194).^2);
plot(tau,b_est,'r');
