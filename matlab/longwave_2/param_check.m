%param_check.m
%run radiation_mod_fun for all 6 profiles for different values of params, check effect

p= 100.*(20:40:980);

for i=1:10
for j=1:10
lwh1(:,i,j) = radiation_mod_fun(1,(260 + i*20), -0.5 + j.*0.1); % 0.154925);
plot(lwh1(:,i,j),p)
hold on
lwh2(:,i,j) = radiation_mod_fun(2,(260 + i*20), -0.5 + j.*0.1); % 0.154925);
lwh3(:,i,j) = radiation_mod_fun(3,(260 + i*20), -0.5 + j.*0.1); % 0.154925);
lwh4(:,i,j) = radiation_mod_fun(4,(260 + i*20), -0.5 + j.*0.1); % 0.154925);
lwh5(:,i,j) = radiation_mod_fun(5,(260 + i*20), -0.5 + j.*0.1); % 0.154925);
lwh6(:,i,j) = radiation_mod_fun(6,(260 + i*20), -0.5 + j.*0.1); % 0.154925);
end
end
return
for i=1:6
lwh_model(:,i) = radiation_mod_fun(i,351.48,0.154925);
end

plot(24.*60.*60.*lwh_model,p);

return
for i=1:10
for j=1:10
plot(lwh3(:,i,j),p,'x')
hold on
end
end

