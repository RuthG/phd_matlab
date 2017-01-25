%fixed_rad_inputs.m
%create input files for fixed radiation runs of MITgcm.

%set up grid and input directories
%gDir='./';
%G=load_grid(gDir,0);

%nx=G.dims(1); ny=G.dims(2); nc=ny;
%xc=G.xC; yc=G.yC; xg=G.xG; yg=G.yG;

rDir = '/project/rg312/final_runs/run_100_rad_on_sens/';

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
xi=-179:2:180;yi=-89:2:90;

load('/project/rg312/mat_files/transmittances_final_rev.mat')

dtrans_orig = trans_lw;
dtrans_sol_orig = trans_sw;
dtrans_win_orig = trans_wi;

nr=size(trans_lw,3);
ny=90;

'Taking zonal average of dtrans fields'
[dtrans_orig_zav,mskzon,ylat,areazon]=calcZonalAvgCube(dtrans_orig,ny,yc,ar,hc);
[dtrans_sol_orig_zav,mskzon,ylat,areazon]=calcZonalAvgCube(dtrans_sol_orig,ny,yc,ar,hc);
[dtrans_win_orig_zav,mskzon,ylat,areazon]=calcZonalAvgCube(dtrans_win_orig,ny,yc,ar,hc);

'Taking hemisphere average of dtrans fields'
for i=1:90
dtrans_orig_hzav(i,:) = (dtrans_orig_zav(i,:) + dtrans_orig_zav(91-i,:) )./2;
dtrans_sol_orig_hzav(i,:) = (dtrans_sol_orig_zav(i,:) + dtrans_sol_orig_zav(91-i,:) )./2;
dtrans_win_orig_hzav(i,:) = (dtrans_win_orig_zav(i,:) + dtrans_win_orig_zav(91-i,:) )./2;
end

new_y = sort(reshape(yc,1,6144));

dtrans_in = zeros(192,32,25);
dtrans_sol_in = zeros(192,32,25);
dtrans_win_in = zeros(192,32,25);

'interpolate dtrans to higher lat resolution'
dtrans_orig_hzav_hd = interp1(ylat, dtrans_orig_hzav, new_y, 'cubic','extrap');
dtrans_sol_orig_hzav_hd = interp1(ylat, dtrans_sol_orig_hzav, new_y, 'cubic','extrap');
dtrans_win_orig_hzav_hd = interp1(ylat, dtrans_win_orig_hzav, new_y, 'cubic','extrap');

'transfer dtrans hzav back onto cube'
for i=1:max(size(new_y))-1
indexes = find(yc==new_y(i));

for j=1:max(size(indexes))
[I_1,J_1] = ind2sub([192,32],indexes(j));
dtrans_in(I_1,J_1,:) = dtrans_orig_hzav_hd (i,:);
dtrans_sol_in(I_1,J_1,:) = dtrans_sol_orig_hzav_hd(i,:);
dtrans_win_in(I_1,J_1,:) = dtrans_win_orig_hzav_hd(i,:);
end
end

'Take zon av of resulting input to check'
[dtrans_in_av,mskzon,ylat,areazon]=calcZonalAvgCube(dtrans_in,ny,yc,ar,hc);
[dtrans_sol_in_av,mskzon,ylat,areazon]=calcZonalAvgCube(dtrans_sol_in,ny,yc,ar,hc);
[dtrans_win_in_av,mskzon,ylat,areazon]=calcZonalAvgCube(dtrans_win_in,ny,yc,ar,hc);

fname='dtrans_in.bin';
fid=fopen(fname,'w','b'); fwrite(fid,dtrans_in,'real*8'); fclose(fid);
fprintf(['write file: ',fname,'\n']);

fname='dtrans_sol_in.bin';
fid=fopen(fname,'w','b'); fwrite(fid,dtrans_sol_in,'real*8'); fclose(fid);
fprintf(['write file: ',fname,'\n']);

fname='dtrans_win_in.bin';
fid=fopen(fname,'w','b'); fwrite(fid,dtrans_win_in,'real*8'); fclose(fid);
fprintf(['write file: ',fname,'\n']);

save('fixed_rad_input_corrected.mat')

return
%also make a version that can be read by the 26 layer as a dummy (28/01/16)

dtrans_in_26 = zeros(192,32,26);
dtrans_sol_in_26 = zeros(192,32,26);
dtrans_win_in_26 = zeros(192,32,26);

fname='dtrans_in.bin';
fid=fopen(fname,'w','b'); fwrite(fid,dtrans_in_26,'real*8'); fclose(fid);
fprintf(['write file: ',fname,'\n']);

fname='dtrans_sol_in.bin';
fid=fopen(fname,'w','b'); fwrite(fid,dtrans_sol_in_26,'real*8'); fclose(fid);
fprintf(['write file: ',fname,'\n']);

fname='dtrans_win_in.bin';
fid=fopen(fname,'w','b'); fwrite(fid,dtrans_win_in_26,'real*8'); fclose(fid);
fprintf(['write file: ',fname,'\n']);

return

