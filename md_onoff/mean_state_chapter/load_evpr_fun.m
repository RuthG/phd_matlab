%tau loading function

function [evap,precip] = load_evpr_fun(run)

  rDir='/project/rg312/final_runs/run_000_final_noshallow/';
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
  yi = -89:2:89;
  xi = -179:2:179;

  if run == '000'
    rDir = ['/project/rg312/final_runs/run_000_final_noshallow/'];
  else
    rDir = ['/project/rg312/final_runs/run_' run '_final/'];
  end

  evap  = zeros(192,32,11,360);
  precip  = zeros(192,32,11,360);

  for j=1:11
    i=0


    for nit = (86400.*(j-1)+240):240:(86400.*j);
      i=i+1;
      [j,i]

      [surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
      eval(M);

      J=find(strcmp(fldList,'AtPhEvap'));
      evap(:,:,j,i)=surf(:,:,J);
      J=find(strcmp(fldList,'AtPhCnvP'));
      precip(:,:,j,i)=surf(:,:,J);
      J=find(strcmp(fldList,'AtPhLscP'));
      precip(:,:,j,i)=precip(:,:,j,i)+surf(:,:,J);

    end %nit loop
  end

  save(['/project/rg312/mat_files/chapter2_variables/evpr_' run '.mat'],'evap','precip');

return


