%read_ape_prof.m
%read in the ape ozone profile and save as .mat file

fid = fopen('~/matlab/sbdart_ozone/apeo3.dat');

numlats = fscanf(fid, '%f\n', 1);
fgetl(fid);
numlevs = fscanf(fid, '%f\n', 1);
for i=1:3
fgetl(fid);
end

for j=1:6
for i=1:10
lats(i+(j-1)*10) = fscanf(fid, '%f\n', 1);
end
end
for i=1:4
lats(60+i) = fscanf(fid, '%f\n', 1);
end
fgetl(fid);
for j=1:5
for i=1:10
press(i+(j-1)*10) = fscanf(fid, '%f\n', 1);
end
end
for i=1:9
press(50+i) = fscanf(fid, '%f\n', 1);
end
fgetl(fid);
for j=1:5
for i=1:10
alts(i+(j-1)*10) = fscanf(fid, '%f\n', 1);
end
end
for i=1:9
alts(50+i) = fscanf(fid, '%f\n', 1);
end
fgetl(fid);
for j=1:6
for i=1:10
intpress(i+(j-1)*10) = fscanf(fid, '%f\n', 1);
end
end
fgetl(fid);
for j=1:6
for i=1:10
intalts(i+(j-1)*10) = fscanf(fid, '%f\n', 1);
end
end
fgetl(fid);

for j=1:377
for i=1:10
store_o3(i+(j-1)*10) = fscanf(fid, '%f\n', 1);
end
end
for i=1:6
store_o3(3770+i) = fscanf(fid, '%f\n', 1);
end

o3_first = reshape(store_o3,64,59);
o3 = shiftdim(o3_first,1);
[alts,n] = shiftdim(alts);
[press,n] = shiftdim(press);
[intalts,n] = shiftdim(intalts);
[intpress,n] = shiftdim(intpress);
save('read_ape_prof.mat')

