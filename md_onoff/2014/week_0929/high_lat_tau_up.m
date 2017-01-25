%our profiles are offset from the SBDART ones esp at high latitudes. Take a look at our fit compared with calculations of upward tau from SBDART.


rDir='/disk1/MITgcm/verification/atm_gray_ruth/run_radon_varyingwin/';
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

nit=51360;

[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);

J=find(strcmp(fldList,'THETA   '));
theta=dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q=dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPhTrLW'));
dtrans_lw_mit=dyn(:,:,:,J);


    convthetatoT=(rC/101325.0).^(2./7.);
    for k=1:size(rC)
      t(:,:,k)=theta(:,:,k).*convthetatoT(k,1);
    end

p = 2000:4000:98000;
p_half = 0.:4000:100000;

xi=-179:2:180;yi=-89:2:90;
tll=cube2latlon(xc,yc,t,xi,yi);
qll=cube2latlon(xc,yc,q,xi,yi);
dtransll=cube2latlon(xc,yc,dtrans_lw_mit,xi,yi);

t_in(1,:) = flipdim(tll(1,46,:),3);
t_in(2,:) = flipdim(tll(1,81,:),3);
q_in(1,:) = flipdim(qll(1,46,:),3);
q_in(2,:) = flipdim(qll(1,81,:),3);
dtrans_lw_mt(1,:) = flipdim(dtransll(1,46,:),3);
dtrans_lw_mt(2,:) = flipdim(dtransll(1,81,:),3);

stefan 	= 5.6734e-8;
window = -0.0967.*(t_in./100).^2 + 0.6516.*t_in./100 - 0.7089;
b = (1. - window).*stefan.*t_in.^4;
b_win = window.*stefan.*t_in.^4;


load('lw_sbdart.mat')
heat_lw_tot = heat_lw_l+heat_lw_u+heat_win;
fxdn_lw_tot = fxdn_lw_l+fxdn_lw_u+fxdn_win;
fxup_lw_tot = fxup_lw_l+fxup_lw_u+fxup_win;

heat_lw = heat_lw_l+heat_lw_u;
fxdn_lw = fxdn_lw_l+fxdn_lw_u;
fxup_lw = fxup_lw_l+fxup_lw_u;

for k=1:25

dtrans_dn(:,k) = (fxdn_lw(:,k+1) - b(:,k)) ./ (fxdn_lw(:,k) - b(:,k));

dtrans_up(:,k) = (fxup_lw(:,k) - b(:,k)) ./ (fxup_lw(:,k+1) - b(:,k));

dtrans_win_dn(:,k) = (fxdn_win(:,k+1) - b_win(:,k)) ./ (fxdn_win(:,k) - b_win(:,k));

dtrans_win_up(:,k) = (fxup_win(:,k) - b_win(:,k)) ./ (fxup_win(:,k+1) - b_win(:,k));

end

dtau_up = -log(dtrans_up);
dtau_win_up = -log(dtrans_win_up);

dtau_dn = -log(dtrans_dn);
dtau_win_dn = -log(dtrans_win_dn);
