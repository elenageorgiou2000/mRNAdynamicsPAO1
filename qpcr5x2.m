%% mRNA gene expression 
clear; clc; close all;

time_h = [0 24 72 120];

col_mfc    = [27  72  94]/255;
col_nonmfc = [128 174 154]/255;

genes = {'edd','lasI','pqsA','rhlA','rhlI','phzA','phzS','algC','fabA'};
letters = {'A','B','C','D','E','F','G','H','I'};

nonmfc_avg.pqsA = [0 61.87 6.43 12.44];
nonmfc_avg.rhlI = [0 11.41 2.91 1.94];
nonmfc_avg.rhlA = [0 66.11 9.81 13.06];
nonmfc_avg.algC = [0 7.09 1.38 1.41];
nonmfc_avg.fabA = [0 1506.21 154.99 353.93];
nonmfc_avg.edd  = [0 11104.74 1666.27 777.28];
nonmfc_avg.lasI = [0 12.65 1.36 2.50];
nonmfc_avg.phzS = [0 110.66 104.12 2.73];
nonmfc_avg.phzA = [0 2518.85 275.75 636.34];

nonmfc_sd.pqsA = [0 13.71 5.40 6.76];
nonmfc_sd.rhlI = [0 6.59 0.54 0.58];
nonmfc_sd.rhlA = [0 3.24 1.27 1.57];
nonmfc_sd.algC = [0 1.36 0.05 0.42];
nonmfc_sd.fabA = [0 250.47 215.63 40.20];
nonmfc_sd.edd  = [0 3279.34 1517.95 77.08];
nonmfc_sd.lasI = [0 3.06 0.29 1.60];
nonmfc_sd.phzS = [0 38.82 166.06 1.71];
nonmfc_sd.phzA = [0 274.67 281.82 255.34];

mfc_avg.pqsA = [0 0.70 4.32 3.38];
mfc_avg.rhlI = [0 0.20 1.57 1.18];
mfc_avg.rhlA = [0 0.62 13.85 3.34];
mfc_avg.algC = [0 0.13 1.75 0.32];
mfc_avg.fabA = [0 16.21 559.49 310.96];
mfc_avg.edd  = [0 703.17 1521.95 1424.20];
mfc_avg.lasI = [0 0.17 3.61 0.49];
mfc_avg.phzS = [0 12.61 197.14 65.73];
mfc_avg.phzA = [0 49.62 700.39 217.02];

mfc_sd.pqsA = [0 0.59 3.49 2.82];
mfc_sd.rhlI = [0 0.11 0.08 0.98];
mfc_sd.rhlA = [0 0.20 2.99 1.12];
mfc_sd.algC = [0 0.13 0.98 0.19];
mfc_sd.fabA = [0 10.23 50.24 0.00];
mfc_sd.edd  = [0 136.45 460.19 290.33];
mfc_sd.lasI = [0 0.10 0.10 0.49];
mfc_sd.phzS = [0 3.60 63.76 0.00];
mfc_sd.phzA = [0 28.42 165.82 127.24];

%% Grid 5x2 
figure('Color','w','Position',[50 50 900 1400]);
t = tiledlayout(5,2, 'TileSpacing','compact', 'Padding','compact');
t.OuterPosition = [0.075 0.02 0.85 0.96];   

for i = 1:numel(genes)
    g = genes{i};
    ax = nexttile;

    % LEFT axis: MFC 
    yyaxis left
    h1 = errorbar(time_h, mfc_avg.(g), mfc_sd.(g), '-s', ...
        'Color', col_mfc, 'MarkerFaceColor', col_mfc, 'MarkerEdgeColor','k', ...
        'LineWidth', 1.3, 'MarkerSize', 5, 'CapSize', 4);
    ax.YAxis(1).Color = 'k';

    %  RIGHT axis: Non-MFC 
    yyaxis right
    h2 = errorbar(time_h, nonmfc_avg.(g), nonmfc_sd.(g), '-o', ...
        'Color', col_nonmfc, 'MarkerFaceColor', col_nonmfc, 'MarkerEdgeColor','k', ...
        'LineWidth', 1.3, 'MarkerSize', 4, 'CapSize', 4);
    ax.YAxis(2).Color = 'k';
    yl_r = ylim;
    ylim([0 yl_r(2)]);   
   
    yyaxis left
    yl_l = ylim;
    ylim([0 yl_l(2)]);  

    % only letters (no name gene)
    title(letters{i}, 'FontName','Arial', 'FontWeight','bold', 'FontSize', 13);

    set(gca, 'FontName','Arial', 'FontSize', 13, 'XColor','k', ...
        'LineWidth', 1, 'Box','on', 'TickDir','in');
    xlim([0 144]);
    xticks([0 24 48 72 96 120 144]);
end

xlabel(t, 'Time (hours)', 'FontName','Arial', 'FontWeight','bold', 'FontSize', 13);

% axes 
ax_lbl = axes('Position', [0 0 1 1], 'Visible', 'off', 'HitTest', 'off');
ax_lbl.XLim = [0 1];
ax_lbl.YLim = [0 1];

text(ax_lbl, 0.055, 0.5, 'Relative mRNA expression of mfc', ...
    'Rotation', 90, 'FontName','Arial', 'FontWeight','bold', 'FontSize', 13, ...
    'HorizontalAlignment','center', 'VerticalAlignment','middle', 'Color','k');

text(ax_lbl, 0.935, 0.5, 'Relative mRNA expression of non mfc', ...
    'Rotation', -90, 'FontName','Arial', 'FontWeight','bold', 'FontSize', 13, ...
    'HorizontalAlignment','center', 'VerticalAlignment','middle', 'Color','k');

uistack(ax_lbl, 'bottom');

%legend
lgd = legend([h1 h2], {'mfc','non MFC'}, 'Orientation','horizontal', ...
    'Box','off', 'FontSize', 11, 'FontName','Arial');
lgd.Layout.Tile = 'south';

%% export graphs
exportgraphics(gcf, 'genes_foldchange_grid_dualaxisnew.tif', 'Resolution', 1200);
exportgraphics(gcf, 'genes_foldchange_grid_dualaxis.eps', 'ContentType', 'vector');
