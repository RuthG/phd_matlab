%load in sbdart lw data and calculate transmittances to compare with radiaton_mod


fxdn_lw_l = zeros(90,25);
fxup_lw_l = zeros(90,25);
fxdir_lw_l = zeros(90,25);
dfdz_lw_l = zeros(90,25);
heat_lw_l = zeros(90,25);

fxdn_lw_u = zeros(90,25);
fxup_lw_u = zeros(90,25);
fxdir_lw_u = zeros(90,25);
dfdz_lw_u = zeros(90,25);
heat_lw_u = zeros(90,25);

fxdn_win = zeros(90,25);
fxup_win = zeros(90,25);
fxdir_win = zeros(90,25);
dfdz_win = zeros(90,25);
heat_win = zeros(90,25);

for i=2:89

name = ['/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0908/lw_output_files_szen/OUTPUT_wv_l_' int2str(i) ];
output=dlmread(name);

fxdn_lw_l(i,:) = output(2:26,3);
fxup_lw_l(i,:) = output(2:26,4);
fxdir_lw_l(i,:) = output(2:26,5);
dfdz_lw_l(i,:) = output(2:26,6);
heat_lw_l(i,:) = output(2:26,7);

name = ['/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0908/lw_output_files_szen/OUTPUT_wv_u_' int2str(i) ];
output=dlmread(name);

fxdn_lw_u(i,:) = output(2:26,3);
fxup_lw_u(i,:) = output(2:26,4);
fxdir_lw_u(i,:) = output(2:26,5);
dfdz_lw_u(i,:) = output(2:26,6);
heat_lw_u(i,:) = output(2:26,7);


name = ['/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0908/win_output_files_szen/OUTPUT_wv_' int2str(i) ];
output=dlmread(name);

fxdn_win(i,:) = output(2:26,3);
fxup_win(i,:) = output(2:26,4);
fxdir_win(i,:) = output(2:26,5);
dfdz_win(i,:) = output(2:26,6);
heat_win(i,:) = output(2:26,7);

end

%interpolate fluxes onto in-between layers to help with rest of analysis.

p = 20:40:980;
p_half = 0:40:1000;

fxdn_lw_l_half = shiftdim(interp1(p,fxdn_lw_l',p_half,'cubic','extrap'),1);
fxdn_lw_u_half = shiftdim(interp1(p,fxdn_lw_u',p_half,'cubic','extrap'),1);
fxdn_win_half = shiftdim(interp1(p,fxdn_win',p_half,'cubic','extrap'),1);

fxup_lw_l_half = shiftdim(interp1(p,fxup_lw_l',p_half,'cubic','extrap'),1);
fxup_lw_u_half = shiftdim(interp1(p,fxup_lw_u',p_half,'cubic','extrap'),1);
fxup_win_half = shiftdim(interp1(p,fxup_win',p_half,'cubic','extrap'),1);

save('lw_sbdart_szen.mat','fxdn_lw_l_half','fxup_lw_l_half','fxdir_lw_l','dfdz_lw_l','heat_lw_l', 'fxdn_lw_u_half','fxup_lw_u_half','fxdir_lw_u','dfdz_lw_u','heat_lw_u',  'fxdn_win_half','fxup_win_half','fxdir_win','dfdz_win','heat_win')
