%convert boundary layer and tropopause height to level indices

load('/project/rg312/mat_files/tropopause_offline.mat')
load('/project/rg312/mat_files/blayer_offline.mat')


blayer_000 = squeeze(mean(blayer_lev_000_ll,1));
blayer_010 = squeeze(mean(blayer_lev_010_ll,1));
blayer_025 = squeeze(mean(blayer_lev_025_ll,1));
blayer_050 = squeeze(mean(blayer_lev_050_ll,1));
blayer_075 = squeeze(mean(blayer_lev_075_ll,1));
blayer_100 = squeeze(mean(blayer_lev_100_ll,1));

trop_p_000(1) = NaN; trop_p_000(90)=NaN;
trop_p_010(1) = NaN; trop_p_010(90)=NaN;
trop_p_025(1) = NaN; trop_p_025(90)=NaN;
trop_p_050(1) = NaN; trop_p_050(90)=NaN;
trop_p_075(1) = NaN; trop_p_075(90)=NaN;
trop_p_100(1) = NaN; trop_p_100(90)=NaN;

for i=1:90

trop_p_000_hav(i) = (trop_p_000(i) + trop_p_000(91-i))./2;
trop_p_010_hav(i) = (trop_p_010(i) + trop_p_010(91-i))./2;
trop_p_025_hav(i) = (trop_p_025(i) + trop_p_025(91-i))./2;
trop_p_050_hav(i) = (trop_p_050(i) + trop_p_050(91-i))./2;
trop_p_075_hav(i) = (trop_p_075(i) + trop_p_075(91-i))./2;
trop_p_100_hav(i) = (trop_p_100(i) + trop_p_100(91-i))./2;

blayer_000_hav(i) = (blayer_000(i) + blayer_000(91-i))./2;
blayer_010_hav(i) = (blayer_010(i) + blayer_010(91-i))./2;
blayer_025_hav(i) = (blayer_025(i) + blayer_025(91-i))./2;
blayer_050_hav(i) = (blayer_050(i) + blayer_050(91-i))./2;
blayer_075_hav(i) = (blayer_075(i) + blayer_075(91-i))./2;
blayer_100_hav(i) = (blayer_100(i) + blayer_100(91-i))./2;

end




b_lev_000 = (round( (102000 - blayer_000_hav)./4000)); 
b_lev_010 = (round( (102000 - blayer_010_hav)./4000)); 
b_lev_025 = (round( (102000 - blayer_025_hav)./4000)); 
b_lev_050 = (round( (102000 - blayer_050_hav)./4000)); 
b_lev_075 = (round( (102000 - blayer_075_hav)./4000)); 
b_lev_100 = (round( (102000 - blayer_100_hav)./4000)); 

for i=2:89

trop_lev_000(i) = max(find(rC >= trop_p_000_hav(i)));
trop_lev_010(i) = max(find(rC >= trop_p_010_hav(i)));
trop_lev_025(i) = max(find(rC >= trop_p_025_hav(i)));
trop_lev_050(i) = max(find(rC >= trop_p_050_hav(i)));
trop_lev_075(i) = max(find(rC >= trop_p_075_hav(i)));
trop_lev_100(i) = max(find(rC >= trop_p_100_hav(i)));

end

trop_lev_000(1) = NaN; trop_lev_000(90)=NaN;
trop_lev_010(1) = NaN; trop_lev_010(90)=NaN;
trop_lev_025(1) = NaN; trop_lev_025(90)=NaN;
trop_lev_050(1) = NaN; trop_lev_050(90)=NaN;
trop_lev_075(1) = NaN; trop_lev_075(90)=NaN;
trop_lev_100(1) = NaN; trop_lev_100(90)=NaN;

save('/project/rg312/mat_files/blayer_trop_levs.mat', 'b_lev_000', 'b_lev_010', 'b_lev_025', 'b_lev_050', 'b_lev_075', 'b_lev_100', 'trop_lev_000', 'trop_lev_010', 'trop_lev_025', 'trop_lev_050', 'trop_lev_075', 'trop_lev_100' )



