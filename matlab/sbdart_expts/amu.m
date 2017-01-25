%amu.m

%Read data from amu_runs
%Parameterise SW absorption by co2, o2
%Check effect on dtaudsigma for wv, is there interference?

%Load up old data
%load('~/matlab/tp_btb/tau_wv_final.mat')
load('~/matlab/tp_btb/tau_wv_final_allelse.mat')


%Read in results

output_noco2wvo2 = dlmread('~/matlab/sbdart_expts/OUTPUT_noco2wvo2');

output_noco2p5o2 = dlmread('~/matlab/sbdart_expts/OUTPUT_noco2p5o2');
output_noco21o2 = dlmread('~/matlab/sbdart_expts/OUTPUT_noco21o2');
output_noco22o2 = dlmread('~/matlab/sbdart_expts/OUTPUT_noco22o2');
output_noco24o2 = dlmread('~/matlab/sbdart_expts/OUTPUT_noco24o2');

output_p5co2 = dlmread('~/matlab/sbdart_expts/OUTPUT_p5co2');
output_1co2 = dlmread('~/matlab/sbdart_expts/OUTPUT_1co2');
output_2co2 = dlmread('~/matlab/sbdart_expts/OUTPUT_2co2');
output_4co2 = dlmread('~/matlab/sbdart_expts/OUTPUT_4co2');

output_p5o2 = dlmread('~/matlab/sbdart_expts/OUTPUT_p5o2');
output_1o2 = dlmread('~/matlab/sbdart_expts/OUTPUT_1o2');
output_2o2 = dlmread('~/matlab/sbdart_expts/OUTPUT_2o2');
output_4o2 = dlmread('~/matlab/sbdart_expts/OUTPUT_4o2');

fxdn_noco2wvo2  = output_noco2wvo2(2:26,3);

fxdn_noco2p5o2  = output_noco2p5o2(2:26,3);
fxdn_noco21o2  = output_noco21o2(2:26,3);
fxdn_noco22o2  = output_noco22o2(2:26,3);
fxdn_noco24o2  = output_noco24o2(2:26,3);

fxdn_p5co2  = output_p5co2(2:26,3);
fxdn_1co2  = output_1co2(2:26,3);
fxdn_2co2  = output_2co2(2:26,3);
fxdn_4co2  = output_4co2(2:26,3);

fxdn_p5o2  = output_p5o2(2:26,3);
fxdn_1o2  = output_1o2(2:26,3);
fxdn_2o2  = output_2o2(2:26,3);
fxdn_4o2  = output_4o2(2:26,3);

tau_noco2wvo2 = -log(fxdn_noco2wvo2(:)./fxdn_noco2wvo2(1));

tau_noco2p5o2 = -log(fxdn_noco2p5o2(:)./fxdn_noco2p5o2(1));
tau_noco21o2 = -log(fxdn_noco21o2(:)./fxdn_noco21o2(1));
tau_noco22o2 = -log(fxdn_noco22o2(:)./fxdn_noco22o2(1));
tau_noco24o2 = -log(fxdn_noco24o2(:)./fxdn_noco24o2(1));

tau_p5co2 = -log(fxdn_p5co2(:)./fxdn_p5co2(1));
tau_1co2 = -log(fxdn_1co2(:)./fxdn_1co2(1));
tau_2co2 = -log(fxdn_2co2(:)./fxdn_2co2(1));
tau_4co2 = -log(fxdn_4co2(:)./fxdn_4co2(1));

tau_p5o2 = -log(fxdn_p5o2(:)./fxdn_p5o2(1));
tau_1o2 = -log(fxdn_1o2(:)./fxdn_1o2(1));
tau_2o2 = -log(fxdn_2o2(:)./fxdn_2o2(1));
tau_4o2 = -log(fxdn_4o2(:)./fxdn_4o2(1));



plot(tau_noco2wvo2,sigma,'k');
hold on
plot(tau_noco2p5o2,sigma);
plot(tau_noco21o2,sigma);
plot(tau_noco22o2,sigma);
plot(tau_noco24o2,sigma);

plot(tau_p5co2,sigma,'g');
plot(tau_1co2,sigma,'g');
plot(tau_2co2,sigma,'g');
plot(tau_4co2,sigma,'g');

plot(tau_p5o2,sigma,'m');
plot(tau_1o2,sigma,'m');
plot(tau_2o2,sigma,'m');
plot(tau_4o2,sigma,'m');


%param background

basemu = regress(tau_noco2wvo2,sigma);

