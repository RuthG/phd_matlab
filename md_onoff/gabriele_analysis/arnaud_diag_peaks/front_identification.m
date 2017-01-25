%load in snapshots of temperature and relative vorticity. 
%calculate the magnitiude of the temperature gradient and multiply with vorticity, see if we see fronts..


rDir='/project/rg312/final_runs/run_000_final_noshallow/';
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
xi = -179:2:179;yi=-89:2:90;
radius = 6371.0e3;
f = 10^-4;

for i=1:10
    i
    load(['/project/rg312/mat_files/snapshot_data_final/run_100_ro/t_100_ro_' num2str(i) '.mat'])
    load(['/project/rg312/mat_files/snapshot_data_final/run_100_ro/vort_100_ro_' num2str(i) '.mat'])

    t_ll(:,:, i.*360-359:i.*360) = cube2latlon(xc,yc,t_100(:,:,1,:),xi,yi);
    vort_ll(:,:, i.*360-359:i.*360) = cube2latlon(xg,yg,vort_100(:,:,1,:),xi,yi);

end

[dTdy,dTdx] = gradient(t_ll(:,2:89,:),pi./90);
dTdy = dTdy./radius;

for i=1:88
    dTdx(:,i,:) = dTdx(:,i,:)./cos(yi(i+1).*pi./180)./radius;
end
dTgrad = sqrt(dTdy.^2 + dTdx.^2);

dTgrad_vort = dTgrad.*vort_ll(:,2:89,:)./(f./100./1000.);
dTgrad_vort(:,1:44,:) = -1.*dTgrad_vort(:,1:44,:);

save('/project/rg312/gabriele/front_diag.mat', 'dTgrad_vort');

nn=1;
ns=1;
for j=1:3600
    j
    for i=60:88
        [pks,locs,w,p] = findpeaks(dTgrad_vort(:,i,j), 'MinPeakHeight', 0.);

        if min(size(pks))~=0
            peak_list_n(1,nn:nn+max(size(pks))-1) = i+1;
            peak_list_n(2,nn:nn+max(size(pks))-1) = locs;
            peak_list_n(3,nn:nn+max(size(pks))-1) = j;

            peak_list_n(4,nn:nn+max(size(pks))-1) = pks;
            peak_list_n(5,nn:nn+max(size(pks))-1) = w;
            peak_list_n(6,nn:nn+max(size(pks))-1) = p;

            nn = nn+max(size(pks));
        end
    end
    for i=1:29
        [pks,locs,w,p] = findpeaks(dTgrad_vort(:,i,j), 'MinPeakHeight', 0.);

        if min(size(pks))~=0
            peak_list_s(1,ns:ns+max(size(pks))-1) = i+1;
            peak_list_s(2,ns:ns+max(size(pks))-1) = locs;
            peak_list_s(3,ns:ns+max(size(pks))-1) = j;

            peak_list_s(4,ns:ns+max(size(pks))-1) = pks;
            peak_list_s(5,ns:ns+max(size(pks))-1) = w;
            peak_list_s(6,ns:ns+max(size(pks))-1) = p;

            ns = ns+max(size(pks));
        end
    end
end


save('/project/rg312/gabriele/peak_list.mat', 'peak_list_n', 'peak_list_s');