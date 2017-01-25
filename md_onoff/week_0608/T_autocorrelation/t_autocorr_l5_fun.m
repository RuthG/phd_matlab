%calculate lag correlation of t maps

function t_ac = t_autocorr_fun(run)

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


t_var = ['t_' run];
t_cs = load('/project/rg312/mat_files/snapshot_data/t_snapshots_best.mat',t_var);
t_cs = t_cs.(t_var);
t_ll = squeeze(cube2latlon(xc,yc,t_cs,xi,yi));
t_ll_tav = repmat(mean(t_ll,4),[1 1 1 720]);
t_ed_ll = t_ll - t_ll_tav;
clear('t_cs','t_ll','t_ll_tav')

x_var_n = ['x' run 'n'];
x_var_s = ['x' run 's'];
xvals = load('/project/rg312/mat_files/vt_lats_best.mat',x_var_n,x_var_s);
xn = xvals.(x_var_n);
xs = xvals.(x_var_s);

t_ed_h1 = zeros(180,90,720,21);
t_ed_h2 = zeros(180,90,720,21);


norm = (mean(t_ed_ll(90,xn,5,:).^2,4) + mean(t_ed_ll(90,xs,5,:).^2,4))./2 ;


for k=0:10
for j=1:720-k
t_ed_h1(:,:,j,11-k) = t_ed_ll(90,xn,5,j+k).*t_ed_ll(:,:,5,j);
t_ed_h2(:,:,j,11-k) = t_ed_ll(90,xs,5,j+k).*t_ed_ll(:,:,5,j);
end
end


for k=1:10
for j=1:720-k
t_ed_h1(:,:,j,k+11) = t_ed_ll(90,xn,5,j).*t_ed_ll(:,:,5,j+k);
t_ed_h2(:,:,j,k+11) = t_ed_ll(90,xs,5,j).*t_ed_ll(:,:,5,j+k);
end
end

clear('t_ed_ll')

for i=1:21
i
%720 - abs(11-i)
t_ac(:,:,:,i) = ( mean(t_ed_h1(:,:,1 : (720 - abs(11-i)),i),3) + flipdim(mean(t_ed_h2(:,:,1 : (720 - abs(11-i)) ,i),3),2) )./2;
end

t_ac = t_ac./norm;

save(['/project/rg312/mat_files/t_ac_' run '.mat'],'t_ac')

