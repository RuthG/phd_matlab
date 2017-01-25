%ozone_fit.m
%fit eqn 17 Lacis and Hansen to our profs

%load up data
load('standard_profs.mat');

%choose pressure levels so lower levels match MITgcm
p_levs(1:25,1) = 980:-40:20
p_levs(26:49,1) = p_gl(27:50,1)

%interpolate ozone density and altitudes onto new pressure levels
for i=1:6
o_dens_press(:,i) = interp1(p_gl(:,i),o_dens_gl(:,i),p_levs,'linear','extrap');
alt_press(:,i) = interp1(p_gl(:,i),alts(:,i),p_levs,'linear','extrap');
end

o_dens_press(find(o_dens_press<0))=0;

%make 'seasonal average' ozone profile
midlat_av = (o_dens_press(:,2)+o_dens_press(:,3))./2;
subpol_av = (o_dens_press(:,4)+o_dens_press(:,5))./2;
midlat_alts = (alt_press(:,2)+alt_press(:,3))./2;
subpol_alts = (alt_press(:,4)+alt_press(:,5))./2;

alt_prof = zeros(49,6);
alt_prof(:,1) = subpol_alts;
alt_prof(:,2) = midlat_alts;
alt_prof(:,3) = alt_press(:,1);
alt_prof(:,4) = alt_press(:,1);
alt_prof(:,5) = midlat_alts;
alt_prof(:,6) = subpol_alts;
o_prof= zeros(49,6);
o_prof(:,1) = subpol_av;
o_prof(:,2) = midlat_av;
o_prof(:,3) = o_dens_press(:,1);
o_prof(:,4) = o_dens_press(:,1);
o_prof(:,5) = midlat_av;
o_prof(:,6) = subpol_av;
lat_o(1) = -60.;
lat_o(2) = -45.;
lat_o(3) = -15.;
lat_o(4) = 15.;
lat_o(5) = 45.;
lat_o(6) = 60.;


%integrate column o3
for i=1:6
for j=1:48
dz(j,i) = alt_prof(j+1,i) - alt_prof(j,i);
o_prof_half(j,i) = (o_prof(j,i)+o_prof(j+1,i))./2;
p_levs_half(j,1) = (p_levs(j,1)+p_levs(j+1,1))./2;
end
end

%ozone column amount in grams
col_o = sum(o_prof_half .* dz , 1)

%find params to fit L+H fn to profs
options = optimset('lsqcurvefit');
options = optimset(options,'TolFun',1e-15,'TolX',1e-15);
for i=1:6
x0=[0.007,20.,1.];
[c(:,i),resnorm(i)] = lsqcurvefit(@fun,x0,alt_prof(:,i),o_prof(:,i),0,100,options);
vals(:,i) = fun(c(:,i),alt_prof(:,i));
end

plot(vals,p_levs,'b')
hold on
plot(o_prof, p_levs,'r')


%keep a and b constant so column 03 and peak position are const, vary c to change dist so at trop roughly 1e-4 g/m3

a_check = c(:,1);
a_check(3,1) = 5.0;
prof_sub = fun (a_check,alt_prof(:,1));
plot(vals(:,1),p_levs(:,1),'b')
hold on
plot(prof_sub,p_levs(:,1),'g')
plot(vals(:,1),540)
plot(0.5e-4,p_levs)
set(gca,'YDir','reverse')

load('/disk1/rg312/run_daily_swwv/tropopause.mat')

a_sub = c(:,1);
a_sub(3,1) = 5.0;
a_mid = c(:,2);
a_mid(3,1) = 6.5;
a_trop = c(:,3);
a_trop(3,1) = 4.8;

sb_o_prof(:,1) = fun(a_sub,alt_prof(:,1));
sb_o_prof(:,2) = fun(a_mid,alt_prof(:,2));
sb_o_prof(:,3) = fun(a_trop,alt_prof(:,3));
sb_o_prof(:,4) = fun(a_trop,alt_prof(:,4));
sb_o_prof(:,5) = fun(a_mid,alt_prof(:,5));
sb_o_prof(:,6) = fun(a_sub,alt_prof(:,6));

plot(sb_o_prof,p_levs);

s(1) = subplot(2,1,1)
v= (0:0.2:4)/10000
contourf(lat_o, p_levs,sb_o_prof,v)
set(gca,'YDir','reverse')
%set(gca,'YScale','log') 
caxis([0.,4e-4])
colorbar
hold on
plot(yredu,tropo_pressure_red/100,'k','LineWidth',2)
title(s(1),'Aquaplanet annual mean ozone profile')
xlabel('Latitude')
ylabel('Pressure, hPa')

s(2) = subplot(2,1,2)
contourf(lat_o, p_levs,o_prof,v)
set(gca,'YDir','reverse')
%set(gca,'YScale','log') 
caxis([0.,4e-4])
colorbar
hold on
plot(yredu,tropo_pressure_red/100,'k','LineWidth',2)
title(s(2),'Real annual mean ozone profile')
xlabel('Latitude')
ylabel('Pressure, hPa')


%old way of finding o_prof params
%options = optimset('lsqcurvefit');
%options = optimset(options,'TolFun',1e-15,'TolX',1e-15);
%for i=1:6
%x0=[0.007,20.,1.];
%[c(:,i),resnorm(i)] = lsqcurvefit(@fun3,x0,alt_prof(:,i),o_prof_half(:,i)',0,100,options);
%vals(:,i) = fun3(c(:,i),alt_prof(:,i));
%end

ylat(1,:) = -89:2:89;
sb_o_prof_sd = shiftdim(sb_o_prof,1);
full_prof = interp1(lat_o, sb_o_prof_sd, ylat,'linear','extrap');
full_prof(find(full_prof<0.))=0.

o_prof_sd = shiftdim(o_prof,1);
full_prof_real = interp1(lat_o, o_prof_sd, ylat,'linear','extrap');
full_prof_real(find(full_prof_real<0.))=0.


vals_sd = shiftdim(vals,1);
full_vals = interp1(lat_o, vals_sd, ylat,'linear','extrap');
full_vals(find(vals<0.))=0.

alt_prof_sd = shiftdim(alt_prof,1);
full_alt_prof = interp1(lat_o, alt_prof_sd, ylat,'linear','extrap');
full_alt_prof(find(alt_prof<0.))=0.;
