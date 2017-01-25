%use the profiles calculated in write_qt_profile to run sbdart

yi = -89:2:89;

yy=yi*90/60*pi/180;
sinyy=sin(yy);
sst=27*(1-sinyy.*sinyy);
sst(find(abs(yi)>=60))=0;
t_surf=sst+273.15;

for i=2:89
%for i=58:89

system('rm OUTPUT')
command = ['cp ./atm_profs/atms.dat_' int2str(i) ' atms.dat']

system(command);

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
    fprintf(fileID,'  xco2 = 7200.0\n');
% formatSpec = '  sza =  %3.1f\n';
%    fprintf(fileID,formatSpec,yi(i));
    fprintf(fileID,'  iout = 11\n');
    fprintf(fileID,'  isalb = 0\n');
    fprintf(fileID,'  albcon = 0.06\n');
    fprintf(fileID,'  kdist = 3\n');
 formatSpec = '  btemp =  %3.1f\n';
    fprintf(fileID,formatSpec,t_surf(i));
    %fprintf(fileID,'  idb(7) = 1\n');
    fprintf(fileID,'$end\n');
    fclose(fileID);

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

command = ['mv OUTPUT sw_output_files/OUTPUT_wv_' int2str(i)]
	system(command)



system('rm OUTPUT')




system(command);

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
    fprintf(fileID,'  xco2 = 7200.0\n');
 formatSpec = '  sza =  %3.1f\n';
    fprintf(fileID,formatSpec,yi(i));
    fprintf(fileID,'  iout = 11\n');
    fprintf(fileID,'  isalb = 0\n');
    fprintf(fileID,'  albcon = 0.06\n');
    fprintf(fileID,'  kdist = 3\n');
 formatSpec = '  btemp =  %3.1f\n';
    fprintf(fileID,formatSpec,t_surf(i));
    %fprintf(fileID,'  idb(7) = 1\n');
    fprintf(fileID,'$end\n');
    fclose(fileID);

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

command = ['mv OUTPUT lw_output_files/OUTPUT_wv_l_' int2str(i)]
	system(command)


system('rm OUTPUT')

system(command);

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
    fprintf(fileID,'  xco2 = 7200.0\n');
 formatSpec = '  sza =  %3.1f\n';
    fprintf(fileID,formatSpec,yi(i));
    fprintf(fileID,'  iout = 11\n');
    fprintf(fileID,'  isalb = 0\n');
    fprintf(fileID,'  albcon = 0.06\n');
    fprintf(fileID,'  kdist = 3\n');
 formatSpec = '  btemp =  %3.1f\n';
    fprintf(fileID,formatSpec,t_surf(i));
    %fprintf(fileID,'  idb(7) = 1\n');
    fprintf(fileID,'$end\n');
    fclose(fileID);

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

command = ['mv OUTPUT lw_output_files/OUTPUT_wv_u_' int2str(i)]
	system(command)



system('rm OUTPUT')

system(command);

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
    fprintf(fileID,'  xco2 = 7200.0\n');
 formatSpec = '  sza =  %3.1f\n';
    fprintf(fileID,formatSpec,yi(i));
    fprintf(fileID,'  iout = 11\n');
    fprintf(fileID,'  isalb = 0\n');
    fprintf(fileID,'  albcon = 0.06\n');
    fprintf(fileID,'  kdist = 3\n');
 formatSpec = '  btemp =  %3.1f\n';
    fprintf(fileID,formatSpec,t_surf(i));
    %fprintf(fileID,'  idb(7) = 1\n');
    fprintf(fileID,'$end\n');
    fclose(fileID);

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

command = ['mv OUTPUT win_output_files/OUTPUT_wv_' int2str(i)]
	system(command)





end
