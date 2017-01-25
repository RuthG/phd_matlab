%simpler_mape_calc.m
%Use 'Arnaud method' to calculate mape


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% load up directories, gridding params, make naming convention etc %%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_5year_c/';
slashes = findstr(rDir,'/');
point1 = slashes(max(size(slashes))-2);
dir_label = rDir(point1+1:max(size(rDir))-1);
dir_label = strrep(dir_label,'/','_');

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Load in theta data to use %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

i=0;
for nit = 259200:86400:604800;
i=i+1

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'THETA   '));
theta(:,:,:,i) = dyn(:,:,:,J);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Take zonal average theta to calculate theta^2 and dthetadp %%%%%

[theta_zav,mskzon,ylat,areazon]=calcZonalAvgCube(theta,ny,yc,ar,hc);

%%%%%% time mean of zon av theta %%%%%
theta_tzav = mean(theta_zav,3);

%%%%%% Find T to allow density to be evaluated %%%%%%%%%%
convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
temp_tzav(:,j)=theta_tzav(:,j).*convthetatoT(j,1);
end

%%%%%%%%% Input constants and calculate density %%%%%%%%%%
g = 9.81;
a = 6371.0e3;
Ra = 287.058;
for i=1:25
rho(:,i) = rC(i)./(Ra.*temp_tzav(:,i));
end

%%%%%% differentiate theta w r t p %%%%%%%%%%%%%%%%%%%%%%
[dthetadp,junk] = gradient(theta_tzav,-4000.);
[junk,dthetady] = gradient(theta_tzav,a.*pi./90);

%%%%%%%%% Use density to convert this to dthetadz %%%%%%%%
dthetadz = -g.*rho.*dthetadp;
for i=1:90
dthetadz(i,:) = dthetadz(i,:).*cos(ylat(i).*pi./180);
dthetady(i,:) = dthetady(i,:).*cos(ylat(i).*pi./180);
end

%%%%%% Load up box information %%%%%%%%
name = ['bc_box_' dir_label '.mat'];
load(name);

%%%% identify edges of baroclinic zone %%%
if(mod(barzon_lats(1),2)==0)
min_no = find(abs(ylat) == barzon_lats(1)-1);
max_no = find(abs(ylat) == barzon_lats(2)+1);
else
min_no = find(abs(ylat) == barzon_lats(1));
max_no = find(abs(ylat) == barzon_lats(2));
end


%%%%% average dthetady and dthetadp over baroclinic zone %%%%%
weight_sum = sum(cos(ylat(max_no(1):min_no(1)).*pi./180));
dthetadz_bzav = (sum(dthetadz(max_no(1):min_no(1),3:level),1)./weight_sum + sum(dthetadz(min_no(2):max_no(2),3:level),1)./weight_sum)./2;
dthetadp_bzav = (sum(dthetadp(max_no(1):min_no(1),3:level),1)./weight_sum + sum(dthetadp(min_no(2):max_no(2),3:level),1)./weight_sum)./2;
dthetady_bzav = (sum(-dthetady(max_no(1):min_no(1),3:level),1)./weight_sum + sum(dthetady(min_no(2):max_no(2),3:level),1)./weight_sum)./2;
theta_bzav = (sum(theta_tzav(max_no(1):min_no(1),3:level),1)./weight_sum + sum(theta_tzav(min_no(2):max_no(2),3:level),1)./weight_sum)./2;

%%%%%%%% Calculate integrand without box width factor included %%%%%%%
%%%%(lose the g factor as this disappears when integrated over rho dz = -1/g dp
integrand = dthetady_bzav.^2./dthetadz_bzav./8./theta_bzav;

%%%%%%%%%Calculate the width of the box in m %%%%%%%%%%%%%%%%%%%%%%

merid_width = a.*((ylat(min_no(1)) - ylat(max_no(1))).*pi./180);

simple_mape = sum(integrand).*4000.*merid_width.^2.;

name = ['simp_mape_og_' dir_label '.mat'];
save(name)
