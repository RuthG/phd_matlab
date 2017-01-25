%load up convective heating from dry model and compare magnitude with imbalance


rDir='/project/rg312/final_runs/run_000_final/';
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
yi=-89:2:89;
xi = -179:2:179;
L = 2.500e6;
cp = 287.04./(2./7.);


load('/project/rg312/mat_files/heat_rates_best.mat','htrt_000','radht_000','difht_000','cnvht_000');

convthetatoT=(rC/100000.0).^(2./7.);
for k=1:size(rC)
htrt_000(:,:,k,:)=htrt_000(:,:,k,:).*convthetatoT(k,1);
cnvht_000(:,:,k,:)=cnvht_000(:,:,k,:).*convthetatoT(k,1);
radht_000(:,:,k,:)=radht_000(:,:,k,:).*convthetatoT(k,1);
difht_000(:,:,k,:)=difht_000(:,:,k,:).*convthetatoT(k,1);
end

htrt_int = sum(4000.*cp.*mean(htrt_000(:,:,:,1:719),4)./9.8,3);
htrt_int_av = sum(sum(htrt_int.*ar))/sum(sum(ar))

cnvht_int = sum(4000.*cp.*mean(cnvht_000(:,:,:,1:719),4)./9.8,3);
cnvht_int_av = sum(sum(cnvht_int.*ar))/sum(sum(ar))

radht_int = sum(4000.*cp.*mean(radht_000(:,:,:,1:719),4)./9.8,3);
radht_int_av = sum(sum(radht_int.*ar))/sum(sum(ar))

difht_int = sum(4000.*cp.*mean(difht_000(:,:,:,1:719),4)./9.8,3);
difht_int_av = sum(sum(difht_int.*ar))/sum(sum(ar))

%cnvht_000_ll = squeeze(cube2latlon(xc,yc,cnvht_000,xi,yi));

clear

rDir='/project/rg312/final_runs/run_100_final/';
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
yi=-89:2:89;
xi = -179:2:179;
L = 2.500e6;
cp = 287.04./(2./7.);

load('/project/rg312/mat_files/heat_rates_best.mat','htrt_100','radht_100','difht_100','cnvht_100','cndht_100');
convthetatoT=(rC/100000.0).^(2./7.);
for k=1:size(rC)
htrt_100(:,:,k,:)=htrt_100(:,:,k,:).*convthetatoT(k,1);
cnvht_100(:,:,k,:)=cnvht_100(:,:,k,:).*convthetatoT(k,1);
cndht_100(:,:,k,:)=cndht_100(:,:,k,:).*convthetatoT(k,1);
radht_100(:,:,k,:)=radht_100(:,:,k,:).*convthetatoT(k,1);
difht_100(:,:,k,:)=difht_100(:,:,k,:).*convthetatoT(k,1);
end


htrt_int = sum(4000.*cp.*mean(htrt_100(:,:,:,1:719),4)./9.8,3);
htrt_int_av = sum(sum(htrt_int.*ar))/sum(sum(ar))

cnvht_int = sum(4000.*cp.*mean(cnvht_100(:,:,:,1:719),4)./9.8,3);
cnvht_int_av = sum(sum(cnvht_int.*ar))/sum(sum(ar))

cndht_int = sum(4000.*cp.*mean(cndht_100(:,:,:,1:719),4)./9.8,3);
cndht_int_av = sum(sum(cndht_int.*ar))/sum(sum(ar))

radht_int = sum(4000.*cp.*mean(radht_100(:,:,:,1:719),4)./9.8,3);
radht_int_av = sum(sum(radht_int.*ar))/sum(sum(ar))

difht_int = sum(4000.*cp.*mean(difht_100(:,:,:,1:719),4)./9.8,3);
difht_int_av = sum(sum(difht_int.*ar))/sum(sum(ar))
