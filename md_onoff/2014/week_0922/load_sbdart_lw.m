%load in sbdart lw data and calculate transmittances to compare with radiation_mod


fxdn_lw_l = zeros(90,26);
fxup_lw_l = zeros(90,26);
fxdir_lw_l = zeros(90,26);
dfdz_lw_l = zeros(90,25);
heat_lw_l = zeros(90,25);

fxdn_lw_u = zeros(90,26);
fxup_lw_u = zeros(90,26);
fxdir_lw_u = zeros(90,26);
dfdz_lw_u = zeros(90,25);
heat_lw_u = zeros(90,25);

fxdn_win = zeros(90,26);
fxup_win = zeros(90,26);
fxdir_win = zeros(90,26);
dfdz_win = zeros(90,25);
heat_win = zeros(90,25);

for i=2:89

name = ['/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0922/lw_output_files/OUTPUT_wv_l_' int2str(i) ];
output=dlmread(name);

fxdn_lw_l(i,:) = output(2:27,3);
fxup_lw_l(i,:) = output(2:27,4);
fxdir_lw_l(i,:) = output(2:27,5);
dfdz_lw_l(i,:) = output(3:27,6);
heat_lw_l(i,:) = output(3:27,7);

name = ['/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0922/lw_output_files/OUTPUT_wv_u_' int2str(i) ];
output=dlmread(name);

fxdn_lw_u(i,:) = output(2:27,3);
fxup_lw_u(i,:) = output(2:27,4);
fxdir_lw_u(i,:) = output(2:27,5);
dfdz_lw_u(i,:) = output(3:27,6);
heat_lw_u(i,:) = output(3:27,7);


name = ['/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0922/win_output_files/OUTPUT_wv_' int2str(i) ];
output=dlmread(name);

fxdn_win(i,:) = output(2:27,3);
fxup_win(i,:) = output(2:27,4);
fxdir_win(i,:) = output(2:27,5);
dfdz_win(i,:) = output(3:27,6);
heat_win(i,:) = output(3:27,7);

end


save('lw_sbdart.mat','fxdn_lw_l','fxup_lw_l','fxdir_lw_l','dfdz_lw_l','heat_lw_l', 'fxdn_lw_u','fxup_lw_u','fxdir_lw_u','dfdz_lw_u','heat_lw_u',  'fxdn_win','fxup_win','fxdir_win','dfdz_win','heat_win')