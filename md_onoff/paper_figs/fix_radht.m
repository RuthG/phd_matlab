%radht diag doesn't save so load up other htrts and subtract to get this

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
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
xi=-179:2:180;
yi=-89:2:90;

for year = 2:10
year
load(['/project/rg312/mat_files/snapshot_data_final/run_000_ns/htrt_000_' num2str(year) '.mat']);
load(['/project/rg312/mat_files/snapshot_data_final/run_000_ns/cndht_000_' num2str(year) '.mat']);
load(['/project/rg312/mat_files/snapshot_data_final/run_000_ns/cnvht_000_' num2str(year) '.mat']);
load(['/project/rg312/mat_files/snapshot_data_final/run_000_ns/difht_000_' num2str(year) '.mat']);
radht_000 = htrt_000 - (cndht_000 + cnvht_000 + difht_000);
save(['/project/rg312/mat_files/snapshot_data_final/run_000_ns/radht_000_' num2str(year) '.mat']);
clear('htrt_000','radht_000','cndht_000','cnvht_000','difht_000')
'000'

load(['/project/rg312/mat_files/snapshot_data_final/run_010/htrt_010_' num2str(year) '.mat']);
load(['/project/rg312/mat_files/snapshot_data_final/run_010/cndht_010_' num2str(year) '.mat']);
load(['/project/rg312/mat_files/snapshot_data_final/run_010/cnvht_010_' num2str(year) '.mat']);
load(['/project/rg312/mat_files/snapshot_data_final/run_010/difht_010_' num2str(year) '.mat']);
radht_010 = htrt_010 - (cndht_010 + cnvht_010 + difht_010);
save(['/project/rg312/mat_files/snapshot_data_final/run_010/radht_010_' num2str(year) '.mat']);
clear('htrt_010','radht_010','cndht_010','cnvht_010','difht_010')
'010'

load(['/project/rg312/mat_files/snapshot_data_final/run_025/htrt_025_' num2str(year) '.mat']);
load(['/project/rg312/mat_files/snapshot_data_final/run_025/cndht_025_' num2str(year) '.mat']);
load(['/project/rg312/mat_files/snapshot_data_final/run_025/cnvht_025_' num2str(year) '.mat']);
load(['/project/rg312/mat_files/snapshot_data_final/run_025/difht_025_' num2str(year) '.mat']);
radht_025 = htrt_025 - (cndht_025 + cnvht_025 + difht_025);
save(['/project/rg312/mat_files/snapshot_data_final/run_025/radht_025_' num2str(year) '.mat']);
clear('htrt_025','radht_025','cndht_025','cnvht_025','difht_025')
'025'

load(['/project/rg312/mat_files/snapshot_data_final/run_050/htrt_050_' num2str(year) '.mat']);
load(['/project/rg312/mat_files/snapshot_data_final/run_050/cndht_050_' num2str(year) '.mat']);
load(['/project/rg312/mat_files/snapshot_data_final/run_050/cnvht_050_' num2str(year) '.mat']);
load(['/project/rg312/mat_files/snapshot_data_final/run_050/difht_050_' num2str(year) '.mat']);
radht_050 = htrt_050 - (cndht_050 + cnvht_050 + difht_050);
save(['/project/rg312/mat_files/snapshot_data_final/run_050/radht_050_' num2str(year) '.mat']);
clear('htrt_050','radht_050','cndht_050','cnvht_050','difht_050')
'050'

load(['/project/rg312/mat_files/snapshot_data_final/run_075/htrt_075_' num2str(year) '.mat']);
load(['/project/rg312/mat_files/snapshot_data_final/run_075/cndht_075_' num2str(year) '.mat']);
load(['/project/rg312/mat_files/snapshot_data_final/run_075/cnvht_075_' num2str(year) '.mat']);
load(['/project/rg312/mat_files/snapshot_data_final/run_075/difht_075_' num2str(year) '.mat']);
radht_075 = htrt_075 - (cndht_075 + cnvht_075 + difht_075);
save(['/project/rg312/mat_files/snapshot_data_final/run_075/radht_075_' num2str(year) '.mat']);
clear('htrt_075','radht_075','cndht_075','cnvht_075','difht_075')
'075'

load(['/project/rg312/mat_files/snapshot_data_final/run_100/htrt_100_' num2str(year) '.mat']);
load(['/project/rg312/mat_files/snapshot_data_final/run_100/cndht_100_' num2str(year) '.mat']);
load(['/project/rg312/mat_files/snapshot_data_final/run_100/cnvht_100_' num2str(year) '.mat']);
load(['/project/rg312/mat_files/snapshot_data_final/run_100/difht_100_' num2str(year) '.mat']);
radht_100 = htrt_100 - (cndht_100 + cnvht_100 + difht_100);
save(['/project/rg312/mat_files/snapshot_data_final/run_100/radht_100_' num2str(year) '.mat']);
clear('htrt_100','radht_100','cndht_100','cnvht_100','difht_100')
'100'

load(['/project/rg312/mat_files/snapshot_data_final/run_125/htrt_125_' num2str(year) '.mat']);
load(['/project/rg312/mat_files/snapshot_data_final/run_125/cndht_125_' num2str(year) '.mat']);
load(['/project/rg312/mat_files/snapshot_data_final/run_125/cnvht_125_' num2str(year) '.mat']);
load(['/project/rg312/mat_files/snapshot_data_final/run_125/difht_125_' num2str(year) '.mat']);
radht_125 = htrt_125 - (cndht_125 + cnvht_125 + difht_125);
save(['/project/rg312/mat_files/snapshot_data_final/run_125/radht_125_' num2str(year) '.mat']);
clear('htrt_125','radht_125','cndht_125','cnvht_125','difht_125')
'125'

load(['/project/rg312/mat_files/snapshot_data_final/run_150/htrt_150_' num2str(year) '.mat']);
load(['/project/rg312/mat_files/snapshot_data_final/run_150/cndht_150_' num2str(year) '.mat']);
load(['/project/rg312/mat_files/snapshot_data_final/run_150/cnvht_150_' num2str(year) '.mat']);
load(['/project/rg312/mat_files/snapshot_data_final/run_150/difht_150_' num2str(year) '.mat']);
radht_150 = htrt_150 - (cndht_150 + cnvht_150 + difht_150);
save(['/project/rg312/mat_files/snapshot_data_final/run_150/radht_150_' num2str(year) '.mat']);
clear('htrt_150','radht_150','cndht_150','cnvht_150','difht_150')
'150'

end

