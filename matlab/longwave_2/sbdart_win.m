%sbdart_win.m
%Run SBDART in the LW separating the window region from the rest of the spectrum to see if this helps!

load('~/matlab/sbdart_ozone/standard_profs.mat')

atm_ml = zeros(25,5);

for c=1:6

atm_ml(:,1) = flipud(alts_ml(:,c));
atm_ml(:,2) = flipud(p_ml);
atm_ml(:,3) = flipud(t_ml(:,c));
atm_ml(:,4) = flipud(h2o_dens_ml(:,c));
atm_ml(:,5) = 1.e-15; %flipud(o_dens_ml(:,c));
filename=['~/matlab/longwave_2/atms.dat' num2str(c)];
dlmwrite(filename, 25)
dlmwrite(filename, atm_ml,'delimiter', '\t','precision', '%.15f','-append')
job = ['cp atms.dat' num2str(c) ' atms.dat'];
system(job)

blank = '0';
data = zeros(7,25);
file = '';

    fileID = fopen('INPUT','w'); 
    fprintf(fileID,'$INPUT\n');
    %fprintf(fileID,'  nf = 0.\n');
    fprintf(fileID,'  wlinf = 8.0\n');
    fprintf(fileID,'  wlsup = 14.0\n');
    fprintf(fileID,'  wlinc = 0.005\n');
    fprintf(fileID,'  idatm = 0\n');
 formatSpec = '  sza =  %3.1f\n';
    fprintf(fileID,formatSpec,lat(c));
    fprintf(fileID,'  iout = 11\n');
    fprintf(fileID,'  isalb = 0\n');
    fprintf(fileID,'  albcon = 0.06\n');
    fprintf(fileID,'  kdist = 3\n');
    %fprintf(fileID,'  idb(7) = 1\n');
    fprintf(fileID,'$end\n');
    fclose(fileID);

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

	system(['mv OUTPUT out/OUTPUT_win' num2str(c)])

blank = '0';
data = zeros(7,25);
file = '';

    fileID = fopen('INPUT','w'); 
    fprintf(fileID,'$INPUT\n');
    %fprintf(fileID,'  nf = 0.\n');
    fprintf(fileID,'  wlinf = 4.005\n');
    fprintf(fileID,'  wlsup = 7.995\n');
    fprintf(fileID,'  wlinc = 0.005\n');
    fprintf(fileID,'  idatm = 0\n');
 formatSpec = '  sza =  %3.1f\n';
    fprintf(fileID,formatSpec,lat(c));
    fprintf(fileID,'  iout = 11\n');
    fprintf(fileID,'  isalb = 0\n');
    fprintf(fileID,'  albcon = 0.06\n');
    fprintf(fileID,'  kdist = 3\n');
    %fprintf(fileID,'  idb(7) = 1\n');
    fprintf(fileID,'$end\n');
    fclose(fileID);

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

	system(['mv OUTPUT out/OUTPUT_lw1' num2str(c)])

blank = '0';
data = zeros(7,25);
file = '';

    fileID = fopen('INPUT','w'); 
    fprintf(fileID,'$INPUT\n');
    %fprintf(fileID,'  nf = 0.\n');
    fprintf(fileID,'  wlinf = 14.005\n');
    fprintf(fileID,'  wlsup = 100.0\n');
    fprintf(fileID,'  wlinc = 0.005\n');
    fprintf(fileID,'  idatm = 0\n');
 formatSpec = '  sza =  %3.1f\n';
    fprintf(fileID,formatSpec,lat(c));
    fprintf(fileID,'  iout = 11\n');
    fprintf(fileID,'  isalb = 0\n');
    fprintf(fileID,'  albcon = 0.06\n');
    fprintf(fileID,'  kdist = 3\n');
    %fprintf(fileID,'  idb(7) = 1\n');
    fprintf(fileID,'$end\n');
    fclose(fileID);

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

	system(['mv OUTPUT out/OUTPUT_lw2' num2str(c)])


end
