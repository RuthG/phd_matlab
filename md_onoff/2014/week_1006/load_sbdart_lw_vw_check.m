%load in sbdart lw data and calculate transmittances to compare with radiation_mod


fxdn_lw_l = zeros(2,26);
fxup_lw_l = zeros(2,26);
fxdir_lw_l = zeros(2,26);
dfdz_lw_l = zeros(2,25);
heat_lw_l = zeros(2,25);

fxdn_lw_u = zeros(2,26);
fxup_lw_u = zeros(2,26);
fxdir_lw_u = zeros(2,26);
dfdz_lw_u = zeros(2,25);
heat_lw_u = zeros(2,25);

fxdn_win = zeros(2,26);
fxup_win = zeros(2,26);
fxdir_win = zeros(2,26);
dfdz_win = zeros(2,25);
heat_win = zeros(2,25);

i=0;
for a=46:35:81
i=i+1;
name = ['./OUTPUT_lw_l_' int2str(a) ];
output=dlmread(name);

fxdn_lw_l(i,:) = output(2:27,3);
fxup_lw_l(i,:) = output(2:27,4);
fxdir_lw_l(i,:) = output(2:27,5);
dfdz_lw_l(i,:) = output(3:27,6);
heat_lw_l(i,:) = output(3:27,7);

name = ['./OUTPUT_lw_u_' int2str(a) ];
output=dlmread(name);

fxdn_lw_u(i,:) = output(2:27,3);
fxup_lw_u(i,:) = output(2:27,4);
fxdir_lw_u(i,:) = output(2:27,5);
dfdz_lw_u(i,:) = output(3:27,6);
heat_lw_u(i,:) = output(3:27,7);


name = ['./OUTPUT_wv_' int2str(a) ];
output=dlmread(name);

fxdn_win(i,:) = output(2:27,3);
fxup_win(i,:) = output(2:27,4);
fxdir_win(i,:) = output(2:27,5);
dfdz_win(i,:) = output(3:27,6);
heat_win(i,:) = output(3:27,7);

end


save('lw_sbdart_difft.mat','fxdn_lw_l','fxup_lw_l','fxdir_lw_l','dfdz_lw_l','heat_lw_l', 'fxdn_lw_u','fxup_lw_u','fxdir_lw_u','dfdz_lw_u','heat_lw_u',  'fxdn_win','fxup_win','fxdir_win','dfdz_win','heat_win')
