%oz_sbdart.m
%Run SBDART driven with: 'yearly zon av o3 profs' + T profile from MITgcm. Run with no WV + with WV + with no O3 to check if roughly additive

%Load up O3, T, WV, P, alt data

load('standard_profs.mat');

%choose pressure levels so lower levels match MITgcm
p_levs(1:25,1) = 980:-40:20;
p_levs(26:49,1) = p_gl(27:50,1);

%interpolate ozone density and altitudes onto new pressure levels
for i=1:6
o_dens_press(:,i) = interp1(p_gl(:,i),o_dens_gl(:,i),p_levs,'linear','extrap');
alt_press(:,i) = interp1(p_gl(:,i),alts(:,i),p_levs,'linear','extrap');
end

o_dens_press(find(o_dens_press<0))=0;

%make 'seasonal average' ozone profile
midlat_av = (o_dens_press(:,2)+o_dens_press(:,3))./2;
subpol_av = (o_dens_press(:,4)+o_dens_press(:,5))./2;
midlat_alts = (alt_press(:,2)+alt_press(:,3))./2;
subpol_alts = (alt_press(:,4)+alt_press(:,5))./2;

alt_prof = zeros(49,6);
alt_prof(:,1) = subpol_alts;
alt_prof(:,2) = midlat_alts;
alt_prof(:,3) = alt_press(:,1);
alt_prof(:,4) = alt_press(:,1);
alt_prof(:,5) = midlat_alts;
alt_prof(:,6) = subpol_alts;
o_prof= zeros(49,6);
o_prof(:,1) = subpol_av;
o_prof(:,2) = midlat_av;
o_prof(:,3) = o_dens_press(:,1);
o_prof(:,4) = o_dens_press(:,1);
o_prof(:,5) = midlat_av;
o_prof(:,6) = subpol_av;
lat_o(1) = -60.;
lat_o(2) = -45.;
lat_o(3) = -15.;
lat_o(4) = 15.;
lat_o(5) = 45.;
lat_o(6) = 60.;
return
nit=345600;
rDir='/disk1/rg312/run_control_0516/';
ny=90;
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

theta_full=rdmds([rDir,'Ttave'],nit);
[theta_av,mskzon,ylat,areazon]=calcZonalAvgCube(theta_full,ny,yc,ar,hc);
convthetatoT(1,:)=(rC/rC(1)).^(2./7.);
t_prof(:,1) = theta_av(15,:).*convthetatoT;
t_prof(:,2) = theta_av(23,:).*convthetatoT;
t_prof(:,3) = theta_av(38,:).*convthetatoT;
t_prof(:,4) = theta_av(53,:).*convthetatoT;
t_prof(:,5) = theta_av(68,:).*convthetatoT;
t_prof(:,6) = theta_av(76,:).*convthetatoT;

t_prof(:,1) = (t_prof(:,1)+t_prof(:,6))./2;
t_prof(:,2) = (t_prof(:,2)+t_prof(:,5))./2;
t_prof(:,3) = (t_prof(:,3)+t_prof(:,4))./2;
t_prof(:,4) = t_prof(:,3);
t_prof(:,5) = t_prof(:,2);
t_prof(:,6) = t_prof(:,1);

q=rdmds([rDir,'Stave'],nit);
[q_av,mskzon,ylat,areazon]=calcZonalAvgCube(q,ny,yc,ar,hc);
q_prof(:,1) = q_av(15,:);
q_prof(:,2) = q_av(23,:);
q_prof(:,3) = q_av(38,:);
q_prof(:,4) = q_av(53,:);
q_prof(:,5) = q_av(68,:);
q_prof(:,6) = q_av(76,:);
q_prof(:,1) = (q_prof(:,1)+q_prof(:,6))./2;
q_prof(:,2) = (q_prof(:,2)+q_prof(:,5))./2;
q_prof(:,3) = (q_prof(:,3)+q_prof(:,4))./2;
q_prof(:,4) = q_prof(:,3);
q_prof(:,5) = q_prof(:,2);
q_prof(:,6) = q_prof(:,1);

theta = false;

