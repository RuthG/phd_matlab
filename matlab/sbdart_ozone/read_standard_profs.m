%read_standard_profs.m
%read in standard profiles from glatm2.dat and convert O3 and H20 from ppmv to SBDART usable and MITgcm desired units

%read in from glatm2.dat
fid = fopen('~/matlab/sbdart_ozone/glatm2.dat');
for i=1:36
fgetl(fid);
end
numlevs = fscanf(fid, '%f\n', 1)
for i=1:4
fgetl(fid)
end
for j=1:6
lat(j) = fscanf(fid, '%f\n', 1)
for i=1:2
fgetl(fid);
end
for i=1:10
alts(5*i-4:5*i,j) = fscanf(fid, '%f\n,',5);
end
for i=1:2
fgetl(fid);
end
for i=1:10
p_gl(5*i-4:5*i,j) = fscanf(fid, '%f\n,',5);
end
for i=1:2
fgetl(fid);
end
for i=1:10
t_gl(5*i-4:5*i,j) = fscanf(fid, '%f\n,',5);
end
for i=1:2
fgetl(fid);
end
for i=1:10
rho_gl(5*i-4:5*i,j) = fscanf(fid, '%f\n,',5);
end
for i=1:2
fgetl(fid);
end
for i=1:10
h2o_ppmv(5*i-4:5*i,j) = fscanf(fid, '%f\n,',5);
end
for i=1:14
fgetl(fid);
end
for i=1:10
o3_ppmv(5*i-4:5*i,j) = fscanf(fid, '%f\n,',5);
end
for i=1:54
fgetl(fid)
end
end
clear i j ans fid

%calculate O3 and H2O in units of SBDART (g/m3) and of MITgcm (kg/kg)

%g/mol O3, H2O
gmolo = 48.0;
gmolh = 18.0;

%p = rho R_a T .... rho = p/(R_a T)
%pV = nRT ..... V/n = RT/p

Ra = 287.058;  		%J/kg/K
R = 8.3144621;  		%J/mol/K
rhoair_gl = p_gl.*100./(Ra.*t_gl); 	%Pa./(J/kg) = N/m2 ./ (Nm/kg) = kg/m3
vmol_gl = R*t_gl./(p_gl.*100.); 	%Nm/mol ./ N/m2 = m3/mol

%ppmv * 10-6 *g/mol ./ v/mol = g/v

o_dens_gl = (o3_ppmv * 1e-6 * gmolo)./vmol_gl;	%g/m3 o3
h2o_dens_gl = (h2o_ppmv * 1e-6 * gmolh)./vmol_gl;	%g/m3 h2o

o_mix_gl = o_dens_gl ./ (1000.*rhoair_gl);	%kg o3/kg air
h2o_mix_gl = h2o_dens_gl ./ (1000.*rhoair_gl);	%kg h2o/kg dry air = w	NB treatment of w and q possibly dubious, but makes v little difference to mag
h2o_q_gl = h2o_mix_gl./(1+h2o_mix_gl);	%kg h2o/(kg dry air + kg h2o)


%Interpolate these onto MITgcms levels

%MIT pressure levels
p_ml(:,1) = 20.:40.:980.;
p_ml = flipud(p_ml);

for j=1:6
t_ml(:,j) 		= interp1(p_gl(:,j),t_gl(:,j),       p_ml);
o_dens_ml(:,j) 	= interp1(p_gl(:,j),o_dens_gl(:,j),  p_ml);
h2o_dens_ml(:,j) 	= interp1(p_gl(:,j),h2o_dens_gl(:,j),p_ml);
o_mix_ml(:,j) 	= interp1(p_gl(:,j),o_mix_gl(:,j),   p_ml);
h2o_q_ml(:,j) 	= interp1(p_gl(:,j),h2o_q_gl(:,j),   p_ml);
rhoair_ml(:,j) 	= interp1(p_gl(:,j),rhoair_gl(:,j),  p_ml);
vmol_ml(:,j)	 	= interp1(p_gl(:,j),vmol_gl(:,j),    p_ml);
alts_ml(:,j)		= interp1(p_gl(:,j),alts(:,j),       p_ml);
end

%save all variables
save('standard_profs.mat')
