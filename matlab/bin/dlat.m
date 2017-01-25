%function dlat.m
%Differentiate a vector w.r.t. latitude

%inputs: vector to differentiate (1st dim lat), latitudes
%output: dvectordlat

%declare function

function out = dlat(vecin,varargin);


%use parser to help with optional input yi

 p = inputParser;

%set defaults

defaultyi = -89:2:90;

   addRequired(p,'vecin',@isnumeric);
   addOptional(p,'yi',defaultyi,@isnumeric);

   parse(p,vecin,varargin{:});


cosphi = zeros(size(p.Results.vecin));

for i=1:size(p.Results.yi,2)

cosphi(i,:) = cos(p.Results.yi(i).*pi./180);

end

vecin_w = p.Results.vecin.*cosphi;

spacing = (p.Results.yi(2) - p.Results.yi(1)).*pi./180;

[moo,dvecin_w] = gradient(vecin_w,spacing);

a=6371.0e3;
out = dvecin_w./cosphi./a;


