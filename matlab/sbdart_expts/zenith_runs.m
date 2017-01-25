%zenith.m

%Run SBDART with fixed 'MIT' wv profile, fixed CO2 conc for different zenith angles


mitprof = dlmread('~/matlab/sbdart/atms_profiles/atms.dat_nowv');

filename=['~/matlab/sbdart_expts/atms.dat'];
dlmwrite(filename, 25)
dlmwrite(filename, mitprof(2:26,:),'delimiter', '\t','precision', '%.15f','-append')


system('rm OUTPUT')

szen = [0,10,20,30,40,50,60,70,80,82,84,86,88,89,90]

for i=1:15
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
 formatSpec = '  sza =  %3.1f\n';
    fprintf(fileID,formatSpec,szen(i));
    fprintf(fileID,'  iout = 11\n');
    fprintf(fileID,'  isalb = 0\n');
    fprintf(fileID,'  albcon = 0.06\n');
    fprintf(fileID,'  kdist = 3\n');
    %fprintf(fileID,'  idb(7) = 1\n');
    fprintf(fileID,'$end\n');
    fclose(fileID);

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

command = ['mv OUTPUT OUTPUT_zenith_nowv' num2str(szen(i))]
	system(command)
end

