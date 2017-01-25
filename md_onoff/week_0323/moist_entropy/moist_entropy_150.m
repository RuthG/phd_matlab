%have a go at evaluating moist entropy. Start with 100 run
%need T, e, RH

% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_150_best/';
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

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_150')
load('/project/rg312/mat_files/snapshot_data/q_snapshots_best.mat','q_150')


es_150 = 1.5.*610.78.*exp((L./Rv).*(1./Tref - 1./t_150));

rC(1,1,:,1) = (98000:-4000:2000);
p = repmat(rC,[192,32,1,720]);

e_150 = q_150.*p./epsilon;

RH = e_150./es_150;

s = cpd.* log(t_150./Tref) - Rd.*log((p-e_150)./pref) + L.*q_150./t_150 - Rv.*q_150.*log(RH);

s_full = s + cpd.*log(Tref);

moisttheta_150 = exp(s_full./cpd);
moisttheta_150_ll = cube2latlon(xc,yc,moisttheta_150,xi,yi);

save('/project/rg312/mat_files/snapshot_data/mtheta_snapshots_best.mat','moisttheta_150','-append')

return

t_150_ll = cube2latlon(xc,yc,t_150,xi,yi);
q_150_ll = cube2latlon(xc,yc,q_150,xi,yi);
clear('t_150','q_150')

es_150 = 1.*610.78.*exp((L./Rv).*(1./Tref - 1./t_150_ll));

rC(1,1,:,1) = (98000:-4000:2000);
p = repmat(rC,[180,90,1,720]);

e_150 = q_150_ll.*p./epsilon;

RH = e_150./es_150;

s = cpd.* log(t_150_ll./Tref) - Rd.*log((p-e_150)./pref) + L.*q_150_ll./t_150_ll - Rv.*q_150_ll.*log(RH);

s_tav = mean(s,4);
s_tzav = squeeze(mean(s_tav,1));

s_tzav_full = s_tzav + cpd.*log(Tref);

moistentropy_150 = exp(s_tzav_full./cpd);

v=270:30:700;
contourf(yi,980:-40:20,moistentropy_150',v);
