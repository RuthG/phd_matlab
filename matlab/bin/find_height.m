%function find_height.m
%Find height corresponding to pressure level using hydrostatic equation.

%declare function
function z = find_height(p,t,theta);

%Check direction of inputs
if p(1) < p(2)
p=flipud(p);
p=fliplr(p);
t=flipud(t);
t=fliplr(t);
end

index = 1:6;
for i=1:6
check(i) = p(1)./(10^index(i));
end
p_scale = index(min(find(check<=1)));
p_ground = 1.01325 * 10^p_scale;

s=max(size(t));

%if t is given in potential t, convert
tprof=t;
if theta
convthetatoT=(p/p(1)).^(2./7.);
for i=1:s
tprof(i)=t(i)*convthetatoT(i);
end
end
t=tprof;

dp=p(1)-p(2);
p_g(1) = (p_ground+p(1))./2;
p_g(2:s)=p(1:s-1)-dp/2;

t_g = interp1(p,t,p_g,'linear','extrap');

z=zeros(25,1);
ra=287;  %spec gas const of dry air
g=9.8;   %gravity
fac=ra/g;

%use hydrostatic equn to find z
z_ground = 0.;
z(1)=z_ground + fac*t_g(1)*log(p_ground/p(1));
for i=1:s-1
steps(i)=fac*t_g(i+1)*log(p(i)/p(i+1));
z(i+1)=z(i)+steps(i);
end



