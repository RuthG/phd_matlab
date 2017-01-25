%radscheme_swonly

nit=1814400;
rDir='./';
ny=90
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

p_half = 0.:4000:100000;
sw_co2 		= 0.0596;
q=rdmds([rDir,'Stave'],nit);
[q_zav,mskzon,ylat,areazon]=calcZonalAvgCube(q,ny,yc,ar,hc);

solar_tau = zeros(n);
solar_tau(1) = 0.;

for k=1:n;
   sw_wv = exp(0.01887./(solar_tau(k) + 0.009522) + 1.603./((solar_tau(k) + 0.5194).^2));
   del_sol_tau = ( sw_co2 + sw_wv.*q(k) ) .* mag_fac .* (p_half(k+1) - p_half(k))./p_half(n+1);
   solar_tau(k+1) = solar_tau(k) + del_sol_tau;
   dtrans_sol(k) = exp( -del_sol_tau);
  end

