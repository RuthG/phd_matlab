%test theta theory vaguely: i.e. theta anomalies capped by dry stability

% choose directory, load grid
rDir='/project/rg312/wv_on_rad_off/run_doshallower10/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
yi = -89:2:89;
xi = -179:2:179;

load('/project/rg312/mat_files/climatology_vars.mat','theta_000_zav','theta_010_zav','theta_025_zav','theta_050_zav','theta_075_zav','theta_100_zav')
load('/project/rg312/mat_files/climatology_vars.mat','q_000_zav','q_010_zav','q_025_zav','q_050_zav','q_075_zav','q_100_zav')
load('/project/rg312/mat_files/climatology_vars.mat','t_000_zav','t_010_zav','t_025_zav','t_050_zav','t_075_zav','t_100_zav')
load('/project/rg312/mat_files/vt_lats.mat')

L = 2.500e6;
Rd = 287.04;
Rv = 461.50;
cp = 287.04./(2/7);
convtheta(1,:)=(rC/101325.0).^(2./7.);
convthetatoT=repmat(convtheta,[90,1]);

teq_000_zav = t_000_zav + Rd./Rv .* L./cp .*q_000_zav./0.622;
thetaeq_000_zav = teq_000_zav./convthetatoT;
teq_010_zav = t_010_zav + Rd./Rv .* L./cp .*q_010_zav./0.622;
thetaeq_010_zav = teq_010_zav./convthetatoT;
teq_025_zav = t_025_zav + Rd./Rv .* L./cp .*q_025_zav./0.622;
thetaeq_025_zav = teq_025_zav./convthetatoT;
teq_050_zav = t_050_zav + Rd./Rv .* L./cp .*q_050_zav./0.622;
thetaeq_050_zav = teq_050_zav./convthetatoT;
teq_075_zav = t_075_zav + Rd./Rv .* L./cp .*q_075_zav./0.622;
thetaeq_075_zav = teq_075_zav./convthetatoT;
teq_100_zav = t_100_zav + Rd./Rv .* L./cp .*q_100_zav./0.622;
thetaeq_100_zav = teq_100_zav./convthetatoT;

for i=1:25
theta_000_drystab(:,i) = theta_000_zav(:,1) - theta_000_zav(:,i);
theta_010_drystab(:,i) = theta_010_zav(:,1) - theta_010_zav(:,i);
theta_025_drystab(:,i) = theta_025_zav(:,1) - theta_025_zav(:,i);
theta_050_drystab(:,i) = theta_050_zav(:,1) - theta_050_zav(:,i);
theta_075_drystab(:,i) = theta_075_zav(:,1) - theta_075_zav(:,i);
theta_100_drystab(:,i) = theta_100_zav(:,1) - theta_100_zav(:,i) ;

thetaeq_000_drystab(:,i) = thetaeq_000_zav(:,1) - thetaeq_000_zav(:,i);
thetaeq_010_drystab(:,i) = thetaeq_010_zav(:,1) - thetaeq_010_zav(:,i);
thetaeq_025_drystab(:,i) = thetaeq_025_zav(:,1) - thetaeq_025_zav(:,i);
thetaeq_050_drystab(:,i) = thetaeq_050_zav(:,1) - thetaeq_050_zav(:,i);
thetaeq_075_drystab(:,i) = thetaeq_075_zav(:,1) - thetaeq_075_zav(:,i);
thetaeq_100_drystab(:,i) = thetaeq_100_zav(:,1) - thetaeq_100_zav(:,i) ;

end

for i=1:45
theta_000_eqpole(i,:) =  theta_000_zav(i,:) - theta_000_zav(x000s,:);
theta_000_eqpole(i+45,:) = theta_000_zav(i+45,:) - theta_000_zav(x000n,:);
theta_010_eqpole(i,:) =  theta_010_zav(i,:) - theta_010_zav(x010s,:);
theta_010_eqpole(i+45,:) = theta_010_zav(i+45,:) - theta_010_zav(x010n,:);
theta_025_eqpole(i,:) =  theta_025_zav(i,:) - theta_025_zav(x025s,:);
theta_025_eqpole(i+45,:) = theta_025_zav(i+45,:) - theta_025_zav(x025n,:);
theta_050_eqpole(i,:) =  theta_050_zav(i,:) - theta_050_zav(x050s,:);
theta_050_eqpole(i+45,:) = theta_050_zav(i+45,:) - theta_050_zav(x050n,:);
theta_075_eqpole(i,:) =  theta_075_zav(i,:) - theta_075_zav(x075s,:);
theta_075_eqpole(i+45,:) = theta_075_zav(i+45,:) - theta_075_zav(x075n,:);
theta_100_eqpole(i,:) = theta_100_zav(i,:) - theta_100_zav(x100s,:);
theta_100_eqpole(i+45,:) = theta_100_zav(i+45,:) - theta_100_zav(x100n,:);

