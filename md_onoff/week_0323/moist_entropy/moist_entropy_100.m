%have a go at evaluating moist entropy. Start with 100 run
%need T, e, RH

% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_100_best/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
Grid='C';
ny=90;
xi=-179:2:179;
yi=-89:2:89;

%consts
cpd = 1005;
Rd = 287.04;
Rv = 461.50;
L = 2.5e6;
Tref = 273.16;
pref = 100000;
epsilon = Rd/Rv;

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_100')
load('/project/rg312/mat_files/snapshot_data/q_snapshots_best.mat','q_100')


es_100 = 1.*610.78.*exp((L./Rv).*(1./Tref - 1./t_100));

rC(1,1,:,1) = (98000:-4000:2000);
p = repmat(rC,[192,32,1,720]);

e_100 = q_100.*p./epsilon;

RH = e_100./es_100;

s = cpd.* log(t_100./Tref) - Rd.*log((p-e_100)./pref) + L.*q_100./t_100 - Rv.*q_100.*log(RH);

s_full = s + cpd.*log(Tref);

moisttheta_100 = exp(s_full./cpd);
moisttheta_100_ll = cube2latlon(xc,yc,moisttheta_100,xi,yi);

save('/project/rg312/mat_files/snapshot_data/mtheta_snapshots_best.mat','moisttheta_100','-append')

return

t_100_ll = cube2latlon(xc,yc,t_100,xi,yi);
q_100_ll = cube2latlon(xc,yc,q_100,xi,yi);
clear('t_100','q_100')

es_100 = 1.*610.78.*exp((L./Rv).*(1./Tref - 1./t_100_ll));

rC(1,1,:,1) = (98000:-4000:2000);
p = repmat(rC,[180,90,1,720]);

e_100 = q_100_ll.*p./epsilon;

RH = e_100./es_100;

s = cpd.* log(t_100_ll./Tref) - Rd.*log((p-e_100)./pref) + L.*q_100_ll./t_100_ll - Rv.*q_100_ll.*log(RH);

s_tav = mean(s,4);
s_tzav = squeeze(mean(s_tav,1));

s_tzav_full = s_tzav + cpd.*log(Tref);

moistentropy_100 = exp(s_tzav_full./cpd);

v=270:30:700;
contourf(yi,980:-40:20,moistentropy_100',v);
