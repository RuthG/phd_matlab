xbins = -45:0.2:45;

for i=1:2:15
[advt_hist,tott_hist,htrt_hist] = advtend_hist_fun('000',i);
bar(xbins,advt_hist)
print('-dpng',['advt_hist_000_' num2str(i) '.png'])
bar(xbins,htrt_hist)
print('-dpng',['htrt_hist_000_' num2str(i) '.png'])
bar(xbins,tott_hist)
print('-dpng',['tott_hist_000_' num2str(i) '.png'])

[advt_hist,tott_hist,htrt_hist] = advtend_hist_fun('010',i);
bar(xbins,advt_hist)
print('-dpng',['advt_hist_010_' num2str(i) '.png'])
bar(xbins,htrt_hist)
print('-dpng',['htrt_hist_010_' num2str(i) '.png'])
bar(xbins,tott_hist)
print('-dpng',['tott_hist_010_' num2str(i) '.png'])

[advt_hist,tott_hist,htrt_hist] = advtend_hist_fun('025',i);
bar(xbins,advt_hist)
print('-dpng',['advt_hist_025_' num2str(i) '.png'])
bar(xbins,htrt_hist)
print('-dpng',['htrt_hist_025_' num2str(i) '.png'])
bar(xbins,tott_hist)
print('-dpng',['tott_hist_025_' num2str(i) '.png'])

[advt_hist,tott_hist,htrt_hist] = advtend_hist_fun('050',i);
bar(xbins,advt_hist)
print('-dpng',['advt_hist_050_' num2str(i) '.png'])
bar(xbins,htrt_hist)
print('-dpng',['htrt_hist_050_' num2str(i) '.png'])
bar(xbins,tott_hist)
print('-dpng',['tott_hist_050_' num2str(i) '.png'])

[advt_hist,tott_hist,htrt_hist] = advtend_hist_fun('075',i);
bar(xbins,advt_hist)
print('-dpng',['advt_hist_075_' num2str(i) '.png'])
bar(xbins,htrt_hist)
print('-dpng',['htrt_hist_075_' num2str(i) '.png'])
bar(xbins,tott_hist)
print('-dpng',['tott_hist_075_' num2str(i) '.png'])

[advt_hist,tott_hist,htrt_hist] = advtend_hist_fun('100',i);
bar(xbins,advt_hist)
print('-dpng',['advt_hist_100_' num2str(i) '.png'])
bar(xbins,htrt_hist)
print('-dpng',['htrt_hist_100_' num2str(i) '.png'])
bar(xbins,tott_hist)
print('-dpng',['tott_hist_100_' num2str(i) '.png'])

end
