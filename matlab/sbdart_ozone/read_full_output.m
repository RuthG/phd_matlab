%Read in full (ie all wavelengths all levels) output data for sbdart

nlamdas = 751;

lamdas = 0.250:0.005:4.000;

output=dlmread('OUTPUT_blendfull1');

alt = zeros(49,1);
fdird = zeros(49,nlamdas);
fdifd = zeros(49,nlamdas);
flxdn = zeros(49,nlamdas);
flxup = zeros(49,nlamdas);

alt(1:10) = output(2,:);
alt(11:20) = output(3,:);
alt(21:30) = output(4,:);
alt(31:40) = output(5,:);
alt(41:49) = output(6,1:9);

for i=1:nlamdas
fdird(1:10,i) = output(7+26*(i-1),:);
fdird(11:20,i) = output(8+26*(i-1),:);
fdird(21:30,i) = output(9+26*(i-1),:);
fdird(31:40,i) = output(10+26*(i-1),:);
fdird(41:49,i) = output(11+26*(i-1),1:9);

fdifd(1:10,i) = output(12+26*(i-1),:);
fdifd(11:20,i) = output(13+26*(i-1),:);
fdifd(21:30,i) = output(14+26*(i-1),:);
fdifd(31:40,i) = output(15+26*(i-1),:);
fdifd(41:49,i) = output(16+26*(i-1),1:9);

flxdn(1:10,i) = output(17+26*(i-1),:);
flxdn(11:20,i) = output(18+26*(i-1),:);
flxdn(21:30,i) = output(19+26*(i-1),:);
flxdn(31:40,i) = output(20+26*(i-1),:);
flxdn(41:49,i) = output(21+26*(i-1),1:9);

flxup(1:10,i) = output(22+26*(i-1),:);
flxup(11:20,i) = output(23+26*(i-1),:);
flxup(21:30,i) = output(24+26*(i-1),:);
flxup(31:40,i) = output(25+26*(i-1),:);
flxup(41:49,i) = output(26+26*(i-1),1:9);

end

clear output

return

