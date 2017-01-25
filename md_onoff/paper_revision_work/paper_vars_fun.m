% Load vH, vt, vq, vph for boundary layer

%take pressure, time and zonal average v't'  for each run
%also calculate average associated with cold sector only

function output = paper_vars_fun(run)

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
    ny=90;
    xi=-179:2:179;yi=-89:2:90;
    L = 2.500e6;
    cp = 287.04./(2./7.);

    %Names of variables to load
    t_var = ['t_' run];
    q_var = ['q_' run];
    vN_var = ['vN_' run];
    x_var_n = ['x' run 'n'];
    x_var_s = ['x' run 's'];
    blev_var = ['b_lev_' run];
    tlev_var = ['trop_lev_' run];
    ph_adj_var = ['ph_adj_' run];

    %locate directory
    if run =='000'
        dir = '/project/rg312/mat_files/snapshot_data_final/run_000_ns/';
    else
        dir = ['/project/rg312/mat_files/snapshot_data_final/run_' run '/'] ;
    end

    %load stormtracklats and blayer and trop levs
    xvals = load('/project/rg312/mat_files/vt_lats_final.mat',x_var_n,x_var_s);
    xn = xvals.(x_var_n);
    xs = xvals.(x_var_s);
    blev = load('/project/rg312/mat_files/blayer_levs_final.mat',blev_var);
    blev = blev.(blev_var);
    tlev = load('/project/rg312/mat_files/trop_levs_final.mat',tlev_var);
    tlev = tlev.(tlev_var);

    %load tzavs of fields
    load([dir 'vN_tzmean.mat']);
    vN_ll_tav_lats(:,1,:,:) = repmat(vN_ll_ztav(:,xn,:),[1 1 1 360]);
    vN_ll_tav_lats(:,2,:,:) = repmat(vN_ll_ztav(:,xs,:),[1 1 1 360]);
    clear('vN_ll_ztav')

    load([dir 't_tzmean.mat']);
    t_ll_tav_lats(:,1,:,:) = repmat(t_ll_ztav(:,xn,:),[1 1 1 360]);
    t_ll_tav_lats(:,2,:,:) = repmat(t_ll_ztav(:,xs,:),[1 1 1 360]);
    clear('t_ll_ztav')

    load([dir 'q_tzmean.mat']);
    q_ll_tav_lats(:,1,:,:) = repmat(q_ll_ztav(:,xn,:),[1 1 1 360]);
    q_ll_tav_lats(:,2,:,:) = repmat(q_ll_ztav(:,xs,:),[1 1 1 360]);
    clear('q_ll_ztav')
    
    load([dir 'ph_adj_tzmean.mat']);
    ph_adj_ll_tav_lats(:,1,:,:) = repmat(ph_adj_ll_ztav(:,xn,:),[1 1 1 360]);
    ph_adj_ll_tav_lats(:,2,:,:) = repmat(ph_adj_ll_ztav(:,xs,:),[1 1 1 360]);
    clear('ph_adj_ll_ztav')
    
    %allocate arrays
    vNH_ed_pzav = zeros(2,360,10,3);
    vNH_ed_warm_pzav = zeros(2,360,10,3);
    vNH_ed_cold_pzav = zeros(2,360,10,3);

    vNt_ed_pzav = zeros(2,360,10,3);
    vNt_ed_warm_pzav = zeros(2,360,10,3);
    vNt_ed_cold_pzav = zeros(2,360,10,3);

    tt_ed_pzav = zeros(2,360,10,2);
    tt_ed_warm_pzav = zeros(2,360,10,2);
    tt_ed_cold_pzav = zeros(2,360,10,2);
    
    vv_ed_pzav = zeros(2,360,10,2);
    vv_ed_warm_pzav = zeros(2,360,10,2);
    vv_ed_cold_pzav = zeros(2,360,10,2);

    for year = 1:10
        year 

        vN_cs = load([dir 'vN_' run '_' num2str(year) '.mat'],vN_var);
        vN_cs = vN_cs.(vN_var);
        vN_ll = squeeze(cube2latlon(xc,yc,vN_cs,xi,yi));
        vN_ed(:,1,:,:) = vN_ll(:,xn,:,:) - vN_ll_tav_lats(:,1,:,:);
        vN_ed(:,2,:,:) = -(vN_ll(:,xs,:,:) - vN_ll_tav_lats(:,2,:,:));
        clear('vN_ll')

        t_cs = load([dir 't_' run '_' num2str(year) '.mat'],t_var);
        t_cs = t_cs.(t_var);
        t_ll = squeeze(cube2latlon(xc,yc,t_cs,xi,yi));
        t_ed(:,1,:,:) = t_ll(:,xn,:,:) - t_ll_tav_lats(:,1,:,:);
        t_ed(:,2,:,:) = t_ll(:,xs,:,:) - t_ll_tav_lats(:,2,:,:);
        clear('t_ll')

        q_cs = load([dir 'q_' run '_' num2str(year) '.mat'],q_var);
        q_cs = q_cs.(q_var);
        q_ll = squeeze(cube2latlon(xc,yc,q_cs,xi,yi));
        q_ed(:,1,:,:) = q_ll(:,xn,:,:) - q_ll_tav_lats(:,1,:,:);
        q_ed(:,2,:,:) = q_ll(:,xs,:,:) - q_ll_tav_lats(:,2,:,:);
        clear('q_ll')

        ph_adj_cs = load([dir 'ph_adj_' run '_' num2str(year) '.mat'],ph_adj_var);
        ph_adj_cs = ph_adj_cs.(ph_adj_var);
        ph_adj_ll = squeeze(cube2latlon(xc,yc,ph_adj_cs,xi,yi));
        ph_adj_ed(:,1,:,:) = ph_adj_ll(:,xn,:,:) - ph_adj_ll_tav_lats(:,1,:,:);
        ph_adj_ed(:,2,:,:) = ph_adj_ll(:,xs,:,:) - ph_adj_ll_tav_lats(:,2,:,:);
        clear('ph_adj_ll')
        
        vv_ed = vN_ed.*vN_ed;
        tt_ed = t_ed.*t_ed;
        vNt_ed = vN_ed.*t_ed;
        vNH_ed = cp.*vN_ed.*t_ed + L.*vN_ed.*q_ed + vN_ed.*ph_adj_ed;

        t_mask_pos = +(t_ed > 0);
        t_mask_neg = +(t_ed < 0);
        v_mask_pos = +(vN_ed > 0);
        v_mask_neg = +(vN_ed < 0);
        
        vNt_ed_warm = vNt_ed.*t_mask_pos;
        vNt_ed_cold = vNt_ed.*t_mask_neg;
        vNH_ed_warm = vNH_ed.*t_mask_pos;
        vNH_ed_cold = vNH_ed.*t_mask_neg;
        tt_ed_warm = tt_ed.*t_mask_pos;
        tt_ed_cold = tt_ed.*t_mask_neg;
        vv_ed_warm = vv_ed.*v_mask_pos;
        vv_ed_cold = vv_ed.*v_mask_neg;
        
        levs(1,:) = [1,tlev(xn)];           %trop  
        levs(2,:) = [1,blev(xn)];           %blayer
        levs(3,:) = [blev(xn)+1,tlev(xn)];  %freetrop
        
        for i=1:3
            vNH_ed_pzav(:,:,year,i) =      squeeze(mean(mean(vNH_ed(:,:,levs(i,1):levs(i,2),:),1),3));
            vNH_ed_warm_pzav(:,:,year,i) = squeeze(mean(mean(vNH_ed_warm(:,:,levs(i,1):levs(i,2),:),1),3));
            vNH_ed_cold_pzav(:,:,year,i) = squeeze(mean(mean(vNH_ed_cold(:,:,levs(i,1):levs(i,2),:),1),3));
            
            vNt_ed_pzav(:,:,year,i) =      squeeze(mean(mean(vNt_ed(:,:,levs(i,1):levs(i,2),:),1),3));
            vNt_ed_warm_pzav(:,:,year,i) = squeeze(mean(mean(vNt_ed_warm(:,:,levs(i,1):levs(i,2),:),1),3));
            vNt_ed_cold_pzav(:,:,year,i) = squeeze(mean(mean(vNt_ed_cold(:,:,levs(i,1):levs(i,2),:),1),3));      

            tt_ed_pzav(:,:,year,i) = squeeze(mean(mean(tt_ed(:,:,levs(i,1):levs(i,2),:),1),3));
            tt_ed_warm_pzav(:,:,year,i) = squeeze(mean(mean(tt_ed_warm(:,:,levs(i,1):levs(i,2),:),1),3));
            tt_ed_cold_pzav(:,:,year,i) = squeeze(mean(mean(tt_ed_cold(:,:,levs(i,1):levs(i,2),:),1),3));
        
            vv_ed_pzav(:,:,year,i) = squeeze(mean(mean(vv_ed(:,:,levs(i,1):levs(i,2),:),1),3));
            vv_ed_warm_pzav(:,:,year,i) = squeeze(mean(mean(vv_ed_warm(:,:,levs(i,1):levs(i,2),:),1),3));
            vv_ed_cold_pzav(:,:,year,i) = squeeze(mean(mean(vv_ed_cold(:,:,levs(i,1):levs(i,2),:),1),3));
        end
                
    end

    vNH_ed_out =  squeeze(mean(mean(mean(vNH_ed_pzav,1),2),3));
    vNH_ed_warm_out = squeeze(mean(mean(mean(vNH_ed_warm_pzav,1),2),3));
    vNH_ed_cold_out = squeeze(mean(mean(mean(vNH_ed_cold_pzav,1),2),3));
    
    vNt_ed_out =  squeeze(mean(mean(mean(vNt_ed_pzav,1),2),3));
    vNt_ed_warm_out = squeeze(mean(mean(mean(vNt_ed_warm_pzav,1),2),3));
    vNt_ed_cold_out = squeeze(mean(mean(mean(vNt_ed_cold_pzav,1),2),3));

    tt_ed_out =  squeeze(mean(mean(mean(tt_ed_pzav,1),2),3));
    tt_ed_warm_out = squeeze(mean(mean(mean(tt_ed_warm_pzav,1),2),3));
    tt_ed_cold_out = squeeze(mean(mean(mean(tt_ed_cold_pzav,1),2),3));
    
    vv_ed_out =  squeeze(mean(mean(mean(vv_ed_pzav,1),2),3));
    vv_ed_warm_out = squeeze(mean(mean(mean(vv_ed_warm_pzav,1),2),3));
    vv_ed_cold_out = squeeze(mean(mean(mean(vv_ed_cold_pzav,1),2),3));


    %evaluate standard errors on values

    for i = 1:3
        vNH_ed_var(i) =  mean(mean(mean( (vNH_ed_pzav(:,:,:,i) - vNH_ed_out(i)).^2 ,1),2),3);
        vNH_ed_warm_var(i) =  mean(mean(mean( (vNH_ed_warm_pzav(:,:,:,i) - vNH_ed_warm_out(i)).^2 ,1),2),3);
        vNH_ed_cold_var(i) =  mean(mean(mean( (vNH_ed_cold_pzav(:,:,:,i) - vNH_ed_cold_out(i)).^2 ,1),2),3);
        
        vNt_ed_var(i) =  mean(mean(mean( (vNt_ed_pzav(:,:,:,i) - vNt_ed_out(i)).^2 ,1),2),3);
        vNt_ed_warm_var(i) =  mean(mean(mean( (vNt_ed_warm_pzav(:,:,:,i) - vNt_ed_warm_out(i)).^2 ,1),2),3);
        vNt_ed_cold_var(i) =  mean(mean(mean( (vNt_ed_cold_pzav(:,:,:,i) - vNt_ed_cold_out(i)).^2 ,1),2),3);

        tt_ed_var(i) =  mean(mean(mean( (tt_ed_pzav(:,:,:,i) - tt_ed_out(i)).^2 ,1),2),3);
        tt_ed_warm_var(i) =  mean(mean(mean( (tt_ed_warm_pzav(:,:,:,i) - tt_ed_warm_out(i)).^2 ,1),2),3);
        tt_ed_cold_var(i) =  mean(mean(mean( (tt_ed_cold_pzav(:,:,:,i) - tt_ed_cold_out(i)).^2 ,1),2),3);
        
        vv_ed_var(i) =  mean(mean(mean( (vv_ed_pzav(:,:,:,i) - vv_ed_out(i)).^2 ,1),2),3);
        vv_ed_warm_var(i) =  mean(mean(mean( (vv_ed_warm_pzav(:,:,:,i) - vv_ed_warm_out(i)).^2 ,1),2),3);
        vv_ed_cold_var(i) =  mean(mean(mean( (vv_ed_cold_pzav(:,:,:,i) - vv_ed_cold_out(i)).^2 ,1),2),3);
    end
    
    vNH_ed_out(:,2) = sqrt(vNH_ed_var)./sqrt(360.*2.*10);
    vNH_ed_warm_out(:,2) = sqrt(vNH_ed_warm_var)./sqrt(360.*2.*10);
    vNH_ed_cold_out(:,2) = sqrt(vNH_ed_cold_var)./sqrt(360.*2.*10);

    vNt_ed_out(:,2) = sqrt(vNt_ed_var)./sqrt(360.*2.*10);
    vNt_ed_warm_out(:,2) = sqrt(vNt_ed_warm_var)./sqrt(360.*2.*10);
    vNt_ed_cold_out(:,2) = sqrt(vNt_ed_cold_var)./sqrt(360.*2.*10);
    
    tt_ed_out(:,2) = sqrt(tt_ed_var)./sqrt(360.*2.*10);
    tt_ed_warm_out(:,2) = sqrt(tt_ed_warm_var)./sqrt(360.*2.*10);
    tt_ed_cold_out(:,2) = sqrt(tt_ed_cold_var)./sqrt(360.*2.*10);
    
    vv_ed_out(:,2) = sqrt(vv_ed_var)./sqrt(360.*2.*10);
    vv_ed_warm_out(:,2) = sqrt(vv_ed_warm_var)./sqrt(360.*2.*10);
    vv_ed_cold_out(:,2) = sqrt(vv_ed_cold_var)./sqrt(360.*2.*10);

    output = struct('vH', vNH_ed_out, 'vH_cold', vNH_ed_cold_out, 'vH_warm', vNH_ed_warm_out, ...
                    'vT', vNt_ed_out, 'vT_cold', vNt_ed_cold_out, 'vT_warm', vNt_ed_warm_out, ...
                    'vv', vv_ed_out, 'vv_cold', vv_ed_cold_out, 'vv_warm', vv_ed_warm_out, ...
                    'tt', tt_ed_out, 'tt_cold', tt_ed_cold_out, 'tt_warm', tt_ed_warm_out);




