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

xi=-179:2:180;yi=-89:2:90;

for i=1:10
cndhtll(:,:,:,i)=cube2latlon(xc,yc,cndht_firstten(:,:,:,i),xi,yi);

contourf(xi,yi,cndhtll(:,:,6,i)')
colorbar
caxis([0 100])

print('-dpng',['lntht' num2str(i) '.png'])
end
