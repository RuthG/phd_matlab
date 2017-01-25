%load in sbdart sw data and calculate transmittances to compare with radiation_mod


fxdn_sw = zeros(90,26);
fxup_sw = zeros(90,26);
fxdir_sw = zeros(90,26);
dfdz_sw = zeros(90,25);
heat_sw = zeros(90,25);

for i=2:89

name = ['sw_output_files/OUTPUT_wv_' int2str(i) ];
output=dlmread(name);

fxdn_sw(i,:) = output(2:27,3);
fxup_sw(i,:) = output(2:27,4);
fxdir_sw(i,:) = output(2:27,5);
dfdz_sw(i,:) = output(3:27,6);
heat_sw(i,:) = output(3:27,7);

end



save('sw_sbdart_nozen.mat','fxdn_sw','fxup_sw','fxdir_sw','dfdz_sw','heat_sw')


