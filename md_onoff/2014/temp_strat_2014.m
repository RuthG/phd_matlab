%check what heat pert has done

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

nit = 604800;
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'THETA   '));
theta = dyn(:,:,:,J);
[theta_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta,ny,yc,ar,hc);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp_zav(:,j)=theta_zav(:,j).*convthetatoT(j,1);
temp(:,:,j) = theta(:,:,j).*convthetatoT(j,1);
end


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_2yeardaily_pert_2014/';

nit = 864000;
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'THETA   '));
theta_p = dyn(:,:,:,J);
[theta_p_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_p,ny,yc,ar,hc);

theta_p=rdmds([rDir,'Ttave'],nit);
[theta_p_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta_p,ny,yc,ar,hc);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp_p_zav(:,j)=theta_p_zav(:,j).*convthetatoT(j,1);
temp_p(:,:,j) = theta_p(:,:,j).*convthetatoT(j,1);

end




xi=-179:2:180;yi=-89:2:90;
temp_ll(:,:,:)=cube2latlon(xc,yc,temp(:,:,:),xi,yi);
temp_p_ll(:,:,:)=cube2latlon(xc,yc,temp_p(:,:,:),xi,yi);


