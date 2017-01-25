%calculate the fraction of blackbody radiation in the window band, and use to check our approx for this

lambda = 0.25e-6:0.005e-6:100e-6;
T = 200:10:300;

h = 6.626e-34;  % Js = kg m2 s-1
c = 2.997e8;    % m/s
kb = 1.38e-23;  % m2 kg s-2 K-1
stefan 	= 5.6734e-8;  % W m−2 K−4   = kg s-3 K-4


lambda5 = lambda.^5; % m5
const1 = 2.*h.*c.^2;  % kg m4 s-3


for i=1:11

expterm = exp( (h.*c)./(lambda.*kb.*T(i)) ); 
B(i,:) = const1 ./ lambda5 ./ (expterm - 1);   % kg m-1 s-3

B_l(i) = sum(B(i,752:1550),2).*pi.*0.005e-6;
B_win(i) = sum(B(i,1551:2751),2).*pi.*0.005e-6;
B_tot(i) = sum(B(i,:),2).*pi.*0.005e-6;

end

B_stefan = stefan.*T.^4;

p = polyfit(T./100,B_win./B_stefan,2);

B_check = p(1).*(T./100).^2 + p(2).*T./100 + p(3);


plot(T,B_win./B_stefan)
hold on
plot(T,B_check,'r--')
xlabel('Temperature')
ylabel('Fraction of Black-Body Emission in the Infrared Window Region')
print('-dpdf','bb_win_frac.pdf')


maxB = max(B,2);

return

plot(lambda.*10^6,B270)
hold on
plot(lambda.*10^6,B280,'r')
plot(lambda.*10^6,B290,'g')
plot(lambda.*10^6,B300,'k')
