
rDir='/project/rg312/run_delsol02/';

xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
ny=90;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Load data (adjust nit and rDir depending on run %%%%%%%%%%%%%%%%


niti = 173040;
nits = 240;
nitt = 259200;

var(1,:) = 'UVEL    ';
var(2,:) = 'UVELSQ  ';
var(3,:) = 'VVELSQ  ';

%varv = zeros(size(var));
varv(1,:) = 'VVEL    ';
varv(2,:) = '        ';
varv(3,:) = '        ';

loaded = false;

if loaded 

load('ekecalcvars.mat')

else

rDir='/project/rg312/run_delsol02/';
[tzav_02,tzavv_02] = mit_zavs(rDir,var,niti,nitt,nits,'varv',varv);

'tzav_02 loaded'

rDir='/project/rg312/wv_on_rad_off/run_doshallower_5year/';
[tzav_14,tzavv_14] = mit_zavs(rDir,var,259200,'varv',varv);

'tzav_14 loaded'

rDir='/project/rg312/run_delsol18/';
[tzav_18,tzavv_18] = mit_zavs(rDir,var,niti,nitt,nits,'varv',varv);

'tzav_18 loaded'

save('ekecalcvars.mat')

end

tke_02 = (tzav_02(:,:,2) + tzav_02(:,:,3))./2;
tke_14 = (tzav_14(:,:,2) + tzav_14(:,:,3))./2;
tke_18 = (tzav_18(:,:,2) + tzav_18(:,:,3))./2;


p0 = 100000;

zke_02 = (tzav_02(:,:,1).^2 + tzavv_02(:,:,1).^2)./2;
zke_14 = (tzav_14(:,:,1).^2 + tzavv_14(:,:,1).^2)./2;
zke_18 = (tzav_18(:,:,1).^2 + tzavv_18(:,:,1).^2)./2;


eke_02 =  tke_02 - zke_02;
eke_14 =  tke_14 - zke_14;
eke_18 =  tke_18 - zke_18;


%convert to two hemispheres
eke_hem_02(:,:,1) = eke_02(46:90,:);
eke_hem_14(:,:,1) = eke_14(46:90,:);
eke_hem_18(:,:,1) = eke_18(46:90,:);

for i=1:45
eke_hem_02(i,:,2) = eke_02(46-i,:);
eke_hem_14(i,:,2) = eke_14(46-i,:);
eke_hem_18(i,:,2) = eke_18(46-i,:);
end

name = ['bc_box_02.mat'];
load(name)
name = ['bc_box_14.mat'];
load(name)
name = ['bc_box_18.mat'];
load(name)


if mod(barzon_lats_02(1),2) == 0
barzon_reg_02 = barzon_lats_02(1)+1:2:barzon_lats_02(2)+1;
else
barzon_reg_02 = barzon_lats_02(1):2:barzon_lats_02(2);
end

if mod(barzon_lats_14(1),2) == 0
barzon_reg_14 = barzon_lats_14(1)+1:2:barzon_lats_14(2)+1;
else
barzon_reg_14 = barzon_lats_14(1):2:barzon_lats_14(2);
end

if mod(barzon_lats_18(1),2) == 0
barzon_reg_18 = barzon_lats_18(1)+1:2:barzon_lats_18(2)+1;
else
barzon_reg_18 = barzon_lats_18(1):2:barzon_lats_18(2);
end


%set up loop
ylat2=1:2:89;
start_02 = find(ylat2 == min(barzon_reg_02))-1;
start_14 = find(ylat2 == min(barzon_reg_14))-1;
start_18 = find(ylat2 == min(barzon_reg_18))-1;

for i=1:size(barzon_reg_02,2)
eke_weight_02(i,:,:) = cos(barzon_reg_02(i).*pi./180) .* eke_hem_02(start_02+i,:,:) ;
cosy_02(i) = cos(barzon_reg_02(i).*pi./180);
end
for i=1:size(barzon_reg_14,2)
eke_weight_14(i,:,:) = cos(barzon_reg_14(i).*pi./180) .* eke_hem_14(start_14+i,:,:) ;
cosy_14(i) = cos(barzon_reg_14(i).*pi./180);
end
for i=1:size(barzon_reg_18,2)
eke_weight_18(i,:,:) = cos(barzon_reg_18(i).*pi./180) .* eke_hem_18(start_18+i,:,:) ;
cosy_18(i) = cos(barzon_reg_18(i).*pi./180);
end


eke_bzav_02(:,:) = sum(eke_weight_02,1)./sum(cosy_02) ;
eke_bzav_14(:,:) = sum(eke_weight_14,1)./sum(cosy_14) ;
eke_bzav_18(:,:) = sum(eke_weight_18,1)./sum(cosy_18) ;

eke_bzav_02_av = mean(eke_bzav_02,2);
eke_bzav_14_av = mean(eke_bzav_14,2);
eke_bzav_18_av = mean(eke_bzav_18,2);

figure
plot(eke_bzav_14_av,rC,'k')
set(gca,'YDir','reverse')
hold on
plot(eke_bzav_18_av,rC,'b')
plot(eke_bzav_02_av,rC,'r')
print('-dpng','eke_bzav.png')


%integrating over dp/g is rho dz

eke_int_02 = sum(eke_bzav_02(1:level_02,:),1) .* 4000./9.81;
eke_int_14 = sum(eke_bzav_14(1:level_14,:),1) .* 4000./9.81;
eke_int_18 = sum(eke_bzav_18(1:level_18,:),1) .* 4000./9.81;

eke_out_02 = mean(eke_int_02);
eke_out_14 = mean(eke_int_14);
eke_out_18 = mean(eke_int_18);

%save
name = ['eke_out.mat'];
save(name, 'eke_out_14', 'eke_out_18','eke_out_02')




