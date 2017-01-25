function [R2,R,SLOPE,OFFSET,pval,tval,GaussianRes] = myregress(a,b,FIG)
% function [R2,R,SLOPE,OFFSET,pval,tval,GaussianRes] = myregress(a,b,FIG)
% test the model: a = SLOPE*b + OFFSET
% if FIG=1 then plot figure.

y = a'; x = b'; clear a b;
X = [ones(length(x),1) x];
N = length(y);

[b,BINT,R,RINT,STATS] = regress(y,X); 
ypred = b(1) + b(2)*x; 
R2 = STATS(1); 
SLOPE = b(2);
OFFSET = b(1);
R = sqrt(R2)*sign(SLOPE); %equal to cor = (x'-mean(x))*(y-mean(y))/( length(x)*std(y)*std(x) )
pval = STATS(3);

%study residuals
res = ypred-y;
[Nhist,bin] = hist(res); dbin = mean( diff(bin) );
res_mea = mean(res);
err_std = std(res);
PDFgauss = 1/(err_std*sqrt(2*pi)) * exp( -(bin-res_mea).^2 / (2*err_std^2) );
alpha = 0.4; G = kstest(res,[],alpha,'unequal'); %alpha=0.05 for 95% confidence
GaussianRes = 1 - G; %1 if residuals are Gaussian, 0 otherwise

%t-variable
SSE = sum( res.^2 );
SSX = sum( (x-mean(x)).^2 );
sigma = sqrt(SSE/(N-2));
tval = b(2)*sqrt(SSX)/sigma;

if FIG == 1
  figure(98), clf,
   plot(x,y,'k+',x,ypred,'k-');
   %plot(x/max(x),y/max(y),'k+',x/max(x),ypred/max(y),'k-');
 
  figure(99), clf,
  plot(bin,Nhist/(dbin*sum(Nhist)),'k-o',bin,PDFgauss,'r-o');
end

end

