%Code up a function to load in v, T, S, phi, Eta, pbl height for the sensitivity run data

function output = load_vars_fun(run)

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

    ph_ref=rdmds([rDir,'PHrefC']);

    for j=1:2
        i=0
        u = zeros(192,32,25,360);
        v = zeros(192,32,25,360);
        theta = zeros(192,32,25,360);
        q = zeros(192,32,25,360);
        eta = zeros(192,32,360);
        ph = zeros(192,32,25,360);

        for nit = (86400.*j+240):240:(86400.*(j+1));
            i=i+1;
            [j,i]
            u(:,:,:,i)=rdmds([rDir,'U'],nit);
            v(:,:,:,i)=rdmds([rDir,'V'],nit);
            theta(:,:,:,i)=rdmds([rDir,'T'],nit);
            q(:,:,:,i)=rdmds([rDir,'S'],nit);
            ph(:,:,:,i)=rdmds([rDir,'PH'],nit);
            eta(:,:,i)=rdmds([rDir,'Eta'],nit);
        end %nit loop

        [uE,vN] = rotate_uv2uvEN(u,v,AngleCS,AngleSN,Grid);

        convthetatoT=(rC/100000.0).^(2./7.);
        for k=1:size(rC)
            t(:,:,k,:)=theta(:,:,k,:).*convthetatoT(k,1);
        end

        rho(:,:,:) = 98000./(Ra.*t(:,:,1,:));
        ph_surf = eta./rho;

        for i=1:25
            ph_adj(:,:,i,:) = squeeze(ph(:,:,i,:) + ph_ref(:,:,i,:)) + ph_surf(:,:,:);
        end

        name=[dir 't_' run '_' num2str(j) '.mat'];
        save(name,'t')
        name=[dir 'q_' run '_' num2str(j) '.mat'];
        save(name,'q')
        name=[dir 'vN_' run '_' num2str(j) '.mat'];
        save(name,'vN')
        name=[dir 'ph_' run '_' num2str(j) '.mat'];
        save(name,'ph_adj')

        t_tav(:,:,:,j) = mean(t,4);
        q_tav(:,:,:,j) = mean(q,4);
        vN_tav(:,:,:,j) = mean(vN,4);
        ph_adj_tav(:,:,:,j) = mean(ph_adj,4);

	 nit = 172800:86400:259200;
        zpbl = zeros(192,32,2);
        [surf,iter,M]=rdmds([rDir,'surfDiag'],nit(j));  
        eval(M);
        J=find(strcmp(fldList,'AtPhzpbl'));
        zpbl(:,:,j) = surf(:,:,J);

    end  %j loop

    vN_tav = mean(vN_tav,4);
    vN_ll_tav = cube2latlon(xc,yc,vN_tav,xi,yi);
    vN_ll_ztav = repmat( mean(vN_ll_tav,1), [180 1 1] );
    save([dir 'vN_tzmean_' run '.mat'],'vN_ll_ztav');

    t_tav = mean(t_tav,4);
    t_ll_tav = cube2latlon(xc,yc,t_tav,xi,yi);
    t_ll_ztav = repmat( mean(t_ll_tav,1), [180 1 1] );
    save([dir 't_tzmean_' run '.mat'],'t_ll_ztav');
    
    q_tav = mean(q_tav,4);
    q_ll_tav = cube2latlon(xc,yc,q_tav,xi,yi);
    q_ll_ztav = repmat( mean(q_ll_tav,1), [180 1 1] );
    save([dir 'q_tzmean_' run '.mat'],'q_ll_ztav');
    
    ph_adj_tav = mean(ph_adj_tav,4);
    ph_adj_ll_tav = cube2latlon(xc,yc,ph_adj_tav,xi,yi);
    ph_adj_ll_ztav = repmat( mean(ph_adj_ll_tav,1), [180 1 1] );
    save([dir 'ph_adj_tzmean_' run '.mat'],'ph_adj_ll_ztav');

    zpbl = mean(zpbl,3);
    name=['/project/rg312/mat_files/sensitivity_data_2016/zpbl_' run '.mat'];
    save(name,'zpbl')
