function  blayer_lev_p_tav = blayer_offline(run)


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


theta_var = ['theta_' run];
q_var = ['q_' run];
uE_var = ['uE_' run];
vN_var = ['vN_' run];
ph_var = ['ph_' run];


theta = load(['/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat'],theta_var);
theta = theta.(theta_var);
q = load(['/project/rg312/mat_files/snapshot_data/q_snapshots_best.mat'],q_var);
q = q.(q_var);

theta_virt = (1 + 0.61.*q).*theta;
clear('q','theta')


uE = load(['/project/rg312/mat_files/snapshot_data/uE_snapshots_best.mat'],uE_var);
uE = uE.(uE_var);
vN = load(['/project/rg312/mat_files/snapshot_data/vN_snapshots_best.mat'],vN_var);
vN = vN.(vN_var);

vsq = uE.^2 + vN.^2;
clear('uE','vN')

ph = load(['/project/rg312/mat_files/snapshot_data/ph_snapshots_best.mat'],ph_var);
ph = ph.(ph_var);


for i=1:25
Ri(:,:,i,:) = (ph(:,:,i,:).*(theta_virt(:,:,i,:) - theta_virt(:,:,1,:))./theta_virt(:,:,1,:) )./vsq(:,:,i,:);
end

clear('ph','theta_virt','vsq')


blayer_lev_z = zeros(192,32,1,720);
blayer_lev_p = zeros(192,32,1,720);
bmask = zeros(192,32,1,720);
bmask_inv = ones(192,32,1,720);

for i=1:25

bmask_inv = bmask_inv - bmask;

bmask = +(Ri(:,:,i,:) > 1);

bmask = bmask .* bmask_inv;

blayer_lev_p = blayer_lev_p + bmask.*(rC(i) + 2000);

end

blayer_lev_p_tav = squeeze(mean(blayer_lev_p,4));



