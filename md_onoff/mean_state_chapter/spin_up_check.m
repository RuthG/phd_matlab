%load ke for first 2 years of 100 expt and plot sum


rDir='/project/rg312/final_runs/run_100_final/';

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
ny=90;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Load data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%for j=1:11
%i=0;

%uucs = zeros(192,32,25,360);
%vvcs = zeros(192,32,25,360);

%for nit = (j.*360 - 359).*240:240: (j.*360).*240;
%i=i+1

%[dyn,iter,M]=rdmds([rDir,'dynDiag'],nit);  
%eval(M);

%J=find(strcmp(fldList,'UVELSQ  '));
%uucs(:,:,:,i) = dyn(:,:,:,J);
%J=find(strcmp(fldList,'VVELSQ  '));
%vvcs(:,:,:,i) = dyn(:,:,:,J);

%end

%save(['/project/rg312/mat_files/chapter2_variables/ke_change_' num2str(j) '.mat'])

%end

%return

ke_sum = zeros(360,11);

for j=1:11
j
load(['/project/rg312/mat_files/chapter2_variables/ke_change_' num2str(j) '.mat'])

ke = (uucs + vvcs)./2.*4000./9.8;
ke_sum_vert = mean(ke,3);

for i=1:360
ke_sum(i,j) = sum(sum(ke_sum_vert(:,:,1,i).*ar,1),2)./sum(sum(ar,1),2);
%ke_sec(i,j) = sum(sum(ke(:,:,20,i).*ar,1),2)./sum(sum(ar,1),2);

end

end


load('/project/rg312/mat_files/chapter2_variables/epvars_tav_100.mat','usq_tav','vsq_tav')
ke_mean = (usq_tav+vsq_tav)./2;
ke_mean_sum_vert = mean(ke_mean,3).*4000./9.8;
ke_mean_sum = sum(sum(ke_mean_sum_vert.*ar,1),2)./sum(sum(ar,1),2);

%try a monthly average to smooth
%for i=1:36
%ke_monthly(i) = mean(ke_sum(i.*30-29:i.*30));
%end

ke_sdev = sqrt(mean(mean((ke_sum(:,2:11)./1000 - ke_mean_sum./1000).^2)));

ke_plot(1:360) = ke_sum(:,1);
ke_plot(361:720) = ke_sum(:,2);
ke_plot(721:1080) = ke_sum(:,3);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOTTING PARAMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# centimeters units
Y = 29.7;                  %# A4 paper size
X = 21;                  %# A4 paper size
yMargin = 0.75;               %# left/right margins from page borders
xMargin = 1;               %# bottom/top margins from page borders
xSize = X - 1*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 0*yMargin;     %# figure size on paper (widht & hieght)
ySize_sub = 0.2625; 
xSize_sub = 0.6; 

pos1x = 0.1 ; 	pos1y = 0.7; 

hFig = figure('Menubar','none');
%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

axes('position',[pos1x pos1y xSize_sub ySize_sub])
plot(ke_plot./1000,'kx')
set(gca,'FontSize',10)
hold on
plot([0, 1080], [ke_mean_sum./1000, ke_mean_sum./1000],'k')
xlim([0 1080])
xlabel('Time, days','FontSize',12)
ylabel('Global mean kinetic energy, kJm^{-2}','FontSize',12)
print('-dpdf','ke_spinup.pdf')
