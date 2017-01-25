
function htrtth_hist = htrtth_hist_latrange_fun(run)


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
yi = -89:2:89;
xi = -179:2:179;

x_var_n = ['x' run 'n'];
x_var_s = ['x' run 's'];

xvals = load('/project/rg312/mat_files/vt_lats_best.mat',x_var_n,x_var_s);
xn = xvals.(x_var_n);
xs = xvals.(x_var_s);



th_var = ['theta_' run];
th_cs = load('/project/rg312/mat_files/snapshot_data/theta_snapshots_best.mat',th_var);
th_cs = th_cs.(th_var);
th_ll = squeeze(cube2latlon(xc,yc,th_cs(:,:,11,1:719),xi,yi));
clear('th_cs')
th_ll_tav = repmat(mean(th_ll,3),[1 1 719]);
th_ed_ll = th_ll - th_ll_tav;
clear('th_ll','th_ll_tav')

htrt_var = ['htrt_' run];
htrt_cs = load('/project/rg312/mat_files/heat_rates_best.mat',htrt_var);
htrt_cs = htrt_cs.(htrt_var);
htrt_ll = squeeze(cube2latlon(xc,yc,htrt_cs(:,:,11,1:719),xi,yi)).*86400;
clear('htrt_cs')
htrt_ll_tav = repmat(mean(htrt_ll,3),[1 1 719]);
htrt_ed_ll = htrt_ll - htrt_ll_tav;
clear('htrt_ll','htrt_ll_tav')

htrtth_ed_ll = th_ed_ll.*htrt_ed_ll;


xbins=-700:5:700;

j=0
for i=xn-7:xn+7
j=j+1
i
k=xs-8+j

%include lat weighting too

htrtth_ed_counts_n = hist(reshape(htrtth_ed_ll(:,i,:),[numel(htrtth_ed_ll(:,i,:)),1]),xbins);
htrtth_ed_counts_s = hist(reshape(htrtth_ed_ll(:,k,:),[numel(htrtth_ed_ll(:,k,:)),1]),xbins);

htrtth_ed_counts_cos(2.*j-1,:) = htrtth_ed_counts_n.*cos(yi(i).*pi./180);
htrtth_ed_counts_cos(2.*j,:) = htrtth_ed_counts_s.*cos(yi(k).*pi./180);

end


htrtth_hist = sum(htrtth_ed_counts_cos,1)./sum(sum(htrtth_ed_counts_cos));


