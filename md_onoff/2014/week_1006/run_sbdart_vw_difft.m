%run sbdart for two q profiles from new run output, one at equator one at higher lat. Use t profile from a lower wv run
%compare with heating rates produced by running matlab radiation mod for vw, np, and original schemes.


% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_doshallower_5year/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));
drC=squeeze(rdmds([rDir,'DRC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
ny=90;

%read files

nit=432000;

rDir='/project/rg312/wv_on_rad_off/run_doshallower_5year/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'SALT    '));
q=dyn(:,:,:,J);

rDir='/project/rg312/wv_on_rad_off/run_doshallower_5yearh/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta=dyn(:,:,:,J);



xi=-179:2:180;yi=-89:2:90;
qll=cube2latlon(xc,yc,q,xi,yi);
thetall=cube2latlon(xc,yc,theta,xi,yi);

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:size(rC)
tll(:,:,k)=thetall(:,:,k).*convthetatoT(k,1);
end

% wv mixing ratio w = q/(1-q)
% density of wv = w*density of air
% density of air = p/RaT (or close enough) *1000 to get in g/m3

Ra = 287.04;
g= 9.81;
omega = 2.*pi./24./60./60;

for i=1:25
rho(:,:,i) = rC(i)./Ra./tll(:,:,i);
end

dz_approx = 4000./rho./g;
%integrating the above (summing) gives us z at 100000, 96000, 92000, etc. Assumes p=100000 at z=0
z_approx = zeros(180,90,26);
z_approx(:,:,1) = 0;
z_approx(:,:,2:26) = cumsum(dz_approx,3);
rC_zlevs = 100000:-4000:0;
rC_zlevs_o = rC_zlevs;
rC_zlevs(26) = 0.1;

q_zlevs = zeros(2,26);
t_zlevs = zeros(2,26);
rho_zlevs = zeros(2,26);

%interpolate q and T to get to match with z levels
q_zlevs(1,:) = shiftdim(interp1(rC,shiftdim(qll(1,46,:),1),rC_zlevs,'cubic','extrap'),1);
t_zlevs(1,:) = shiftdim(interp1(rC,shiftdim(tll(1,46,:),1),rC_zlevs,'cubic','extrap'),1);
z_zlevs(1,:) = shiftdim(interp1(rC_zlevs_o,shiftdim(z_approx(1,46,:),1),rC_zlevs,'cubic','extrap'),1);
q_zlevs(2,:) = shiftdim(interp1(rC,shiftdim(qll(1,81,:),1),rC_zlevs,'cubic','extrap'),1);
t_zlevs(2,:) = shiftdim(interp1(rC,shiftdim(tll(1,81,:),1),rC_zlevs,'cubic','extrap'),1);
z_zlevs(2,:) = shiftdim(interp1(rC_zlevs_o,shiftdim(z_approx(1,81,:),1),rC_zlevs,'cubic','extrap'),1);

for i=1:26
rho_zlevs(:,i) = rC_zlevs(i)./Ra./t_zlevs(:,i);
end

%DOUBLE CHECK
w_zlevs = q_zlevs./(1-q_zlevs);
wvdens_zlevs = w_zlevs.*rho_zlevs.*1000.;

%need height, pressure, temperature, water vapour density, ozone density

z_sb = fliplr(z_zlevs);
p_sb = fliplr(rC_zlevs)./100;
t_sb = fliplr(t_zlevs);
wvdens_sb = fliplr(wvdens_zlevs);
ozdens_sb = 1e-15;

atm=zeros(26,5);
nn=size(atm,1);

i=0;
for a=46:35:81
i=i+1;
atm(:,1)=z_sb(i,:)./1000.;
atm(:,2)=p_sb(:);
atm(:,3)=t_sb(i,:);
atm(:,4)=wvdens_sb(i,:);
atm(:,5)=ozdens_sb;

filename=['./atm_profs/atms.dat_' int2str(a)];
dlmwrite(filename, 26)
dlmwrite(filename, atm,'delimiter', '\t','precision', '%.15f','-append')

end




clear


%%%%%%%%%% now run SBDART for the above %%%%%%%%%%%%%%%%%%


yi = -89:2:89;

yy=yi*90/60*pi/180;
sinyy=sin(yy);
sst=27*(1-sinyy.*sinyy);
sst(find(abs(yi)>=60))=0;
t_surf=sst+273.15;

for i=46:35:81

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

command = ['mv OUTPUT ./OUTPUT_sw_' int2str(i)]
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
 formatSpec = '  sza =  %3.1f\n';
    fprintf(fileID,formatSpec,yi(i));
    fprintf(fileID,'  iout = 11\n');
    fprintf(fileID,'  isalb = 0\n');
    fprintf(fileID,'  albcon = 0.0\n');
    fprintf(fileID,'  kdist = 3\n');
 formatSpec = '  btemp =  %3.1f\n';
    fprintf(fileID,formatSpec,t_surf(i));
    %fprintf(fileID,'  idb(7) = 1\n');
    fprintf(fileID,'$end\n');
    fclose(fileID);

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

command = ['mv OUTPUT ./OUTPUT_lw_l_' int2str(i)]
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
 formatSpec = '  sza =  %3.1f\n';
    fprintf(fileID,formatSpec,yi(i));
    fprintf(fileID,'  iout = 11\n');
    fprintf(fileID,'  isalb = 0\n');
    fprintf(fileID,'  albcon = 0.0\n');
    fprintf(fileID,'  kdist = 3\n');
 formatSpec = '  btemp =  %3.1f\n';
    fprintf(fileID,formatSpec,t_surf(i));
    %fprintf(fileID,'  idb(7) = 1\n');
    fprintf(fileID,'$end\n');
    fclose(fileID);

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

command = ['mv OUTPUT ./OUTPUT_lw_u_' int2str(i)]
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
 formatSpec = '  sza =  %3.1f\n';
    fprintf(fileID,formatSpec,yi(i));
    fprintf(fileID,'  iout = 11\n');
    fprintf(fileID,'  isalb = 0\n');
    fprintf(fileID,'  albcon = 0.0\n');
    fprintf(fileID,'  kdist = 3\n');
 formatSpec = '  btemp =  %3.1f\n';
    fprintf(fileID,formatSpec,t_surf(i));
    %fprintf(fileID,'  idb(7) = 1\n');
    fprintf(fileID,'$end\n');
    fclose(fileID);

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

command = ['mv OUTPUT ./OUTPUT_wv_' int2str(i)]
	system(command)





end



