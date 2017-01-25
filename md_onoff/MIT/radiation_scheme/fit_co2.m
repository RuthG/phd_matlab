%for long wave absorption, load up window and non window optical depths for each run and look first at near equator profile in troposphere and stratosphere. Then look at midlats. 

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

stefan 	= 5.6734e-8;
B_tot = stefan.*t_in.^4;
window = 0.3732;
B_win = B_tot.*window;
B = B_tot - B_win;

p_half = 0.:4000:100000;

%load data....
load('0_co2_runs/lw_sbdart_0co2.mat')
fxdn_lw = fxdn_lw_u + fxdn_lw_l;
fxup_lw = fxup_lw_u + fxup_lw_l;
for k=1:25
dtrans_dn(:,k) = (fxdn_lw(:,k+1) - B(1:45,k)) ./ (fxdn_lw(:,k) - B(1:45,k));
dtrans_win_dn(:,k) = (fxdn_win(:,k+1) - B_win(1:45,k)) ./ (fxdn_win(:,k) - B_win(1:45,k));
end
dtau_dn_0co2 = -log(dtrans_dn);
dtau_win_dn_0co2 = -log(dtrans_win_dn);

clear('dtrans_dn','dtrans_win_dn')

load('~/md_onoff/radiation_chapter_beginning/lw_sbdart.mat')
fxdn_lw = fxdn_lw_u + fxdn_lw_l;
fxup_lw = fxup_lw_u + fxup_lw_l;
for k=1:25
dtrans_dn(:,k) = (fxdn_lw(:,k+1) - B(:,k)) ./ (fxdn_lw(:,k) - B(:,k));
dtrans_win_dn(:,k) = (fxdn_win(:,k+1) - B_win(:,k)) ./ (fxdn_win(:,k) - B_win(:,k));
end
dtau_dn_1co2 = -log(dtrans_dn);
dtau_win_dn_1co2 = -log(dtrans_win_dn);

load('double_co2_runs/lw_sbdart_2co2.mat')
fxdn_lw = fxdn_lw_u + fxdn_lw_l;
fxup_lw = fxup_lw_u + fxup_lw_l;
for k=1:25
dtrans_dn(:,k) = (fxdn_lw(:,k+1) - B(:,k)) ./ (fxdn_lw(:,k) - B(:,k));
dtrans_win_dn(:,k) = (fxdn_win(:,k+1) - B_win(:,k)) ./ (fxdn_win(:,k) - B_win(:,k));
end
dtau_dn_2co2 = -log(dtrans_dn);
dtau_win_dn_2co2 = -log(dtrans_win_dn);

load('4_co2_runs/lw_sbdart_4co2.mat')
fxdn_lw = fxdn_lw_u + fxdn_lw_l;
fxup_lw = fxup_lw_u + fxup_lw_l;
for k=1:25
dtrans_dn(:,k) = (fxdn_lw(:,k+1) - B(:,k)) ./ (fxdn_lw(:,k) - B(:,k));
dtrans_win_dn(:,k) = (fxdn_win(:,k+1) - B_win(:,k)) ./ (fxdn_win(:,k) - B_win(:,k));
end
dtau_dn_4co2 = -log(dtrans_dn);
dtau_win_dn_4co2 = -log(dtrans_win_dn);

clear('dtrans_dn','dtrans_win_dn')

load('10_co2_runs/lw_sbdart_10co2.mat')
fxdn_lw = fxdn_lw_u + fxdn_lw_l;
fxup_lw = fxup_lw_u + fxup_lw_l;
for k=1:25
dtrans_dn(:,k) = (fxdn_lw(1:45,k+1) - B(1:45,k)) ./ (fxdn_lw(1:45,k) - B(1:45,k));
dtrans_win_dn(:,k) = (fxdn_win(1:45,k+1) - B_win(1:45,k)) ./ (fxdn_win(1:45,k) - B_win(1:45,k));
end
dtau_dn_10co2 = -log(dtrans_dn);
dtau_win_dn_10co2 = -log(dtrans_win_dn);

dtau_dn_fnco2_eq(1,:) = dtau_dn_0co2(45,:);
dtau_dn_fnco2_eq(2,:) = dtau_dn_1co2(45,:);
dtau_dn_fnco2_eq(3,:) = dtau_dn_2co2(45,:);
dtau_dn_fnco2_eq(4,:) = dtau_dn_4co2(45,:);

dtau_dn_fnco2_ml(1,:) = dtau_dn_0co2(21,:);
dtau_dn_fnco2_ml(2,:) = dtau_dn_1co2(21,:);
dtau_dn_fnco2_ml(3,:) = dtau_dn_2co2(21,:);
dtau_dn_fnco2_ml(4,:) = dtau_dn_4co2(21,:);

