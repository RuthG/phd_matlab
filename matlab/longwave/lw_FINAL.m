%lw_FINAL.m
%Just sort it out!

%Load up data

load('sbdart_lw.mat')
p	= 2000:4000:98000;
p_half 	= 0:4000:100000;
stefan 	= 5.67e-8;
grav 	= 9.81;
RDGAS  	= 287.04;
KAPPA  	= 2./7.;
cp_air 	= RDGAS/KAPPA;
spd 	= 86400;


%Read in results of lw runs
for i = 1:9
output_lw(:,:,i) = dlmread(['~/matlab/longwave/check_window/OUTPUT_lw' num2str(91-i*10)]);
end

%translate fluxes onto half layers as in MITgcm
for i=1:9
fxdn(:,i)  = output_lw(2:26,3,i);
fxup(:,i)  = output_lw(2:26,4,i);
heat(:,i)  = output_lw(2:26,7,i);
end

fxdn_half = interp1(p,fxdn,p_half,'linear','extrap');
fxup_half = interp1(p,fxup,p_half,'linear','extrap');
t_mit_half = interp1(p,t_mit,p_half,'linear','extrap');

b = stefan*t_mit.^4;

for i=1:25
dfxdn(i,:) = fxdn_half(i+1,:) - fxdn_half(i,:);
dfxup(i,:) = fxup_half(i,:) -fxup_half(i+1,:);
dtau_dn(i,:) = dfxdn(i,:)./(b(i,:) - fxdn_half(i,:));
%dtau_up_check(i,:) = dfxup(i,:)./(b(i,:) - fxup_half(i+1,:));
dtau_up(i,:) = (b(i,:).*dtau_dn(i,:) - dfxup(i,:))./fxup_half(i+1,:);
end
dfxdn_nw(i,:) = fxdn_half_nw(i+1,:) - fxdn_half_nw(i,:);
dfxup_nw(i,:) = fxup_half_nw(i,:) -fxup_half_nw(i+1,:);
dtau_dn_nw(i,:) = dfxdn_nw(i,:)./(b(i,:) - fxdn_half_nw(i,:));
dtau_up_nw(i,:) = (b(i,:).*dtau_dn_nw(i,:) - dfxup_nw(i,:))./fxup_half_nw(i+1,:);
end
