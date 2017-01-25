%load in v'T' and T' data for full atmosphere
%produce figures showing lat-pressure: 
%v'T' associated with warm sector/v'T' associated with cold sector
%T'T' associated with warm sector/T' associated with cold sector

function [htrt_t_w, htrt_t_c, th_sq_w, th_sq_c] = heat_assym_anom(run)

    % choose directory, load grid
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
    xi=-179:2:179;yi=-89:2:90;
    cp = 287.04./(2./7.);

    %Names of variables to load
    theta_var = ['theta_' run];
    t_var = ['t_' run];

    %locate directory
    if run =='000'
        dir = '/project/rg312/mat_files/snapshot_data_final/run_000_ns/';
    else
        dir = ['/project/rg312/mat_files/snapshot_data_final/run_' run '/'] ;
    end

    %load tzavs of fields
    load([dir 'theta_tzmean.mat']);
    theta_ll_tav_lats = repmat(theta_ll_ztav,[1 1 1 360]);

    load([dir 't_tzmean.mat']);
    t_ll_tav_lats = repmat(t_ll_ztav,[1 1 1 360]);

    load([dir 'htrt_tzmean.mat']);
    htrt_ll_tav_lats = repmat(htrt_ll_ztav,[1 1 1 360]);

    for year = 1:10
        year 

        load([dir 'ttend_snap_' run '_' num2str(year) '.mat'],'htrt');
        htrt_ll = squeeze(cube2latlon(xc,yc,htrt,xi,yi));
        htrt_ed = htrt_ll - htrt_ll_tav_lats;
        clear('htrt_ll')

        theta_cs = load([dir 'theta_' run '_' num2str(year) '.mat'],theta_var);
        theta_cs = theta_cs.(theta_var);
        theta_ll = squeeze(cube2latlon(xc,yc,theta_cs,xi,yi));
        theta_ed = theta_ll - theta_ll_tav_lats;
        clear('theta_ll')
        
        t_cs = load([dir 't_' run '_' num2str(year) '.mat'],t_var);
        t_cs = t_cs.(t_var);
        t_ll = squeeze(cube2latlon(xc,yc,t_cs,xi,yi));
        t_ed = t_ll - t_ll_tav_lats;
        clear('t_ll')

        htrt_t = htrt_ed.*theta_ed;
        th_sq = theta_ed.^2;

        t_mask_pos = +(t_ed > 0);
        t_mask_neg = +(t_ed < 0);
        
        htrt_t_warm(:,:,year) = squeeze(mean(mean( htrt_t.*t_mask_pos,4),1));
        htrt_t_cold(:,:,year) = squeeze(mean(mean( htrt_t.*t_mask_neg,4),1));
        th_sq_warm(:,:,year) = squeeze(mean(mean( th_sq.*t_mask_pos,4),1));
        th_sq_cold(:,:,year) = squeeze(mean(mean( th_sq.*t_mask_neg,4),1));     
        
    end

    htrt_t_w = mean(htrt_t_warm,3);
    htrt_t_c = mean(htrt_t_cold,3);
    th_sq_w = mean(th_sq_warm,3);
    th_sq_c = mean(th_sq_cold,3);
