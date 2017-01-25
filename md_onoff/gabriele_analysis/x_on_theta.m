%load in a variable in pressure coordinates, plus theta
%Interpolate both to higher resolution
%Create bins
%Reorder columns

%For now, try just one snapshot

function output = x_on_theta(theta,x)

    rDir='/project/rg312/final_runs/run_100_rad_on/';
    xc=rdmds([rDir,'XC']);
    yc=rdmds([rDir,'YC']);
    xg=rdmds([rDir,'XG']);
    yg=rdmds([rDir,'YG']);;
    ar=rdmds([rDir,'RAC']);
    rC=squeeze(rdmds([rDir,'RC']));
    Grid='C';
    xi=-179:2:179; yi=-89:2:89;

    rC_fine = 98000:-1000:2000;
    theta_grid = 290:5:350;

    theta_big = shiftdim( interp1(rC, shiftdim(theta,2), rC_fine) ,1);
    x_big = shiftdim( interp1(rC, shiftdim(x,2), rC_fine) ,1);

    for i=1:size(theta,2)
        for j=1:size(theta,1)
            sortmat(:,1)=theta_big(j,i,:);
            sortmat(:,2)=x_big(j,i,:);
            theta_lev = sortrows(sortmat);
            output(j,i,:) = interp1(theta_lev(:,1), theta_lev(:,2), theta_grid);
        end
    end


