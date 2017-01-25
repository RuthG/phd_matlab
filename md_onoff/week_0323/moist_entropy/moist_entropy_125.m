%have a go at evaluating moist entropy. Start with 100 run
%need T, e, RH

% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_125_best/';
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

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_125')
load('/project/rg312/mat_files/snapshot_data/q_snapshots_best.mat','q_125')


es_125 = 1.25.*610.78.*exp((L./Rv).*(1./Tref - 1./t_125));

rC(1,1,:,1) = (98000:-4000:2000);
p = repmat(rC,[192,32,1,720]);

e_125 = q_125.*p./epsilon;

RH = e_125./es_125;

s = cpd.* log(t_125./Tref) - Rd.*log((p-e_125)./pref) + L.*q_125./t_125 - Rv.*q_125.*log(RH);

s_full = s + cpd.*log(Tref);

moisttheta_125 = exp(s_full./cpd);
moisttheta_125_ll = cube2latlon(xc,yc,moisttheta_125,xi,yi);

save('/project/rg312/mat_files/snapshot_data/mtheta_snapshots_best.mat','moisttheta_125','-append')

return

t_125_ll = cube2latlon(xc,yc,t_125,xi,yi);
q_125_ll = cube2latlon(xc,yc,q_125,xi,yi);
clear('t_125','q_125')

es_125 = 1.*610.78.*exp((L./Rv).*(1./Tref - 1./t_125_ll));

rC(1,1,:,1) = (98000:-4000:2000);
p = repmat(rC,[180,90,1,720]);

e_125 = q_125_ll.*p./epsilon;

RH = e_125./es_125;

s = cpd.* log(t_125_ll./Tref) - Rd.*log((p-e_125)./pref) + L.*q_125_ll./t_125_ll - Rv.*q_125_ll.*log(RH);

s_tav = mean(s,4);
s_tzav = squeeze(mean(s_tav,1));

s_tzav_full = s_tzav + cpd.*log(Tref);

moistentropy_125 = exp(s_tzav_full./cpd);

v=270:30:700;
contourf(yi,980:-40:20,moistentropy_125',v);
