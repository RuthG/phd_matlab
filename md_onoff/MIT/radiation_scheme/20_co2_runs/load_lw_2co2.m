%load in sbdart lw data and calculate transmittances to compare with radiation_mod


fxdn_lw_l = zeros(45,26);
fxup_lw_l = zeros(45,26);
fxdir_lw_l = zeros(45,26);
dfdz_lw_l = zeros(45,25);
heat_lw_l = zeros(45,25);

fxdn_lw_u = zeros(45,26);
fxup_lw_u = zeros(45,26);
fxdir_lw_u = zeros(45,26);
dfdz_lw_u = zeros(45,25);
heat_lw_u = zeros(45,25);

fxdn_win = zeros(45,26);
fxup_win = zeros(45,26);
fxdir_win = zeros(45,26);
dfdz_win = zeros(45,25);
heat_win = zeros(45,25);

for i=2:45

name = ['lw_output_files/OUTPUT_wv_l_' int2str(i) ];
output=dlmread(name);

fxdn_lw_l(i,:) = output(2:27,3);
fxup_lw_l(i,:) = output(2:27,4);
fxdir_lw_l(i,:) = output(2:27,5);
dfdz_lw_l(i,:) = output(3:27,6);
heat_lw_l(i,:) = output(3:27,7);

name = ['lw_output_files/OUTPUT_wv_u_' int2str(i) ];
output=dlmread(name);

fxdn_lw_u(i,:) = output(2:27,3);
fxup_lw_u(i,:) = output(2:27,4);
fxdir_lw_u(i,:) = output(2:27,5);
dfdz_lw_u(i,:) = output(3:27,6);
heat_lw_u(i,:) = output(3:27,7);


name = ['win_output_files/OUTPUT_wv_' int2str(i) ];
output=dlmread(name);

fxdn_win(i,:) = output(2:27,3);
fxup_win(i,:) = output(2:27,4);
fxdir_win(i,:) = output(2:27,5);
dfdz_win(i,:) = output(3:27,6);
heat_win(i,:) = output(3:27,7);

end


save('lw_sbdart_20co2.mat','fxdn_lw_l','fxup_lw_l','fxdir_lw_l','dfdz_lw_l','heat_lw_l', 'fxdn_lw_u','fxup_lw_u','fxdir_lw_u','dfdz_lw_u','heat_lw_u',  'fxdn_win','fxup_win','fxdir_win','dfdz_win','heat_win')
