%check_window.m
%check results from sbdart_lw as to whether changing window param fixes LW scheme

%Run SBDART with a range of WV profiles using MITgcm control run zonal mean data


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

q=rdmds([rDir,'Stave'],nit);
[q_av,mskzon,ylat,areazon]=calcZonalAvgCube(q,ny,yc,ar,hc);
for i=1:9
q_mit(:,i) = q_av(i*5,:);
end
q_mit = flipud(q_mit);

theta = false;

for i=1:9
z_mit(:,i) = find_height(p_mit,t_mit(:,i),theta);
end
z_mit = flipud(z_mit);

% wv mixing ratio w = q/(1-q)
% density of wv = w*density of air
% density of air = p/RaT (or close enough) *1000 to get in g/m3

for i=1:9
rhoair(:,i) = p_mit.*100./(287.058*t_mit(:,i));
end
w_mit = q_mit./(1-q_mit);
wvdens_mit = w_mit.*rhoair.*1000.;

for i=1:9

%write this profile both in mit and on doh pressure levels for comparison

atm=zeros(25,5);
nn=size(atm,1);
atm(:,1)=z_mit(:,i)./1000.;
atm(:,2)=p_mit;
atm(:,3)=t_mit(:,i);
atm(:,4)=wvdens_mit(:,i);
atm(:,5)=1e-15;

save('sbdart_lw.mat','atm','q_mit','rhoair','t_mit','z_mit','p_mit','wvdens_mit')
filename=['~/matlab/longwave/atms.dat_lw' num2str(91-i*10)];
dlmwrite(filename, 25)
dlmwrite(filename, atm,'delimiter', '\t','precision', '%.15f','-append')

system('rm OUTPUT')
system(['cp atms.dat_lw' num2str(91-i*10) ' atms.dat'])

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

	system(['mv OUTPUT check_window/OUTPUT_lw' num2str(91-i*10)])

%Read in results
output_lw(:,:,i) = dlmread(['~/matlab/longwave/check_window/OUTPUT_lw' num2str(91-i*10)]);
end

%Run also once with just equator profile and full output, see if window no is meaningful or just a best fit thing


atm=zeros(25,5);
nn=size(atm,1);
atm(:,1)=z_mit(:,9)./1000.;
atm(:,2)=p_mit;
atm(:,3)=t_mit(:,9);
atm(:,4)=wvdens_mit(:,9);
atm(:,5)=1e-15;


filename=['~/matlab/longwave/atms.dat_lw_eqfull'];
dlmwrite(filename, 25)
dlmwrite(filename, atm,'delimiter', '\t','precision', '%.15f','-append')

system('rm OUTPUT')
system('cp atms.dat_lw_eqfull atms.dat')

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

	system('mv OUTPUT check_window/OUTPUT_lw_eqfull')


%use sbdart_window_fn to see if we can get a consistent solution

nothing = zeros(1,22);
options = optimset('lsqcurvefit');
options = optimset(options,'TolFun',1e-30,'TolX',1e-30,'MaxFunEvals',1000);
x0=[0.1]
for index=1:9
[c,resnorm] = lsqcurvefit(@sbdart_window_fn,x0,index,nothing,0,1,options)
end

[x,fval] = fminsearch(@sbdart_window_fn,x0)

