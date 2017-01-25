%Code up a function to load in v, T, S, phi, Eta, pbl height for the sensitivity run data

function output = load_totttend(run)

    % choose directory, load grid
    if run == '000'
        rDir=['/project/rg312/final_runs/run_' run '_final_noshallow/'];
    else
        rDir=['/project/rg312/final_runs/run_' run '_final/'];
    end
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
    if run == '000'
        dir = ['/project/rg312/mat_files/snapshot_data_final/run_' run '_ns/'] ;
    else 
        dir = ['/project/rg312/mat_files/snapshot_data_final/run_' run '/'] ;
    end


    for j=1:10
        i=0
        tott = zeros(192,32,25,360);
        htrt = zeros(192,32,25,360);
        tott_th = zeros(192,32,25,360);
        htrt_th = zeros(192,32,25,360);

        for nit = (86400.*j+240):240:(86400.*(j+1));
            i=i+1;
            [j,i]
            [snap,iter,M]=rdmds([rDir,'snapDiag'],nit);  
            eval(M);
            J=find(strcmp(fldList,'TOTTTEND'));
            tott_th(:,:,:,i)= snap(:,:,:,J);
            J=find(strcmp(fldList,'AtPhdTdt'));
            htrt_th(:,:,:,i)= snap(:,:,:,J);
        end %nit loop

        convthetatoT=(rC/100000.0).^(2./7.);
        for k=1:size(rC)
            tott(:,:,k,:)=tott_th(:,:,k,:).*convthetatoT(k,1);
            htrt(:,:,k,:)=htrt_th(:,:,k,:).*convthetatoT(k,1);
        end


        name=[dir 'ttend_snap_' run '_' num2str(j) '.mat'];
        save(name,'tott', 'tott_th','htrt','htrt_th')

    end  %j loop
