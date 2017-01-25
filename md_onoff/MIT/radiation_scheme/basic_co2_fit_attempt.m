%load up q and tau data for each run
%mask for q values between 0.2 and 0.3 g/kg
%use these q values to remove the q fit from the scatter (i.e. q + q2 or q0.5 part)
%plot remaining scatter for CO2 plus decide on a fit to this
%replot dtau fits with adjustment to see if cross terms could be avoided...


%load grid
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

%load q and t data
load('/project/rg312/mat_files/radiation_chapter/uvwqt_tav_radon.mat','q_tav','theta_tav')

    convthetatoT=(rC/100000.0).^(2./7.);
    for k=1:size(rC)
      t_tav(:,:,k)=theta_tav(:,:,k).*convthetatoT(k,1);
    end

q_ll=cube2latlon(xc,yc,q_tav,xi,yi);
t_ll=cube2latlon(xc,yc,t_tav,xi,yi);
q_zav(:,:) = mean(q_ll,1);
t_zav(:,:) = mean(t_ll,1);
q_in = flipdim(q_zav,2);
t_in = flipdim(t_zav,2);

%mask q for lower values only
q_mask = +(q_in(1:45,:) >= 0.2./1000 & q_in(1:45,:) <= 0.3./1000);

%consts
stefan 	= 5.6734e-8;
B_tot = stefan.*t_in.^4;
window = 0.3732;
B_win = B_tot.*window;
B = B_tot - B_win;


load('0_co2_runs/lw_sbdart_0co2.mat')
fxdn_lw = fxdn_lw_u + fxdn_lw_l;
for k=1:25
dtrans_dn(:,k) = (fxdn_lw(:,k+1) - B(1:45,k)) ./ (fxdn_lw(:,k) - B(1:45,k));
dtrans_win_dn(:,k) = (fxdn_win(:,k+1) - B_win(1:45,k)) ./ (fxdn_win(:,k) - B_win(1:45,k));
end
dtau_dn_0co2 = -log(dtrans_dn);
dtau_win_dn_0co2 = -log(dtrans_win_dn);

clear('dtrans_dn','dtrans_win_dn')

load('~/md_onoff/radiation_chapter_beginning/lw_sbdart.mat')
fxdn_lw = fxdn_lw_u + fxdn_lw_l;
for k=1:25
dtrans_dn(:,k) = (fxdn_lw(:,k+1) - B(:,k)) ./ (fxdn_lw(:,k) - B(:,k));
dtrans_win_dn(:,k) = (fxdn_win(:,k+1) - B_win(:,k)) ./ (fxdn_win(:,k) - B_win(:,k));
end
dtau_dn_1co2 = -log(dtrans_dn);
dtau_win_dn_1co2 = -log(dtrans_win_dn);

load('double_co2_runs/lw_sbdart_2co2.mat')
fxdn_lw = fxdn_lw_u + fxdn_lw_l;
for k=1:25
dtrans_dn(:,k) = (fxdn_lw(:,k+1) - B(:,k)) ./ (fxdn_lw(:,k) - B(:,k));
dtrans_win_dn(:,k) = (fxdn_win(:,k+1) - B_win(:,k)) ./ (fxdn_win(:,k) - B_win(:,k));
end
dtau_dn_2co2 = -log(dtrans_dn);
dtau_win_dn_2co2 = -log(dtrans_win_dn);

load('4_co2_runs/lw_sbdart_4co2.mat')
fxdn_lw = fxdn_lw_u + fxdn_lw_l;
for k=1:25
dtrans_dn(:,k) = (fxdn_lw(:,k+1) - B(:,k)) ./ (fxdn_lw(:,k) - B(:,k));
dtrans_win_dn(:,k) = (fxdn_win(:,k+1) - B_win(:,k)) ./ (fxdn_win(:,k) - B_win(:,k));
end
dtau_dn_4co2 = -log(dtrans_dn);
dtau_win_dn_4co2 = -log(dtrans_win_dn);

clear('dtrans_dn','dtrans_win_dn')

load('10_co2_runs/lw_sbdart_10co2.mat')
fxdn_lw = fxdn_lw_u + fxdn_lw_l;
for k=1:25
dtrans_dn(:,k) = (fxdn_lw(1:45,k+1) - B(1:45,k)) ./ (fxdn_lw(1:45,k) - B(1:45,k));
dtrans_win_dn(:,k) = (fxdn_win(1:45,k+1) - B_win(1:45,k)) ./ (fxdn_win(1:45,k) - B_win(1:45,k));
end
dtau_dn_10co2 = -log(dtrans_dn);
dtau_win_dn_10co2 = -log(dtrans_win_dn);