%param o2

tau_diffp5o = tau_noco2p5o2 - tau_noco2wvo2;
tau_diff1o =  tau_noco21o2 - tau_noco2wvo2;
tau_diff2o =  tau_noco22o2 - tau_noco2wvo2;
tau_diff4o =  tau_noco24o2 - tau_noco2wvo2;

po(1,1) = regress(tau_diffp5o,sigma);
po(2,1)  = regress(tau_diff1o,sigma);
po(3,1)  = regress(tau_diff2o,sigma);
po(4,1)  = regress(tau_diff4o,sigma);

oconcs(1,1) = 104500.;
oconcs(2,1) = 209000.;
oconcs(3,1) = 418000.;
oconcs(4,1) = 836000.;

fittingo(:,1) = log(oconcs);
fittingo(:,2) = 1;

fito = regress(po,fittingo)

%param co2

tau_diffp5co = tau_p5co2 - tau_noco21o2;
tau_diff1co = tau_1co2 - tau_noco21o2;
tau_diff2co = tau_2co2 - tau_noco21o2;
tau_diff4co = tau_4co2 - tau_noco21o2;

pc(1,1) = regress(tau_diffp5co,sigma);
pc(2,1)  = regress(tau_diff1co,sigma);
pc(3,1)  = regress(tau_diff2co,sigma);
pc(4,1)  = regress(tau_diff4co,sigma);

cconcs(1,1) = 180.;
cconcs(2,1) = 360.;
cconcs(3,1) = 720.;
cconcs(4,1) = 1440.;

fittingc(:,1) = log(cconcs);
fittingc(:,2) = 1;

fitc = regress(pc,fittingc)


amu_calc(1) = 0.0013 + 0.0033*log(180.) + 0.0032*log(209000.);
amu_calc(2) = 0.0013 + 0.0033*log(360.) + 0.0032*log(209000.);
amu_calc(3) = 0.0013 + 0.0033*log(720.) + 0.0032*log(209000.);
amu_calc(4) = 0.0013 + 0.0033*log(1440.) + 0.0032*log(209000.);
amu_calc(5) = 0.0013 + 0.0033*log(360.) + 0.0032*log(104500.);
amu_calc(6) = 0.0013 + 0.0033*log(360.) + 0.0032*log(209000.);
amu_calc(7) = 0.0013 + 0.0033*log(360.) + 0.0032*log(418000.);
amu_calc(8) = 0.0013 + 0.0033*log(360.) + 0.0032*log(836000.);

compare(1) = regress(tau_p5co2,sigma);
compare(2) = regress(tau_1co2,sigma);
compare(3) = regress(tau_2co2,sigma);
compare(4) = regress(tau_4co2,sigma);

compare(5) = regress(tau_p5o2,sigma);
compare(6) = regress(tau_1o2,sigma);
compare(7) = regress(tau_2o2,sigma);
compare(8) = regress(tau_4o2,sigma);


%check params for amu work

system('rm OUTPUT')

blank = '0';
data = zeros(7,25);
file = '';

    fileID = fopen('INPUT','w'); 
    fprintf(fileID,'$INPUT\n');
    %fprintf(fileID,'  nf = 0.\n');
    fprintf(fileID,'  wlinf = 0.25\n');
    fprintf(fileID,'  wlsup = 4.0\n');
    fprintf(fileID,'  wlinc = 0.005\n');
    fprintf(fileID,'  idatm = 0\n');
    fprintf(fileID,'  xo2 = 209000.0\n');
    fprintf(fileID,'  xco2 = 800.0\n');
    fprintf(fileID,'  sza = 0\n');
    fprintf(fileID,'  iout = 11\n');
    fprintf(fileID,'  isalb = 0\n');
    fprintf(fileID,'  albcon = 0.06\n');
    fprintf(fileID,'  kdist = 3\n');
    %fprintf(fileID,'  idb(7) = 1\n');
    fprintf(fileID,'$end\n');
    fclose(fileID);

    [a,b]=system('/home/rg312/matlab/sbdart/sbdart_stuff/sbdart.exe');

	system('mv OUTPUT OUTPUT_checkamu')

output_checkamu = dlmread('~/matlab/sbdart_expts/OUTPUT_checkamu');

fxdn_checkamu  = output_checkamu(2:26,3);

tau_checkamu = -log(fxdn_checkamu./fxdn_checkamu(1));

regress(tau_checkamu, sigma)

amu_calc = 0.0013 + 0.0033*log(800.) + 0.0032*log(209000.);
