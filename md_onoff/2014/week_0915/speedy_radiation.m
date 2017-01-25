%try to run speedy lw radiation for our inputs..


rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5year/';
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
for nit = 259200:86400:432000;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'SALT    '));
q(:,:,:,i)=dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta(:,:,:,i)=dyn(:,:,:,J);

end

    convthetatoT=(rC/101325.0).^(2./7.);
    for k=1:size(rC)
      t(:,:,k,:)=theta(:,:,k,:).*convthetatoT(k,1);
    end

q_mean = mean(q,4);
theta_mean = mean(theta,4);
t_mean = mean(t,4);

xi=-179:2:180;yi=-89:2:90;
qll=cube2latlon(xc,yc,q_mean,xi,yi);
thetall=cube2latlon(xc,yc,theta_mean,xi,yi);
tll=cube2latlon(xc,yc,t_mean,xi,yi);

q_zav(:,:) = mean(qll,1);
theta_zav(:,:) = mean(thetall,1);
t_zav(:,:) = mean(tll,1);

yy=yi*90/60*pi/180;
sinyy=sin(yy);
sst=27*(1-sinyy.*sinyy);
sst(find(abs(yi)>=60))=0;
t_surf=sst+273.15;

stefan 	= 5.6734e-8;
brad = stefan.*t_zav.^4;
b_surf = stefan.*t_surf.^4;

%first define bands

lwtemp1 = round(min(min(t_zav)));
lwtemp2 = round(max(max(t_zav)));

for jtemp = 200:320

fband(jtemp,2) = 0.148 - 3e-6 .* (jtemp - 247).^2;
fband(jtemp,3) = (0.375 - 5.5e-6 .* (jtemp - 282).^2).*0.95;
fband(jtemp,4) = 0.314 - 1e-5 .* (jtemp - 315).^2;
fband(jtemp,1) = 1 - (fband(jtemp,2) + fband(jtemp,3) + fband(jtemp,4));

end

for jtemp = lwtemp1:199
 fband(jtemp,:) = fband(200,:);
end
for jtemp = 321:lwtemp2
 fband(jtemp,:) = fband(320,:);
end

ablwin = 0.7;
ablco2 = 4;
ablwv1 = 0.7;
ablwv2 = 50;
deltap = 0.04;

tau2 = zeros(90,25,4);
tau2(:,:,1) = exp(-deltap.*(ablwin));
tau2(:,:,2) = exp(-deltap.*(ablco2));
tau2(:,:,3) = exp(-deltap.*(ablwv1.*q_zav));
tau2(:,:,4) = exp(-deltap.*(ablwv2.*q_zav));



flux_down = zeros(90,25,4);
flux_up = zeros(90,25,4);

k=25;
for jb = 1:2
 for j=2:89

   emis = fband(round(t_zav(j,k)),jb) .* (1 - tau2(j,k,jb));
   flux_down(j,k,jb) = emis.*brad(j,k);

 end
end

for jb = 1:4
 for j=2:89
  for k=24:-1:1

   emis = fband(round(t_zav(j,k)),jb) .* (1 - tau2(j,k,jb));
   flux_down(j,k,jb) = emis.*brad(j,k) + tau2(j,k,jb).*flux_down(j,k+1,jb);

  end
 end
end


k=1;
for jb = 1:4
  for j=2:89

   flux_surf(j,jb) = fband(round(t_surf(j)),jb) .* b_surf(j) ;
   emis = fband(round(t_zav(j,k)),jb) .* (1 - tau2(j,k,jb));
   flux_up(j,k,jb) = tau2(j,k,jb).*flux_surf(j,jb) + emis.*brad(j,k);
  end
end

for jb = 1:4
 for j=2:89
  for k=2:25

   emis = fband(round(t_zav(j,k)),jb) .* (1 - tau2(j,k,jb));
   flux_up(j,k,jb) = tau2(j,k,jb).*flux_up(j,k-1,jb) + emis.*brad(j,k);

  end
 end
end

flux_up_tot = sum(flux_up,3);
flux_down_tot = sum(flux_down,3);
flux_net = flux_up - flux_down;

grav 		= 9.8;
cp_air 		= 287.04./(2./7);

for k=1:24
   speedy_tdt(:,k) = (flux_net(:,k+1) - flux_net(:,k)).*grav./(cp_air.*(rC(k+1) - rC(k)));
   speedy_tdt_up(:,k) = (flux_up_tot(:,k+1) - flux_up_tot(:,k)).*grav./(cp_air.*(rC(k+1) - rC(k)));
   speedy_tdt_down(:,k) = (-flux_down_tot(:,k+1) + flux_down_tot(:,k)).*grav./(cp_air.*(rC(k+1) - rC(k)));
end

load('lw_sbdart_bt.mat')

fxdn_lw_half = fxdn_lw_l_half + fxdn_lw_u_half + fxdn_win_half;
fxup_lw_half = fxup_lw_l_half + fxup_lw_u_half + fxup_win_half;

for k = 1:25

   sbdart_tdt_up(:,k) = (fxup_lw_half(:,k+1) - fxup_lw_half(:,k)).*grav./(cp_air.*(4000));
   sbdart_tdt_down(:,k) = (-fxdn_lw_half(:,k+1) + fxdn_lw_half(:,k)).*grav./(cp_air.*(4000));

end
