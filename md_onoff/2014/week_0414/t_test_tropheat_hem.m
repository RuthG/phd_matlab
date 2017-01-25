%try coding up t_test...

%start with u field, tropheat hw spinup run

%need: mean of each
%variance calculated using mean of each yr diff from mean
%correlation of each year (does this make sense here?)


%Read in iteration number, directory, MITgcm output and grid details

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_tropheat_hw/';

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


%read fields
i=0;
for nit = 703440:240:705600 ;% 691440:240:693600; %
i=i+1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Full wv run%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_tropheat_hw/';


[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_w(:,:,:,i) = dyn(:,:,:,J);
[uE_w(:,:,:,i),vN_w(:,:,:,i)] = rotate_uv2uvEN(ucs_w(:,:,:,i),vcs_w(:,:,:,i),AngleCS,AngleSN,Grid);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Half wv run%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_tropheat_hw_control/';


[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs_h(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs_h(:,:,:,i) = dyn(:,:,:,J);
[uE_h(:,:,:,i),vN_h(:,:,:,i)] = rotate_uv2uvEN(ucs_h(:,:,:,i),vcs_h(:,:,:,i),AngleCS,AngleSN,Grid);

end

[uE_w_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_w,ny,yc,ar,hc);
[uE_h_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_h,ny,yc,ar,hc);

uE_w_tzav = mean(uE_w_zav,3);
uE_h_tzav = mean(uE_h_zav,3);

for i=1:45
uE_w_thzav(46-i,:) = (uE_w_tzav(i,:) + uE_w_tzav(91-i,:))./2;
uE_h_thzav(46-i,:) = (uE_h_tzav(i,:) + uE_h_tzav(91-i,:))./2;
end

uE_w_hzav(:,:,1) = uE_w_tzav(46:90,:);
uE_w_hzav(:,:,2) = flipdim(uE_w_tzav(1:45,:),1);

uE_h_hzav(:,:,1) = uE_h_tzav(46:90,:);
uE_h_hzav(:,:,2) = flipdim(uE_h_tzav(1:45,:),1);

N_pop = 2;

%calculate variance of each population for bottom part of lag covar
for i=1:N_pop
vardiff_w (:,:,i) = (uE_w_hzav(:,:,i) - uE_w_thzav).^2;
vardiff_h (:,:,i) = (uE_h_hzav(:,:,i) - uE_h_thzav).^2;
end


T0_w = 1 ;
T0_h = 1 ;


%%%%%%%%%%%%%%%%%%%
n_w = N_pop./T0_w;
n_h = N_pop./T0_h;

var_weight_w = N_pop - T0_w;
var_weight_h = N_pop - T0_h;

var_w = sum(vardiff_w,3)./var_weight_w;
var_h = sum(vardiff_h,3)./var_weight_h;


%%%%% initial t calculation...
T = (uE_w_thzav - uE_h_thzav)./sqrt(var_w./n_w + var_h./n_h);

DF = (var_w./n_w + var_h./n_h).^2./( (var_w./n_w).^2./(n_w-1) + (var_h./n_h).^2./(n_h-1) ) ;

%%% significance (one sided statistics? whatever that means...)

p = tcdf(abs(T),DF);
