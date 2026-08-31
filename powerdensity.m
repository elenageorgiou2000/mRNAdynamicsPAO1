
%% Power Density vs Time
clear; clc; close all;

%% DATA-
time_h = [0 6 12 18 24 30 36 42 48 54 60 66 72 78 84 90 96 102 108 114 120];

% P density ( mW/m2) 
Pdens1 = [0.033 0.674 0.529 0.519 0.390 0.316 0.135 0.083 0.060 0.049 ...
          0.046 0.031 0.031 0.033 0.026 0.024 0.017 0.015 0.014 0.014 0.013];
Pdens1_sd = [0.00116 0.00110 0.00105 0.00098 0.00128 0.001727 0.001114 ...
             0.000967 0.000933 0.001037 0.001453 0.000521 0.000469 ...
             0.000428 0.000388 0.000356 0.000328 0.000306 0.000281 ...
             0.000260 0.000237];

% P density (mW/m3)
Pdens2 = [35.392 728.368 571.142 560.218 420.943 341.682 145.357 89.948 ...
          65.129 53.401 49.583 33.272 33.391 35.673 28.007 26.314 18.553 ...
          16.309 15.358 14.793 14.027];
Pdens2_sd = [0.001 0.001 0.001 0.001 0.001 0.002 0.001 0.001 0.001 0.001 ...
             0.001 0.001 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000];

%% colours
col_left  = [27  72  94]/255;    % Teal 5
col_right = [128 174 154]/255;   % Teal 2

%% plot
figure('Color','w','Position',[100 100 800 500]);

yyaxis left
errorbar(time_h, Pdens1, Pdens1_sd, '-o', ...
    'Color', col_left, 'MarkerFaceColor', col_left, 'MarkerEdgeColor','k', ...
    'LineWidth', 1.5, 'MarkerSize', 5, 'CapSize', 4);
ylabel('Power Density (mW/m^2)', 'FontName','Arial', 'FontWeight','normal', ...
    'FontSize', 13, 'Color','k');
ylim([0 0.8]);
ax = gca;
ax.YAxis(1).Color = 'k';

yyaxis right
errorbar(time_h, Pdens2, Pdens2_sd, '-o', ...
    'Color', col_right, 'MarkerFaceColor', col_right, 'MarkerEdgeColor','k', ...
    'LineWidth', 1.5, 'MarkerSize', 5, 'CapSize', 4);
ylabel('Power Density (mW/m^2)', 'FontName','Arial', 'FontWeight','normal', ...
    'FontSize', 13, 'Color','k');
ylim([0 800]);
ax.YAxis(2).Color = 'k';

xlabel('Time (h)', 'FontName','Arial', 'FontWeight','normal', 'FontSize', 13, 'Color','k');
xlim([0 120]);
xticks([0 24 48 72 96 120]);

%% AXES
set(gca, 'FontName', 'Arial', 'FontWeight', 'normal', 'FontSize', 12, ...
    'XColor', 'k', 'Box', 'on', 'TickDir', 'in', ...
    'XGrid','off', 'YGrid','off');
grid off;

%% LEGEND
legend({'Power Density(mW/m2)','Power Density (mW/m3)'}, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'Box', 'off', 'FontSize', 10, 'FontName','Arial');

%% EXPORT
set(gcf, 'PaperUnits', 'centimeters', 'PaperPosition', [0 0 18 12]);
set(gcf, 'Renderer', 'painters');
exportgraphics(gcf, 'power_density_plot.tif', 'Resolution', 1200);
exportgraphics(gcf, 'power_density_plot.eps', 'ContentType', 'vector');
exportgraphics(gcf, 'power_density_plot.png', 'Resolution', 1200);