%lacis_hansen.m

load('/project/rg312/mat_files/radiation_chapter/uvwqt_tav_radon.mat','q_tav','theta_tav')

rDir='/project/rg312/final_runs/run_100_rad_on/';
xc=rdmds([rDir,'XC']);
yc=rdmds([rDir,'YC']);
xg=rdmds([rDir,'XG']);
yg=rdmds([rDir,'YG']);
hc=rdmds([rDir,'hFacC']);
hw=rdmds([rDir,'hFacW']);
hs=rdmds([rDir,'hFacS']);
ar=rdmds([rDir,'RAC']);
rC=squeeze(rdmds([rDir,'RC']));
drC=squeeze(rdmds([rDir,'DRC']));
AngleCS=rdmds([rDir,'AngleCS']);
AngleSN=rdmds([rDir,'AngleSN']);
Grid='C';
xi=-179:2:179;
yi=-89:2:89;


    convthetatoT=(rC/100000.0).^(2./7.);
    for k=1:size(rC)
      t_tav(:,:,k)=theta_tav(:,:,k).*convthetatoT(k,1);
    end


q_ll=cube2latlon(xc,yc,q_tav,xi,yi);
%theta_ll=cube2latlon(xc,yc,theta_tav,xi,yi);
t_ll=cube2latlon(xc,yc,t_tav,xi,yi);

q_zav(:,:) = mean(q_ll,1);
%theta_zav(:,:) = mean(theta_ll,1);
t_zav(:,:) = mean(t_ll,1);


%t_zav = flipdim(t_zav,2);
%q_zav = flipdim(q_zav,2);

yi = -89:2:89;
rC = 98000:-4000:2000;

Ra = 287.04;
grav= 9.81;
spd = 24.*60.*60;
cp_air = 287.04./(2./7);
%mag = 35./(1224.*(cos(yi.*pi./180.)).^2 + 1).^0.5;

yy=yi*90/60*pi/180;
sinyy=sin(yy);
sst=27*(1-sinyy.*sinyy);
sst(find(abs(yi)>=60))=0;
t_surf=sst+273.15;


for i=1:25
rhoair(:,i) = rC(i)./Ra./t_zav(:,i);  %kg./m3
end

w_zav = q_zav./(1-q_zav);
rhovapour = w_zav.*rhoair; %kg/m3

dz = 4000./grav./rhoair;


pw = rhovapour.*dz.*100./1000;

for i=1:90
pw_eff(i,:) = rhovapour(i,:).*dz(i,:).*100./1000.*(rC(:)'./100000).*(t_surf(i)./t_zav(i,:)).^0.5;

pw_alt(i,:) = q_zav(i,:)./1000 .* (rC(:)'./100000).*(t_surf(i)./t_zav(i,:)).^0.5 .*4000./grav .*100;
end


pw_int = cumsum(flipdim(pw,2),2);
pw_int_eff = cumsum(flipdim(pw_eff,2),2);
pw_int_alt = cumsum(flipdim(pw_alt,2),2);


abs_yam = 2.9.*pw_int./((1 + 141.5.*pw_int).^0.635 + 5.925.*pw_int);
abs_lh = 2.9.*pw_int_eff./((1 + 141.5.*pw_int_eff).^0.635 + 5.925.*pw_int_eff);

abs_fowl = 0.0946.*pw_int.^0.303;

log102abskorb = -0.74 + 0.347.*log10(pw_int) - 0.056.*(log10(pw_int)).^2 - 0.006*(log10(pw_int)).^3;
abs_korb = 0.5.*10.^log102abskorb;

plot(log10(pw_int),abs_yam,'k')
hold on
plot(log10(pw_int),abs_fowl,'k.')
plot(log10(pw_int),abs_korb,'k--')
%plot(log10(pw_int),abs_lh,'r')
hold off



solar_constant = 1360.;
ss = sin(yi*pi./180.);
p2 = (1. - 3.*ss.^2)./4;
solar = 0.25.*solar_constant.*(1.0 + 1.4.*p2);
sw_down_yam(:,1) = solar;
sw_down_lh(:,1) = solar;
sw_down_fowl(:,1) = solar;
sw_down_korb(:,1) = solar;

trans_yam = 1-abs_yam;
trans_lh = 1-abs_lh;
trans_fowl = 1-abs_fowl;
trans_korb = 1-abs_korb;

for i=1:90
sw_down_yam(i,2:26) = solar(i).*trans_yam(i,:);
sw_down_lh(i,2:26) = solar(i).*trans_lh(i,:);
sw_down_fowl(i,2:26) = solar(i).*trans_fowl(i,:);
sw_down_korb(i,2:26) = solar(i).*trans_korb(i,:);

end

for i=1:25

dtrans_yam(:,i) = sw_down_yam(:,i+1)./sw_down_yam(:,i);
dtrans_lh(:,i) = sw_down_lh(:,i+1)./sw_down_lh(:,i);
dtrans_fowl(:,i) = sw_down_fowl(:,i+1)./sw_down_fowl(:,i);
dtrans_korb(:,i) = sw_down_korb(:,i+1)./sw_down_korb(:,i);

end

rC_half = 0:4000:100000;
rC_flip = 2000:4000:98000;

for k=1:25
  tdt_sw_yam(:,k) = -spd.*(sw_down_yam(:,k+1) - sw_down_yam(:,k)).*grav./(cp_air.*(rC_half(k+1) - rC_half(k)));
  tdt_sw_lh(:,k) = -spd.*(sw_down_lh(:,k+1) - sw_down_lh(:,k)).*grav./(cp_air.*(rC_half(k+1) - rC_half(k)));
  tdt_sw_fowl(:,k) = -spd.*(sw_down_fowl(:,k+1) - sw_down_fowl(:,k)).*grav./(cp_air.*(rC_half(k+1) - rC_half(k)));
  tdt_sw_korb(:,k) = -spd.*(sw_down_korb(:,k+1) - sw_down_korb(:,k)).*grav./(cp_air.*(rC_half(k+1) - rC_half(k)));

end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 29.7;                  %# A4 paper size
X = 21;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 1*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 0*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.225; %0.4;
xSize_sub = 0.375;

pos1x = 0.1 ; 	pos1y = 0.7; 
pos2x = 0.55;	pos2y = 0.7; 
pos3x = 0.1; 	pos3y = 0.05;
pos4x = 0.55; 	pos4y = 0.05;



hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')


v=0:0.2:1.6;
label = 0:0.2:1.6;

axes('position',[pos1x pos1y xSize_sub ySize_sub])
[C,h] = contour(yi,rC_flip./100,tdt_sw_lh',v,'k');
clabel(C,h,'FontSize',10);
set(gca,'YDir','reverse','FontSize',10)
ylabel('Pressure, hPa','FontSize',12)
xlabel('Latitude','FontSize',12)

print('-dpdf','lh_test.pdf')

save('/project/rg312/mat_files/radiation_chapter/lh_heatrates.mat')
