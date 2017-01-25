%load up data from run folder and check nothing crazy is happening


%rDir='/disk1/MITgcm/verification/atm_gray_ruth/run/';
rDir='/disk1/MITgcm/verification/atm_gray_ruth/run_radon_doshallower/';
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

%read files
i=0;
%for nit = 72720:240:86400;
for nit = 432000;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'SALT    '));
q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta(:,:,:,i)=dyn(:,:,:,J);

J=find(strcmp(fldList,'UVEL    '));
ucs(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'VVEL    '));
vcs(:,:,:,i) = dyn(:,:,:,J);
[uE(:,:,:,i),vN(:,:,:,i)] = rotate_uv2uvEN(ucs(:,:,:,i),vcs(:,:,:,i),AngleCS,AngleSN,Grid);

J=find(strcmp(fldList,'AtPhLWD '));
lwd(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhLWN '));
lwn(:,:,:,i)=dyn(:,:,:,J);
%J=find(strcmp(fldList,'AtPhTrLW'));
%lw_trans(:,:,:,i)=dyn(:,:,:,J);

end

    convthetatoT=(rC/101325.0).^(2./7.);
    for k=1:size(rC)
      t(:,:,k,:)=theta(:,:,k,:).*convthetatoT(k,1);
    end

q_mean = mean(q,4);
theta_mean = mean(theta,4);
t_mean = mean(t,4);
uE_mean = mean(uE,4);
vN_mean = mean(vN,4);
lwd_mean = mean(lwd,4);
lwn_mean = mean(lwn,4);
%lw_trans_mean = mean(lw_trans,4);

xi=-179:2:180;yi=-89:2:90;
qll=cube2latlon(xc,yc,q_mean,xi,yi);
thetall=cube2latlon(xc,yc,theta_mean,xi,yi);
tll=cube2latlon(xc,yc,t_mean,xi,yi);
uEll=cube2latlon(xc,yc,uE_mean,xi,yi);
vNll=cube2latlon(xc,yc,vN_mean,xi,yi);
lwdll=cube2latlon(xc,yc,lwd_mean,xi,yi);
lwnll=cube2latlon(xc,yc,lwn_mean,xi,yi);
%lw_transll=cube2latlon(xc,yc,lw_trans_mean,xi,yi);

q_zav(:,:) = mean(qll,1);
theta_zav(:,:) = mean(thetall,1);
t_zav(:,:) = mean(tll,1);
uE_zav(:,:) = mean(uEll,1);
vN_zav(:,:) = mean(vNll,1);
lwd_zav(:,:) = mean(lwdll,1);
lwn_zav(:,:) = mean(lwnll,1);
%lw_trans_zav(:,:) = mean(lw_transll,1);

cp_air 		= 287.04./(2./7);

for k=1:24
   tdt(:,k) = (lwn_zav(:,k+1) - lwn_zav(:,k)).*9.8./(cp_air.*(rC(k+1) - rC(k)));
end