dtau_dn_fnco2_top(1:44) = dtau_dn_0co2(2:45,1);
dtau_dn_fnco2_top(45:88) = dtau_dn_1co2(2:45,1);
dtau_dn_fnco2_top(89:132) = dtau_dn_2co2(2:45,1);
dtau_dn_fnco2_top(133:176) = dtau_dn_4co2(2:45,1);
dtau_dn_fnco2_top(177:220) = dtau_dn_10co2(2:45,1);

dtau_win_dn_fnco2_top(1:44) = dtau_win_dn_0co2(2:45,1);
dtau_win_dn_fnco2_top(45:88) = dtau_win_dn_1co2(2:45,1);
dtau_win_dn_fnco2_top(89:132) = dtau_win_dn_2co2(2:45,1);
dtau_win_dn_fnco2_top(133:176) = dtau_win_dn_4co2(2:45,1);
dtau_win_dn_fnco2_top(177:220) = dtau_win_dn_10co2(2:45,1);

co2(1:44) = 0;
co2(45:88) = 360;
co2(89:132) = 720;
co2(133:176) = 1440;
co2(177:220) = 3600;

b = regress(dtau_dn_fnco2_top'./0.04,sqrt(co2)');

b_win_sqrt = regress(dtau_win_dn_fnco2_top(45:220)'./0.04,sqrt(co2(45:220))');
b_win = polyfit(co2(45:220)',dtau_win_dn_fnco2_top(45:220)'./0.04,1);

b_win_0 = polyfit(co2',dtau_win_dn_fnco2_top'./0.04,1);
b_win_0_q = polyfit(co2',dtau_win_dn_fnco2_top'./0.04,2);


figure
plot(co2,dtau_dn_fnco2_top./0.04,'x')
hold on
plot(0:36:3600,sqrt(0:36:3600).*b)


figure
plot(co2,dtau_win_dn_fnco2_top./0.04,'x')
hold on
plot(0:36:3600,sqrt(0:36:3600).*b_win_sqrt)
plot(0:36:3600,(0:36:3600).*b_win(1) + b_win(2))
plot(0:36:3600,(0:36:3600).*b_win_0(1) + b_win_0(2),'r')
plot(0:36:3600,(0:36:3600).^2.*b_win_0_q(1) + (0:36:3600).*b_win_0_q(2) + b_win_0_q(3),'g')





dtau_dn_fnco2_mid(1:44) = dtau_dn_0co2(2:45,13);
dtau_dn_fnco2_mid(45:88) = dtau_dn_1co2(2:45,13);
dtau_dn_fnco2_mid(89:132) = dtau_dn_2co2(2:45,13);
dtau_dn_fnco2_mid(133:176) = dtau_dn_4co2(2:45,13);
dtau_dn_fnco2_mid(177:220) = dtau_dn_10co2(2:45,13);

dtau_win_dn_fnco2_mid(1:44) = dtau_win_dn_0co2(2:45,13);
dtau_win_dn_fnco2_mid(45:88) = dtau_win_dn_1co2(2:45,13);
dtau_win_dn_fnco2_mid(89:132) = dtau_win_dn_2co2(2:45,13);
dtau_win_dn_fnco2_mid(133:176) = dtau_win_dn_4co2(2:45,13);
dtau_win_dn_fnco2_mid(177:220) = dtau_win_dn_10co2(2:45,13);




dtau_dn_fnco2_mid(1:44) = dtau_dn_0co2(2:45,13);
dtau_dn_fnco2_mid(45:88) = dtau_dn_1co2(2:45,13) - dtau_dn_0co2(2:45,13);
dtau_dn_fnco2_mid(89:132) = dtau_dn_2co2(2:45,13) - dtau_dn_0co2(2:45,13);
dtau_dn_fnco2_mid(133:176) = dtau_dn_4co2(2:45,13) - dtau_dn_0co2(2:45,13);
dtau_dn_fnco2_mid(177:220) = dtau_dn_10co2(2:45,13) - dtau_dn_0co2(2:45,13);

dtau_win_dn_fnco2_mid(1:44) = dtau_win_dn_0co2(2:45,13);
dtau_win_dn_fnco2_mid(45:88) = dtau_win_dn_1co2(2:45,13) - dtau_win_dn_0co2(2:45,13);
dtau_win_dn_fnco2_mid(89:132) = dtau_win_dn_2co2(2:45,13) - dtau_win_dn_0co2(2:45,13);
dtau_win_dn_fnco2_mid(133:176) = dtau_win_dn_4co2(2:45,13) - dtau_win_dn_0co2(2:45,13);
dtau_win_dn_fnco2_mid(177:220) = dtau_win_dn_10co2(2:45,13) - dtau_win_dn_0co2(2:45,13);
