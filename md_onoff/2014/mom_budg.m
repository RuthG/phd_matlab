%Plot up terms in momentum budget so can see how they cancel

load('means_ctrl.mat');

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';
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
[uE_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(uE_ctrl_mean,ny,yc,ar,hc);
[vN_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(vN_ctrl_mean,ny,yc,ar,hc);
[theta_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(theta_ctrl_mean,ny,yc,ar,hc);
[temp_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(temp_ctrl_mean,ny,yc,ar,hc);
[uv_ed_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(uv_ed_ctrl_mean,ny,yc,ar,hc);
[vt_ed_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(vt_ed_ctrl_mean,ny,yc,ar,hc);
[w_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(w_ctrl_mean,ny,yc,ar,hc);
[q_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(q_ctrl_mean,ny,yc,ar,hc);
[htrt_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(htrt_ctrl_mean,ny,yc,ar,hc);
[radht_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(radht_ctrl_mean,ny,yc,ar,hc);
[cndht_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(cndht_ctrl_mean,ny,yc,ar,hc);
[cnvht_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(cnvht_ctrl_mean,ny,yc,ar,hc);
[difht_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(difht_ctrl_mean,ny,yc,ar,hc);

for i=1:5

%FRICTION

end


rad_earth = 6371000;
ylat = -89:2:89;
f=2*2*pi./(24*60*60) * sin(ylat.*pi./180);

for i=1:90
coriolis_term(i,:) = f(i).*vN_zav_c(i,:);

eddy_prod(i,:) = uv_ed_zav_c(i,:).*(cos(ylat(i).*pi./180)).^2 ;
heddy_prod(i,:) = vt_ed_zav_c(i,:).*(cos(ylat(i).*pi./180)) ;

end

grad_eddy = shiftdim(gradient( eddy_prod' ,2.*pi./180.),1);
grad_heddy = shiftdim(gradient( heddy_prod' ,2.*pi./180.),1);

for i=1:90
eddy_term(i,:) = 1./(rad_earth.*(cos(ylat(i).*pi./180)).^2) .* grad_eddy(i,:);
heddy_term(i,:) = 1./(rad_earth.*(cos(ylat(i).*pi./180))) .* grad_heddy(i,:);
end

%FRICTION
