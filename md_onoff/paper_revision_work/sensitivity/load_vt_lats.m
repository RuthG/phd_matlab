
function x_var = load_vt_lats(run)

    % choose directory, load grid
    rDir=['/project/rg312/final_runs/run_' run '_sens/'];
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
    ny=90;
    xi=-179:2:179;yi=-89:2:90;
    Ra=287.04;
    dir = '/project/rg312/mat_files/sensitivity_data_2016/' ;

    load([dir 'vN_tzmean_' run '.mat'],'vN_ll_ztav');
    load([dir 't_tzmean_' run '.mat'],'t_ll_ztav');

    for j = 1:2
        j
        load([dir 'vN_' run '_' num2str(j) '.mat'],'vN')
        vN_ed = cube2latlon(xc,yc,vN,xi,yi) - repmat(vN_ll_ztav,[1 1 1 360]);

        load([dir 't_' run '_' num2str(j) '.mat'],'t')
        t_ed = cube2latlon(xc,yc,t,xi,yi) - repmat(t_ll_ztav,[1 1 1 360]);

        vNt_ed(:,:,j) = squeeze(mean(mean(vN_ed.*t_ed,4),1));
    end

    vNt_ed= mean(vNt_ed,3);


    [x_var(1),yn] = ind2sub([90 25], find( vNt_ed == max(max(vNt_ed)) ));
    [x_var(2),ys] = ind2sub([90 25], find( vNt_ed == min(min(vNt_ed)) ));

    name=['/project/rg312/mat_files/sensitivity_data_2016/vt_lats_' run '.mat'];
    save(name,'x_var')
