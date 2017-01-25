%load in v'T' and T' data for full atmosphere
%produce figures showing lat-pressure: 
%v'T' associated with warm sector/v'T' associated with cold sector
%T'T' associated with warm sector/T' associated with cold sector

function [vNt_ed_w, vNt_ed_c, tt_ed_w, tt_ed_c] = vt_assym_nanmean(run)

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
    vN_var = ['vN_' run];

    %locate directory
    if run =='000'
        dir = '/project/rg312/mat_files/snapshot_data_final/run_000_ns/';
    else
        dir = ['/project/rg312/mat_files/snapshot_data_final/run_' run '/'] ;
    end

    %load tzavs of fields
    load([dir 'vN_tzmean.mat']);
    vN_ll_tav_lats = repmat(vN_ll_ztav,[1 1 1 360]);

    load([dir 't_tzmean.mat']);
    t_ll_tav_lats = repmat(t_ll_ztav,[1 1 1 360]);


    for year = 1:10
        year 

        vN_cs = load([dir 'vN_' run '_' num2str(year) '.mat'],vN_var);
        vN_cs = vN_cs.(vN_var);
        vN_ll = squeeze(cube2latlon(xc,yc,vN_cs,xi,yi));
        vN_ed = vN_ll - vN_ll_tav_lats;
        clear('vN_ll')

        t_cs = load([dir 't_' run '_' num2str(year) '.mat'],t_var);
        t_cs = t_cs.(t_var);
        t_ll = squeeze(cube2latlon(xc,yc,t_cs,xi,yi));
        t_ed = t_ll - t_ll_tav_lats;
        clear('t_ll')
        
        tt_ed = t_ed.*t_ed;
        vNt_ed = vN_ed.*t_ed;

        t_mask_pos = +(t_ed > 0);
        t_mask_neg = +(t_ed < 0);

        t_mask_pos(t_mask_pos==0) = NaN;
        t_mask_neg(t_mask_neg==0) = NaN;
        
        vNt_ed_warm(:,:,year) = squeeze(nanmean(nanmean( vNt_ed.*t_mask_pos,4),1));
        vNt_ed_cold(:,:,year) = squeeze(nanmean(nanmean( vNt_ed.*t_mask_neg,4),1));
        tt_ed_warm(:,:,year) = squeeze(nanmean(nanmean( tt_ed.*t_mask_pos,4),1));
        tt_ed_cold(:,:,year) = squeeze(nanmean(nanmean( tt_ed.*t_mask_neg,4),1));
                
    end

    vNt_ed_w = nanmean(vNt_ed_warm,3);
    vNt_ed_c = nanmean(vNt_ed_cold,3);
    tt_ed_w = nanmean(tt_ed_warm,3);
    tt_ed_c = nanmean(tt_ed_cold,3);
