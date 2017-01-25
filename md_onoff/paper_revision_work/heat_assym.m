%load in v'T' and T' data for full atmosphere
%produce figures showing lat-pressure: 
%v'T' associated with warm sector/v'T' associated with cold sector
%T'T' associated with warm sector/T' associated with cold sector

function [tott_t_w, tott_t_c, htrt_t_w, htrt_t_c, tott_w, tott_c, htrt_w, htrt_c] = heat_assym(run)

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
    t_var = ['t_' run];

    %locate directory
    if run =='000'
        dir = '/project/rg312/mat_files/snapshot_data_final/run_000_ns/';
    else
        dir = ['/project/rg312/mat_files/snapshot_data_final/run_' run '/'] ;
    end

    %load tzavs of fields
    load([dir 't_tzmean.mat']);
    t_ll_tav_lats = repmat(t_ll_ztav,[1 1 1 360]);


    for year = 1:10
        year 

        load([dir 'ttend_snap_' run '_' num2str(year) '.mat'],'tott','htrt');
        tott_ll = squeeze(cube2latlon(xc,yc,tott,xi,yi));
        htrt_ll = squeeze(cube2latlon(xc,yc,htrt,xi,yi));

        t_cs = load([dir 't_' run '_' num2str(year) '.mat'],t_var);
        t_cs = t_cs.(t_var);
        t_ll = squeeze(cube2latlon(xc,yc,t_cs,xi,yi));
        t_ed = t_ll - t_ll_tav_lats;
        clear('t_ll')
        
        htrt_t = htrt_ll.*t_ed;
        tott_t = tott_ll.*t_ed;

        t_mask_pos = +(t_ed > 0);
        t_mask_neg = +(t_ed < 0);
        
        tott_t_warm(:,:,year) = squeeze(mean(mean( tott_t.*t_mask_pos,4),1));
        tott_t_cold(:,:,year) = squeeze(mean(mean( tott_t.*t_mask_neg,4),1));
        htrt_t_warm(:,:,year) = squeeze(mean(mean( htrt_t.*t_mask_pos,4),1));
        htrt_t_cold(:,:,year) = squeeze(mean(mean( htrt_t.*t_mask_neg,4),1));

        tott_warm(:,:,year) = squeeze(mean(mean( tott_ll.*t_mask_pos,4),1));
        tott_cold(:,:,year) = squeeze(mean(mean( tott_ll.*t_mask_neg,4),1));
        htrt_warm(:,:,year) = squeeze(mean(mean( htrt_ll.*t_mask_pos,4),1));
        htrt_cold(:,:,year) = squeeze(mean(mean( htrt_ll.*t_mask_neg,4),1));                
    end

    tott_t_w = mean(tott_t_warm,3);
    tott_t_c = mean(tott_t_cold,3);
    htrt_t_w = mean(htrt_t_warm,3);
    htrt_t_c = mean(htrt_t_cold,3);

    tott_w = mean(tott_warm,3);
    tott_c = mean(tott_cold,3);
    htrt_w = mean(htrt_warm,3);
    htrt_c = mean(htrt_cold,3);

