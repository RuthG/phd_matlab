%load in heat fluxes and calculate divergences of these to get heat trans estimate (need to assume zero somewhere, try different poles+ equator for funsies.



% choose directory, load grid
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

%read files
i=0;
for nit = 259200:86400:604800;
i=i+1

%heating rates
[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'AtPhSens'));
sens_w(:,:,i)=surf(:,:,J);
J=find(strcmp(fldList,'AtPhEvap'));
evap_w(:,:,i)=surf(:,:,J)*2.5e6;;
J=find(strcmp(fldList,'AtPhNSSR'));
nssr_w(:,:,i)=surf(:,:,J);
J=find(strcmp(fldList,'AtPhDSLR'));
dslr_w(:,:,i)=surf(:,:,J);
J=find(strcmp(fldList,'AtPhUSLR'));
uslr_w(:,:,i)=surf(:,:,J);
J=find(strcmp(fldList,'AtPhOLR '));
olr_w(:,:,i)=surf(:,:,J);
J=find(strcmp(fldList,'AtPhInSR'));
insr_w(:,:,i)=surf(:,:,J);

end


sens_w_mean = mean(sens_w,3);
evap_w_mean = mean(evap_w,3);
nssr_w_mean = mean(nssr_w,3);
dslr_w_mean = mean(dslr_w,3);
uslr_w_mean = mean(uslr_w,3);
olr_w_mean  = mean(olr_w,3);
insr_w_mean = mean(insr_w,3);

xi=-179:2:180;yi=-89:2:90;
sensll_w = cube2latlon(xc,yc,sens_w_mean,xi,yi);
evapll_w = cube2latlon(xc,yc,evap_w_mean,xi,yi);
nssrll_w = cube2latlon(xc,yc,nssr_w_mean,xi,yi);
dslrll_w = cube2latlon(xc,yc,dslr_w_mean,xi,yi);
uslrll_w = cube2latlon(xc,yc,uslr_w_mean,xi,yi);
olrll_w  = cube2latlon(xc,yc,olr_w_mean,xi,yi);
insrll_w = cube2latlon(xc,yc,insr_w_mean,xi,yi);

sensll_w_zav(:,:) = mean(sensll_w,1);
evapll_w_zav(:,:) = mean(evapll_w,1);
nssrll_w_zav(:,:) = mean(nssrll_w,1); %down
dslrll_w_zav(:,:) = mean(dslrll_w,1); %down
uslrll_w_zav(:,:) = mean(uslrll_w,1); %up
olrll_w_zav(:,:)  = mean(olrll_w,1);  %up
insrll_w_zav(:,:) = mean(insrll_w,1); %down


toa_flux_dwn = insrll_w_zav - olrll_w_zav;

surf_flux_up = uslrll_w_zav - dslrll_w_zav - nssrll_w_zav + sensll_w_zav + evapll_w_zav;


return



