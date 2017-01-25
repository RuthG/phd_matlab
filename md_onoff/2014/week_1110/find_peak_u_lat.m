load('/project/rg312/mat_files/climatology_vars.mat')

yi = -89:2:89;
rC = 980:-40:20;

uE_000_max = find(uE_000_zav(:,1) == max(max(uE_000_zav(46:90,1))));
uE_010_max = find(uE_010_zav(:,1) == max(max(uE_010_zav(46:90,1))));
uE_025_max = find(uE_025_zav(:,1) == max(max(uE_025_zav(46:90,1))));
uE_050_max = find(uE_050_zav(:,1) == max(max(uE_050_zav(46:90,1))));
uE_075_max = find(uE_075_zav(:,1) == max(max(uE_075_zav(46:90,1))));
uE_100_max = find(uE_100_zav(:,1) == max(max(uE_100_zav(46:90,1))));

save('/project/rg312/mat_files/uE_surf_jet_max.mat','uE_000_max', 'uE_010_max', 'uE_025_max', 'uE_050_max', 'uE_075_max', 'uE_100_max')


