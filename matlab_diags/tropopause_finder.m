%Use psi (calculated with mass_transport3.m) to estimate the location of the tropopause in pressure coordinates.

%load up psi values
load('daily_data_psi.mat')

%select threshold for min mass transport values at tropopause. 0.95e10 chosen to avoid the 'smeared' bit at the top where mass budget not closed

threshmin=0.95e10;
threshmax=1.5e10;

%open year 5 theta files and zonally average; corresponds to theta at the start of the run
rDir='/home/rg312/RUTH/MITgcm/verification/atm_gray/run/';
nit=259200;
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
AngleCS=single(rdmds([rDir,'AngleCS']));
AngleSN=single(rdmds([rDir,'AngleSN']));

t=rdmds([rDir,'Ttave'],nit);
[fldzon,mskzon,ylat,areazon]=calcZonalAvgCube(t,ny,yc,ar,hc);

%locate threshold values
mask_1=abs(psi)>threshmin & abs(psi)<threshmax;
tr=single(mask_1);

tropopause=zeros(90,1);
tropo_pressure=zeros(90,1);

%find theta values at tropopause for each lat, selecting highest, and convert to pressures at each lat
for i=1:90
tropopause(i)=max(theta_ranges.*tr(i,:));
tropo_pressure(i)=rC(find(fldzon(i,:)==min(fldzon(i,(fldzon(i,:)>tropopause(i))))));
end
disp('BOOM!!!')

%for i=1:90
%tropo_pressure(i)=rC(find(fldzon(i,:)==min(fldzon(i,(fldzon(i,:)>tropopause(i))))));
%end

%if psi never within threshold at a lat, cut off that tropo_pressure value
a=find(tropopause~=0);
yredu=yi(a);
tropo_pressure_red=tropo_pressure(a);

%overplot tropopause on theta to check.
[C,h]=contourf(ylat,rC,fldzon',20);
%set(h,'edgecolor','none')
colorbar
set(gca,'YDir','reverse')
xlabel('Latitude')
ylabel('Pressure, Pa')
hold on
plot(yredu,tropo_pressure_red,'k','LineWidth',2) 
name=['tropopause' num2str(nit) '.png']
print('-dpng',name) 

for i=1:90
sigma_no(i) = find(rC==tropo_pressure(i));
end

save('tropopause_masstransmethod.mat')
