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
drC=squeeze(rdmds([rDir,'DRC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
xi=-179:2:179;
yi=-89:2:89;


load('/project/rg312/mat_files/chapter2_variables/htrts_tav_000.mat')
radht_tav = htrt_tav - cndht_tav-cnvht_tav-difht_tav;
radht_ll=cube2latlon(xc,yc,radht_tav,xi,yi);
radht_zav_000(:,:) = mean(radht_ll,1).*86400;

load('/project/rg312/mat_files/chapter2_variables/htrts_tav_010.mat')
radht_tav = htrt_tav - cndht_tav-cnvht_tav-difht_tav;
radht_ll=cube2latlon(xc,yc,radht_tav,xi,yi);
radht_zav_010(:,:) = mean(radht_ll,1).*86400;

load('/project/rg312/mat_files/chapter2_variables/htrts_tav_025.mat')
radht_tav = htrt_tav - cndht_tav-cnvht_tav-difht_tav;
radht_ll=cube2latlon(xc,yc,radht_tav,xi,yi);
radht_zav_025(:,:) = mean(radht_ll,1).*86400;

load('/project/rg312/mat_files/chapter2_variables/htrts_tav_050.mat')
radht_tav = htrt_tav - cndht_tav-cnvht_tav-difht_tav;
radht_ll=cube2latlon(xc,yc,radht_tav,xi,yi);
radht_zav_050(:,:) = mean(radht_ll,1).*86400;

load('/project/rg312/mat_files/chapter2_variables/htrts_tav_075.mat')
radht_tav = htrt_tav - cndht_tav-cnvht_tav-difht_tav;
radht_ll=cube2latlon(xc,yc,radht_tav,xi,yi);
radht_zav_075(:,:) = mean(radht_ll,1).*86400;

load('/project/rg312/mat_files/chapter2_variables/htrts_tav_100.mat')
radht_tav = htrt_tav - cndht_tav-cnvht_tav-difht_tav;
radht_ll=cube2latlon(xc,yc,radht_tav,xi,yi);
radht_zav_100(:,:) = mean(radht_ll,1).*86400;

load('/project/rg312/mat_files/chapter2_variables/htrts_tav_125.mat')
radht_tav = htrt_tav - cndht_tav-cnvht_tav-difht_tav;
radht_ll=cube2latlon(xc,yc,radht_tav,xi,yi);
radht_zav_125(:,:) = mean(radht_ll,1).*86400;

load('/project/rg312/mat_files/chapter2_variables/htrts_tav_150.mat')
radht_tav = htrt_tav - cndht_tav-cnvht_tav-difht_tav;
radht_ll=cube2latlon(xc,yc,radht_tav,xi,yi);
radht_zav_150(:,:) = mean(radht_ll,1).*86400;



load('/project/rg312/mat_files/radiation_chapter/heating_myscheme.mat')

