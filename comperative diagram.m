%% ==========================================================
%% mfc vs non-mfc — individual bar chart per gene, ΜΟΝΟ στις 120h
%% Exported ξεχωριστά, Teal χρώματα
%% ==========================================================
clear; clc; close all;

genes = {'lasI','rhlI','pqsA','rhlA','edd','algC','phzA','phzS','fabA'};

% ---- Average στις 120h: [non-mfc, mfc] ----
avg120.lasI = [2.50   1.18];
avg120.rhlI = [1.94   0.49];
avg120.pqsA = [12.44  3.38];
avg120.rhlA = [13.06  2.55];
avg120.edd  = [722.78 1424.20];
avg120.algC = [1.41   0.20];
avg120.phzA = [636.34 217.02];
avg120.phzS = [2.73   41.83];
avg120.fabA = [353.93 197.88];

% ---- Stdev στις 120h: [non-mfc, mfc] ----
sd120.lasI = [1.60   0.98];
sd120.rhlI = [0.58   0.49];
sd120.pqsA = [6.76   2.82];
sd120.rhlA = [1.57   0.00];
sd120.edd  = [0.00   290.33];
sd120.algC = [0.42   0.12];
sd120.phzA = [255.34 127.24];
sd120.phzS = [1.71   0.00];
sd120.fabA = [40.20  0.00];

% ---- Χρώματα: Teal 5 (mfc), Teal 2 (non-mfc) ----
col_mfc    = [27  72  94]/255;
col_nonmfc = [128 174 154]/255;

labels = {'non mfc','mfc'};

%% ---- Δημιουργία και export ξεχωριστού chart για κάθε γονίδιο ----
for i = 1:numel(genes)
    g = genes{i};
    vals = avg120.(g);
    errs = sd120.(g);

    fig = figure('Color','w','Position',[100 100 350 350]);
    ax = axes(fig);
    hold(ax,'on');

    b = bar(ax, 1:2, diag(vals), 'stacked', 'EdgeColor','k', 'LineWidth', 1, ...
        'BarWidth', 0.6);
    b(1).FaceColor = col_nonmfc;   % non-mfc
    b(2).FaceColor = col_mfc;      % mfc

    errorbar(ax, 1:2, vals, errs, 'k', 'LineStyle','none', ...
        'LineWidth', 1.2, 'CapSize', 8);

    hold(ax,'off');

    set(ax, 'FontName','Arial', 'FontSize', 11, 'XColor','k', 'YColor','k', ...
        'LineWidth', 1, 'Box','on', 'TickDir','out', ...
        'XTick', 1:2, 'XTickLabel', labels);

    title(ax, g, 'FontName','Arial', 'FontWeight','bold', 'FontSize', 14, ...
        'FontAngle','italic');
    ylabel(ax, 'Relative mRNA expression (120 h)', 'FontName','Arial', ...
        'FontWeight','bold', 'FontSize', 10);

    ylim(ax, [0, max(vals+errs)*1.2]);
    xlim(ax, [0.4 2.6]);

    % ---- Export ξεχωριστό αρχείο για κάθε γονίδιο ----
    fname = sprintf('mfc_vs_nonmfc_120h_%s', g);
    exportgraphics(fig, [fname '.tif'], 'Resolution', 1200);
    exportgraphics(fig, [fname '.eps'], 'ContentType', 'vector');
end