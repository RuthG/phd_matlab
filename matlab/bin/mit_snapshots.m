%function mit_zavs.m
%Load MIT diagnostic for a given time range, take zonal mean

%inputs: diag variable name (8 character string in a cell array), lowest iteration no, highest iteration number, iteration no spacing, logical check for velocity, v component of velocity
%output: zonal mean of variable, v component if input is a speed

%declare function

function [outll,varargout] = mit_snapshots(rDir,var,niti,varargin);


%use parser to help with optional inputs (nitt, nits, varv)

 p = inputParser;

%set defaults

defaultStep = 240;
defaultTop = niti;
defaultIsvel = false;
defaultVarv = '        ';

   addRequired(p,'rDir',@iscell);
   addRequired(p,'var');
   addRequired(p,'niti',@isnumeric);
   addOptional(p,'nitt',defaultTop,@isnumeric);
   addOptional(p,'nits',defaultStep,@isnumeric);
   addOptional(p,'varv',defaultVarv);

   parse(p,rDir,var,niti,varargin{:});


%read files
dir = char(p.Results.rDir(1));
xc=rdmds([dir,'XC']);
yc=rdmds([dir,'YC']);
AngleCS=rdmds([dir,'AngleCS']);
AngleSN=rdmds([dir,'AngleSN']);
Grid='C';

varsize = size(p.Results.var,1);
dirs = size(p.Results.rDir,1);

nitsize = size(p.Results.niti:p.Results.nits:p.Results.nitt,2);

raw = zeros(192,32,25,nitsize,varsize,dirs);
rawv = zeros(192,32,25,nitsize,varsize,dirs);
rawll = zeros(180,90,25,nitsize,varsize,dirs);
rawvll = zeros(180,90,25,nitsize,varsize,dirs);
xi=-179:2:180;
yi=-89:2:90;

% to allow velocities to be rotated, use an optional input varv which has the vcs variables corresponding to the ucs in var
for j=1:varsize

isvel(j) = logical(mean(p.Results.varv(j) ~= '        ',2));
end



i=0;
for nit = p.Results.niti:p.Results.nits:p.Results.nitt;
  i=i+1

 for k = 1:dirs 

dir = char(p.Results.rDir(k));

  for j = 1: varsize;

    if isvel(j)

      rawucs=rdmds([dir,p.Results.var(j,:)],nit);
      rawvcs=rdmds([dir,p.Results.varv(j,:)],nit);

      [raw(:,:,:,i,j,k),rawv(:,:,:,i,j,k)] = rotate_uv2uvEN(rawucs,rawvcs,AngleCS,AngleSN,Grid);

    else

      raw(:,:,:,i,j,k)=rdmds([dir,p.Results.var(j,:)],nit);
      rawv(:,:,:,i,j,k)=0;

    end

  end
 
 end

end

'loop done'


tic
rawll=cube2latlon(xc,yc,raw,xi,yi);
toc
clear raw
tic
if max(max(max(max(max(max(rawv)))))) == 0
'skipped rawv'
clear rawvll
rawvll = 0;
else
rawvll=cube2latlon(xc,yc,rawv,xi,yi);
end
toc
clear rawv

outll = squeeze(rawll);
varargout{1} = squeeze(rawvll);
