%load in lw and sw toa and surface fluxes to compare with SBDART

load('/project/rg312/mat_files/heating_myscheme.mat')

net_surf_rm = net(:,26);
net_toa_rm = net(:,1);

down_surf_rm = down(:,26);
down_toa_rm = down(:,1);

up_surf_rm = up(:,26);
up_toa_rm = up(:,1);


load('/project/rg312/mat_files/radmod_lw_vw.mat')

net_surf_vw = net(:,26);
net_toa_vw = net(:,1);

down_surf_vw = down(:,26);
down_toa_vw = down(:,1);

up_surf_vw = up(:,26);
up_toa_vw = up(:,1);


load('tdt_lw_byrne.mat')

net_surf_b = net(:,26);
net_toa_b = net(:,1);

down_surf_b = down(:,26);
down_toa_b = down(:,1);

up_surf_b = up(:,26);
up_toa_b = up(:,1);

load('tdt_lw_frierson.mat')

net_surf_f = net(:,26);
net_toa_f = net(:,1);

down_surf_f = down(:,26);
down_toa_f = down(:,1);

up_surf_f = up(:,26);
up_toa_f = up(:,1);

load('~/md_onoff/week_0922/lw_sbdart.mat')

fxup_lw = fxup_lw_l + fxup_lw_u + fxup_win;
fxdn_lw = fxdn_lw_l + fxdn_lw_u + fxdn_win;

fxnet_lw = fxup_lw - fxdn_lw;

figure
yi = -89:2:89;
plot(yi,net_surf_rm)
hold on
plot(yi,net_surf_vw,'r')
plot(yi,net_surf_b,'g')
plot(yi,net_surf_f,'c')
plot(yi(2:89),fxnet_lw(2:89,26),'k')
xlabel('Latitude')
ylabel('Net surface longwave flux, Wm^{-2}')
legend('Radiation mod','Varying window param','Byrne','Frierson','SBDART')
print('-dpng','lw_fluxes_surf.png')

figure
yi = -89:2:89;
plot(yi,net_toa_rm)
hold on
plot(yi,net_toa_vw,'r')
plot(yi,net_toa_b,'g')
plot(yi,net_toa_f,'c')
plot(yi(2:89),fxnet_lw(2:89,1),'k')
xlabel('Latitude')
ylabel('Net top of atmosphere longwave flux, Wm^{-2}')
legend('Radiation mod','Varying window param','Byrne','Frierson','SBDART')
print('-dpng','lw_fluxes_toa.png')


