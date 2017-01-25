%load up composite data and have a go at calculating richardson number for our composites....
%start with 000 then do 100

load('/project/rg312/mat_files/composite_data_tlag/u_compdata_000.mat')
comp_u_000 = comp_data;

load('/project/rg312/mat_files/composite_data_tlag/theta_compdata_000.mat')
comp_theta_000 = comp_data;

load('/project/rg312/mat_files/composite_data_tlag/t_compdata_000.mat')
comp_t_000 = comp_data;


rC = 98000: -4000: 2000;
Ra = 287.04;
g= 9.81;
omega = 2.*pi./24./60./60;

for i=1:25
rho_000(:,i,:) = rC(i)./Ra./comp_t_000(:,i,:);
end


[a,dthetadp_000,d] = gradient(comp_theta_000,-4000);


[a,dudp_000,d] = gradient(comp_u_000,-4000);


dudz_000 = -g.*rho_000.*dudp_000;

Nsq_000 = - g.^2 .* rho_000 .* dthetadp_000 ./comp_theta_000;

richardson_000 = nanmean(Nsq_000,3)./nanmean(dudz_000,3).^2;
