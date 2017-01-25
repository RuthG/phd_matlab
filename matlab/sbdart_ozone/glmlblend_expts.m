%glmlblend_expts.m
%make atm profs which match mitgcm levels for 20hPa and below, and standard levels above, and run in SBDART

load('standard_profs.mat')

p_blend = zeros(49,6);

for i=1:6
p_blend(1:25,i) = p_ml(1:25,:);
end

t_blend(1:25,:) = t_ml;
o_dens_blend(1:25,:) = o_dens_ml;
o_mix_blend(1:25,:) = o_mix_ml;
alts_blend(1:25,:) = alts_ml;

p_blend(26:49,:) = p_gl(27:50,:);
t_blend(26:49,:) = t_gl(27:50,:);
o_dens_blend(26:49,:) = o_dens_gl(27:50,:);
o_mix_blend(26:49,:) = o_mix_gl(27:50,:);
alts_blend(26:49,:) = alts(27:50,:);

save('glmlblend.mat');

for c=1:6

atm_gl(:,1) = flipud(alts_blend(:,c));
atm_gl(:,2) = flipud(p_blend(:,c));
atm_gl(:,3) = flipud(t_blend(:,c));
atm_gl(:,4) = 1e-12; 
atm_gl(:,5) = 5.*flipud(o_dens_blend(:,c));
filename=['~/matlab/sbdart_ozone/atms.dat_blend' num2str(c)];
dlmwrite(filename, 49)
dlmwrite(filename, atm_gl,'delimiter', '\t','precision', '%.15f','-append')
job = ['cp atms.dat_blend' num2str(c) ' atms.dat'];
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
    fprintf(fileID,'  iout = 7\n');
    fprintf(fileID,'  isalb = 0\n');
    fprintf(fileID,'  albcon = 0.06\n');
    fprintf(fileID,'  kdist = 3\n');
    %fprintf(fileID,'  idb(7) = 1\n');
    fprintf(fileID,'$end\n');
    fclose(fileID);

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe')

	system(['mv OUTPUT OUTPUT_blendfull' num2str(c)])

end
