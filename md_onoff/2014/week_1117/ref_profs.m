%load in reference profiles used in convection scheme




% choose directory, load grid
rDir = '/project/rg312/ref_prof_runs/run_100_lzb/';
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



i=0
for nit = 259320;
i=i+1

rDir = '/project/rg312/ref_prof_runs/run_000_lzb/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPh_Trf'));
tref_000(:,:,:) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPh_Qrf'));
qref_000(:,:,:) = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_000(:,:,:) = dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q_000(:,:,:) = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVEL    '));
w_000(:,:,:) = dyn(:,:,:,J);
[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhConv'));
conv_000(:,:) = surf(:,:,J);
J=find(strcmp(fldList,'AtPhCnvP'));
convp_000(:,:) = surf(:,:,J);
J=find(strcmp(fldList,'AtPhKlzb'));
lzb_000(:,:) = surf(:,:,J);

rDir = '/project/rg312/ref_prof_runs/run_100_lzb/';
[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPh_Trf'));
tref_100(:,:,:) = dyn(:,:,:,J);
J=find(strcmp(fldList,'AtPh_Qrf'));
qref_100(:,:,:) = dyn(:,:,:,J);
J=find(strcmp(fldList,'THETA   '));
theta_100(:,:,:) = dyn(:,:,:,J);
J=find(strcmp(fldList,'SALT    '));
q_100(:,:,:) = dyn(:,:,:,J);
J=find(strcmp(fldList,'WVEL    '));
w_100(:,:,:) = dyn(:,:,:,J);
[surf,iter,M]=rdmds([rDir,'surfDiag'],nit);  
eval(M);
J=find(strcmp(fldList,'AtPhConv'));
conv_100(:,:) = surf(:,:,J);
J=find(strcmp(fldList,'AtPhCnvP'));
convp_100(:,:) = surf(:,:,J);
J=find(strcmp(fldList,'AtPhKlzb'));
lzb_100(:,:) = surf(:,:,J);

end

press = 2000:4000:98000;

for i=1:32
for j=1:192

if round(lzb_000(j,i)) ~= 0
lzb_000(j,i) = press(round(lzb_000(j,i)));
end
if round(lzb_100(j,i)) ~= 0
lzb_100(j,i) = press(round(lzb_100(j,i)));
end

end
end

xi=-179:2:180;yi=-89:2:90;

qref_000_ll = cube2latlon(xc,yc,qref_000,xi,yi);
tref_000_ll = cube2latlon(xc,yc,tref_000,xi,yi);
q_000_ll = cube2latlon(xc,yc,q_000,xi,yi);
w_000_ll = cube2latlon(xc,yc,w_000,xi,yi);
theta_000_ll = cube2latlon(xc,yc,theta_000,xi,yi);
conv_000_ll = cube2latlon(xc,yc,conv_000,xi,yi);
convp_000_ll = cube2latlon(xc,yc,convp_000,xi,yi);
lzb_000_ll = cube2latlon(xc,yc,lzb_000,xi,yi);

qref_100_ll = cube2latlon(xc,yc,qref_100,xi,yi);
tref_100_ll = cube2latlon(xc,yc,tref_100,xi,yi);
q_100_ll = cube2latlon(xc,yc,q_100,xi,yi);
w_100_ll = cube2latlon(xc,yc,w_100,xi,yi);
theta_100_ll = cube2latlon(xc,yc,theta_100,xi,yi);
conv_100_ll = cube2latlon(xc,yc,conv_100,xi,yi);
convp_100_ll = cube2latlon(xc,yc,convp_100,xi,yi);
lzb_100_ll = cube2latlon(xc,yc,lzb_100,xi,yi);

convthetatoT=(rC/101325.0).^(2./7.);
for j=1:size(rC)
t_000_ll(:,:,j)=theta_000_ll(:,:,j).*convthetatoT(j,1);
t_100_ll(:,:,j)=theta_100_ll(:,:,j).*convthetatoT(j,1);
end

theta_000_prof(1:25) = theta_000_ll(1,45,:);
t_000_prof(1:25) = t_000_ll(1,45,:);
tref_000_prof(1:25) = tref_000_ll(1,45,:);
q_000_prof(1:25) = q_000_ll(1,45,:);
qref_000_prof(1:25) = qref_000_ll(1,45,:);
t_000_prof2(1:25) = t_000_ll(39,25,:);
tref_000_prof2(1:25) = tref_000_ll(39,25,:);

t_100_prof(1:25) = t_100_ll(1,45,:);
tref_100_prof(1:25) = tref_100_ll(1,45,:);
q_100_prof(1:25) = q_100_ll(1,45,:);
qref_100_prof(1:25) = qref_100_ll(1,45,:);
t_100_prof2(1:25) = t_100_ll(40,25,:);
tref_100_prof2(1:25) = tref_100_ll(40,25,:);
q_100_prof2(1:25) = q_100_ll(40,25,:);
qref_100_prof2(1:25) = qref_100_ll(40,25,:);


figure
plot(t_000_prof,rC)
set(gca,'YDir','reverse')
hold on
plot(tref_000_prof,rC,'--')
plot(t_100_prof,rC,'r')
plot(tref_100_prof,rC,'r--')
plot(t_000_prof2,rC,'m')
plot(tref_000_prof2,rC,'m--')
plot(t_100_prof2,rC,'g')
plot(tref_100_prof2,rC,'g--')

ylabel('Pressure, Pa')
xlabel('Temperature, K')
title('Reference Temperature profiles')
legend('Dry: T','Dry: Tref','Wet: T','Wet: Tref')
print('-dpng','trefs.png')
return
figure
plot(q_000_prof,rC)
set(gca,'YDir','reverse')
hold on
plot(qref_000_prof,rC,'--')
plot(q_100_prof,rC,'r')
plot(qref_100_prof,rC,'r--')
plot(q_100_prof2,rC,'g')
plot(qref_100_prof2,rC,'g--')
ylabel('Pressure, Pa')
xlabel('Specific Humidity, kg/kg')
title('Reference Humidity profiles')
legend('Dry: q','Dry: qref','Wet: q','Wet: qref')
print('-dpng','qrefs.png')

figure
k=8;
figure(1);clf;
ccB=[0 0];
AxBx=[-180 180 -90 90];
kEnv=0; shift=-1; cbV=1;
grph_CS(conv_000,xc,yc,xg,yg,ccB(1),ccB(2),shift,cbV,AxBx,kEnv);
xlabel('Longitude')
ylabel('Latitude')
title('Convection scheme choice, dry')
print('-dpng','conv000.png')

figure
k=8;
figure(1);clf;
ccB=[0 0];
AxBx=[-180 180 -90 90];
kEnv=0; shift=-1; cbV=1;
grph_CS(conv_100,xc,yc,xg,yg,ccB(1),ccB(2),shift,cbV,AxBx,kEnv);
xlabel('Longitude')
ylabel('Latitude')
title('Convection scheme choice, dry')
print('-dpng','conv100.png')

figure
grph_CS(lzb_000,xc,yc,xg,yg,ccB(1),ccB(2),shift,cbV,AxBx,kEnv);
xlabel('Longitude')
ylabel('Latitude')
print('-dpng','lzb000.png')

figure
grph_CS(lzb_100,xc,yc,xg,yg,ccB(1),ccB(2),shift,cbV,AxBx,kEnv);
xlabel('Longitude')
ylabel('Latitude')
print('-dpng','lzb100.png')

figure
grph_CS(w_000(:,:,5),xc,yc,xg,yg,ccB(1),ccB(2),shift,cbV,AxBx,kEnv);
xlabel('Longitude')
ylabel('Latitude')
title('W, Pa/s, dry')
print('-dpng','w000.png')

figure
grph_CS(w_100(:,:,5),xc,yc,xg,yg,ccB(1),ccB(2),shift,cbV,AxBx,kEnv);
xlabel('Longitude')
ylabel('Latitude')
title('W, Pa/s, wet')
print('-dpng','w100.png')



