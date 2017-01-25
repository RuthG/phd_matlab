rDir='/disk1/MITgcm/verification/atm_gray_ruth/wv_off_rad_off/run_5year_c/';
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
ylat = -89:2:89;

load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/drytowet_tidy/hwv_data.mat')
load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/drytowet_tidy/ctrl_data.mat')
load('/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/drytowet_tidy/wcl_data.mat')

vt_q(1,1) = max(max(vt_ed_cl_hzav));
vt_q(2,1) = max(max(vt_ed_hw_hzav));
vt_q(3,1) = max(max(vt_ed_wl_hzav));

vt_q(1,2) = max(max(q_cl_hzav));
vt_q(2,2) = max(max(q_hw_hzav));
vt_q(3,2) = max(max(q_wl_hzav));

vt_q(1,3) = max(max(uv_ed_cl_hzav));
vt_q(2,3) = max(max(uv_ed_hw_hzav));
vt_q(3,3) = max(max(uv_ed_wl_hzav));
