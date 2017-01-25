function conc = fun(x,alt_prof)
	expbit(:,1) = exp( (alt_prof(:,1)-x(2))/x(3) );
	conc(:,1) = expbit(:,1) * ( x(1) + x(1)*exp(-x(2)/x(3)) ) ./ ( x(3)*(1 + expbit(:,1)).^2 );

end
