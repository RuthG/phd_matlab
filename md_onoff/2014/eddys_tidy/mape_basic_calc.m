%calculate the MAPE integrated over the storm track as defined in O'Gorman and Schneider 2008

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% load up directories, gridding params, make naming convention etc %%%%%

checking = true;
%checking = false;

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

if checking
contourf(theta_tzav',20)
colorbar
prompt = 'Continue? No=1';
result = input(prompt)
if result == 1
return
end
end

%%%%%% square of tzav theta %%%%%%%%%%
thsq_zav = theta_tzav.^2;

if checking
contourf(thsq_zav',20)
colorbar
prompt = 'Continue? No=1'
result = input(prompt)
if result == 1
return
end
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

%%%%% average theta^2 and theta over baroclinic zone %%%%%
thsq_bzav = (mean(thsq_zav(max_no(1):min_no(1),:),1) + mean(thsq_zav(min_no(2):max_no(2),:),1))./2;

if checking
plot(thsq_bzav,rC)
hold on
for i=max_no(1):min_no(1)
plot(thsq_zav(i,:),rC,'x')
end
hold off
prompt = 'Continue? No=1'
result = input(prompt)
if result == 1
return
end
end

theta_bzav = (mean(theta_tzav(max_no(1):min_no(1),:),1) + mean(theta_tzav(min_no(2):max_no(2),:),1))./2;

if checking
plot(theta_bzav,rC)
hold on
for i=max_no(1):min_no(1)
plot(theta_tzav(i,:),rC,'x')
end
hold off
prompt = 'Continue? No=1'
result = input(prompt)
if result == 1
return
end
end

theta_bzavsq = theta_bzav.^2;

%%%% calculate variance of thetasq around average over baroclinic zone %%%%%%
thsq_ed = thsq_bzav - theta_bzavsq;

if checking
plot(thsq_bzav,rC)
hold on
plot(theta_bzavsq,rC)
plot(thsq_ed,rC)
hold off
prompt = 'Continue? No=1'
result = input(prompt)
if result == 1
return
end
end

%%%%%% differentiate theta w r t p %%%%%%%%%%%%%%%%%%%%%%
[dthetadp,junk] = gradient(theta_tzav,-4000.);

if checking
contourf(dthetadp')
colorbar
prompt = 'Continue? No=1'
result = input(prompt)
if result == 1
return
end
end

%%%%%%% average this over baroclinic zone too %%%%%%%%%%%
dthetadp_bzav = (mean(dthetadp(max_no(1):min_no(1),:),1) + mean(dthetadp(min_no(2):max_no(2),:),1))./2;

if checking
plot(dthetadp_bzav,rC)
hold on
for i=max_no(1):min_no(1)
plot(dthetadp(i,:),rC,'x')
end
hold off
prompt = 'Continue? No=1'
result = input(prompt)
if result == 1
return
end
end

%%%%%%% use to calculate gamma factor, see O'Gorman 2008%%%%%%%%%
gamma = -2./(7.*rC.*dthetadp_bzav');

if checking
plot(gamma,rC)
prompt = 'Continue? No=1'
result = input(prompt)
if result == 1
return
end
end

%%%%%%%%%% calculate integrand for MAPE calculation %%%%%%%%%%%%%
integrand = gamma.*(rC./10^5).^(2./7).*thsq_ed';

if checking
plot(integrand,rC)
prompt = 'Continue? No=1'
result = input(prompt)
if result == 1
return
end
end

%%%%%%%%% calculate constants for MAPE calculation %%%%%%%%%%%%%
cp = 1004;
g = 9.81;
a = 6371.0e3;
prefactor = cp.*10^5./(2.*9.81); 
dsigma = 4000/101325.0;

%%%%%%%%%%% MAPE!!!!!!! %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mape = sum(integrand(3:level)).*dsigma.*prefactor;

%%%%%%%%% Save it! %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
name = ['mape_' dir_label '.mat'];
save(name)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Extra check: theta gradient %%%%%%%%%%%%%%%%%%%%%

[junk,dtempdy] = gradient(theta_tzav,a.*pi./90);
