%Redo time averaging to use time and zonal mean data

function average = redo_averaging_htrt(run);
    run
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
    xi=-179:2:180;
    yi=-89:2:90;

    if run =='000'
        dir = '/project/rg312/mat_files/snapshot_data_final/run_000_ns/';
    else
        dir = ['/project/rg312/mat_files/snapshot_data_final/run_' run '/'] ;
    end
    
    for year = 1:10
        year
        
        load([dir 'ttend_snap_' run '_' num2str(year) '.mat'],'htrt');
        htrt_tav(:,:,:,year) = mean(htrt,4);
        
        theta_cs = load([dir 'theta_' run '_' num2str(year) '.mat'],['theta_' run]);
        theta_cs = theta_cs.(['theta_' run]);
        theta_tav(:,:,:,year) = mean(theta_cs,4);
               
    end


    htrt_tav = mean(htrt_tav,4);
    htrt_ll_tav = cube2latlon(xc,yc,htrt_tav,xi,yi);
    htrt_ll_ztav = repmat( mean(htrt_ll_tav,1), [180 1 1] );
    save([dir 'htrt_tzmean.mat'],'htrt_ll_ztav');


    theta_tav = mean(theta_tav,4);
    theta_ll_tav = cube2latlon(xc,yc,theta_tav,xi,yi);
    theta_ll_ztav = repmat( mean(theta_ll_tav,1), [180 1 1] );
    save([dir 'theta_tzmean.mat'],'theta_ll_ztav');