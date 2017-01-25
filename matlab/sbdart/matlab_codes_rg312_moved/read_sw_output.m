%Read in full (ie all wavelengths all levels) output data for sbdart

nlamdas = 751;

lamdas = 0.250:0.005:4.000;

output=dlmread('OUTPUT_DOH_SWALL');

alt = zeros(25,1);
fdird = zeros(25,nlamdas);
fdifd = zeros(25,nlamdas);
flxdn = zeros(25,nlamdas);
flxup = zeros(25,nlamdas);

alt(1:10) = output(2,:);
alt(11:20) = output(3,:);
alt(21:25) = output(4,1:5);

for i=1:751
fdird(1:10,i) = output(5+16*(i-1),:);
fdird(11:20,i) = output(6+16*(i-1),:);
fdird(21:25,i) = output(7+16*(i-1),1:5);

fdifd(1:10,i) = output(8+16*(i-1),:);
fdifd(11:20,i) = output(9+16*(i-1),:);
fdifd(21:25,i) = output(10+16*(i-1),1:5);

flxdn(1:10,i) = output(11+16*(i-1),:);
flxdn(11:20,i) = output(12+16*(i-1),:);
flxdn(21:25,i) = output(13+16*(i-1),1:5);

flxup(1:10,i) = output(14+16*(i-1),:);
flxup(11:20,i) = output(15+16*(i-1),:);
flxup(21:25,i) = output(16+16*(i-1),1:5);

end

clear output

tausbdart=zeros(25,751);
for i=1:751
temp = flxdn(:,i);
tausbdart(:,i)=log(temp(1)./temp);
end
clear temp
