% Generalised function for locating fronts in data using Arnaud's diagnostic
% Reference: p122 Luke Sheldon's PhD thesis: https://spiral.imperial.ac.uk/handle/10044/1/25755

rDir='/project/rg312/final_runs/run_000_final_noshallow/';

xi = -179:2:179; % Longitudes
yi=-89:2:89; % Latitudes

radius = 6371.0e3;  % Planetary radius
f = 10^-4; % Approximate Coriolis parameter (order of magnitude)

% Load up arrays of temperature and vorticity
% Note, only need low level values, for our purposes I have used the lowest MITgcm level, 980 hPa. 925 hPa from ERA would be fine.
load(['/project/rg312/mat_files/snapshot_data_final/run_100_ro/t_100_ro_3.mat'])
load(['/project/rg312/mat_files/snapshot_data_final/run_100_ro/vort_100_ro_3.mat'])
t_ll = cube2latlon(xc,yc,t_100(:,:,1,:),xi,yi);         % Transferring from cubesphere to lat-lon grid
vort_ll = cube2latlon(xg,yg,vort_100(:,:,1,:),xi,yi);

%Take latitude and longitude gradients of low level temperature
[dTdy,dTdx] = gradient(t_ll(:,2:89,:),pi./90);
dTdy = dTdy./radius;
for i=1:88
    dTdx(:,i,:) = dTdx(:,i,:)./cos(yi(i+1).*pi./180)./radius;
end

% Calculate magnitude of gradient, i.e. sum of squares.
dTgrad = sqrt(dTdy.^2 + dTdx.^2);

% Front diag is temperature gradient * rel vort
% To make this non-dimensional it is then divided by typical scales for vorticity and temperature gradient
% Scale for vorticity: f ~10^-4
% Scale for temperature gradient: 1K/100km = 1/(100*1000)
dTgrad_vort = dTgrad.*vort_ll(:,2:89,:)./(f./100./1000.);

% Reverse sign in Southern Hemisphere
dTgrad_vort(:,1:44,:) = -1.*dTgrad_vort(:,1:44,:);


% I then locate peaks with specific characteristics using matlab's findpeaks function, which returns the magnitude, location, width, and prominence of the peaks.
% e.g. for the example year of data loaded above

nn=1;
ns=1;
for j=1:360
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


