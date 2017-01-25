%load in t profile and calculate the lw cooling that would result using optical depths calculated in the original Frierson way


load('/project/rg312/mat_files/radiation_chapter/uvwqt_tav_radon.mat','q_tav','theta_tav')

rDir='/project/rg312/final_runs/run_100_rad_on/';
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
xi=-179:2:179;
yi=-89:2:89;


    convthetatoT=(rC/100000.0).^(2./7.);
    for k=1:size(rC)
      t_tav(:,:,k)=theta_tav(:,:,k).*convthetatoT(k,1);
    end


q_ll=cube2latlon(xc,yc,q_tav,xi,yi);
%theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
t_ll=cube2latlon(xc,yc,t_tav,xi,yi);

q_zav(:,:) = mean(q_ll,1);
%theta_zav(:,:) = mean(theta_ll,1);
t_zav(:,:) = mean(t_ll,1);


t_zav = flipdim(t_zav,2);

yi = -89:2:89;
ss = sin(yi.*pi./180);
rC = 0:4000:100000;

linear_tau = 0.1;
ir_tau_pole = 1.5;
ir_tau_eq = 6.0;
stefan 	= 5.6734e-8;
grav 		= 9.8;
cp_air 		= 287.04./(2./7);

tau_0 = ir_tau_eq + (ir_tau_pole - ir_tau_eq).*ss.^2;

for i=1:26
  tau(:,i) = tau_0(:) .* (linear_tau.* rC(i)./100000 + (1 - linear_tau).* (rC(i)./100000).^4);
end
 
for i=1:25
  dtrans(:,i) = exp( -(tau(:,i+1) - tau(:,i)) );
end

b = stefan.*t_zav.^4;
down(1:90,1) = 0.0;

for k = 1:25
  down(:,k+1) = down(:,k).*dtrans(:,k) + b(:,k).*(1.0 - dtrans(:,k));
end 

yy=yi*90/60*pi/180;
sinyy=sin(yy);
sst=27*(1-sinyy.*sinyy);
sst(find(abs(yi)>=60))=0;
t_surf=sst+273.15;

b_surf = stefan*t_surf.^4;

up(:,26) = b_surf;

for k = 25:-1:1
  up(:,k) = up(:,k+1).*dtrans(:,k) + b(:,k).*(1.0 - dtrans(:,k));
end

net = up - down;


for k=1:25
   tdt_lw(:,k) = (net(:,k+1) - net(:,k)).*grav./(cp_air.*(rC(k+1) - rC(k)));

end

save('/project/rg312/mat_files/radiation_chapter/tdt_lw_frierson.mat','tdt_lw','net','dtrans')

