%plot up absolute vorticity for 10 day runs
%f - du/dy
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%We need: u

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_tropheat3/';
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
for nit = 691440:240:705600; 
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE(:,:,:,i),vN(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);

end

for i=1:6
uE_av(:,:,:,i) = mean(uE(:,:,:,10*i-9:10*i),4);
end

[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_av,ny,yc,ar,hc);

a = 6371000; % radius of earth
omeg = 2.*pi./(24.*60.*60);  %rotation rate of earth
f = 2.*omeg.*sin(ylat.*pi./180);

for i=1:6
uE_av(:,:,:,i) = mean(uE(:,:,:,10*i-9:10*i),4);
end
[uE_zav,mskzon,ylat,areazon]=calcZonalAvgCube(uE_av,ny,yc,ar,hc);

ylat_arr = zeros(90,25,6);
for i=1:90
ylat_arr(i,:,:) = ylat(i).*pi./180;
end

[b,top,moo] = gradient(uE_zav.*cos(ylat_arr),pi./90);
bottom = a.*cos(ylat_arr);

dudy = top./bottom;

for i=1:90
vort(i,:,:) = f(i) - dudy(i,:,:);
end



rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_60days_accidentalcontrol/';
i=0;
for nit = 691440:240:705600; 
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE_c(:,:,:,i),vN(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);

end

for i=1:6
uE_av_c(:,:,:,i) = mean(uE_c(:,:,:,10*i-9:10*i),4);
end
[uE_zav_c,mskzon,ylat,areazon]=calcZonalAvgCube(uE_av_c,ny,yc,ar,hc);

ylat_arr = zeros(90,25,6);
for i=1:90
ylat_arr(i,:,:) = ylat(i).*pi./180;
end

[b,top_c,moo] = gradient(uE_zav_c.*cos(ylat_arr),pi./90);
bottom = a.*cos(ylat_arr);

dudy_c = top_c./bottom;

for i=1:90
vort_c(i,:,:) = f(i) - dudy_c(i,:,:);
end


