%wv_expts.m
%Use the wv profile from MITgcm to parameterise absorption by wv by comparison with SBDART

%read in q, p, T, calc rho, z, and wv dens

nit=345600;
rDir='/disk1/rg312/run_swwvscheme_mag/';
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
t_mit(:,1) = theta_av(45,:).*convthetatoT;
t_mit = flipud(t_mit);

q=rdmds([rDir,'Stave'],nit);
[q_av,mskzon,ylat,areazon]=calcZonalAvgCube(q,ny,yc,ar,hc);
q_mit(:,1) = q_av(45,:);
q_mit = flipud(q_mit);

theta = false;

z_mit = find_height(p_mit,t_mit,theta);
z_mit = flipud(z_mit);

% wv mixing ratio w = q/(1-q)
% density of wv = w*density of air
% density of air = p/RaT (or close enough) *1000 to get in g/m3

rhoair = p_mit.*100./(287.058*t_mit);
w_mit = q_mit./(1-q_mit);
wvdens_mit = w_mit.*rhoair.*1000.;

%write this profile both in mit and on doh pressure levels for comparison

atm=zeros(25,5);
nn=size(atm,1);
atm(:,1)=z_mit./1000.;
atm(:,2)=p_mit;
atm(:,3)=t_mit;
atm(:,4)=wvdens_mit;
atm(:,5)=1e-15;

filename=['~/matlab/sbdart_wv/atms.dat_mitl'];
dlmwrite(filename, 25)
dlmwrite(filename, atm,'delimiter', '\t','precision', '%.15f','-append')

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

	system('mv OUTPUT OUTPUT_wv_mit')

save('wv_expts.mat')
