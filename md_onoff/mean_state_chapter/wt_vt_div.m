%load up data for heat divergence plot

function [vNt_ed,wt_ed,vNt_div,wt_div] = wt_vt_div(run)

    rDir='/project/rg312/final_runs/run_100_final/';
    xc=rdmds([rDir,'XC']);
    yc=rdmds([rDir,'YC']);
    xi=-179:2:180;yi=-89:2:90;
    rC_half = 100000:-4000:0';
    rC=squeeze(rdmds([rDir,'RC']));

    a=6371.0e3;
    cosphi = repmat(cos(yi.*pi./180)',[1,25]);

    %load up variables
    load(['/project/rg312/mat_files/chapter2_variables/epvars_tav_', run, '.mat'],'vNth_tav','wth_tav')
    load(['/project/rg312/mat_files/chapter2_variables/uvwqt_tav_', run, '.mat'],'w_tav','vN_tav','theta_tav')

    %transfer to lat-lon grid
    wll_half=cube2latlon(xc,yc,w_tav,xi,yi);
    wtll_half=cube2latlon(xc,yc,wth_tav,xi,yi);
    vNll=cube2latlon(xc,yc,vN_tav,xi,yi);
    vNtll=cube2latlon(xc,yc,vNth_tav,xi,yi);
    thetall=cube2latlon(xc,yc,theta_tav,xi,yi);

    %move w variables to full levels
    wll_half(:,:,26) = 0;
    wtll_half(:,:,26) = 0;
    wll = shiftdim(interp1(rC_half,shiftdim(wll_half,2),rC),1);
    wtll = shiftdim(interp1(rC_half,shiftdim(wtll_half,2),rC),1);
 
    %take zonal mean
    w_zav(:,:) = mean(wll,1);
    wt_zav(:,:) = mean(wtll,1);
    vN_zav(:,:) = mean(vNll,1);
    vNt_zav(:,:) = mean(vNtll,1);
    theta_zav(:,:) = mean(thetall,1);

    %evaluate eddies relative to temporal and zonal mean
    vNt_ed_zav = vNt_zav - vN_zav.*theta_zav;
    wt_ed_zav = wt_zav - w_zav.*theta_zav;

    %calculate divergence
    vNt_ed_div = gradient(vNt_ed_zav(2:89,:)'.*cosphi(2:89,:)',pi./90)'./a./cosphi(2:89,:) .*86400;
    vNt_ed_div(1,:) = NaN; vNt_ed_div(90,:) = NaN;
    wt_ed_div = gradient(wt_ed_zav,-4000) .*86400;

    %average over both hemispheres
    for i=1:45
        vNt_div(i,:) = (vNt_ed_div(45+i,:) + vNt_ed_div(46-i,:))./2;
        wt_div(i,:) = (wt_ed_div(45+i,:) + wt_ed_div(46-i,:))./2;

        vNt_ed_hzav(i,:) = (vNt_ed_zav(45+i,:) - vNt_ed_zav(46-i,:))./2;
        wt_ed_hzav(i,:) = (wt_ed_zav(45+i,:) + wt_ed_zav(46-i,:))./2;
    end

    for i=1:22
        for j=1:13
            vNt_ed(i,j) = vNt_ed_hzav(i*2 -1, j*2 -1);
            wt_ed(i,j) = wt_ed_hzav(i*2 -1, j*2 -1);
        end
    end

end
