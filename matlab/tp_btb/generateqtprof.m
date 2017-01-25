%generate q and T profiles to read into sbdart

doh = dlmread('~/atms.dat');

sigma = doh(2:26,2)/doh(26,2);

q_surf(:,1) = (1:20)/1000.;
q_prof(:,1) = 1.:0.5:10.5;
hold off
for i=1:size(q_surf)

	for j=1:size(q_prof)
	q(i,j,1:25) = q_surf(i)*sigma(1:25).^q_prof(j);
	b(1:25,1)=q(i,j,:);
	plot(b,sigma)
	hold on
	end

end

set(gca,'YDir','reverse')
xlabel('Specific humidity, kg/kg')
ylabel('Pressure, Pa')
name=['q_profiles.png']
print('-dpng',name) 

hold off 

rhoair=1.292269;
w = rhoair*1000*q./(1-q);
w(find(w<=1e-14))=1e-14;


t_surf=300.
t_prof(:,1)=45:80;

for i=1:size(t_prof)

t(i,1:25) = t_prof(i)*log(sigma) + t_surf;
t(i,1:4) = t(i,5);
b(1:25,1) = t(i,:);
plot(b,sigma)
hold on

end
set(gca,'YDir','reverse')
xlabel('Temperature, K')
ylabel('Pressure, Pa')
name=['t_profiles.png']
print('-dpng',name) 


save('profiles.mat','t','w','q','q_surf','q_prof','t_prof')

return
