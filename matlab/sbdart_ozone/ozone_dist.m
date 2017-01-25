%ozone_dist.m
%Load up 'standard' pressure dists, fit fn and create 'aquaplanet tropopause' based dist

%load up data
load('standard_profs.mat');

%integrate column o3
for i=1:6
for j=1:49
dz(j,i) = alts(j+1,i) - alts(j,i);
o_dens_gl_half(j,i) = (o_dens_gl(j,i)+o_dens_gl(j+1,i))./2;
end
end

col_o = sum(o_dens_gl_half .* dz , 1)
o_g = o_dens_gl_half .* dz;

%a = total 1m^2 column ozone content (g)
a = col_o;

%b = altitude of maximum
for i=1:6
index(1,i) = find(o_dens_gl_half(:,i)==max(o_dens_gl_half(:,i)))
end
b2 = alts(index) ;


%pick c to try to fit to actual profile
c=2.5

%ozone above a certain level
for j=1:6
u(:,j) = a(j)*(1+exp(-b2(j)/c))./(1+exp((alts(:,j)-b2(j))./c));
end

%differentiate u to get ozone profile
for i=1:49
for j=1:6
diffu(i,j)=-1*(u((i+1),j)-u((i),j))./(alts(i+1,j)-alts(i,j));
p_gl_half(i,j) = (p_gl(i,j)+p_gl(i+1,j))./2;
alts_half(i,j) = (alts(i,j)+alts(i+1,j))./2;
end
end

plot(nmo(:,1),p_gl(:,1),'r');
hold on
plot(diffu(:,1),p_gl_half(:,1))   ;
set(gca,'YDir','reverse');
hold off

plot(o_g(:,1),alts_half(:,1),'r');
hold on
plot(diffu(:,1),alts_half(:,1))   ;

trop_lev=zeros(50,6);
trop_lev(:,1) = 9.370e1;
trop_lev(:,2) = 1.530E+02;
trop_lev(:,3) = 6.280E+01;
trop_lev(:,4) = 2.677E+02;
trop_lev(:,5) = 2.829E+02;
trop_lev(:,6) = 1.940E+02;


midlat_av = (o_dens_gl(:,2)+o_dens_gl(:,3))./2;
subpol_av = (o_dens_gl(:,4)+o_dens_gl(:,5))./2;

o_prof= zeros(50,6);
o_prof(:,1) = subpol_av;
o_prof(:,2) = midlat_av;
o_prof(:,3) = o_dens_gl(:,1);
o_prof(:,4) = o_dens_gl(:,1);
o_prof(:,5) = midlat_av;
o_prof(:,6) = subpol_av;
lat_o(1) = -60.;
lat_o(2) = -45.;
lat_o(3) = -15.;
lat_o(4) = 15.;
lat_o(5) = 45.;
lat_o(6) = 60.;
p_o(:,1) = p_gl(:,4);
p_o(:,2) = p_gl(:,2);
p_o(:,3) = p_gl(:,1);
p_o(:,4) = p_gl(:,1);
p_o(:,5) = p_gl(:,2);
p_o(:,6) = p_gl(:,4);

[C,h] = contourf(lat_o, p_o(:,3), o_prof);
set(gca,'YDir','reverse')
set(gca,'YScale','log')
