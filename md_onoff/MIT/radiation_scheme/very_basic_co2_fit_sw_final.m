%load up q and tau data for each run
%take mean difference of tau from 1co2 run
%fit co2 to this
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

%consts
stefan 	= 5.6734e-8;
B_tot = stefan.*t_in.^4;
window = 0.3732;
B_win = B_tot.*window;
B = B_tot - B_win;

load('~/md_onoff/radiation_chapter_beginning/sw_sbdart.mat')
for i=1:26
tau(:,i) = -log(fxdn_sw(:,i)./fxdn_sw(:,1));
end
%dtau between flux levels
for k=1:25
dtau(:,k)=tau(:,k+1)-tau(:,k);
end
dtaudsigma_1co2 = dtau./0.04;
clear('tau','dtau')

load('double_co2_runs/sw_sbdart_2co2.mat')
for i=1:26
tau(:,i) = -log(fxdn_sw(:,i)./fxdn_sw(:,1));
end
%dtau between flux levels
for k=1:25
dtau(:,k)=tau(:,k+1)-tau(:,k);
end
dtaudsigma_2co2 = dtau./0.04;
clear('tau','dtau')

load('4_co2_runs/sw_sbdart_4co2.mat')
for i=1:26
tau(:,i) = -log(fxdn_sw(:,i)./fxdn_sw(:,1));
end
%dtau between flux levels
for k=1:25
dtau(:,k)=tau(:,k+1)-tau(:,k);
end
dtaudsigma_4co2 = dtau./0.04;
clear('tau','dtau')

load('10_co2_runs/sw_sbdart_10co2.mat')
for i=1:26
tau(:,i) = -log(fxdn_sw(:,i)./fxdn_sw(:,1));
end
%dtau between flux levels
for k=1:25
dtau(:,k)=tau(:,k+1)-tau(:,k);
end
dtaudsigma_10co2 = dtau./0.04;
clear('tau','dtau')

load('20_co2_runs/sw_sbdart_20co2.mat')
for i=1:26
tau(:,i) = -log(fxdn_sw(:,i)./fxdn_sw(:,1));
end
%dtau between flux levels
for k=1:25
dtau(:,k)=tau(:,k+1)-tau(:,k);
end
dtaudsigma_20co2 = dtau./0.04;
clear('tau','dtau')

tau_diff_mean(1) = 0;
tau_diff_mean(2) = mean(mean((real(dtaudsigma_2co2(2:89,:)  - dtaudsigma_1co2(2:89,:)))));
tau_diff_mean(3) = mean(mean((real(dtaudsigma_4co2(2:89,:)  - dtaudsigma_1co2(2:89,:)))));
tau_diff_mean(4) = mean(mean((real(dtaudsigma_10co2(2:45,:)  - dtaudsigma_1co2(2:45,:)))));
tau_diff_mean(5) = mean(mean((real(dtaudsigma_20co2(2:45,:)  - dtaudsigma_1co2(2:45,:)))));


%Fitting time!

co2 = [360,720,1440,3600,7200];
b_l = regress(tau_diff_mean',log(co2'./360));
b_sq = regress(tau_diff_mean',sqrt(co2')-sqrt(360));

figure
plot(co2,tau_diff_mean,'xk')
hold on
plot(co2,b_sq.*(sqrt(co2) - sqrt(360)),'b');
plot(co2,b_l.*log(co2./360),'g');
print('-dpng','sw_tau_fits.png')

