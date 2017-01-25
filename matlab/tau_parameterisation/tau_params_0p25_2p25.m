%tau_params.m
%Use sbdart output to try to identify optical depth dependencies

%First look at dtau/dp at surface at 'mit' temperature profile (ie profile most similar to mitgcms)
%output files are named tau_results(q_surf value no)_(q_prof value no) and contain an array with 36x25 running through the 36 T profiles (T_surf constant at 300K to match Ape profs)

%load up values for q_surf, q_prof, t_prof, and t, w, p and z profiles
load('~/matlab/tau_parameterisation/profiles.mat')
doh = dlmread('~/atms.dat');
z=doh(2:26,1);
p=doh(2:26,2);

%calculate dp, dz, and halfway values for pressure and height levels
for i=1:24
dp(i,1)=p(i+1)-p(i);
dz(i,1)=z(i+1)-z(i);
z_dz(i,1)=(z(i+1)+z(i))/2.;
p_dp(i,1)=(p(i+1)+p(i))/2.;
end

tau_q=zeros(20,20,36,25);

for i=1:20  
for j=1:20

%load in all SBDART results
name=['~/matlab/tau_parameterisation/results/tau_results' num2str(i) '_' num2str(j) '.mat'];
load(name);

tau(i,j,:)=tau_rec;

%calcuate dtau, and then dtau/dz, dtau/dp
for k=1:24
dtau(i,j,k)=tau(i,j,k+1)-tau(i,j,k);
dtaudz(i,j,k) = shiftdim(dtau(i,j,k),2)./dz(k,1);
dtaudp(i,j,k) = shiftdim(dtau(i,j,k),2)./dp(k,1);
end

end
end


q_int(:,:,1)=q(:,:,1);
for i=2:25
q_int(:,:,i)=q(:,:,i)+q_int(:,:,i-1);
end

m(:,:)=q_int(15,:,:);
contourf(q_prof,p,m',20)
set(gca,'YDir','reverse')
xlabel('x, in q=q_s*(p/ps)^x')
ylabel('p, mb')
colorbar
name=['q_int_p_q_prof.png']
print('-dpng',name)
hold off


n(:,:)=q(15,:,:);
contourf(q_prof,p,n'-0.1*m',20)
set(gca,'YDir','reverse')
xlabel('x, in q=q_s*(p/ps)^x')
ylabel('p, mb')
colorbar
name=['qminpt1qint_p_q_prof.png']
print('-dpng',name) 
hold off

return

m(:,:)=dtaudp(:,1,4,:);
contourf(q_surf,p_dp,m',40);
colorbar
set(gca,'YDir','reverse')
xlabel('q_s; specific humidity at the surface, kg/kg')
ylabel('p, mb')
name=['dtaudp_p_q_surf.png']
print('-dpng',name) 
hold off

q_check(:,:)=q(:,1,:);
q_check2 = q_check.^2;
m_check = 50*q_check - 5*q_check2;
contourf(q_surf,p,m_check',40);
colorbar
set(gca,'YDir','reverse')

return

m(:,:)=-1*dtaudz(15,:,:);
contourf(q_prof,z_dz,m',40);
colorbar
xlabel('x, in q=q_s*(p/ps)^x')
ylabel('z, km')
name=['dtaudz_z_q_prof.png']
print('-dpng',name) 
hold off

m(:,:)=dtaudp(15,:,:);
contourf(q_prof,p_dp,m',40);
colorbar
set(gca,'YDir','reverse')
xlabel('x, in q=q_s*(p/ps)^x')
ylabel('p, mb')
name=['dtaudp_p_q_prof.png']
print('-dpng',name) 
hold off

n(:,:)=tau(15,:,:);
contourf(q_prof,p,n',40);
colorbar
set(gca,'YDir','reverse')
xlabel('x, in q=q_s*(p/ps)^x')
ylabel('p, mb')
name=['tau_p_q_prof.png']
print('-dpng',name) 
hold off

n(:,:)=q(15,:,:);
contourf(q_prof,p,n',40);
colorbar
set(gca,'YDir','reverse')
xlabel('x, in q=q_s*(p/ps)^x')
ylabel('p, mb')
name=['q_p_q_prof.png']
print('-dpng',name) 
hold off

return

hold off
for i=1:20
plot(q_surf,-1*dtaudz(:,i,4,24))
hold on
end
for i=1:36
plot(q_surf,-1*dtaudz(:,4,i,24),'r')
hold on
end
xlabel('q_s; specific humidity at the surface, kg/kg')
ylabel('Bottom layer dtau/dz')
name=['dtaudz_q_surf.png']
print('-dpng',name) 
hold off
return

for i=1:20
plot(q_prof,dtaudp(i,:,4,1))
hold on
end
for i=1:36
plot(q_prof,dtaudp(15,:,i,1),'r')
hold on
end
xlabel('x, in q=q_s*(p/ps)^x')
ylabel('Top layer dtau/dp')
name=['dtaudp_q_prof.png']
print('-dpng',name) 
hold off

for i=1:20
a(:,1)=dtaudp(i,4,:,1);
plot(t_prof,a)
hold on
end
for i=1:20
a(:,1)=dtaudp(15,i,:,1);
plot(t_prof,a,'r')
hold on
end
xlabel('A, in T = Alog(p/p_s) + T_s')
ylabel('Top layer dtau/dp')
name=['dtaudp_t_prof.png']
print('-dpng',name) 
hold off
