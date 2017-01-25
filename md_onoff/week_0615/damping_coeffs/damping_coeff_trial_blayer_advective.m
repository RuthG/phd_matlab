

[dcoeff_tottend_p_000, dcoeff_tottend_n_000,dcoeff_advtend_p_000, dcoeff_advtend_n_000] = damping_coeff_blayer_adv_fun('000');
'000'

[dcoeff_tottend_p_010, dcoeff_tottend_n_010,dcoeff_advtend_p_010, dcoeff_advtend_n_010] = damping_coeff_blayer_adv_fun('010');
'010'

[dcoeff_tottend_p_025, dcoeff_tottend_n_025,dcoeff_advtend_p_025, dcoeff_advtend_n_025] = damping_coeff_blayer_adv_fun('025');
'025'

[dcoeff_tottend_p_050, dcoeff_tottend_n_050,dcoeff_advtend_p_050, dcoeff_advtend_n_050] = damping_coeff_blayer_adv_fun('050');
'050'

[dcoeff_tottend_p_075, dcoeff_tottend_n_075,dcoeff_advtend_p_075, dcoeff_advtend_n_075] = damping_coeff_blayer_adv_fun('075');
'075'

[dcoeff_tottend_p_100, dcoeff_tottend_n_100,dcoeff_advtend_p_100, dcoeff_advtend_n_100] = damping_coeff_blayer_adv_fun('100');
'100'

save('/project/rg312/mat_files/damping_coeffs_adv.mat')
