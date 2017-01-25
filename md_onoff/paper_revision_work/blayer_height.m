%look at the pbl height associated with warm and cold anomalies (use 940hPa T, in the pbl for all runs, hopefully indicative...)

function [z_w, z_c] = blayer_height(run)

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
    z_var = ['zpbl_' run];

    %locate directory
    if run =='000'
        dir = '/project/rg312/mat_files/snapshot_data_final/run_000_ns/';
    else
        dir = ['/project/rg312/mat_files/snapshot_data_final/run_' run '/'] ;
    end

    %load tzavs of fields
    load([dir 't_tzmean.mat']);
    t_ll_tav_lats = repmat(t_ll_ztav(:,:,2),[1 1 360]);


    for year = 1:10
        year 

        z_cs = load([dir 'zpbl_' run '_' num2str(year) '.mat'],z_var);
        z_cs = z_cs.(z_var);
        z_ll = squeeze(cube2latlon(xc,yc,z_cs,xi,yi));
 
        t_cs = load([dir 't_' run '_' num2str(year) '.mat'],t_var);
        t_cs = t_cs.(t_var);
        t_ll = squeeze(cube2latlon(xc,yc,t_cs(:,:,2,:),xi,yi));
        t_ed = t_ll - t_ll_tav_lats;
        clear('t_ll')
        
        t_mask_pos = squeeze(+(t_ed > 0));
        t_mask_neg = squeeze(+(t_ed < 0));

        t_mask_pos(t_mask_pos==0) = NaN;
        t_mask_neg(t_mask_neg==0) = NaN;

        
        z_warm(:,:,year) = squeeze(nanmean(nanmean( z_ll.*t_mask_pos,3),1));
        z_cold(:,:,year) = squeeze(nanmean(nanmean( z_ll.*t_mask_neg,3),1));

                
    end

    z_w = nanmean(z_warm,3);
    z_c = nanmean(z_cold,3);