thetaeq_000_eqpole(i,:) =  thetaeq_000_zav(i,:) - thetaeq_000_zav(x000s,:);
thetaeq_000_eqpole(i+45,:) = thetaeq_000_zav(i+45,:) - thetaeq_000_zav(x000n,:);
thetaeq_010_eqpole(i,:) =  thetaeq_010_zav(i,:) - thetaeq_010_zav(x010s,:);
thetaeq_010_eqpole(i+45,:) = thetaeq_010_zav(i+45,:) - thetaeq_010_zav(x010n,:);
thetaeq_025_eqpole(i,:) =  thetaeq_025_zav(i,:) - thetaeq_025_zav(x025s,:);
thetaeq_025_eqpole(i+45,:) = thetaeq_025_zav(i+45,:) - thetaeq_025_zav(x025n,:);
thetaeq_050_eqpole(i,:) =  thetaeq_050_zav(i,:) - thetaeq_050_zav(x050s,:);
thetaeq_050_eqpole(i+45,:) = thetaeq_050_zav(i+45,:) - thetaeq_050_zav(x050n,:);
thetaeq_075_eqpole(i,:) =  thetaeq_075_zav(i,:) - thetaeq_075_zav(x075s,:);
thetaeq_075_eqpole(i+45,:) = thetaeq_075_zav(i+45,:) - thetaeq_075_zav(x075n,:);
thetaeq_100_eqpole(i,:) = thetaeq_100_zav(i,:) - thetaeq_100_zav(x100s,:);
thetaeq_100_eqpole(i+45,:) = thetaeq_100_zav(i+45,:) - thetaeq_100_zav(x100n,:);
end

v=-10:2:10;
figure
[C,h] = contourf(yi,rC./100,theta_000_eqpole',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','theta_eqpole_000.png')

figure
[C,h] = contourf(yi,rC./100,theta_010_eqpole',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','theta_eqpole_010.png')

figure
[C,h] = contourf(yi,rC./100,theta_025_eqpole',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','theta_eqpole_025.png')

figure
[C,h] = contourf(yi,rC./100,theta_050_eqpole',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','theta_eqpole_050.png')

figure
[C,h] = contourf(yi,rC./100,theta_075_eqpole',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','theta_eqpole_075.png')

figure
[C,h] = contourf(yi,rC./100,theta_100_eqpole',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','theta_eqpole_100.png')



figure
[C,h] = contourf(yi,rC./100,theta_000_drystab',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','theta_drystab_000.png')

figure
[C,h] = contourf(yi,rC./100,theta_010_drystab',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','theta_drystab_010.png')

figure
[C,h] = contourf(yi,rC./100,theta_025_drystab',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','theta_drystab_025.png')

figure
[C,h] = contourf(yi,rC./100,theta_050_drystab',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','theta_drystab_050.png')

figure
[C,h] = contourf(yi,rC./100,theta_075_drystab',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','theta_drystab_075.png')

figure
[C,h] = contourf(yi,rC./100,theta_100_drystab',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','theta_drystab_100.png')





