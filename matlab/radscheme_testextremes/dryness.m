%dryness.m
%Run SBDART for the temperature profiles produced using our longwave scheme but with no water vapour
%Calculate dtau/dsigma and try to fit a constant to this

%load in pressure, altitude and temperature profiles to use

nit=1728000;
rDir='/disk1/rg312/run_20yrcontrol/'; 
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

%zonally average theta data
t=rdmds([rDir,'Ttave'],nit);
[th_mean,mskzon,ylat,areazon]=calcZonalAvgCube(t,ny,yc,ar,hc);

%convert theta to temperature
convthetatoT=(rC/rC(1)).^(2./7.);
for j=1:size(rC)
realt(:,j)=th_mean(:,j)*convthetatoT(j);
end

%use function find_height with rC and th_mean to find z profile
theta=true
for i=1:90
z(i,:)=find_height(rC,th_mean(i,:),theta);
end

%reorder variables to lowest pressure is at top for all (as in SBDART)
realt = fliplr(realt);
th_mean=fliplr(th_mean);
z = fliplr(z)./1000.;
rC = flipud(rC);

%load SBDART input atmosphere up so don't have to re-input pressure and ozone
mitprof = dlmread('~/matlab/sbdart/atms_profiles/atms.dat_mitwv');

%run SBDART for this profile, no wv

for i=1:5:46
i
%define and save atmos profile to atms.dat using MITgcm output
mitprof(2:26,1) = z(i,:);
mitprof(2:26,3) = realt(i,:);
mitprof(2:26,4) = 1e-15;

filename=['./atms.dat' num2str(i)];
dlmwrite(filename, 25)
dlmwrite(filename, mitprof(2:26,:),'delimiter', '\t','precision', '%.15f','-append')
job = ['cp atms.dat' num2str(i) ' atms.dat'];
system(job)

%Run SBDART for this profile

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
    fprintf(fileID,formatSpec,ylat(i));
    fprintf(fileID,'  iout = 11\n');
    fprintf(fileID,'  isalb = 0\n');
    fprintf(fileID,'  albcon = 0.06\n');
    fprintf(fileID,'  kdist = 3\n');
    %fprintf(fileID,'  idb(7) = 1\n');
    fprintf(fileID,'$end\n');
    fclose(fileID);

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

	system(['mv OUTPUT out/OUTPUT_win' num2str(i)])

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
    fprintf(fileID,formatSpec,ylat(i));
    fprintf(fileID,'  iout = 11\n');
    fprintf(fileID,'  isalb = 0\n');
    fprintf(fileID,'  albcon = 0.06\n');
    fprintf(fileID,'  kdist = 3\n');
    %fprintf(fileID,'  idb(7) = 1\n');
    fprintf(fileID,'$end\n');
    fclose(fileID);

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

	system(['mv OUTPUT out/OUTPUT_lw1' num2str(i)])

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
    fprintf(fileID,formatSpec,ylat(i));
    fprintf(fileID,'  iout = 11\n');
    fprintf(fileID,'  isalb = 0\n');
    fprintf(fileID,'  albcon = 0.06\n');
    fprintf(fileID,'  kdist = 3\n');
    %fprintf(fileID,'  idb(7) = 1\n');
    fprintf(fileID,'$end\n');
    fclose(fileID);

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

	system(['mv OUTPUT out/OUTPUT_lw2' num2str(i)])


end
