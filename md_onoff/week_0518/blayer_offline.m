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
ny=90;
xi=-179:2:180;yi=-89:2:90;

load('/project/rg312/mat_files/snapshot_data_final/run_000/theta_000_1.mat');
load('/project/rg312/mat_files/snapshot_data_final/run_000/q_000_1.mat');
load('/project/rg312/mat_files/snapshot_data_final/run_000/uE_000_1.mat');
load('/project/rg312/mat_files/snapshot_data_final/run_000/vN_000_1.mat');

theta_000_ll = cube2latlon(xc,yc,theta_000(:,:,:,360),xi,yi);
q_000_ll = cube2latlon(xc,yc,q_000(:,:,:,360),xi,yi);
uE_000_ll = cube2latlon(xc,yc,uE_000(:,:,:,360),xi,yi);
vN_000_ll = cube2latlon(xc,yc,vN_000(:,:,:,360),xi,yi);

convthetatoT=(rC/100000.0).^(2./7.);
for k=1:size(rC)
t_000_ll(:,:,k)=theta_000_ll(:,:,k).*convthetatoT(k,1);
end


theta_virt_000 = (1 + 0.61.*q_000_ll).*theta_000_ll;


nit = 172800;
phref_000=rdmds([rDir,'PHrefC']);
ph_000=rdmds([rDir,'PH'],nit);

phtot_000 = ph_000 + repmat(phref_000,[192,32,1]);
phtot_000_ll = cube2latlon(xc,yc,phtot_000,xi,yi);
z_000_ll = phtot_000_ll./9.8;


vsq = uE_000_ll.^2 + vN_000_ll.^2;

for i=1:25
Ri_000(:,:,i) = (phtot_000_ll(:,:,i).*(theta_virt_000(:,:,i) - theta_virt_000(:,:,1))./theta_virt_000(:,:,1) )./vsq(:,:,i);
end

load(['/project/rg312/mat_files/snapshot_data_final/run_000/zpbl_000_1.mat'])
load(['/project/rg312/mat_files/snapshot_data_final/run_000/rich_000_1.mat'])

zpbl_000_ll = cube2latlon(xc,yc,zpbl_000(:,:,360),xi,yi);
rich_000_ll = cube2latlon(xc,yc,rich_000(:,:,:,360),xi,yi);

rC_half = 100000:-4000:0;
z_000_ll_half = shiftdim(interp1(rC,shiftdim(z_000_ll,2),rC_half,'linear','extrap'),1);

blayer_lev_z = zeros(180,90);
blayer_lev_p = zeros(180,90);
bmask = zeros(180,90);
bmask_inv = ones(180,90);

for i=1:25

bmask_inv = bmask_inv - bmask;

bmask = +(Ri_000(:,:,i) > 1);

bmask = bmask .* bmask_inv;

blayer_lev_p = blayer_lev_p + bmask.*(rC(i) + 2000);
blayer_lev_z = blayer_lev_z + bmask.*z_000_ll_half(:,:,i);

end


blayer_lev_zp = zeros(180,90);

for i=1:25 

blayer_lev_zp = blayer_lev_zp + rC(i) .* (zpbl_000_ll >= z_000_ll_half(:,:,i) & zpbl_000_ll < z_000_ll_half(:,:,i+1)); 

end





