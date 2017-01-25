%v_time_plot
%load up v data and plot a lon time graph at a set latitude.

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_oneyrdaily_wvoffradoff/';

slashes = findstr(rDir,'/');
point1 = slashes(max(size(slashes))-2);
dir_label = rDir(point1+1:max(size(rDir))-1);
dir_label = strrep(dir_label,'/','_');

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

i=0;
for nit = 605040:240:691200
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE(:,:,:,i),vN(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);

end

xi=-179:2:180;yi=-89:2:90;
vNll=single(cube2latlon(xc,yc,vN,xi,yi));

toplot(:,:) = vNll(:,61,18,:);

name = ['v_time_plot1' dir_label '.png'];
[C,h]=contourf(toplot(:,1:50)');
colorbar
print('-dpng',name)

toplot(:,:) = vNll(:,66,18,:);


name = ['v_time_plot2' dir_label '.png'];
[C,h]=contourf(toplot(:,1:50)');
colorbar
print('-dpng',name)

toplot(:,:) = vNll(:,57,20,:);

name = ['v_time_plot3' dir_label '.png'];
[C,h]=contourf(toplot(:,1:50)');
colorbar
print('-dpng',name)



name = ['v_time_plot' dir_label '.mat'];
save(name)
