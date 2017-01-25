function fld=read_llc_fkij(fnam,nx,face,kx,ix,jx,prec)

% Function fld=read_llc_fkij(fnam,nx,face,kx,ix,jx,prec)
% read in specific face and indices for llc configuration
%
% INPUTS
% fnam  input path and file name
% nx    tile dimension (default 270)
% face  face number, 1 to 5, to read (default 1)
% kx    vertical indices to read, e.g., 1:50 (default 1)
% ix    i-indices, 1 to nx, to read (default 1:nx)
% jx    j-indices, 1 to 3*nx, to read (default 1:nx or 1:3*nx)
% prec  numeric precision (see fread; default 'real*4')
%
% OUTPUTS
% fld   output array of dimension length(ix)*length(jx)*length(kx)
%
% SEE ALSO
% quilread_llc

if nargin < 1, error('please specify input file name'); end
if nargin < 2, nx=270; end
if nargin < 3, face=1; end
if nargin < 4, kx=1; end
if nargin < 5, ix=1:nx; end
if nargin < 6,
    jx=1:(3*nx);
    if face==3, jx=1:nx; end
end
if nargin < 7, prec='real*4'; end

% reverse jx if reading faces 4 and 5
if face > 3
    jx=3*nx+1-jx(end:-1:1);
end

fid=fopen(fnam,'r','ieee-be');

switch prec
 case {'int8','integer*1'}
  preclength=1;
 case {'int16','integer*2','uint16','integer*2'}
  preclength=2;
 case {'int32','integer*4','uint32','single','real*4','float32'}
  preclength=4;
 case {'int64','integer*8','uint64','double','real*8','float64'}
  preclength=8;
end

if preclength<=4
    % if input is single precision,
    % output single precision to save space
    fld=zeros(length(ix),length(jx),length(kx),'single');
    prec=[prec '=>' prec];
else
    fld=zeros(length(ix),length(jx),length(kx));
end

for k=1:length(kx)
    skip=(kx(k)-1)*nx*nx*13; % numbers to skip to reach vertical level kx(k)    
    switch face
      case {1,2,3}
        skip=skip + ...
             (face-1)*3*nx*nx + ...     % add numbers to reach face
             (jx(1)-1)*nx + ...         % add numbers to reach row jx(1)
             ix(1)-1;                   % add numbers to reach column ix(1)
        if(fseek(fid,skip*preclength,'bof')<0)
            error(['past end of file']);
        end
        tmp=fread(fid,[length(ix),length(jx)], ...
                  [int2str(length(ix)) '*' prec], ... % repetition factor
                  (nx-length(ix))*preclength);        % skip argument
      case {4,5}
        oskip=skip;
        skip=skip + ...
             ((face-1)*3-2)*nx*nx + ... % add numbers to reach face
             (ix(1)-1)*3*nx + ...       % add numbers to reach row ix(1)
             jx(1)-1;                   % add numbers to reach column jx(1)
        if(fseek(fid,skip*preclength,'bof')<0)
            error(['past end of file']);
        end
        tmp=rot90(fread(fid,[length(jx),length(ix)], ...
                        [int2str(length(jx)) '*' prec], ... % repetition factor
                        (3*nx-length(jx))*preclength), ...  % skip argument
                  3);
    end
    fld(:,:,k)=tmp;
end

fid=fclose(fid);
