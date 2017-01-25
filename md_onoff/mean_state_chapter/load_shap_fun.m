%shap filter diag loading function

function [shapu,shapv,shapuE] = load_shap_fun(run)

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

  shapu  = zeros(192,32,25,360);
  shapv  = zeros(192,32,25,360);
  for j=11
    i=0


    for nit = (86400.*(j-1)+240):240:(86400.*j);
      i=i+1;
      [j,i]
      [dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
      eval(M);
      J=find(strcmp(fldList,'SHAP_dU '));
      shapu(:,:,:,i)=dyn(:,:,:,J);
      J=find(strcmp(fldList,'SHAP_dV '));
      shapv(:,:,:,i)=dyn(:,:,:,J);
      [shapuE(:,:,:,i),shapvN(:,:,:,i)] = rotate_uv2uvEN(shapu(:,:,:,i),shapv(:,:,:,i),AngleCS,AngleSN,Grid);
    end %nit loop
  end

  save(['/project/rg312/mat_files/chapter2_variables/shap_' run '.mat'],'shapu', 'shapv', 'shapuE', 'shapvN');

return
