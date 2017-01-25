%Redo time averaging to use time and zonal mean data

function average = redo_averaging(run);
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
        vN_cs = load([dir 'vN_' run '_' num2str(year) '.mat'],['vN_' run]);
        vN_cs = vN_cs.(['vN_' run]);
        vN_tav(:,:,:,year) = mean(vN_cs,4);
        
        t_cs = load([dir 't_' run '_' num2str(year) '.mat'],['t_' run]);
        t_cs = t_cs.(['t_' run]);
        t_tav(:,:,:,year) = mean(t_cs,4);
        
        q_cs = load([dir 'q_' run '_' num2str(year) '.mat'],['q_' run]);
        q_cs = q_cs.(['q_' run]);
        q_tav(:,:,:,year) = mean(q_cs,4);
        
        ph_adj_cs = load([dir 'ph_adj_' run '_' num2str(year) '.mat'],['ph_adj_' run]);
        ph_adj_cs = ph_adj_cs.(['ph_adj_' run]);
        ph_adj_tav(:,:,:,year) = mean(ph_adj_cs,4);
               
    end

    vN_tav = mean(vN_tav,4);
    vN_ll_tav = cube2latlon(xc,yc,vN_tav,xi,yi);
    vN_ll_ztav = repmat( mean(vN_ll_tav,1), [180 1 1] );
    save([dir 'vN_tzmean.mat'],'vN_ll_ztav');

    t_tav = mean(t_tav,4);
    t_ll_tav = cube2latlon(xc,yc,t_tav,xi,yi);
    t_ll_ztav = repmat( mean(t_ll_tav,1), [180 1 1] );
    save([dir 't_tzmean.mat'],'t_ll_ztav');
    
    q_tav = mean(q_tav,4);
    q_ll_tav = cube2latlon(xc,yc,q_tav,xi,yi);
    q_ll_ztav = repmat( mean(q_ll_tav,1), [180 1 1] );
    save([dir 'q_tzmean.mat'],'q_ll_ztav');
    
    ph_adj_tav = mean(ph_adj_tav,4);
    ph_adj_ll_tav = cube2latlon(xc,yc,ph_adj_tav,xi,yi);
    ph_adj_ll_ztav = repmat( mean(ph_adj_ll_tav,1), [180 1 1] );
    save([dir 'ph_adj_tzmean.mat'],'ph_adj_ll_ztav');
    
    
    