q_masked = q_in(1:45,:).*q_mask(1:45,:);
q_masked = q_masked(q_mask~=0);

ir_tau_co2 	= 0.154925; 
ir_tau_wv 	= 351.48; 
ir_tau_co2_win  = 0.2150;
ir_tau_wv_win1  = 147.11;
ir_tau_wv_win2  = 1.0814e4;

del_tau = (ir_tau_co2 + ir_tau_wv.*q_masked.^0.5).*0.04;
del_tau_win = (ir_tau_co2_win + ir_tau_wv_win1.*q_masked + ir_tau_wv_win2.*q_masked.^2).*0.04;

co2(1:45) = 0;
co2(46:90) = 360;
co2(91:135) = 720;
co2(136:180) = 1440;
co2(181:225) = 3600;

dtau_masked = dtau_dn_0co2(1:45,:).*q_mask(1:45,:);
dtau_fitting(:,1) = dtau_masked(q_mask~=0) - del_tau;
dtau_masked = dtau_dn_1co2(1:45,:).*q_mask(1:45,:);
dtau_fitting(:,2) = dtau_masked(q_mask~=0) - del_tau;
dtau_masked = dtau_dn_2co2(1:45,:).*q_mask(1:45,:);
dtau_fitting(:,3) = dtau_masked(q_mask~=0) - del_tau;
dtau_masked = dtau_dn_4co2(1:45,:).*q_mask(1:45,:);
dtau_fitting(:,4) = dtau_masked(q_mask~=0) - del_tau;
dtau_masked = dtau_dn_10co2(1:45,:).*q_mask(1:45,:);
dtau_fitting(:,5) = dtau_masked(q_mask~=0) - del_tau;

dtau_masked = dtau_dn_0co2(1:45,:).*q_mask(1:45,:);
dtau_win_fitting(:,1) = dtau_masked(q_mask~=0) - del_tau_win;
dtau_masked = dtau_dn_1co2(1:45,:).*q_mask(1:45,:);
dtau_win_fitting(:,2) = dtau_masked(q_mask~=0) - del_tau_win;
dtau_masked = dtau_dn_2co2(1:45,:).*q_mask(1:45,:);
dtau_win_fitting(:,3) = dtau_masked(q_mask~=0) - del_tau_win;
dtau_masked = dtau_dn_4co2(1:45,:).*q_mask(1:45,:);
dtau_win_fitting(:,4) = dtau_masked(q_mask~=0) - del_tau_win;
dtau_masked = dtau_dn_10co2(1:45,:).*q_mask(1:45,:);
dtau_win_fitting(:,5) = dtau_masked(q_mask~=0) - del_tau_win;

dtau_fitting_long = reshape(dtau_fitting,[1,numel(dtau_fitting)]);
dtau_win_fitting_long = reshape(dtau_win_fitting,[1,numel(dtau_win_fitting)]);

%fit outside window using sqrt(co2) fn
b = regress(dtau_fitting_long'./0.04,sqrt(co2'));

%also tried sqrt(co2) and const, linear co2, linear co2 and const
%regress_vals(:,1) = ones(numel(co2),1);
%regress_vals(:,2) = sqrt(co2);
%b_lin = polyfit(co2(46:225),dtau_fitting_long(46:225)./0.04,1);

figure
plot(co2,dtau_fitting_long,'xk')
hold on
plot(co2,b.*sqrt(co2).*0.04)

%fit inside window
regress_vals(:,1) = ones(numel(co2),1);
regress_vals(:,2) = sqrt(co2);
b_win = regress(dtau_win_fitting_long'./0.04,regress_vals);

b_win_lin = polyfit(co2(46:225)',dtau_win_fitting_long(46:225)'./0.04,1);


figure
plot(co2,dtau_win_fitting_long,'xk')
hold on
plot(co2,(b_win(1) + b_win(2).*sqrt(co2)).*0.04)
plot(co2,(b_win_lin(2) + b_win_lin(1).*co2).*0.04,'r')



return
b_win_sqrt = regress(dtau_win_fitting_long'./0.04,sqrt(co2)');
b_win = polyfit(co2',dtau_win_fitting_long'./0.04,1);

b_win_0 = polyfit(co2',dtau_win_fitting_long./0.04,1);
b_win_0_q = polyfit(co2',dtau_win_fitting_long./0.04,2);


