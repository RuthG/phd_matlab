%lw_model.m
%see if using fitting params found in lw_btb can recreate observed fluxes...

dt_dn = (par(1,1)*data(:,1)+par(2,1)).*dsigma;


dt_dn = (par(1,1)*q_mit+par(2,1)).*dsigma;
dt_up = (par(1,2)*q_mit+par(2,2)).*dsigma;

three = polyfit(q_mit(:,9),dtau_dn(:,9)./dsigma,2);
three_up = polyfit(q_mit(:,9),dtau_up(:,9)./dsigma,2);

dt_dn = polyval(pars_dn,q_mit) ;%.*dsigma;
dt_up = polyval(pars_up,q_mit); %.*dsigma;

dt_mit = (0.8678 + 1.9929e3.*q_mit).*dsigma;


down = zeros(26,9);
up = zeros(26,9);
up(26,:) = fxup_half(26,:) ; %stefan.*t_mit_half(26,:).^4;
up_mit(26,:) = fxup_half(26,:) ;
down(1,:) = fxdn_half(1,:);
down_mit(1,:) = fxdn_half(1,:);
for i=1:25
down(i+1,:) = down(i,:).*(1-dt_dn(i,:)) + b(i,:).*dt_dn(i,:);
down_mit(i+1,:) = down_mit(i,:).*(1-dt_mit(i,:)) + b(i,:).*dt_mit(i,:);
end

for i=25:-1:1
up(i,:) = up(i+1,:).*(1-dt_up(i,:)) + 1.*b(i,:).*dt_dn(i,:);
up_mit(i,:) = up_mit(i+1,:).*(1-dt_mit(i,:)) + 1.*b(i,:).*dt_mit(i,:);
end

net = up-down;
net_sb = fxup_half - fxdn_half;
net_mit = up_mit-down_mit;

for i=1:25
heating(i,:) = (net(i+1,:) - net(i,:)).*spd.*grav./(cp_air*(p_half(i+1)-p_half(i)));
heating_mit(i,:) = (net_mit(i+1,:) - net_mit(i,:)).*spd.*grav./(cp_air*(p_half(i+1)-p_half(i)));
heating_sb(i,:) = (net_sb(i+1,:) - net_sb(i,:)).*spd.*grav./(cp_air*(p_half(i+1)-p_half(i)));
end

save('lw_btb.mat')

amu_dn = mean(mean(dtds_dn_nw));
amu_up = mean(mean(dtds_up_nw)); 
