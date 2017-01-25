%run sbdart multiple times from matlab

doh = dlmread('~/atms.dat');
load('~/matlab/tp_btb/profiles.mat')

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

sigma = doh(2:26,2)/doh(26,2);

atm=zeros(25,5);
nn=size(atm,1);
atm(:,1)=doh(2:26,1);
atm(:,2)=doh(2:26,2);
atm(:,5)=1e-15;

tau_rec=zeros(size(t_prof),25);

for i=1:size(q_surf)
i
for j=1:size(q_prof)
j
for k=1:size(t_prof)
k
atm(:,3)=t(k,:);
atm(:,4)=w(i,j,:);

filename=['~/matlab/tau_parameterisation/atms.dat'];
dlmwrite(filename, nn)
dlmwrite(filename, atm,'delimiter', '\t','precision', '%.15f','-append')

    [a,b]=system('/home/rg312/sbdart/sbdart_stuff/sbdart.exe');

if size(b,1)==0

output = dlmread('~/matlab/tau_parameterisation/OUTPUT');
fxdnsw  = output(2:26,3);
tausbdart=log(fxdnsw(1)./fxdnsw);
tau_rec(k,:)=tausbdart;
else
tau_rec(k,:)=zeros(1,25);
end
clear a
clear b
    system('rm OUTPUT');

end

name=['~/matlab/tau_parameterisation/results/tau_results' num2str(i) '_' num2str(j) '.mat']
save(name,'tau_rec')

clear tau_rec
end
end


return
