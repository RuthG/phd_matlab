%load SBDART data and temperature profile and use to check lw parameterisation

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5year/';
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
ny=90;

%read files
i=0;
for nit = 259200:86400:432000;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'SALT    '));
q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta(:,:,:,i)=dyn(:,:,:,J);

end

    convthetatoT=(rC/101325.0).^(2./7.);
    for k=1:size(rC)
      t(:,:,k,:)=theta(:,:,k,:).*convthetatoT(k,1);
    end

q_mean = mean(q,4);
theta_mean = mean(theta,4);
t_mean = mean(t,4);

xi=-179:2:180;yi=-89:2:90;
qll=cube2latlon(xc,yc,q_mean,xi,yi);
thetall=cube2latlon(xc,yc,theta_mean,xi,yi);
tll=cube2latlon(xc,yc,t_mean,xi,yi);

q_zav(:,:) = mean(qll,1);
theta_zav(:,:) = mean(thetall,1);
t_zav(:,:) = mean(tll,1);

q_in = flipdim(q_zav,2);
t_in = flipdim(t_zav,2);

stefan 	= 5.6734e-8;

B_tot = stefan.*t_in.^4;

window = -0.0967.*(t_in./100).^2 + 0.6516.*t_in./100 - 0.7089;
%window = 0.3732;
B_win = B_tot.*window;
B = B_tot - B_win;


load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0922/lw_sbdart.mat')

p_half = 0.:4000:100000;

fxdn_lw = fxdn_lw_u + fxdn_lw_l;
fxup_lw = fxup_lw_u + fxup_lw_l;

for k=1:25

dtrans_dn(:,k) = (fxdn_lw(:,k+1) - B(:,k)) ./ (fxdn_lw(:,k) - B(:,k));

dtrans_up(:,k) = (fxup_lw(:,k) - B(:,k)) ./ (fxup_lw(:,k+1) - B(:,k));

dtrans_win_dn(:,k) = (fxdn_win(:,k+1) - B_win(:,k)) ./ (fxdn_win(:,k) - B_win(:,k));

dtrans_win_up(:,k) = (fxup_win(:,k) - B_win(:,k)) ./ (fxup_win(:,k+1) - B_win(:,k));

end

dtau_up = -log(dtrans_up);
dtau_win_up = -log(dtrans_win_up);

dtau_dn = -log(dtrans_dn);
dtau_win_dn = -log(dtrans_win_dn);



ir_tau_co2 	= 0.154925; 
ir_tau_wv 	= 351.48; 
ir_tau_co2_win  = 0.2150;
ir_tau_wv_win1  = 147.11;
ir_tau_wv_win2  = 1.0814e4;

ir_tau_co2 	= 3.547; 
ir_tau_wv1 	= 2279.9; 
ir_tau_wv2      = 9.8528e4;
ir_tau_co2_win  = 0.29;
ir_tau_wv_win1  = 146.18;
ir_tau_wv_win2  = 1.0433e4;


n=25;
  for k= 1:n
%    del_tau(:,k) = (ir_tau_co2 + ir_tau_wv.*q_in(:,k).^0.5).*(p_half(k+1) - p_half(k))./p_half(n+1);
    del_tau(:,k) = (ir_tau_co2 + ir_tau_wv1.*q_in(:,k) + ir_tau_wv2.*q_in(:,k).^2).*(p_half(k+1) - p_half(k))./p_half(n+1);
    %dtrans(:,k) = exp(-del_tau);
    del_tau_win(:,k) = (ir_tau_co2_win + ir_tau_wv_win1.*q_in(:,k) + ir_tau_wv_win2.*q_in(:,k).^2).*(p_half(k+1) - p_half(k))./p_half(n+1);
    %dtrans_win(:,k) = exp(-del_tau_win);
  end