figure
[C,h] = contourf(yi,rC./100,theta_000_eqpole' - theta_000_drystab',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
hold on
plot([yi(x000s) yi(x000s)],[0 10^5],'k')
plot([yi(x000n) yi(x000n)],[0 10^5],'k')
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','theta_epmds_000.png')

figure
[C,h] = contourf(yi,rC./100,theta_010_eqpole' - theta_010_drystab',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
hold on
plot([yi(x010s) yi(x010s)],[0 10^5],'k')
plot([yi(x010n) yi(x010n)],[0 10^5],'k')
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','theta_epmds_010.png')

figure
[C,h] = contourf(yi,rC./100,theta_025_eqpole' - theta_025_drystab',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
hold on
plot([yi(x025s) yi(x025s)],[0 10^5],'k')
plot([yi(x025n) yi(x025n)],[0 10^5],'k')
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','theta_epmds_025.png')

figure
[C,h] = contourf(yi,rC./100,theta_050_eqpole' - theta_050_drystab',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
hold on
plot([yi(x050s) yi(x050s)],[0 10^5],'k')
plot([yi(x050n) yi(x050n)],[0 10^5],'k')
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','theta_epmds_050.png')

figure
[C,h] = contourf(yi,rC./100,theta_075_eqpole' - theta_075_drystab',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
hold on
plot([yi(x075s) yi(x075s)],[0 10^5],'k')
plot([yi(x075n) yi(x075n)],[0 10^5],'k')
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','theta_epmds_075.png')

figure
[C,h] = contourf(yi,rC./100,theta_100_eqpole' - theta_100_drystab',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
hold on
plot([yi(x100s) yi(x100s)],[0 10^5],'k')
plot([yi(x100n) yi(x100n)],[0 10^5],'k')
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','theta_epmds_100.png')






v=-10:2:10;
figure
[C,h] = contourf(yi,rC./100,thetaeq_000_eqpole',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','thetaeq_eqpole_000.png')

figure
[C,h] = contourf(yi,rC./100,thetaeq_010_eqpole',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','thetaeq_eqpole_010.png')

figure
[C,h] = contourf(yi,rC./100,thetaeq_025_eqpole',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','thetaeq_eqpole_025.png')

figure
[C,h] = contourf(yi,rC./100,thetaeq_050_eqpole',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','thetaeq_eqpole_050.png')

figure
[C,h] = contourf(yi,rC./100,thetaeq_075_eqpole',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','thetaeq_eqpole_075.png')

figure
[C,h] = contourf(yi,rC./100,thetaeq_100_eqpole',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','thetaeq_eqpole_100.png')



figure
[C,h] = contourf(yi,rC./100,thetaeq_000_drystab',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','thetaeq_drystab_000.png')

figure
[C,h] = contourf(yi,rC./100,thetaeq_010_drystab',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','thetaeq_drystab_010.png')

figure
[C,h] = contourf(yi,rC./100,thetaeq_025_drystab',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','thetaeq_drystab_025.png')

figure
[C,h] = contourf(yi,rC./100,thetaeq_050_drystab',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','thetaeq_drystab_050.png')

figure
[C,h] = contourf(yi,rC./100,thetaeq_075_drystab',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','thetaeq_drystab_075.png')

figure
[C,h] = contourf(yi,rC./100,thetaeq_100_drystab',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','thetaeq_drystab_100.png')





figure
[C,h] = contourf(yi,rC./100,thetaeq_000_eqpole' - thetaeq_000_drystab',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
hold on
plot([yi(x000s) yi(x000s)],[0 10^5],'k')
plot([yi(x000n) yi(x000n)],[0 10^5],'k')
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','thetaeq_epmds_000.png')

figure
[C,h] = contourf(yi,rC./100,thetaeq_010_eqpole' - thetaeq_010_drystab',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
hold on
plot([yi(x010s) yi(x010s)],[0 10^5],'k')
plot([yi(x010n) yi(x010n)],[0 10^5],'k')
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','thetaeq_epmds_010.png')

figure
[C,h] = contourf(yi,rC./100,thetaeq_025_eqpole' - thetaeq_025_drystab',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
hold on
plot([yi(x025s) yi(x025s)],[0 10^5],'k')
plot([yi(x025n) yi(x025n)],[0 10^5],'k')
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','thetaeq_epmds_025.png')

figure
[C,h] = contourf(yi,rC./100,thetaeq_050_eqpole' - thetaeq_050_drystab',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
hold on
plot([yi(x050s) yi(x050s)],[0 10^5],'k')
plot([yi(x050n) yi(x050n)],[0 10^5],'k')
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','thetaeq_epmds_050.png')

figure
[C,h] = contourf(yi,rC./100,thetaeq_075_eqpole' - thetaeq_075_drystab',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
hold on
plot([yi(x075s) yi(x075s)],[0 10^5],'k')
plot([yi(x075n) yi(x075n)],[0 10^5],'k')
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','thetaeq_epmds_075.png')

figure
[C,h] = contourf(yi,rC./100,thetaeq_100_eqpole' - thetaeq_100_drystab',v);
set(gca,'YDir','reverse')
colorbar
caxis([-10 10])
hold on
plot([yi(x100s) yi(x100s)],[0 10^5],'k')
plot([yi(x100n) yi(x100n)],[0 10^5],'k')
xlabel('Latitude')
ylabel('Pressure, hPa')
print('-dpng','thetaeq_epmds_100.png')
