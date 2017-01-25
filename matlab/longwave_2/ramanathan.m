%ramanathan.m
%code up ramanathan's wv scheme for LW and see if it's any good for us!

load('standard_profs.mat');
t_0 = 293.;
p_0 = 1.01325e5
g = 9.8;

%conversion and integral???
step = (p./p_0).*(t_0./t).^0.5 .* (-q .* dp)./g;
u_1 = cumsum(step);

emiss_1 = 0.59.*(t_0./t).^0.5 .* ( 1 - 0.5.* (1./(1 + a_1.*(u_1).^0.5) + 1./(1 + a_2.(u_1).^0.5)  ) );

%e is partial pressure of wv
step = (e + alph_2.*p) .* (-q .* dp)./g;
u_2 = cumsum(step);

step = (e + alph_3.*p) .* (-q .* dp)./g;
u_3 = cumsum(step);

emiss_2 = (0.373 + 8.7610e-4.*(t-t_0)).*(1-exp(-20.*u_2));
emiss_3 = (0.124 + 4.9210e-4.*(t-t_0)).*(1-exp(-90.*u_3));
