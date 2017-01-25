atm = dlmread('obs_wv');

press = atm(:,1);
waterv = atm(:,3);

nit=69120*5;
rDir='/disk1/rg312/run_swtest_0111/';
ny=91;
yc=rdmds([rDir,'YC']);
hc=rdmds([rDir,'hFacC']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));
t=rdmds([rDir,'T'],nit);
[fldzon,mskzon,ylat,areazon]=calcZonalAvgCube(t,ny,yc,ar,hc);
t=fldzon(46,:);

convthetatoT=(rC/rC(1)).^(2./7.);
tprof=zeros(1,25);
for i=1:25
tprof(i)=fldzon(46,i)*convthetatoT(i);
end

z=find_height(rC,t,logical(1));

rC=rC/100;
wv = interp1(press,waterv,rC);
wv=wv/1000.;
wprof=wv./(1-wv);
save('wv_doh.mat','wv')
rhoair=1.292269;
wvprof_doh=wprof*1000.*rhoair;

atm=zeros(25,5);
atm(:,1)=z/1000.;
atm(:,2)=rC;
atm(:,3)=tprof;
atm(:,4)=wvprof_doh;
%atm(:,4)=1e-15;
atm(:,5)=1e-15;
atm=flipud(atm);
nn=size(atm,1);

filename='atms_doh.dat'
dlmwrite(filename, nn)
dlmwrite(filename, atm,'delimiter', '\t','precision', '%.6f','-append')
