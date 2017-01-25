%check no convective precip in dry run



% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_000_best/';
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



for j=1
i=0



for nit = (86400.*j+240):240:(86400.*(j+1));
i=i+1;
[j,i]

[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhCnvP'));
cnvp_000(:,:,i) = surf(:,:,J);

J=find(strcmp(fldList,'AtPhLscP'));
lscp_000(:,:,i) = surf(:,:,J);

end
end


%good, none
