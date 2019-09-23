# Script to plot cross-section bathymetric profile (here: 10 profiles, Kuril-Kamchatka Trench).
# cd /Users/pauline/Documents/Octave
# pwd
# load table into Octave
P = dlmread ('table_10KKT_N.csv');
P
# assign variables
K = P(:,1); % assign 400-kilometer cross-section line (km) to x axis
D1 = P(:,2); % assign depths to y axis
D2 = P(:,3); % assign depths to y axis
D3 = P(:,4); % assign depths to y axis
D4 = P(:,5); % assign depths to y axis
D5 = P(:,6); % assign depths to y axis
D6 = P(:,7); % assign depths to y axis
D7 = P(:,8); % assign depths to y axis
D8 = P(:,9); % assign depths to y axis
D9 = P(:,10); % assign depths to y axis
D10 = P(:,11); % assign depths to y axis
# check up variables in the current session
whos
#
# now plot figure
figure;
clf;
hold on;
subplot(2,1,1);
plot(K, D1, 'r+', 'markersize', 5 , K, D2, 'go', 'markersize', 5, K, D3, 'b*', 'markersize', 5, K, D4, 'mx', 'markersize', 5, K, D5, 'cv', 'markersize', 5); % plot x against y
    grid on;
    grid minor on;
    axis tight;
    set(gca,'xlim',[-200 200], 'xminortick', 'on');
    title({'Octave/MATLAB plot: Kuril-Kamchatka Trench (north)' ; 'cross-section profiles 1, 7, 14, 21, 28'}, 'FontSize', 10, 'Color', 'black', 'FontWeight', 'normal', 'FontName', 'Times');
    xlabel('Observations along the 400-km cross-section line', 'FontSize', 8);
    ylabel('Depths, m', 'FontSize', 8);
    x = [0.55 0.50];
    y = [0.85 0.68];
    annotation('textarrow', x, y, 'Color', [0.4940 0.1840 0.5560], 'HeadWidth', 5,
               'String', 'Kuril-Kamchatka Trench', 'TextColor', [0.6350 0.0780 0.1840],
               'FontSize', 10, 'FontName', 'Times');
    ylim ([-9000 200]);
    xlim ([-200 200]);
    axis([-200 200 -9000 200]);
    xticks([-200:50:200]);
    legend ({'profile 1', 'profile 7', 'profile 14', 'profile 21', 'profile 28'}, 'FontSize', 6, 'box', 'off', 'location', 'northeastoutside');
subplot(2,1,2);
plot(K, D6, 'r<', 'markersize', 5 , K, D7, 'go', 'markersize', 5, K, D8, 'b*', 'markersize', 5, K, D9, 'mx', 'markersize', 5, K, D10, 'cv', 'markersize', 5); % plot x against y
    grid on;
    grid minor on;
    axis tight;
    set(gca,'xlim',[-200 200], 'xminortick', 'on');
    title({'Octave/MATLAB plot: Kuril-Kamchatka Trench (north)' ; 'cross-section profiles 35, 42, 49, 56, 62'},
          'FontSize', 10, 'Color', 'black', 'FontWeight', 'normal', 'FontName', 'Times');
    xlabel('Observations along the 400-km cross-section line', 'FontSize', 8);
    ylabel('Depths, m', 'FontSize', 8);
    dim = [0.2 0.2 0.3 0.2];
    str = {'Greater Kuril Chain','Kuril Islands'};
    annotation('textbox', dim, 'String', str, 'FitBoxToText', 'on',
               'FontSize', 10, 'FontName', 'Times');
    ylim ([-9000 200]);
    xlim ([-200 200]);
    axis([-200 200 -9000 200]);
    xticks([-200:50:200]);
    legend ({'profile 35', 'profile 42', 'profile 49', 'profile 56', 'profile 62'},
            'FontSize', 6, 'box', 'off', 'location', 'northeastoutside');
#saveas(gcf,'plot_KKT.jpg');
print('plot_KKTprofilesN','-dpdf', '-r300', '-bestfit')
