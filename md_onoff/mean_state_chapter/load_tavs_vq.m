%load up u, v theta, and q for the rad on run and save time means somewhere obvious!

% choose directory, load grid
rDir='/project/rg312/final_runs/run_000_final_noshallow/';
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
yi = -89:2:89;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run %%%%%%%%%%%%%%%%




rDir='/project/rg312/final_runs/run_150_final/';

for j=1:10
i=0
uq  = zeros(192,32,25,360);
vq  = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVELSLT '));
uq(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSLT '));
vq(:,:,:,i) = dyn(:,:,:,J);

end %nit loop

uq_tava(:,:,:,j) = mean(uq,4);
vq_tava(:,:,:,j) = mean(vq,4);

end

uq_tav = mean(uq_tava,4);
vq_tav = mean(vq_tava,4);

[uEq_tav,vNq_tav] = rotate_uv2uvEN(uq_tav,vq_tav,AngleCS,AngleSN,Grid);

save('/project/rg312/mat_files/chapter2_variables/vq_uq_tav_150.mat','vNq_tav', 'uEq_tav')


return





rDir='/project/rg312/final_runs/run_000_final_noshallow/';

for j=1:10
i=0
uq  = zeros(192,32,25,360);
vq  = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVELSLT '));
uq(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSLT '));
vq(:,:,:,i) = dyn(:,:,:,J);

end %nit loop

uq_tava(:,:,:,j) = mean(uq,4);
vq_tava(:,:,:,j) = mean(vq,4);

end

uq_tav = mean(uq_tava,4);
vq_tav = mean(vq_tava,4);

[uEq_tav,vNq_tav] = rotate_uv2uvEN(uq_tav,vq_tav,AngleCS,AngleSN,Grid);

save('/project/rg312/mat_files/chapter2_variables/vq_uq_tav_000.mat','vNq_tav', 'uEq_tav')




rDir='/project/rg312/final_runs/run_010_final/';

for j=1:10
i=0
uq  = zeros(192,32,25,360);
vq  = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVELSLT '));
uq(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSLT '));
vq(:,:,:,i) = dyn(:,:,:,J);

end %nit loop

uq_tava(:,:,:,j) = mean(uq,4);
vq_tava(:,:,:,j) = mean(vq,4);

end

uq_tav = mean(uq_tava,4);
vq_tav = mean(vq_tava,4);

[uEq_tav,vNq_tav] = rotate_uv2uvEN(uq_tav,vq_tav,AngleCS,AngleSN,Grid);

save('/project/rg312/mat_files/chapter2_variables/vq_uq_tav_010.mat','vNq_tav', 'uEq_tav')




rDir='/project/rg312/final_runs/run_025_final/';

for j=1:10
i=0
uq  = zeros(192,32,25,360);
vq  = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVELSLT '));
uq(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSLT '));
vq(:,:,:,i) = dyn(:,:,:,J);

end %nit loop

uq_tava(:,:,:,j) = mean(uq,4);
vq_tava(:,:,:,j) = mean(vq,4);

end

uq_tav = mean(uq_tava,4);
vq_tav = mean(vq_tava,4);

[uEq_tav,vNq_tav] = rotate_uv2uvEN(uq_tav,vq_tav,AngleCS,AngleSN,Grid);

save('/project/rg312/mat_files/chapter2_variables/vq_uq_tav_025.mat','vNq_tav', 'uEq_tav')




rDir='/project/rg312/final_runs/run_050_final/';

for j=1:10
i=0
uq  = zeros(192,32,25,360);
vq  = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVELSLT '));
uq(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSLT '));
vq(:,:,:,i) = dyn(:,:,:,J);

end %nit loop

uq_tava(:,:,:,j) = mean(uq,4);
vq_tava(:,:,:,j) = mean(vq,4);

end

uq_tav = mean(uq_tava,4);
vq_tav = mean(vq_tava,4);

[uEq_tav,vNq_tav] = rotate_uv2uvEN(uq_tav,vq_tav,AngleCS,AngleSN,Grid);

save('/project/rg312/mat_files/chapter2_variables/vq_uq_tav_050.mat','vNq_tav', 'uEq_tav')





rDir='/project/rg312/final_runs/run_050_final_tropheat/';

for j=1:10
i=0
uq  = zeros(192,32,25,360);
vq  = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVELSLT '));
uq(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSLT '));
vq(:,:,:,i) = dyn(:,:,:,J);

end %nit loop

uq_tava(:,:,:,j) = mean(uq,4);
vq_tava(:,:,:,j) = mean(vq,4);

end

uq_tav = mean(uq_tava,4);
vq_tav = mean(vq_tava,4);

[uEq_tav,vNq_tav] = rotate_uv2uvEN(uq_tav,vq_tav,AngleCS,AngleSN,Grid);

save('/project/rg312/mat_files/chapter2_variables/vq_uq_tav_050_tropheat.mat','vNq_tav', 'uEq_tav')





rDir='/project/rg312/final_runs/run_075_final/';

for j=1:10
i=0
uq  = zeros(192,32,25,360);
vq  = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVELSLT '));
uq(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSLT '));
vq(:,:,:,i) = dyn(:,:,:,J);

end %nit loop

uq_tava(:,:,:,j) = mean(uq,4);
vq_tava(:,:,:,j) = mean(vq,4);

end

uq_tav = mean(uq_tava,4);
vq_tav = mean(vq_tava,4);

[uEq_tav,vNq_tav] = rotate_uv2uvEN(uq_tav,vq_tav,AngleCS,AngleSN,Grid);

save('/project/rg312/mat_files/chapter2_variables/vq_uq_tav_075.mat','vNq_tav', 'uEq_tav')





rDir='/project/rg312/final_runs/run_100_final/';

for j=1:10
i=0
uq  = zeros(192,32,25,360);
vq  = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVELSLT '));
uq(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSLT '));
vq(:,:,:,i) = dyn(:,:,:,J);

end %nit loop

uq_tava(:,:,:,j) = mean(uq,4);
vq_tava(:,:,:,j) = mean(vq,4);

end

uq_tav = mean(uq_tava,4);
vq_tav = mean(vq_tava,4);

[uEq_tav,vNq_tav] = rotate_uv2uvEN(uq_tav,vq_tav,AngleCS,AngleSN,Grid);

save('/project/rg312/mat_files/chapter2_variables/vq_uq_tav_100.mat','vNq_tav', 'uEq_tav')





rDir='/project/rg312/final_runs/run_125_final/';

for j=1:10
i=0
uq  = zeros(192,32,25,360);
vq  = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVELSLT '));
uq(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSLT '));
vq(:,:,:,i) = dyn(:,:,:,J);

end %nit loop

uq_tava(:,:,:,j) = mean(uq,4);
vq_tava(:,:,:,j) = mean(vq,4);

end

uq_tav = mean(uq_tava,4);
vq_tav = mean(vq_tava,4);

[uEq_tav,vNq_tav] = rotate_uv2uvEN(uq_tav,vq_tav,AngleCS,AngleSN,Grid);

save('/project/rg312/mat_files/chapter2_variables/vq_uq_tav_125.mat','vNq_tav', 'uEq_tav')





rDir='/project/rg312/final_runs/run_150_final/';

for j=1:10
i=0
uq  = zeros(192,32,25,360);
vq  = zeros(192,32,25,360);

for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'UVELSLT '));
uq(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVELSLT '));
vq(:,:,:,i) = dyn(:,:,:,J);

end %nit loop

uq_tava(:,:,:,j) = mean(uq,4);
vq_tava(:,:,:,j) = mean(vq,4);

end

uq_tav = mean(uq_tava,4);
vq_tav = mean(vq_tava,4);

[uEq_tav,vNq_tav] = rotate_uv2uvEN(uq_tav,vq_tav,AngleCS,AngleSN,Grid);

save('/project/rg312/mat_files/chapter2_variables/vq_uq_tav_150.mat','vNq_tav', 'uEq_tav')


