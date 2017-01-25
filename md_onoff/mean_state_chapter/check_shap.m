rDir='/project/rg312/final_runs/run_100_final/';
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
yi = -89:2:89;
xi=-179:2:179;

load('/project/rg312/mat_files/chapter2_variables/shap_000.mat')
shapuE_000 = mean(shapuE,4);

load('/project/rg312/mat_files/chapter2_variables/shap_100.mat')
shapuE_100 = mean(shapuE,4);

shapuE_000_ll=cube2latlon(xc,yc,shapuE_000,xi,yi);
shapuE_100_ll=cube2latlon(xc,yc,shapuE_100,xi,yi);

shapuE_000_zav = squeeze(mean(shapuE_000_ll,1));
shapuE_100_zav = squeeze(mean(shapuE_100_ll,1));

shapuE_000_vint = sum(shapuE_000_zav,2).*4000./9.8;
shapuE_100_vint = sum(shapuE_100_zav,2).*4000./9.8;