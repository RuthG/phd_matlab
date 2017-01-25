%have a go at evaluating moist entropy. Start with 100 run
%need T, e, RH

% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_000_best/';
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

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_000')
load('/project/rg312/mat_files/snapshot_data/q_snapshots_best.mat','q_000')


es_000 = 1.*610.78.*exp((L./Rv).*(1./Tref - 1./t_000));

rC(1,1,:,1) = (98000:-4000:2000);
p = repmat(rC,[192,32,1,720]);

e_000 = q_000.*p./epsilon;

RH = e_000./es_000;

s = cpd.* log(t_000./Tref) - Rd.*log((p-e_000)./pref) + L.*q_000./t_000 ;%- Rv.*q_000.*log(RH);

s_full = s + cpd.*log(Tref);

moisttheta_000 = exp(s_full./cpd);
moisttheta_000_ll = cube2latlon(xc,yc,moisttheta_000,xi,yi);

save('/project/rg312/mat_files/snapshot_data/mtheta_snapshots_best.mat','moisttheta_000','-append')

return


%have a go at evaluating moist entropy. Start with 100 run
%need T, e, RH

% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_000_best/';
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

load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat','t_000')
load('/project/rg312/mat_files/snapshot_data/q_snapshots_best.mat','q_000')

t_000_ll = cube2latlon(xc,yc,t_000,xi,yi);
q_000_ll = cube2latlon(xc,yc,q_000,xi,yi);
clear('t_000','q_000')

es_000 = 0.*610.78.*exp((L./Rv).*(1./Tref - 1./t_000_ll));

rC(1,1,:,1) = (98000:-4000:2000);
p = repmat(rC,[180,90,1,720]);

e_000 = q_000_ll.*p./epsilon;

RH = e_000./es_000;

s = cpd.* log(t_000_ll./Tref) - Rd.*log((p-e_000)./pref) + L.*q_000_ll./t_000_ll; % - Rv.*q_000_ll.*log(RH);

s_tav = mean(s,4);
s_tzav = squeeze(mean(s_tav,1));

s_tzav_full = s_tzav + cpd.*log(Tref);

moistentropy_000 = exp(s_tzav_full./cpd);

