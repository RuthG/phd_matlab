%calculate lag correlation of t maps

function htrtt_ac = htrtt_autocorr_l5_fun(run)

rDir='/project/rg312/wv_on_rad_off/run_000_best/';
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
yi=-89:2:89;
xi = -179:2:179;


th_var = ['theta_' run];
th_cs = load('/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat',th_var);
th_cs = th_cs.(th_var);
th_ll = squeeze(cube2latlon(xc,yc,th_cs,xi,yi));
th_ll_tav = repmat(mean(th_ll,4),[1 1 1 719]);
th_ed_ll = th_ll(:,:,:,1:719) - th_ll_tav;
clear('th_cs','th_ll','th_ll_tav')


htrt_var = ['htrt_' run];
htrt_cs = load('/project/rg312/mat_files/heat_rates_best.mat',htrt_var);
htrt_cs = htrt_cs.(htrt_var);
htrt_ll = squeeze(cube2latlon(xc,yc,htrt_cs,xi,yi));
htrt_ll_tav = repmat(mean(htrt_ll,4),[1 1 1 719]);
htrt_ed_ll = htrt_ll(:,:,:,1:719) - htrt_ll_tav;
clear('htrt_cs','htrt_ll','htrt_ll_tav')


x_var_n = ['x' run 'n'];
x_var_s = ['x' run 's'];
xvals = load('/project/rg312/mat_files/vt_lats_best.mat',x_var_n,x_var_s);
xn = xvals.(x_var_n);
xs = xvals.(x_var_s);

htrtt_ed_h1 = zeros(180,90,719,21);
htrtt_ed_h2 = zeros(180,90,719,21);


norm = abs((mean(th_ed_ll(90,xn,5,:).*htrt_ed_ll(90,xn,5,:),4) + mean(th_ed_ll(90,xs,5,:).*htrt_ed_ll(90,xs,5,:),4))./2) ;


for k=0:10
for j=1:719-k
htrtt_ed_h1(:,:,j,11-k) = th_ed_ll(90,xn,5,j+k).*htrt_ed_ll(:,:,5,j);
htrtt_ed_h2(:,:,j,11-k) = th_ed_ll(90,xs,5,j+k).*htrt_ed_ll(:,:,5,j);
end
end


for k=1:10
for j=1:719-k
htrtt_ed_h1(:,:,j,k+11) = th_ed_ll(90,xn,5,j).*htrt_ed_ll(:,:,5,j+k);
htrtt_ed_h2(:,:,j,k+11) = th_ed_ll(90,xs,5,j).*htrt_ed_ll(:,:,5,j+k);
end
end

clear('t_ed_ll','htrt_ed_ll')

for i=1:21
i
%719 - abs(11-i)
htrtt_ac(:,:,:,i) = ( mean(htrtt_ed_h1(:,:,1 : (719 - abs(11-i)),i),3) + flipdim(mean(htrtt_ed_h2(:,:,1 : (719 - abs(11-i)) ,i),3),2) )./2;
end

htrtt_ac = htrtt_ac./norm;

save(['/project/rg312/mat_files/htrtt_ac2_' run '.mat'],'htrtt_ac')

