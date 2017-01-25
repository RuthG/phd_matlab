
function trop_lev = tropopause_fun(run)

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

    load([dir 't_tzmean.mat'],'t_ll_ztav');

    t_tzav = squeeze(t_ll_ztav(1,:,:));

    for i=1:25
        rho(:,i) = rC(i)./Ra./t_tzav(:,i);
    end

    dtdp = gradient(t_tzav,4000);
    dtdz = dtdp.*rho.*9.8.*1000;

    for i=2:89
        trop_p(i) = rC(min(find(dtdz(i,:) >= -2) )) ;
    end

    trop_p(1) = NaN; trop_p(90)=NaN;

    for i=1:90
        trop_p_hav(i) = (trop_p(i) + trop_p(91-i))./2;
    end

    for i=2:89
        trop_lev(i) = max(find(rC >= trop_p_hav(i)));
    end

    trop_lev(1) = NaN; trop_lev(90)=NaN;

    name=['/project/rg312/mat_files/sensitivity_data_2016/trop_lev_' run '.mat'];
    save(name,'trop_lev')
