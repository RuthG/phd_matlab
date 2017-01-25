%load in quasigeostrophic refractive indexes calculated for control and heatpert runs and see if they look like Isla's paper!

load('qg_control.mat')
qg_control = qgref;
dqdphi_control = dqdphi;

load('qg_pert.mat')
qg_pert = qgref;
dqdphi_pert = dqdphi;

load('qg_quarter.mat')
qg_quarter = qgref;
dqdphi_quarter = dqdphi;

load('qg_half.mat')
qg_half = qgref;
dqdphi_half = dqdphi;


v=-200:20:200;
contourf(ylat,rC,qg_pert' - qg_control',v)
colorbar

v= -6e-6:6e-7:6e-6;
contourf(ylat,rC,dqdphi_pert' - dqdphi_control',v)
colorbar

v = 0:20:400;
contourf(ylat,rC,qg_control',v)
colorbar

figure
contourf(ylat,rC,qg_half',v)
colorbar

figure
contourf(ylat,rC,qg_quarter',v)
colorbar

