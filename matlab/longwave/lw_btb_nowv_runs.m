%lw_btb_nowv_runs.m
%Run SBDART with a range of T profiles, no WV using MITgcm control run zonal mean data


nit=345600;
rDir='/disk1/rg312/run_control_0516/';
ny=90
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';

p_mit = flipud(rC)./100.;

theta_full=rdmds([rDir,'Ttave'],nit);
[theta_av,mskzon,ylat,areazon]=calcZonalAvgCube(theta_full,ny,yc,ar,hc);
convthetatoT(1,:)=(rC/rC(1)).^(2./7.);
for i=1:9
t_mit(:,i) = theta_av(5*i,:).*convthetatoT;
end
t_mit = flipud(t_mit);


theta = false;

for i=1:9
z_mit(:,i) = find_height(p_mit,t_mit(:,i),theta);
end
z_mit = flipud(z_mit);


for i=1:9

%write this profile both in mit and on doh pressure levels for comparison

atm=zeros(25,5);
nn=size(atm,1);
atm(:,1)=z_mit(:,i)./1000.;
atm(:,2)=p_mit;
atm(:,3)=t_mit(:,i);
atm(:,4)=1e-15;
atm(:,5)=1e-15;

save('sbdart_lw_nowv.mat','atm','t_mit','z_mit','p_mit')
filename=['~/matlab/longwave/atms.dat_lw_nowv' num2str(91-i*10)];
dlmwrite(filename, 25)
dlmwrite(filename, atm,'delimiter', '\t','precision', '%.15f','-append')

system('rm OUTPUT')
system(['cp atms.dat_lw_nowv' num2str(91-i*10) ' atms.dat'])

blank = '0';
data = zeros(7,25);
file = '';

    fileID = fopen('INPUT','w'); 
    fprintf(fileID,'$INPUT\n');
    %fprintf(fileID,'  nf = 0.\n');
    fprintf(fileID,'  wlinf = 4.005\n');
    fprintf(fileID,'  wlsup = 100.0\n');
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

	system(['mv OUTPUT nowv/OUTPUT_lw_nowv' num2str(91-i*10)])

%Read in results
output_lw_nowv(:,:,i) = dlmread(['~/matlab/longwave/nowv/OUTPUT_lw_nowv' num2str(91-i*10)]);
end

%Run also once with just equator profile and full output, see if window no is meaningful or just a best fit thing


atm=zeros(25,5);
nn=size(atm,1);
atm(:,1)=z_mit(:,9)./1000.;
atm(:,2)=p_mit;
atm(:,3)=t_mit(:,9);
atm(:,4)=1e-15;
atm(:,5)=1e-15;


filename=['~/matlab/longwave/atms.dat_lw_nowv_eqfull'];
dlmwrite(filename, 25)
dlmwrite(filename, atm,'delimiter', '\t','precision', '%.15f','-append')

system('rm OUTPUT')
system('cp atms.dat_lw_nowv_eqfull atms.dat')

blank = '0';
data = zeros(7,25);
file = '';

    fileID = fopen('INPUT','w'); 
    fprintf(fileID,'$INPUT\n');
    %fprintf(fileID,'  nf = 0.\n');
    fprintf(fileID,'  wlinf = 4.005\n');
    fprintf(fileID,'  wlsup = 100.0\n');
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

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

	system('mv OUTPUT nowv/OUTPUT_lw_nowv_eqfull')



