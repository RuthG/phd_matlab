%wmo_tropopause.m
%use wmo definition to locate tropopause

load('means_ctrl.mat')

rDir='./';
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
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
g= 9.81;

for i=1:25
rhoair(:,:,i) = rC(i)./(287.058.*temp_ctrl_mean(:,:,i));
end

for i=1:24
dtempdp_half(:,:,i) = (temp_ctrl_mean(:,:,i+1) - temp_ctrl_mean(:,:,i))./(rC(i+1) - rC(i));
end

rC_half = 96000:-4000:4000;

dtempdp = shiftdim(interp1(rC_half,shiftdim(dtempdp_half,2),rC,'cubic','extrap'),1);

dtempdz = -1.*rhoair.*g.*dtempdp.*1000;

[dtempdz_zav,mskzon,ylat,areazon]=calcZonalAvgCube(dtempdz,ny,yc,ar,hc);

for i=1:192
i
for j=1:32
trop(i,j) = rC(min(find((dtempdz(i,j,:) >= -2))));
end
end

[trop_zav,mskzon,ylat,areazon]=calcZonalAvgCube(trop,ny,yc,ar,hc);

for i=1:90
trop_hzav(i) = (trop_zav(i) + trop_zav(91-i))./2;
end

trop_hzav(find(trop_hzav < trop_hzav(45))) = trop_hzav(45);

new_y = sort(reshape(yc,1,6144));
trop_hzav_hd = interp1(ylat, trop_hzav, new_y, 'cubic','extrap');

for i=1:max(size(new_y))-1
indexes = find(yc==new_y(i));

for j=1:max(size(indexes))
[I_1,J_1] = ind2sub([192,32],indexes(j));
trop_in(I_1,J_1) = trop_hzav_hd(i);
end
end

[trop_in_zav,mskzon,ylat,areazon]=calcZonalAvgCube(trop_in,ny,yc,ar,hc);

fname='trop_test.bin';
fid=fopen(fname,'w','b'); fwrite(fid,trop_in,'real*8'); fclose(fid);
fprintf(['write file: ',fname,'\n']);


contourf(ylat,rC,dtempdz_zav',20)   
set(gca,'YDir','reverse')
colorbar
hold on
plot(ylat,trop_hzav)
hold off

xi=-179:2:180;yi=-89:2:90;
  tropll(:,:)=cube2latlon(xc,yc,trop_in(:,:),xi,yi);

return
