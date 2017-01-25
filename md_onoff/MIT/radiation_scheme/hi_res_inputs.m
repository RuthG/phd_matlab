%load up q and t profiles used in thesis and interpolate to give profiles to test resolution effects on

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
q_zav = flipdim(q_zav,2);

yi = -89:2:89;
p = 1000:2000:99000;
p_half = 0.:2000:100000;


q_hi = interp1(flipud(rC), q_zav', p, 'linear','extrap')';
t_hi = interp1(flipud(rC), t_zav', p, 'linear','extrap')';
save('/project/rg312/mat_files/radiation_chapter/qt_hires.mat','q_hi','t_hi')


p = 5000:10000:95000;
p_half = 0.:10000:100000;


q_hi = interp1(flipud(rC), q_zav', p, 'linear','extrap')';
t_hi = interp1(flipud(rC), t_zav', p, 'linear','extrap')';
save('/project/rg312/mat_files/radiation_chapter/qt_lores.mat','q_hi','t_hi')



p_half = fliplr([100000,98500,96378,93378, 89136, 83136,75336, 66236, 56836,47556, 39156, 32176, 26376, 21556, 17552,14224,11458,9160,7250, 5664,4346,3250,2340,1584,956, 434,0]);
p = p_half(1:26) + 0.5.*diff(p_half);



q_b = interp1(flipud(rC), q_zav', p, 'linear','extrap')';
t_b = interp1(flipud(rC), t_zav', p, 'linear','extrap')';
save('/project/rg312/mat_files/radiation_chapter/qt_bres.mat','q_b','t_b')