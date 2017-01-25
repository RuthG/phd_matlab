%sw_up.m
%Run SBDART for the 5 wv profiles tested to get sw fluxes and heating rates
%Compare with simple model predictions
%Check how diffuse DW up changes with wv


%Load up old data
load('~/matlab/tp_btb/tau_wv_final.mat')
load('~/matlab/tp_btb/tau_wv_final_allelse.mat')

%choose q profiles similar to MITgcm output at different lats
q_45=q_surf(3)*sigma.^q_prof(8);
q_35=q_surf(3)*sigma.^q_prof(7);
q_25=q_surf(4)*sigma.^q_prof(6);
q_15=q_surf(7)*sigma.^q_prof(5);

rhoair=1.292269;

w_45 = rhoair*1000*q_45./(1-q_45);
w_45(find(w_45<=1e-14))=1e-14;
w_35 = rhoair*1000*q_35./(1-q_35);
w_35(find(w_35<=1e-14))=1e-14;
w_25 = rhoair*1000*q_25./(1-q_25);
w_25(find(w_25<=1e-14))=1e-14;
w_15 = rhoair*1000*q_15./(1-q_15);
w_15(find(w_15<=1e-14))=1e-14;
w_mit = rhoair*1000*q_mit./(1-q_mit);
w_mit(find(w_mit<=1e-14))=1e-14;

%Write atm.dat profiles for SBDART and run
doh = dlmread('~/matlab/sbdart/atms_profiles/atms_doh.dat');
atm=zeros(25,5,5);
nn=size(atm,1);
for i=1:5
atm(:,1,i)=doh(2:26,1);
atm(:,2,i)=doh(2:26,2);
atm(:,3,i)=doh(2:26,3);
atm(:,5,i)=1e-15;
end
atm(:,4,1)=w_45;
atm(:,4,2)=w_35;
atm(:,4,3)=w_25;
atm(:,4,4)=w_15;
atm(:,4,5)=w_mit;


system('rm OUTPUT')

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
    fprintf(fileID,'  iaer = 0\n');
    fprintf(fileID,'  sza = 0\n');
    fprintf(fileID,'  iout = 11\n');
    fprintf(fileID,'  isalb = 0\n');
    fprintf(fileID,'  albcon = 0.06\n');
    fprintf(fileID,'  kdist = 3\n');
    %fprintf(fileID,'  idb(7) = 1\n');
    fprintf(fileID,'$end\n');
    fclose(fileID);

filename=['~/matlab/sbdart_expts/atms.dat'];
dlmwrite(filename, nn)
dlmwrite(filename, atm(:,:,1),'delimiter', '\t','precision', '%.15f','-append')

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

	system('mv OUTPUT OUTPUT_45')

filename=['~/matlab/sbdart_expts/atms.dat'];
dlmwrite(filename, nn)
dlmwrite(filename, atm(:,:,2),'delimiter', '\t','precision', '%.15f','-append')

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

	system('mv OUTPUT OUTPUT_35')

filename=['~/matlab/sbdart_expts/atms.dat'];
dlmwrite(filename, nn)
dlmwrite(filename, atm(:,:,3),'delimiter', '\t','precision', '%.15f','-append')

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

	system('mv OUTPUT OUTPUT_25')

filename=['~/matlab/sbdart_expts/atms.dat'];
dlmwrite(filename, nn)
dlmwrite(filename, atm(:,:,4),'delimiter', '\t','precision', '%.15f','-append')

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

	system('mv OUTPUT OUTPUT_15')

filename=['~/matlab/sbdart_expts/atms.dat'];
dlmwrite(filename, nn)
dlmwrite(filename, atm(:,:,5),'delimiter', '\t','precision', '%.15f','-append')

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

	system('mv OUTPUT OUTPUT_MIT')

clear

%Read in results

output_45 = dlmread('~/matlab/sbdart_expts/OUTPUT_45');
output_35 = dlmread('~/matlab/sbdart_expts/OUTPUT_35');
output_25 = dlmread('~/matlab/sbdart_expts/OUTPUT_25');
output_15 = dlmread('~/matlab/sbdart_expts/OUTPUT_15');
output_mit = dlmread('~/matlab/sbdart_expts/OUTPUT_MIT');

fxdn_45  = output_45(2:26,3);
fxup_45  = output_45(2:26,4);
fxdir_45 = output_45(2:26,5);
dfdz_45  = output_45(2:26,6);
heat_45  = output_45(2:26,7);

fxdn_35  = output_35(2:26,3);
fxup_35  = output_35(2:26,4);
fxdir_35 = output_35(2:26,5);
dfdz_35  = output_35(2:26,6);
heat_35  = output_35(2:26,7);

fxdn_25  = output_25(2:26,3);
fxup_25  = output_25(2:26,4);
fxdir_25 = output_25(2:26,5);
dfdz_25  = output_25(2:26,6);
heat_25  = output_25(2:26,7);

fxdn_15  = output_15(2:26,3);
fxup_15  = output_15(2:26,4);
fxdir_15 = output_15(2:26,5);
dfdz_15  = output_15(2:26,6);
heat_15  = output_15(2:26,7);

fxdn_mit = output_mit(2:26,3);
fxup_mit = output_mit(2:26,4);
fxdir_mit= output_mit(2:26,5);
dfdz_mit = output_mit(2:26,6);
heat_mit = output_mit(2:26,7);

plot(heat_45,sigma);
hold on
plot(heat_35,sigma);
plot(heat_25,sigma);
plot(heat_15,sigma);
plot(heat_mit,sigma);

save 'heat_rates.mat' heat_45 heat_35 heat_25 heat_15 heat_mit

plot(fxup_45,sigma);
hold on
plot(fxup_35,sigma);
plot(fxup_25,sigma);
plot(fxup_15,sigma);
plot(fxup_mit,sigma);