for i=1:6
z_prof(:,i) = find_height(p_levs(1:25),t_prof(1:25,i),theta);
end
z_prof = z_prof/1000.;

% wv mixing ratio w = q/(1-q)
% density of wv = w*density of air
% density of air = p/RaT (or close enough) *1000 to get in g/m3

for i=1:6
rhoair(:,i) = p_levs(1:25,1).*100./(287.058*t_prof(:,i));
end
w_prof = q_prof./(1-q_prof);
wvdens_prof = w_prof.*rhoair.*1000.;

%interpolate to get top pressure layer above 20hPa for htrates

for i=1:6
t_prof_ex(:,i) = interp1(p_levs(1:25,1),t_prof(:,i),p_levs(1:26,1),'linear','extrap');
z_prof_ex(:,i) = interp1(p_levs(1:25,1),z_prof(:,i),p_levs(1:26,1),'linear','extrap');
wvdens_prof_ex(:,i) = interp1(p_levs(1:25,1),wvdens_prof(:,i),p_levs(1:26,1),'linear','extrap');
end


%Run SBDART with O3 for SW and LW ranges
%Save in /sbdart_oz/
szen = [60,45,15]
for c=1:3

atm(:,1) = flipud(z_prof_ex(1:26,c));
atm(:,2) = flipud(p_levs(1:26,1));
atm(:,3) = flipud(t_prof_ex(1:26,c));
atm(:,4) = 1e-12; 
atm(:,5) = flipud(o_prof(1:26,c));
filename=['~/matlab/sbdart_ozone/atms.dat_oz' num2str(c)];
dlmwrite(filename, 26)
dlmwrite(filename, atm,'delimiter', '\t','precision', '%.15f','-append')
job = ['cp atms.dat_oz' num2str(c) ' atms.dat'];
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
 formatSpec = '  sza =  %3.1f\n';
    fprintf(fileID,formatSpec,szen(c));
    fprintf(fileID,'  iout = 11\n');
    fprintf(fileID,'  isalb = 0\n');
    fprintf(fileID,'  albcon = 0.06\n');
    fprintf(fileID,'  kdist = 3\n');
    %fprintf(fileID,'  idb(7) = 1\n');
    fprintf(fileID,'$end\n');
    fclose(fileID);

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

	system(['mv OUTPUT sbdart_oz/OUTPUT_ozsw' num2str(c)])



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
    fprintf(fileID,formatSpec,szen(c));
    fprintf(fileID,'  iout = 11\n');
    fprintf(fileID,'  isalb = 0\n');
    fprintf(fileID,'  albcon = 0.06\n');
    fprintf(fileID,'  kdist = 3\n');
    %fprintf(fileID,'  idb(7) = 1\n');
    fprintf(fileID,'$end\n');
    fclose(fileID);

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

	system(['mv OUTPUT sbdart_oz/OUTPUT_ozlw' num2str(c)])


%Run SBDART with WV for SW and LW ranges
%Save in /sbdart_wvonly

atm(:,1) = flipud(z_prof_ex(1:26,c));
atm(:,2) = flipud(p_levs(1:26,1));
atm(:,3) = flipud(t_prof_ex(1:26,c));
atm(:,4) = flipud(wvdens_prof_ex(1:26,c));
atm(:,5) = 1e-14;
filename=['~/matlab/sbdart_ozone/atms.dat_wv' num2str(c)];
dlmwrite(filename, 26)
dlmwrite(filename, atm,'delimiter', '\t','precision', '%.15f','-append')
job = ['cp atms.dat_wv' num2str(c) ' atms.dat'];
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
 formatSpec = '  sza =  %3.1f\n';
    fprintf(fileID,formatSpec,szen(c));
    fprintf(fileID,'  iout = 11\n');
    fprintf(fileID,'  isalb = 0\n');
    fprintf(fileID,'  albcon = 0.06\n');
    fprintf(fileID,'  kdist = 3\n');
    %fprintf(fileID,'  idb(7) = 1\n');
    fprintf(fileID,'$end\n');
    fclose(fileID);

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

	system(['mv OUTPUT sbdart_wvonly/OUTPUT_sw' num2str(c)])

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
    fprintf(fileID,formatSpec,szen(c));
    fprintf(fileID,'  iout = 11\n');
    fprintf(fileID,'  isalb = 0\n');
    fprintf(fileID,'  albcon = 0.06\n');
    fprintf(fileID,'  kdist = 3\n');
    %fprintf(fileID,'  idb(7) = 1\n');
    fprintf(fileID,'$end\n');
    fclose(fileID);

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

	system(['mv OUTPUT sbdart_wvonly/OUTPUT_lw' num2str(c)])

