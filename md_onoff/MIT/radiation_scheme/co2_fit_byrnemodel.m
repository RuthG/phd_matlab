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
B = stefan.*t_in.^4;


load('0_co2_runs/lw_sbdart_0co2.mat')
fxdn_lw = fxdn_lw_u + fxdn_lw_l + fxdn_win;
for k=1:25
    dtrans_dn(:,k) = (fxdn_lw(:,k+1) - B(1:45,k)) ./ (fxdn_lw(:,k) - B(1:45,k));
end
dtau_dn_0co2 = -log(dtrans_dn);
clear('dtrans_dn')

load('~/md_onoff/radiation_chapter_beginning/lw_sbdart.mat')
fxup_lw(:,1) = fxup_lw_u(1:45,1) + fxup_lw_l(1:45,1) + fxup_win(1:45,1);
fxdn_lw = fxdn_lw_u + fxdn_lw_l + fxdn_win;
dn_lw(:,1) = fxdn_lw(1:45,26);
for k=1:25
    dtrans_dn(:,k) = (fxdn_lw(:,k+1) - B(:,k)) ./ (fxdn_lw(:,k) - B(:,k));
end
dtau_dn_1co2 = -log(dtrans_dn);

load('double_co2_runs/lw_sbdart_2co2.mat')
fxup_lw(:,2) = fxup_lw_u(1:45,1) + fxup_lw_l(1:45,1) + fxup_win(1:45,1);
fxdn_lw = fxdn_lw_u + fxdn_lw_l + fxdn_win;
dn_lw(:,2) = fxdn_lw(1:45,26);
for k=1:25
    dtrans_dn(:,k) = (fxdn_lw(:,k+1) - B(:,k)) ./ (fxdn_lw(:,k) - B(:,k));
end
dtau_dn_2co2 = -log(dtrans_dn);

load('4_co2_runs/lw_sbdart_4co2.mat')
fxup_lw(:,3) = fxup_lw_u(1:45,1) + fxup_lw_l(1:45,1) + fxup_win(1:45,1);
fxdn_lw = fxdn_lw_u + fxdn_lw_l + fxdn_win;
dn_lw(:,3) = fxdn_lw(1:45,26);
for k=1:25
    dtrans_dn(:,k) = (fxdn_lw(:,k+1) - B(:,k)) ./ (fxdn_lw(:,k) - B(:,k));
end
dtau_dn_4co2 = -log(dtrans_dn);
clear('dtrans_dn')

load('10_co2_runs/lw_sbdart_10co2.mat')
fxup_lw(:,4) = fxup_lw_u(1:45,1) + fxup_lw_l(1:45,1) + fxup_win(1:45,1);
fxdn_lw = fxdn_lw_u + fxdn_lw_l + fxdn_win;
dn_lw(:,4) = fxdn_lw(1:45,26);
for k=1:25
    dtrans_dn(:,k) = (fxdn_lw(1:45,k+1) - B(1:45,k)) ./ (fxdn_lw(1:45,k) - B(1:45,k));
end
dtau_dn_10co2 = -log(dtrans_dn);
clear('dtrans_dn')

load('20_co2_runs/lw_sbdart_20co2.mat')
fxup_lw(:,5) = fxup_lw_u(1:45,1) + fxup_lw_l(1:45,1) + fxup_win(1:45,1);
fxdn_lw = fxdn_lw_u + fxdn_lw_l + fxdn_win;
dn_lw(:,5) = fxdn_lw(1:45,26);
for k=1:25
    dtrans_dn(:,k) = (fxdn_lw(1:45,k+1) - B(1:45,k)) ./ (fxdn_lw(1:45,k) - B(1:45,k));
end
dtau_dn_20co2 = -log(dtrans_dn);


tau_diff_mean(1) = 0;
tau_diff_mean(2) = mean(mean((real(dtau_dn_2co2(2:89,:)  - dtau_dn_1co2(2:89,:)))))./0.04;
tau_diff_mean(3) = mean(mean((real(dtau_dn_4co2(2:89,:)  - dtau_dn_1co2(2:89,:)))))./0.04;
tau_diff_mean(4) = mean(mean((real(dtau_dn_10co2(2:45,:) - dtau_dn_1co2(2:45,:)))))./0.04;
tau_diff_mean(5) = mean(mean((real(dtau_dn_20co2(2:45,:) - dtau_dn_1co2(2:45,:)))))./0.04;


%Fitting time!

co2 = [360,720,1440,3600,7200];
b_l = regress(tau_diff_mean',log(co2'./360));


figure
plot(co2,tau_diff_mean,'xk')
hold on
plot(co2,b_l.*log(co2./360));
print('-dpng','co2_fit_nowin.png')

yy=yi*90/60*pi/180;
sinyy=sin(yy);
sst=27*(1-sinyy.*sinyy);
sst(find(abs(yi)>=60))=0;
t_surf=sst+273.15;
b_surf = stefan*t_surf.^4;

bog_a = 0.8678;
bog_b = 1997.9;

cp_air = 287.04./(2./7);
p = 0:4000:100000;
p_half = 2000:4000:98000;


for i=1:5

    lw_del_tau = (bog_a + b_l.*log(co2(i)./360.) + bog_b*q_in) .*0.04;
    lw_dtrans = exp( - lw_del_tau );

    down(1:90,1) = 0.0;

    for k = 1:25
        down(:,k+1) = down(:,k).*lw_dtrans(:,k) + B(:,k).*(1.0 - lw_dtrans(:,k));
    end 

    up(:,26) = b_surf;

    for k = 25:-1:1
        up(:,k) = up(:,k+1).*lw_dtrans(:,k) + B(:,k).*(1.0 - lw_dtrans(:,k));
    end

    net = up - down;

    for k=1:25
        tdt_lw(:,k) = (net(:,k+1) - net(:,k)).*9.8./(cp_air.*(p(k+1) - p(k)));
    end

    up_plot(:,i) = up(:,1);
    dn_plot(:,i) = down(:,26);

	
    figure
    [C,h]=contour(yi,p_half,tdt_lw'.*86400,'k');
    clabel(C,h);
    set(gca,'YDir','reverse');
    print('-dpng',['lw_heating_co2' num2str(co2(i)) '.png'])

end
		
figure
plot(yi(2:45),up_plot(2:45,:))
hold on
plot(yi(2:45),fxup_lw(2:45,:),'--')
print('-dpng','lw_toa_flux.png')

figure
plot(yi(2:45),up_plot(2:45,2:5)-repmat(up_plot(2:45,1),[1 4]))
hold on
plot(yi(2:45),fxup_lw(2:45,2:5)-repmat(fxup_lw(2:45,1),[1 4]),'--')
print('-dpng','lw_toa_flux_diff.png')


figure
plot(yi(2:45),dn_plot(2:45,:))
hold on
plot(yi(2:45),dn_lw(2:45,:),'--')
print('-dpng','lw_toa_flux.png')

figure
plot(yi(2:45),dn_plot(2:45,2:5)-repmat(dn_plot(2:45,1),[1 4]))
hold on
plot(yi(2:45),dn_lw(2:45,2:5)-repmat(dn_lw(2:45,1),[1 4]),'--')
print('-dpng','lw_toa_flux_diff.png')