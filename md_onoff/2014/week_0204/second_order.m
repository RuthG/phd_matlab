%second_order.m
%Compare sizes of coefficients in EKE eq to minimise


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% load up directories, gridding params, make naming convention etc %%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_on/run_10yearradon/';
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

%calculate second order derivatives
[ddthetadzdp,junk] = gradient(dthetadz,-4000.);
ddthetadzdz = -g.*rho.*ddthetadzdp;
[junk,ddthetadydy] = gradient(dthetady,a.*pi./90);
[ddthetadydp,junk] = gradient(dthetady,-4000.);
ddthetadydz = -g.*rho.*ddthetadydp;

%for i=1:90
%dthetadz(i,:) = dthetadz(i,:).*cos(ylat(i).*pi./180);
%dthetady(i,:) = dthetady(i,:).*cos(ylat(i).*pi./180);
%end

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

merid_width = a.*((ylat(min_no(1)) - ylat(max_no(1))).*pi./180);

a = -3.*merid_width.*ddthetadzdz./2;
b = 2.*(dthetadz - ddthetadydz.*merid_width);
c = (dthetady - merid_width.*ddthetadydy./2);

b_old = 2.*dthetadz;
c_old = dthetady;

%%%%% average dthetady and dthetadp over baroclinic zone %%%%%
weight_sum = sum(cos(ylat(max_no(1):min_no(1)).*pi./180));