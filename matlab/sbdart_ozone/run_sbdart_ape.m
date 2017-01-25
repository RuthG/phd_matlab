%run_sbdart_ape.m
%read in ape data and run sbdart

load('read_ape_prof.mat')


%get MITgcm p, z, q and T profiles
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

%zonally average q and theta data
q=rdmds([rDir,'Stave'],nit);
[q_mean,mskzon,ylat,areazon]=calcZonalAvgCube(q,ny,yc,ar,hc);
t=rdmds([rDir,'Ttave'],nit);
[th_mean,mskzon,ylat,areazon]=calcZonalAvgCube(t,ny,yc,ar,hc);

%transfer o3 density profile to correct coordinates
o3_mit_1 = interp1(press*100.,o3,rC);
o3_mit_2 = interp1(lats,shiftdim(o3_mit_1,1),ylat,'linear','extrap');

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

%reorder variables so lowest pressure is at top for all (as in SBDART)
q_mean=fliplr(q_mean);
realt = fliplr(realt);
th_mean=fliplr(th_mean);
z = fliplr(z)./1000.;
rC = flipud(rC);
rC=shiftdim(rC,1);
o3_mit_2 = fliplr(o3_mit_2);

Ra = 287.058;  		%J/kg/K
R = 8.3144621;  		%J/mol/K
for i = 1:90
%p = rho R_a T .... rho = p/(R_a T)
rhoair(i,:)=rC./(287.058.*realt(i,:)); 	%Pa./(J/kg) = N/m2 ./ (Nm/kg) = kg/m3
w(i,:) = rhoair(i,:).*1000.*q_mean(i,:)./(1-q_mean(i,:));
end

%change ozone to density
gmolo = 48.0;

%pV = nRT ..... V/n = RT/p
for i=1:25
vmol(:,i) = R*realt(:,i)./(rC(1,i)); 	%Nm/mol ./ N/m2 = m3/mol
end

%ppmv * 10-6 *g/mol ./ v/mol = g/v

o3_dens = (o3_mit_2 * 1e-6 * gmolo)./vmol;	%g/m3 o3




for i=1:90
i
%define atms profile
atms(:,1) = z(i,:);
atms(:,2) = rC./100.;
atms(:,3) = realt(i,:);
atms(:,4) = w(i,:);
atms(:,5) = o3_dens(i,:);

filename=['./atms.dat'];
dlmwrite(filename, 25)
dlmwrite(filename, atms,'delimiter', '\t','precision', '%.15f','-append')


%Run SBDART for this profile - SW
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
    fprintf(fileID,formatSpec,ylat(i));
    fprintf(fileID,'  iout = 11\n');
    fprintf(fileID,'  isalb = 0\n');
    fprintf(fileID,'  albcon = 0.06\n');
    fprintf(fileID,'  kdist = 3\n');
    %fprintf(fileID,'  idb(7) = 1\n');
    fprintf(fileID,'$end\n');
    fclose(fileID);

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

command = ['mv OUTPUT sbdart_out_sw/OUTPUT_check' num2str(ylat(i))];
	system(command);


filename = ['./sbdart_out_sw/OUTPUT_check' num2str(ylat(i))];

%read downward fluxes from SBDART output and calculate optical depth for each lat
output = dlmread(filename);
fxdn_sw(i,:)  = output(2:26,3);
fxup_sw(i,:)  = output(2:26,4);
heat_sw(i,:)  = output(2:26,7);

%Run SBDART for this profile - LW
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

command = ['mv OUTPUT sbdart_out_lw/OUTPUT_check' num2str(ylat(i))];
	system(command);


filename = ['./sbdart_out_lw/OUTPUT_check' num2str(ylat(i))];

%read downward fluxes from SBDART output and calculate optical depth for each lat
output = dlmread(filename);
fxdn_lw(i,:)  = output(2:26,3);
fxup_lw(i,:)  = output(2:26,4);
heat_lw(i,:)  = output(2:26,7);



%repeat with no o3
%define atms profile

atms(:,5) = 1e-15;

filename=['./atms.dat'];
dlmwrite(filename, 25)
dlmwrite(filename, atms,'delimiter', '\t','precision', '%.15f','-append')


%Run SBDART for this profile - SW
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
    fprintf(fileID,formatSpec,ylat(i));
    fprintf(fileID,'  iout = 11\n');
    fprintf(fileID,'  isalb = 0\n');
    fprintf(fileID,'  albcon = 0.06\n');
    fprintf(fileID,'  kdist = 3\n');
    %fprintf(fileID,'  idb(7) = 1\n');
    fprintf(fileID,'$end\n');
    fclose(fileID);

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

command = ['mv OUTPUT sbdart_out_sw/OUTPUT_check_nw' num2str(ylat(i))];
	system(command);


filename = ['./sbdart_out_sw/OUTPUT_check_nw' num2str(ylat(i))];

%read downward fluxes from SBDART output and calculate optical depth for each lat
output = dlmread(filename);
fxdn_sw_nw(i,:)  = output(2:26,3);
fxup_sw_nw(i,:)  = output(2:26,4);
heat_sw_nw(i,:)  = output(2:26,7);

%Run SBDART for this profile - LW
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

command = ['mv OUTPUT sbdart_out_lw/OUTPUT_check_nw' num2str(ylat(i))];
	system(command);


filename = ['./sbdart_out_lw/OUTPUT_check_nw' num2str(ylat(i))];

%read downward fluxes from SBDART output and calculate optical depth for each lat
output = dlmread(filename);
fxdn_lw_nw(i,:)  = output(2:26,3);
fxup_lw_nw(i,:)  = output(2:26,4);
heat_lw_nw(i,:)  = output(2:26,7);


end
