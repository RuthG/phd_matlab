function conc = fun3(x,alts)
	u = x(1)*(1+exp(-x(2)/x(3)))./(1+exp((alts(:,1)-x(2))./x(3)));
	for i=1:48
	conc(i) = -1*( u(i+1)-u(i) ) ./ ( alts(i+1,1)-alts(i,1));
	end
end
