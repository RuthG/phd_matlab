%load in sbdart sw data and calculate transmittances to compare with radiaton_mod


fxdn_sw = zeros(90,25);
fxup_sw = zeros(90,25);
fxdir_sw = zeros(90,25);
dfdz_sw = zeros(90,25);
heat_sw = zeros(90,25);

for i=2:89

name = ['/disk1/MITgcm/verification/atm_gray_ruth/md_onoff/week_0908/sw_output_files_szen/OUTPUT_wv_' int2str(i) ];
output=dlmread(name);

fxdn_sw(i,:) = output(2:26,3);
fxup_sw(i,:) = output(2:26,4);
fxdir_sw(i,:) = output(2:26,5);
dfdz_sw(i,:) = output(2:26,6);
heat_sw(i,:) = output(2:26,7);

end


%interpolate fluxes onto in-between layers to help with rest of analysis.

p = 20:40:980;
p_half = 0:40:1000;

fxdn_sw_half = shiftdim(interp1(p,fxdn_sw',p_half,'cubic','extrap'),1);
fxup_sw_half = shiftdim(interp1(p,fxup_sw',p_half,'cubic','extrap'),1);

save('sw_sbdart_szen.mat','fxdn_sw_half','fxup_sw_half','fxdir_sw','dfdz_sw','heat_sw')


