%sbdart_lw.m
%Run SBDART with a given wv/T profile for comparison with predictions from MIT model

%read in q, p, T, calc rho, z, and wv dens

nit=345600;
rDir='/disk1/rg312/run_swwvscheme_mag_rhofixed/';
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
atm(:,4)=1e-15; %wvdens_mit;
atm(:,5)=1e-15;

save('sbdart_lw.mat','atm','q_mit','rhoair')
filename=['~/matlab/longwave/atms.dat_lwnowv'];
dlmwrite(filename, 25)
dlmwrite(filename, atm,'delimiter', '\t','precision', '%.15f','-append')

system('rm OUTPUT')
system('cp atms.dat_lwnowv atms.dat')

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

	system('mv OUTPUT OUTPUT_lwnowv')

%Read in results
output_lw = dlmread('~/matlab/longwave/OUTPUT_lw');


fxdn  = output_lw(2:26,3);
fxup  = output_lw(2:26,4);
heat  = output_lw(2:26,7);
fxdn_half = interp1(p,fxdn,p_half,'linear','extrap');
fxup_half = interp1(p,fxup,p_half,'linear','extrap');
q_mit_half = interp1(p,q_mit,p_half,'linear','extrap');
t_mit_half = interp1(p,t_mit,p_half,'linear','extrap');

options = optimset('lsqcurvefit');
options = optimset(options,'TolFun',1e-10);
x0=[0.8,1000.,0.1]
[c,resnorm] = lsqcurvefit(@lw_fn,x0,q_mit,heat)

%try inverting MITgcm formula, assuming window = 1
stefan 	= 5.67e-8;
for i=1:24
b(i) = stefan*t_mit(i).^4;
dtrans_dn(i) = (fxdn(i+1)-b(i))./(fxdn(i)-b(i));
dtrans_up(i) = (fxup(i)-b(i))./(fxup(i+1)-b(i));
del_tau_dn(i) = -log(dtrans_dn(i));
del_tau_up(i) = -log(dtrans_up(i));
end

output_lwnowv = dlmread('~/matlab/longwave/OUTPUT_lwnowv');
fxdn_nw  = output_lwnowv(2:26,3);
fxup_nw  = output_lwnowv(2:26,4);
heat_nw  = output_lwnowv(2:26,7);
for i=1:24
b(i) = stefan*t_mit(i).^4;
dtrans_dnnw(i) = (fxdn_nw(i+1)-b(i))./(fxdn_nw(i)-b(i));
dtrans_upnw(i) = (fxup_nw(i)-b(i))./(fxup_nw(i+1)-b(i));
del_tau_dnnw(i) = -log(dtrans_dnnw(i));
del_tau_upnw(i) = -log(dtrans_upnw(i));
end

