% load in w and w2 and do some thinking!


%Read in iteration number, directory, MITgcm output and grid details

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5year/';
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

%read fields
i=0;
for nit = 259200:86400:432000;
i=i+1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Wet Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5year/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'WVEL    '));
w_w(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVELSQ  '));
wsq_w(:,:,:,i) = dyn(:,:,:,J);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Half WV Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearh/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'WVEL    '));
w_h(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVELSQ  '));
wsq_h(:,:,:,i) = dyn(:,:,:,J);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Quarter WV Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yearq/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'WVEL    '));
w_q(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVELSQ  '));
wsq_q(:,:,:,i) = dyn(:,:,:,J);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Dry Run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_on_rad_off/run_doshallower_5yeard/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);
eval(M);

J=find(strcmp(fldList,'WVEL    '));
w_d(:,:,:,i) = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVELSQ  '));
wsq_d(:,:,:,i) = dyn(:,:,:,J);


end

w_w_mean = mean(w_w,4);
w_h_mean = mean(w_h,4);
w_q_mean = mean(w_q,4);
w_d_mean = mean(w_d,4);

wsq_w_mean = mean(wsq_w,4);
wsq_h_mean = mean(wsq_h,4);
wsq_q_mean = mean(wsq_q,4);
wsq_d_mean = mean(wsq_d,4);


xi=-179:2:180;yi=-89:2:90;
wll_w=cube2latlon(xc,yc,w_w_mean,xi,yi);
wsqll_w=cube2latlon(xc,yc,wsq_w_mean,xi,yi);
wll_h=cube2latlon(xc,yc,w_h_mean,xi,yi);
wsqll_h=cube2latlon(xc,yc,wsq_h_mean,xi,yi);
wll_q=cube2latlon(xc,yc,w_q_mean,xi,yi);
wsqll_q=cube2latlon(xc,yc,wsq_q_mean,xi,yi);
wll_d=cube2latlon(xc,yc,w_d_mean,xi,yi);
wsqll_d=cube2latlon(xc,yc,wsq_d_mean,xi,yi);

w_w_zav(:,:) = mean(wll_w,1);
wsq_w_zav(:,:) = mean(wsqll_w,1);
w_h_zav(:,:) = mean(wll_h,1);
wsq_h_zav(:,:) = mean(wsqll_h,1);
w_q_zav(:,:) = mean(wll_q,1);
wsq_q_zav(:,:) = mean(wsqll_q,1);
w_d_zav(:,:) = mean(wll_d,1);
wsq_d_zav(:,:) = mean(wsqll_d,1);

w_w_ed = wsq_w_zav - w_w_zav.^2;
w_h_ed = wsq_h_zav - w_h_zav.^2;
w_q_ed = wsq_q_zav - w_q_zav.^2;
w_d_ed = wsq_d_zav - w_d_zav.^2;




