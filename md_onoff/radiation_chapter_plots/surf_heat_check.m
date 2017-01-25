%check surface heating against sbdart.... is too much cooling a big issue........


load('~/md_onoff/week_0922/lw_sbdart.mat')

heat_lw = heat_lw_u+ heat_lw_l + heat_win;


load('~/md_onoff/week_0922/sw_sbdart.mat')

for i=1:25
trans(:,i) = fxdn_sw(:,i+1)./fxdn_sw(:,1);
end

lat = (-89:2:89).*pi./180;
solar_constant 	= 1360.0;

ss = sin(lat);
p2 = (1. - 3.*ss.^2)./4;
del_sol = 1.4;
solar = repmat(0.25.*solar_constant.*(1.0 + del_sol.*p2'),[1,25]);

mitflux(:,1) = solar(:,1);
mitflux(:,2:26) = solar.*trans;

p_half = 0:4000:100000;
p = 2000:4000:98000;
grav = 9.8;
cp_air 		= 287.04./(2./7);

for k=1:25
   tdt_sw_sbdart(:,k) = -(mitflux(:,k+1) - mitflux (:,k)).*grav./(cp_air.*(p_half(k+1) - p_half(k)));
end

load('/project/rg312/mat_files/heating_myscheme.mat') 


tdt_sw = tdt_sw.*86400;
tdt_lw = tdt_lw.*86400;
