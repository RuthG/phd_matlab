
function vN_hist_data = vN_hist_fun(run,year,lev)

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
    yi = -89:2:89;
    xi = -179:2:179;

    %load heat rates
    vN_var = ['vN_' run];

    dir = run;
    if run == '000'
        dir = '000_ns';
    end

    vN_cs = load(['/net/spat-nas/project/rg312/mat_files/snapshot_data_final/run_' dir '/vN_' run '_' num2str(year) '.mat'],vN_var);
    vN_cs = vN_cs.(vN_var);
    vN_ll = cube2latlon(xc,yc,vN_cs,xi,yi);
    clear('vN_cs')
    load(['/net/spat-nas/project/rg312/mat_files/snapshot_data_final/run_' dir '/vN_tzmean.mat']);
    vN_ed = vN_ll - repmat(vN_ll_ztav,[1 1 1 360]);
    clear('vN_ll')

    vN_hist_in(:,1:45,:) = -1.*vN_ed(:,1:45,lev,:);
    vN_hist_in(:,46:90,:) = vN_ed(:,46:90,lev,:);

    for i=1:90
        %include lat weighting too
        xbins = -70:0.5:70;
        vN_ed_counts = hist(reshape(vN_hist_in(:,i,:),[numel(vN_hist_in(:,i,:)),1]),xbins);
        vN_ed_counts_cos(i,:) = vN_ed_counts.*cos(yi(i).*pi./180);
    end

    vN_hist_data = sum(vN_ed_counts_cos,1);





