%% Reference gene stability — raw Cq averages over time
%% anr, nadB, rpoD, rpsL, rpoN
clear; clc; close all;

time_h = [0 24 72 120];

% Ct
anr  = [NaN         17.21  21.02  30.36];  
nadB = [25.55208559 18.52  23.12  19.99];
rpoD = [22.45604274 20.86  18.45  19.635];
rpsL = [12          12.6   12.175 12.68];
rpoN = [20          21.55  18.67  19.85];

% Stdev 
anr_sd  = [NaN   0.20  2.27  7.43];
nadB_sd = [0.54  0.42  0.48  0.32];
rpoD_sd = [0.28  0.01  0.12  0.59];
rpsL_sd = [0     0.44  0.04  0.50];
rpoN_sd = [0     0.21  0.10  0.09];

% Ct Average — MFC 
anr_mfc  = [NaN   25.76  22.52  23.43];
nadB_mfc = [25.55 26.20  27.14  25.95];

anr_mfc_sd  = [NaN  0.37  0.04  0.30];
nadB_mfc_sd = [0.54 1.62  2.45  1.39];

% colours
col_anr  = [91  155 213]/255;   % light blue
col_nadB = [237 125 49]/255;    % orange
col_rpoD = [165 165 165]/255;   % gray
col_rpsL = [255 192 0]/255;     % gold/yellow
col_rpoN = [68  114 196]/255;   % dark blue

%% plot NON MFC
figure('Color','w','Position',[100 100 900 550]);
hold on

errorbar(time_h, anr,  anr_sd,  '-o', 'Color', col_anr,  'MarkerFaceColor', col_anr,  'LineWidth', 1.8, 'MarkerSize', 6, 'CapSize', 5);
errorbar(time_h, nadB, nadB_sd, '-o', 'Color', col_nadB, 'MarkerFaceColor', col_nadB, 'LineWidth', 1.8, 'MarkerSize', 6, 'CapSize', 5);
errorbar(time_h, rpoD, rpoD_sd, '-o', 'Color', col_rpoD, 'MarkerFaceColor', col_rpoD, 'LineWidth', 1.8, 'MarkerSize', 6, 'CapSize', 5);
errorbar(time_h, rpsL, rpsL_sd, '-o', 'Color', col_rpsL, 'MarkerFaceColor', col_rpsL, 'LineWidth', 1.8, 'MarkerSize', 6, 'CapSize', 5);
errorbar(time_h, rpoN, rpoN_sd, '-o', 'Color', col_rpoN, 'MarkerFaceColor', col_rpoN, 'LineWidth', 1.8, 'MarkerSize', 6, 'CapSize', 5);

hold off

set(gca, 'FontName', 'Arial', 'FontSize', 12, 'XColor','k', 'YColor','k', ...
    'LineWidth', 1, 'Box','on', 'TickDir','in');
xlabel('Time (h)', 'FontName','Arial', 'FontWeight','normal', 'FontSize', 13, 'Color','k');
ylabel('Ct', 'FontName','Arial', 'FontWeight','normal', 'FontSize', 13, 'Color','k');

xlim([0 140]);
ylim([0 40]);
xticks(0:20:140);

legend({'anr','nadB','rpoD','rpsL','rpoN'}, 'Location','southoutside', ...
    'Orientation','horizontal', 'Box','off', 'FontSize', 11, 'FontName','Arial');

exportgraphics(gcf, 'reference_gene_stability_nonMFC.tif', 'Resolution', 1200);
exportgraphics(gcf, 'reference_gene_stability_nonMFC.eps', 'ContentType', 'vector');

%% plot MFC 
figure('Color','w','Position',[100 100 900 550]);
hold on

errorbar(time_h, anr_mfc,  anr_mfc_sd,  '-s', 'Color', col_anr,  'MarkerFaceColor', col_anr,  'LineWidth', 1.8, 'MarkerSize', 6, 'CapSize', 5);
errorbar(time_h, nadB_mfc, nadB_mfc_sd, '-s', 'Color', col_nadB, 'MarkerFaceColor', col_nadB, 'LineWidth', 1.8, 'MarkerSize', 6, 'CapSize', 5);

hold off

set(gca, 'FontName', 'Arial', 'FontSize', 12, 'XColor','k', 'YColor','k', ...
    'LineWidth', 1, 'Box','on', 'TickDir','in');
xlabel('Time (h)', 'FontName','Arial', 'FontWeight','normal', 'FontSize', 13, 'Color','k');
ylabel('Ct', 'FontName','Arial', 'FontWeight','normal', 'FontSize', 13, 'Color','k');


xlim([0 140]);
ylim([0 40]);
xticks(0:20:140);

legend({'anr','nadB'}, 'Location','southoutside', ...
    'Orientation','horizontal', 'Box','off', 'FontSize', 11, 'FontName','Arial');

exportgraphics(gcf, 'reference_gene_stability_MFC.tif', 'Resolution', 1200);
exportgraphics(gcf, 'reference_gene_stability_MFC.eps', 'ContentType', 'vector');