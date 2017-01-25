%load in temperature profiles from vw, np, and original radiation scheme runs
%plot up differences

%also load up the heating rates for fixed T and q profiles and compare the differences in these.



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


var(1,:) = 'THETA   ';
varv(1,:) = '        ';

clear rDir
rDir(1,:)=cellstr('/project/rg312/run_radon_varyingwin/');
rDir(2,:)=cellstr('/project/rg312/run_radon_cwnp/');
tzav = mit_zavs(rDir,var,niti,nitt,nits,'varv',varv);

clear rDir
rDir=cellstr('/project/rg312/run_radon_doshallower/');
tzav_orig = mit_zavs(rDir,var,432000,'varv',varv);


convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
t_vw(:,j)=tzav(:,j,1).*convthetatoT(j,1);
t_np(:,j)=tzav(:,j,2).*convthetatoT(j,1);
t_orig(:,j)=tzav_orig(:,j,1).*convthetatoT(j,1);

end

figure
v = -35:5:5;
[C,h] = contour(yi,rC,t_vw' - t_orig(:,:,1)',v,'k');
set(gca,'yDir','reverse')
xlabel('Latitude')
ylabel('Pressure, Pa')
clabel(C,h);
title('Difference in Temperature between varying window and standard parameterisations')
print('-dpdf','t_diff_vw_orig.pdf')

load('../week_0929/rad_mod_param_tests/windowvarying/radmod_lw_2.mat')
tdt_vw = tdt_lw.*86400;
load('../week_0922/radmod_lw.mat')
tdt_orig = tdt_lw.*86400;


figure
v = -2:0.2:2;
[C,h] = contour(yi,flipdim(rC,1),tdt_vw' - tdt_orig','k');
set(gca,'yDir','reverse')
xlabel('Latitude')
ylabel('Pressure, Pa')
clabel(C,h);
title('Difference in LW Cooling between varying window and standard parameterisations')
print('-dpdf','tdt_diff_vw_orig.pdf')



