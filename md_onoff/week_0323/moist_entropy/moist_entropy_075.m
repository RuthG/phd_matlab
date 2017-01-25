%have a go at evaluating moist entropy. Start with 100 run
%need T, e, RH

% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_075_best/';
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

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_075')
load('/project/rg312/mat_files/snapshot_data/q_snapshots_best.mat','q_075')


es_075 = 0.75.*610.78.*exp((L./Rv).*(1./Tref - 1./t_075));

rC(1,1,:,1) = (98000:-4000:2000);
p = repmat(rC,[192,32,1,720]);

e_075 = q_075.*p./epsilon;

RH = e_075./es_075;

s = cpd.* log(t_075./Tref) - Rd.*log((p-e_075)./pref) + L.*q_075./t_075 - Rv.*q_075.*log(RH);

s_full = s + cpd.*log(Tref);

moisttheta_075 = exp(s_full./cpd);
moisttheta_075_ll = cube2latlon(xc,yc,moisttheta_075,xi,yi);

save('/project/rg312/mat_files/snapshot_data/mtheta_snapshots_best.mat','moisttheta_075','-append')

return

t_075_ll = cube2latlon(xc,yc,t_075,xi,yi);
q_075_ll = cube2latlon(xc,yc,q_075,xi,yi);
clear('t_075','q_075')

es_075 = 1.*610.78.*exp((L./Rv).*(1./Tref - 1./t_075_ll));

rC(1,1,:,1) = (98000:-4000:2000);
p = repmat(rC,[180,90,1,720]);

e_075 = q_075_ll.*p./epsilon;

RH = e_075./es_075;

s = cpd.* log(t_075_ll./Tref) - Rd.*log((p-e_075)./pref) + L.*q_075_ll./t_075_ll - Rv.*q_075_ll.*log(RH);

s_tav = mean(s,4);
s_tzav = squeeze(mean(s_tav,1));

s_tzav_full = s_tzav + cpd.*log(Tref);

moistentropy_075 = exp(s_tzav_full./cpd);

v=270:30:700;
contourf(yi,980:-40:20,moistentropy_075',v);
