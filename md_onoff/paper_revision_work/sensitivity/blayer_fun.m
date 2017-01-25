
function b_lev = blayer_fun(run)

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


    name=['/project/rg312/mat_files/sensitivity_data_2016/zpbl_' run '.mat'];
    load(name,'zpbl')

    load([dir 'ph_adj_tzmean.mat'],'ph_adj_ll_ztav');
    ph_zav = squeeze(ph_adj_ll_ztav(1,:,:));
    zpbl_zav = squeeze(mean(cube2latlon(xc,yc,zpbl,xi,yi),1));

    for i=1:90
        zpbl_hzav(i) = (zpbl_zav(i) + zpbl_zav(91-i))./2;
        ph_hzav(i,:) = (ph_zav(i,:) + ph_zav(91-i,:))./2;
    end

    for i=2:89
        b_lev(i) = min(find (zpbl_hzav(i) <= ph_hzav(i,:)./9.81) );
    end

    b_lev(1) = NaN; b_lev(90)=NaN;

    name=['/project/rg312/mat_files/sensitivity_data_2016/b_lev_' run '.mat'];
    save(name,'b_lev')

