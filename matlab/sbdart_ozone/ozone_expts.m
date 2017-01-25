%ozone_expts.m
%Use the ozone profile from doherty to parameterise absorption by ozone

%read in doh data 
p_doh = [0.1, 0.5, 2.0, 5.0, 10.0, 15.0, 20.0, 30.0, 50.0, 70.0, 100.0, 150.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 850.0, 1000.0];
t_doh=[233.0, 280.0, 266.0, 249.0, 235.5, 227.6, 222.0, 214.5, 205.2, 196.8, 192.8, 206.2, 219.5, 241.6, 257.1, 267.5, 275.6, 282.5, 290.4, 298.9];

%use top levels of doh data and MITgcm levels for below (partly more easily comparable, partly p dist of doh levels seems to cause errors as t gaps are big
p_dm = zeros(1,30);
p_dm(1,1:5) = [0.5, 2.0, 5.0, 10.0, 15.0];

%read in the mitgcm atmospheric profile
mitprof = dlmread('~/matlab/sbdart/atms_profiles/atms.dat_mitwv');

%set mit pressure profile, and bottom layers of doherty/mitgcm blended profile
p_mit = mitprof(2:26,2);
p_dm(6:30) = p_mit;

%find t on these pressure levels by interpolation from doh levels, and use to find z on these layers
theta = false;
t_mit = interp1(p_doh,t_doh,p_mit);
t_dm = interp1(p_doh,t_doh,p_dm);
z_mit = find_height(p_mit,t_mit,theta);
z_mit = flipud(z_mit);
z_dm = interp1(p_mit,z_mit,p_dm,'spline','extrap') ;

%use the above to calculate the density of air in kg/m3
rhoair_doh = p_doh.*100./(287.058*t_doh);

%read in doherty ozone profile in mg/kg
o_doh_mgkg = [1.4, 3.1, 6.3, 14.0, 14.0, 13.0, 11.5, 6.9, 2.6, 0.8, 0.14, 0.09, 0.06, 0.05, 0.04, 0.04, 0.034, 0.03, 0.02, 0.02];
%convert to ozone in g/m3 by multiplying by density of dry air, dividing by 1000 to go g-->mg
o_doh = o_doh_mgkg .* rhoair_doh ./ 1000;
%interpolate onto mit/doherty+mit pressure levels
o_mit = interp1(p_doh,o_doh,p_mit);
o_dm = interp1(p_doh,o_doh,p_dm);


%write this profile both in mit and on doh pressure levels for comparison of top effects
%mit
atm=zeros(25,5);
nn=size(atm,1);
atm(:,1)=z_mit./1000.;
atm(:,2)=p_mit;
atm(:,3)=t_mit;
atm(:,4)=1e-15;
atm(:,5)=o_mit;
filename=['~/matlab/sbdart_ozone/atms.dat_mitl'];
dlmwrite(filename, 25)
dlmwrite(filename, atm,'delimiter', '\t','precision', '%.15f','-append')

%dm
atm_doh=zeros(30,5);
nn=size(atm,1);
atm_doh(:,1)=z_dm./1000.;
atm_doh(:,2)=p_dm;
atm_doh(:,3)=t_dm;
atm_doh(:,4)=1e-15;
atm_doh(:,5)=o_dm;
filename=['~/matlab/sbdart_ozone/atms.dat_dohl'];
dlmwrite(filename, 30)
dlmwrite(filename, atm_doh,'delimiter', '\t','precision', '%.15f','-append')

%prepare to run SBDART using dm profile
system('rm OUTPUT')
system('cp atms.dat_dohl atms.dat')

blank = '0';
data = zeros(7,25);
file = '';

    fileID = fopen('INPUT','w'); 
    fprintf(fileID,'$INPUT\n');
    %fprintf(fileID,'  nf = 0.\n');
    fprintf(fileID,'  wlinf = 0.25\n');
    fprintf(fileID,'  wlsup = 4.0\n');
    fprintf(fileID,'  wlinc = 0.005\n');
    fprintf(fileID,'  idatm = 0\n');
    fprintf(fileID,'  sza = 0\n');
    fprintf(fileID,'  iout = 11\n');
    fprintf(fileID,'  isalb = 0\n');
    fprintf(fileID,'  albcon = 0.06\n');
    fprintf(fileID,'  kdist = 3\n');
    %fprintf(fileID,'  idb(7) = 1\n');
    fprintf(fileID,'$end\n');
    fclose(fileID);

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

	system('mv OUTPUT OUTPUT_ozone_doh')

%prepare to run SBDART using MIT profile

system('rm OUTPUT')
system('cp atms.dat_mitl atms.dat')

blank = '0';
data = zeros(7,25);
file = '';

    fileID = fopen('INPUT','w'); 
    fprintf(fileID,'$INPUT\n');
    %fprintf(fileID,'  nf = 0.\n');
    fprintf(fileID,'  wlinf = 0.25\n');
    fprintf(fileID,'  wlsup = 4.0\n');
    fprintf(fileID,'  wlinc = 0.005\n');
    fprintf(fileID,'  idatm = 0\n');
    fprintf(fileID,'  sza = 0\n');
    fprintf(fileID,'  iout = 11\n');
    fprintf(fileID,'  isalb = 0\n');
    fprintf(fileID,'  albcon = 0.06\n');
    fprintf(fileID,'  kdist = 3\n');
    %fprintf(fileID,'  idb(7) = 1\n');
    fprintf(fileID,'$end\n');
    fclose(fileID);

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

	system('mv OUTPUT OUTPUT_ozone_mit')

%save all variables
save('ozone_expts.mat')
