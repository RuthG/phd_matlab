%plot up boundary layer heights for different runs

yi=-89:2:90;

runlist = cellstr(['000';'010';'025';'050';'075';'100';'125';'150']);

for i=1:8
    x_var_n = ['x' char(runlist(i)) 'n'];
    x_var_s = ['x' char(runlist(i)) 's'];
    xvals = load('/project/rg312/mat_files/vt_lats_final.mat',x_var_n,x_var_s);
    xn = xvals.(x_var_n);
    xs = xvals.(x_var_s);

    [z_w, z_c] = blayer_height(char(runlist(i)));
    figure;
    plot(yi,z_w,'r', 'LineWidth',2);
    set(gca,'FontSize',12)
    hold on;
    plot(yi,z_c, 'LineWidth',2);
    plot([yi(xn),yi(xn)],[0,4000],'k--', 'LineWidth',2)
    plot([yi(xs),yi(xs)],[0,4000],'k--', 'LineWidth',2)
    ylim([0 4000]);
    xlim([-90 90]);
    xlabel('Latitude','FontSize',15)
    ylabel('Boundary layer height, km','FontSize',15)
    title(char(runlist(i)) ,'FontSize',15)
    legend('Warm','Cold');
    print('-dpng',['z_wc_' char(runlist(i)) '.png']);
end

  

