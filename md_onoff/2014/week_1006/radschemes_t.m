%look at whether temperature structure in different rad scheme runs is due to radiative heating alone
%load t, q, dTrd, dTdt, lwn, swn


rDir='/project/rg312/run_radon_varyingwin/';
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
ny=90;

xi=-179:2:180;yi=-89:2:90;
p = 2000:4000:98000;
p_half = 0.:4000:100000;

%read files

niti = 62640;
nits = 240;
nitt = 86400;

var(1,:) = 'SALT    ';
var(2,:) = 'THETA   ';
var(3,:) = 'AtPhdTrd';
var(4,:) = 'AtPhdTdt';
var(5,:) = 'AtPhLWN ';
var(6,:) = 'AtPhSWN ';

varv = zeros(size(var));

rDir = '/project/rg312/run_radon_varyingwin/';
tzav_vw = mit_zavs(rDir,var,niti,86400,240,'varv',varv);

rDir = '/project/rg312/run_radon_cwnp/';
tzav_np = mit_zavs(rDir,var,niti,86400,240,'varv',varv);

rDir='/project/rg312/run_radon_doshallower/';
tzav_orig = mit_zavs(rDir,var,432000,'varv',varv);


lwn_vw_tzav = tzav_vw(:,:,5);
swn_vw_tzav = tzav_vw(:,:,6);
lwn_np_tzav = tzav_np(:,:,5);
swn_np_tzav = tzav_np(:,:,6);
lwn_orig_tzav = tzav_orig(:,:,5);
swn_orig_tzav = tzav_orig(:,:,6);

convthetatoT=(rC/101325.0).^(2./7.);
for k=1:size(rC)
  t_vw(:,k)=tzav_vw(:,k,2).*convthetatoT(k,1);
  radht_vw(:,k)=tzav_vw(:,k,3).*convthetatoT(k,1);
  htrt_vw(:,k)=tzav_vw(:,k,4).*convthetatoT(k,1);
  t_np(:,k)=tzav_np(:,k,2).*convthetatoT(k,1);
  radht_np(:,k)=tzav_np(:,k,3).*convthetatoT(k,1);
  htrt_np(:,k)=tzav_np(:,k,4).*convthetatoT(k,1);
  t_orig(:,k)=tzav_orig(:,k,2).*convthetatoT(k,1);
  radht_orig(:,k)=tzav_orig(:,k,3).*convthetatoT(k,1);
  htrt_orig(:,k)=tzav_orig(:,k,4).*convthetatoT(k,1);
end

cp_air 		= 287.04./(2./7);


for k=1:24
   tdt_lw_vw(:,k) = (lwn_vw_tzav(:,k+1) - lwn_vw_tzav(:,k)).*9.8./(cp_air.*(rC(k+1) - rC(k)));
   tdt_sw_vw(:,k) = (swn_vw_tzav(:,k+1) - swn_vw_tzav(:,k)).*9.8./(cp_air.*(rC(k+1) - rC(k)));
   tdt_lw_np(:,k) = (lwn_np_tzav(:,k+1) - lwn_np_tzav(:,k)).*9.8./(cp_air.*(rC(k+1) - rC(k)));
   tdt_sw_np(:,k) = (swn_np_tzav(:,k+1) - swn_np_tzav(:,k)).*9.8./(cp_air.*(rC(k+1) - rC(k)));
   tdt_lw_orig(:,k) = (lwn_orig_tzav(:,k+1) - lwn_orig_tzav(:,k)).*9.8./(cp_air.*(rC(k+1) - rC(k)));
   tdt_sw_orig(:,k) = (swn_orig_tzav(:,k+1) - swn_orig_tzav(:,k)).*9.8./(cp_air.*(rC(k+1) - rC(k)));
end






