%second attempt at coding speedy radiation, this time follow fortran closer


%INPUTS

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

%flip variables
t_zav = flipdim(t_zav,2);
q_zav = flipdim(q_zav,2);
rC = flipdim(rC,1);

%DEFINE FBAND

lwtemp1 = round(min(min(t_zav)));
lwtemp2 = round(max(max(t_zav)));
epslw = 0;

for jtemp = 200:320

fband(jtemp,2) = 0.148 - 3e-6 .* (jtemp - 247).^2;
fband(jtemp,3) = (0.375 - 5.5e-6 .* (jtemp - 282).^2).*0.95;
fband(jtemp,4) = 0.314 - 1e-5 .* (jtemp - 315).^2;
fband(jtemp,5) = epslw;
fband(jtemp,1) = 1 - (fband(jtemp,2) + fband(jtemp,3) + fband(jtemp,4) + fband(jtemp,5));

end

for jtemp = lwtemp1:199
 fband(jtemp,:) = fband(200,:);
end
for jtemp = 321:lwtemp2
 fband(jtemp,:) = fband(320,:);
end

%DEFINE TAUS

ablwin = 0.7;
ablco2 = 4;
ablwv1 = 0.7;
ablwv2 = 50;
deltap = 0.04;

tau = zeros(90,25,4);
tau(:,:,1) = exp(-deltap.*(ablwin));
tau(:,:,2) = exp(-deltap.*(ablco2));
tau(:,:,3) = exp(-deltap.*(ablwv1.*q_zav));
tau(:,:,4) = exp(-deltap.*(ablwv2.*q_zav));


%Start calculating SPEEDY scheme. Ignore interpolation bits for now as we have 5x as many levels anyway...

%consts
sbc = 5.6734e-8;
emisfc = 0.98;
refsfc = 1 - emisfc;
grav 		= 9.8;
cp_air 		= 287.04./(2./7);

ST4A = sbc.*t_zav.^4;

ftop = zeros(1,90);

%ignore strat solar absorption for now
%do top layer part

DFABS = zeros(90,25);

brad = ST4A;

k=1;
for jb = 1:2
  for j = 2:89

  emis = fband(round(t_zav(j,k)),jb).*(1-tau(j,k,jb)) ; 
  flux(j,jb) = emis.*brad(j,k);
  DFABS(j,k) = DFABS(j,k) - flux(j,jb);   %absorbed flux total = flux in - flux out. here flux out = 0

  end
end

%assume no emission in wv bands
for jb=3:4
  for j=2:89

  flux(j,jb) = 0;

  end
end

%now do lower layers

for jb = 1:4
  for j=2:89
    for k=2:25
    
    emis = fband(round(t_zav(j,k)),jb).*(1-tau(j,k,jb)) ; 
    DFABS(j,k) = DFABS(j,k) + flux(j,jb) ;
    flux(j,jb) = tau(j,k,jb).*flux(j,jb) + emis.*brad(j,k);
    DFABS(j,k) = DFABS(j,k) - flux(j,jb) ;

    end
  end
end

fsfc = zeros(1,90);

for jb = 1:4
  for j=2:89
    fsfc(j) = fsfc(j) + emisfc.*flux(j,jb);
  end
end

%Do surface part

yy=yi*90/60*pi/180;
sinyy=sin(yy);
sst=27*(1-sinyy.*sinyy);
sst(find(abs(yi)>=60))=0;
t_surf=sst+273.15;
b_surf = emisfc.*sbc.*t_surf.^4;

fsfc = b_surf - fsfc;

for jb = 1:4
  for j=2:89
  
  flux(j,jb) = fband(round(t_surf(j)),jb).*b_surf(j) + refsfc.*flux(j,jb); %set flux in each band to surface blackbody emission + reflected part of downward flux
 
  end
end

%now go back up through layers

for jb = 1:4
  for j=2:89
    for k=25:-1:2
    
    emis = fband(round(t_zav(j,k)),jb).*(1-tau(j,k,jb)) ; 
    DFABS(j,k) = DFABS(j,k) + flux(j,jb) ;
    flux(j,jb) = tau(j,k,jb).*flux(j,jb) + emis.*brad(j,k);
    DFABS(j,k) = DFABS(j,k) - flux(j,jb) ;

    end
  end
end

%top layer
k=1;
for jb = 1:2
  for j=2:89

  emis = fband(round(t_zav(j,k)),jb).*(1-tau(j,k,jb)) ; 
  DFABS(j,k) = DFABS(j,k) + flux(j,jb) ;
  flux(j,jb) = tau(j,k,jb).*flux(j,jb) + emis.*brad(j,k);
  DFABS(j,k) = DFABS(j,k) - flux(j,jb) ;

  end
end

%OLR


for jb = 1:4
  for j=2:89

  ftop(j) = ftop(j) + flux(j,jb);

  end
end


%heating

heat_speedy = DFABS.*grav./(cp_air.*4000);


