%oz_heat_run.m
%load up results from ozone heating + vw run and see if this 'sorts out' our zonal winds.



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
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
yi = -89:2:89;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run %%%%%%%%%%%%%%%%

niti = 62640;
nits = 240;
nitt = 86400;

var(1,:) = 'UVEL    ';
var(2,:) = 'THETA   ';

varv(1,:) = 'VVEL    ';
varv(2,:) = '        ';


clear rDir
rDir(1,:)=cellstr('/project/rg312/run_radon_vwoz/');
rDir(2,:)=cellstr('/project/rg312/run_radon_varyingwin/');
[tzav,tzavv] = mit_zavs(rDir,var,niti,nitt,nits,'varv',varv);


convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
t_oz(:,j)=tzav(:,j,2,1).*convthetatoT(j,1);
t_vw(:,j)=tzav(:,j,2,2).*convthetatoT(j,1);
end

v = -20:5:50;
[C,h] = contour(yi,rC,tzav(:,:,1)',v,'k');
clabel(C,h);
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, hPa')
