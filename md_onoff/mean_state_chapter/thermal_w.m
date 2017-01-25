rDir='/project/rg312/final_runs/run_000_final_noshallow/';
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
xi=-179:2:179;
yi=-89:2:89;
a=6371.0e3;

load('/project/rg312/mat_files/chapter2_variables/htrts_tav_000.mat','htrt_tav')
load('/project/rg312/mat_files/chapter2_variables/uvwqt_tav_000.mat','theta_tav')

theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
htrt_ll=cube2latlon(xc,yc,htrt_tav,xi,yi);

theta_zav(:,:) = mean(theta_ll,1);
htrt_zav(:,:) = mean(htrt_ll,1);

dthetadp = gradient(theta_zav,-4000);

w_therm = htrt_zav./dthetadp;
contourf(htrt_zav'./dthetadp')

for i=1:45
integrand(i,:) = -a.^2.*w_therm(45+i,:)./9.8.*cos(yi(45+i).*pi./180);
end

v=-210:30:210;
psi_play = 2.*pi.*cumsum(integrand).*pi./90;
figure
contourf(psi_play'./1e9,v)

