%Load up u and integrate in vertical for 3 runs

rDir='/disk1/MITgcm/verification/atm_gray_ruth/ensemble_control/';

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

load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0421/yzav_c.mat')
load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0421/yzav_th.mat')
load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0421/yzav_w.mat')


uE_c_vint = sum(uE_c_yzav.*4000./9.81,2);
uE_th_vint = sum(uE_th_yzav.*4000./9.81,2);
uE_w_vint = sum(uE_w_yzav.*4000./9.81,2);

ylat = 1:2:89;

plot(ylat,uE_c_vint)
ylabel('Vertical integral of U')
xlabel('Latitude')
hold on
plot(ylat,uE_th_vint,'g')
plot(ylat,uE_w_vint,'r')
legend('Control','Tropical heating','Full wv')
print('-dpng','u_vert_ints.png')
