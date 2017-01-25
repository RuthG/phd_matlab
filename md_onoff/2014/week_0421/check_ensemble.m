load('ezav_th.mat')

figure
for i=1:6
subplot(2,3,i)
contourf(psi_th_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(uE_th_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(theta_th_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(htrt_th_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(uv_ed_th_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(vt_ed_th_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(Fphi_scaled_th_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(Fp_scaled_th_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(fluxdiv_th_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(eke_th_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(qgref_th_ezav(:,:,i)')
end


return

load('ezav_c.mat')

figure
for i=1:6
subplot(2,3,i)
contourf(psi_c_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(uE_c_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(theta_c_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(htrt_c_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(uv_ed_c_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(vt_ed_c_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(Fphi_scaled_c_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(Fp_scaled_c_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(fluxdiv_c_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(eke_c_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(qgref_c_ezav(:,:,i)')
end

return

load('ezav_w.mat')

figure
for i=1:6
subplot(2,3,i)
contourf(psi_w_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(uE_w_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(theta_w_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(htrt_w_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(uv_ed_w_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(vt_ed_w_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(Fphi_scaled_w_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(Fp_scaled_w_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(fluxdiv_w_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(eke_w_ezav(:,:,i)')
end
figure
for i=1:6
subplot(2,3,i)
contourf(qgref_w_ezav(:,:,i)')
end

return

load('ens_th.mat')
figure
for i=1:20
subplot(2,10,i)
contourf(psi_th_ens(:,:,6,i)')
end
figure
for i=1:20
subplot(2,10,i)
contourf(uE_th_ens(:,:,6,i)')
end
figure
for i=1:20
subplot(2,10,i)
contourf(theta_th_ens(:,:,6,i)')
end
figure
for i=1:20
subplot(2,10,i)
contourf(htrt_th_ens(:,:,6,i)')
end
figure
for i=1:20
subplot(2,10,i)
contourf(uv_ed_th_ens(:,:,6,i)')
end
figure
for i=1:20
subplot(2,10,i)
contourf(vt_ed_th_ens(:,:,6,i)')
end
figure
for i=1:20
subplot(2,10,i)
contourf(Fphi_scaled_th_ens(:,:,6,i)')
end
figure
for i=1:20
subplot(2,10,i)
contourf(Fp_scaled_th_ens(:,:,6,i)')
end
figure
for i=1:20
subplot(2,10,i)
contourf(eke_th_ens(:,:,6,i)')
end
figure
for i=1:20
subplot(2,10,i)
contourf(qgref_th_ens(:,:,6,i)')
end

return


load('ens_c.mat')
figure
for i=1:20
subplot(2,10,i)
contourf(psi_c_ens(:,:,6,i)')
end
figure
for i=1:20
subplot(2,10,i)
contourf(uE_c_ens(:,:,6,i)')
end
figure
for i=1:20
subplot(2,10,i)
contourf(theta_c_ens(:,:,6,i)')
end
figure
for i=1:20
subplot(2,10,i)
contourf(htrt_c_ens(:,:,6,i)')
end
figure
for i=1:20
subplot(2,10,i)
contourf(uv_ed_c_ens(:,:,6,i)')
end
figure
for i=1:20
subplot(2,10,i)
contourf(vt_ed_c_ens(:,:,6,i)')
end
figure
for i=1:20
subplot(2,10,i)
contourf(Fphi_scaled_c_ens(:,:,6,i)')
end
figure
for i=1:20
subplot(2,10,i)
contourf(Fp_scaled_c_ens(:,:,6,i)')
end
figure
for i=1:20
subplot(2,10,i)
contourf(eke_c_ens(:,:,6,i)')
end
figure
for i=1:20
subplot(2,10,i)
contourf(qgref_c_ens(:,:,6,i)')
end

return

load('ens_w.mat')
figure
for i=1:18
subplot(2,9,i)
contourf(psi_w_ens(:,:,6,i)')
end
figure
for i=1:18
subplot(2,9,i)
contourf(uE_w_ens(:,:,6,i)')
end
figure
for i=1:18
subplot(2,9,i)
contourf(theta_w_ens(:,:,6,i)')
end
figure
for i=1:18
subplot(2,9,i)
contourf(htrt_w_ens(:,:,6,i)')
end
figure
for i=1:18
subplot(2,9,i)
contourf(uv_ed_w_ens(:,:,6,i)')
end
figure
for i=1:18
subplot(2,9,i)
contourf(vt_ed_w_ens(:,:,6,i)')
end
figure
for i=1:18
subplot(2,9,i)
contourf(Fphi_scaled_w_ens(:,:,6,i)')
end
figure
for i=1:18
subplot(2,9,i)
contourf(Fp_scaled_w_ens(:,:,6,i)')
end
figure
for i=1:18
subplot(2,9,i)
contourf(eke_w_ens(:,:,6,i)')
end
figure
for i=1:18
subplot(2,9,i)
contourf(qgref_w_ens(:,:,6,i)')
end
