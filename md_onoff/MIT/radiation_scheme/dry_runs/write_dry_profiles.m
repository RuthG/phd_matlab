%load in q and t from MITgcm output, convert to right units for SBDART and write profiles to use


load('/project/rg312/mat_files/radiation_chapter/uvwqt_tav_radon.mat','q_tav','theta_tav')
load('/project/rg312/mat_files/radiation_chapter/geopot.mat','ph_tav')

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
ph_ll=cube2latlon(xc,yc,ph_tav,xi,yi);

q_zav(:,:) = mean(q_ll,1);
%theta_zav(:,:) = mean(theta_ll,1);
t_zav(:,:) = mean(t_ll,1);
ph_zav(:,:) = mean(ph_ll,1);



rC_half = 100000:-4000:0;
rC_half(26) = 0.1;

q_half = zeros(90,26);
t_half = zeros(90,26);
rho_half = zeros(90,26);

%interpolate q and T to get to match with z levels
q_half(2:89,:) = shiftdim(interp1(rC,q_zav(2:89,:)',rC_half,'cubic','extrap'),1);
t_half(2:89,:) = shiftdim(interp1(rC,t_zav(2:89,:)',rC_half,'cubic','extrap'),1);
ph_half(2:89,:) = shiftdim(interp1(rC,ph_zav(2:89,:)',rC_half,'cubic','extrap'),1);
Ra = 287.04;

for i=1:26
rho_half(2:89,i) = rC_half(i)./Ra./t_half(2:89,i);
end



% wv mixing ratio w = q/(1-q)
% density of wv = w*density of air
% density of air = p/RaT (or close enough) *1000 to get in g/m3

Ra = 287.04;
g= 9.8;
omega = 2.*pi./24./60./60;

z_half = ph_half./9.8;

%for i=1:25
%rho_zav(:,i) = rC(i)./Ra./t_zav(:,i);
%end

w_half = q_half./(1-q_half);
wvdens_half = w_half.*rho_half.*1000.;




%need height, pressure, temperature, water vapour density, ozone density

z_sb = fliplr(z_half);
p_sb = fliplr(rC_half)./100;
t_sb = fliplr(t_half);
wvdens_sb = 1e-14; %fliplr(wvdens_half);
ozdens_sb = 1e-15;

atm=zeros(26,5);
nn=size(atm,1);

for i=2:89
i
atm(:,1)=z_sb(i,:)./1000.;
atm(:,2)=p_sb(:);
atm(:,3)=t_sb(i,:);
atm(:,4)=wvdens_sb;
atm(:,5)=ozdens_sb;

filename=['./atm_profs/atms.dat_' int2str(i)];
dlmwrite(filename, 26)
dlmwrite(filename, atm,'delimiter', '\t','precision', '%.15f','-append')

end

return




