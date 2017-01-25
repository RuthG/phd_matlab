rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_wvspinup/';

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

load('firstten_data.mat')

[uE_ft_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_firstten,ny,yc,ar,hc);
[vN_ft_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_firstten,ny,yc,ar,hc);

xi=-179:2:180;yi=-89:2:90;

for i=1:10
uEvN_ft_zav(:,:,i) = uE_ft_zav(:,:,i).*vN_ft_zav(:,:,i);
uvll(:,:,:,i)=cube2latlon(xc,yc,uv_firstten(:,:,:,i),xi,yi);
end

for i=1:180

uvll_h(:,:,:) = uvll(i,:,:,:);

uv_ed_ll(i,:,:,:) = uvll_h(:,:,:) - uEvN_ft_zav(:,:,:);
end


load('drydays_data.mat')

[uE_dd_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_drydays,ny,yc,ar,hc);
[vN_dd_zav,mskzon,ylat,areazon]=calcZonalAvgCube(vN_drydays,ny,yc,ar,hc);

xi=-179:2:180;yi=-89:2:90;

for i=1:10
uEvN_dd_zav(:,:,i) = uE_dd_zav(:,:,i).*vN_dd_zav(:,:,i);
uvll(:,:,:,i)=cube2latlon(xc,yc,uv_drydays(:,:,:,i),xi,yi);
end

for i=1:180

uvll_d(:,:,:) = uvll(i,:,:,:);

uv_ed_lld(i,:,:,:) = uvll_d(:,:,:) - uEvN_dd_zav(:,:,:);
end
