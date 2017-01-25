%sbdart_standard_profs.m
%Run SBDART with the standard o3 profiles from glatm2.dat for both glatm2.dat pressure levels and MITgcm pressure levels

load('standard_profs.mat')

atm_gl = zeros(50,5);
atm_ml = zeros(25,4);

for c=1:6

atm_gl(:,1) = flipud(alts(:,c));
atm_gl(:,2) = flipud(p_gl(:,c));
atm_gl(:,3) = flipud(t_gl(:,c));
atm_gl(:,4) = 1e-12; 
atm_gl(:,5) = 5.*flipud(o_dens_gl(:,c));
filename=['~/matlab/sbdart_ozone/atms.dat_gl5' num2str(c)];
dlmwrite(filename, 50)
dlmwrite(filename, atm_gl,'delimiter', '\t','precision', '%.15f','-append')
job = ['cp atms.dat_gl5' num2str(c) ' atms.dat'];
system(job)

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

	system(['mv OUTPUT OUTPUT_gl5' num2str(c)])



atm_ml(:,1) = flipud(alts_ml(:,c));
atm_ml(:,2) = flipud(p_ml);
atm_ml(:,3) = flipud(t_ml(:,c));
atm_ml(:,4) = 1e-12;
atm_ml(:,5) = 5.*flipud(o_dens_ml(:,c));
filename=['~/matlab/sbdart_ozone/atms.dat_ml5' num2str(c)];
dlmwrite(filename, 25)
dlmwrite(filename, atm_ml,'delimiter', '\t','precision', '%.15f','-append')
job = ['cp atms.dat_ml5' num2str(c) ' atms.dat'];
system(job)

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

	system(['mv OUTPUT OUTPUT_ml5' num2str(c)])

end