%Run SBDART with both for SW and LW ranges
%Save in /sbdart_ozwv

atm(:,1) = flipud(z_prof_ex(1:26,c));
atm(:,2) = flipud(p_levs(1:26,1));
atm(:,3) = flipud(t_prof_ex(1:26,c));
atm(:,4) = flipud(wvdens_prof_ex(1:26,c));
atm(:,5) = flipud(o_prof(1:26,c));
filename=['~/matlab/sbdart_ozone/atms.dat_ozwv' num2str(c)];
dlmwrite(filename, 26)
dlmwrite(filename, atm,'delimiter', '\t','precision', '%.15f','-append')
job = ['cp atms.dat_ozwv' num2str(c) ' atms.dat'];
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
 formatSpec = '  sza =  %3.1f\n';
    fprintf(fileID,formatSpec,szen(c));
    fprintf(fileID,'  iout = 11\n');
    fprintf(fileID,'  isalb = 0\n');
    fprintf(fileID,'  albcon = 0.06\n');
    fprintf(fileID,'  kdist = 3\n');
    %fprintf(fileID,'  idb(7) = 1\n');
    fprintf(fileID,'$end\n');
    fclose(fileID);

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

	system(['mv OUTPUT sbdart_ozwv/OUTPUT_ozwvsw' num2str(c)])

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
    fprintf(fileID,formatSpec,szen(c));
    fprintf(fileID,'  iout = 11\n');
    fprintf(fileID,'  isalb = 0\n');
    fprintf(fileID,'  albcon = 0.06\n');
    fprintf(fileID,'  kdist = 3\n');
    %fprintf(fileID,'  idb(7) = 1\n');
    fprintf(fileID,'$end\n');
    fclose(fileID);

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

	system(['mv OUTPUT sbdart_ozwv/OUTPUT_ozwvlw' num2str(c)])


%Run with no oz, no wv
atm(:,1) = flipud(z_prof_ex(1:26,c));
atm(:,2) = flipud(p_levs(1:26,1));
atm(:,3) = flipud(t_prof_ex(1:26,c));
atm(:,4) = 1e-12; 
atm(:,5) = 1e-14;
filename=['~/matlab/sbdart_ozone/atms.dat_cl' num2str(c)];
dlmwrite(filename, 26)
dlmwrite(filename, atm,'delimiter', '\t','precision', '%.15f','-append')
job = ['cp atms.dat_cl' num2str(c) ' atms.dat'];
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
 formatSpec = '  sza =  %3.1f\n';
    fprintf(fileID,formatSpec,szen(c));
    fprintf(fileID,'  iout = 11\n');
    fprintf(fileID,'  isalb = 0\n');
    fprintf(fileID,'  albcon = 0.06\n');
    fprintf(fileID,'  kdist = 3\n');
    %fprintf(fileID,'  idb(7) = 1\n');
    fprintf(fileID,'$end\n');
    fclose(fileID);

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

	system(['mv OUTPUT sbdart_cl/OUTPUT_clsw' num2str(c)])



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
    fprintf(fileID,formatSpec,szen(c));
    fprintf(fileID,'  iout = 11\n');
    fprintf(fileID,'  isalb = 0\n');
    fprintf(fileID,'  albcon = 0.06\n');
    fprintf(fileID,'  kdist = 3\n');
    %fprintf(fileID,'  idb(7) = 1\n');
    fprintf(fileID,'$end\n');
    fclose(fileID);

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

	system(['mv OUTPUT sbdart_cl/OUTPUT_cllw' num2str(c)])


end
