% ==========================================================
% Surface Tension over Time — MFC vs Non-MFC
% ==========================================================
% ---- Δεδομένα MFC ----
hours_mfc = [0, 24, 72, 120];
mfc_avg   = [72, 49.10, 45.63, 44.43];
mfc_sd    = [0,  4.81,  0.59,  0.47];

% ---- Δεδομένα Non-MFC ----
hours_nonmfc = [0, 24, 72, 120];
nonmfc_avg   = [72, 52.75, 51.25, 48.9];
nonmfc_sd    = [0,  3.182, 0.3536, 3.5355];

% ---- Χρώματα: Teal 5 (MFC), Teal 2 (Non-MFC) ----
col_mfc    = [27  72  94]/255;
col_nonmfc = [128 174 154]/255;

% ---- Line plot με error bars ----
figure('Color', 'w');

errorbar(hours_mfc, mfc_avg, mfc_sd, '-s', 'Color', col_mfc, ...
    'MarkerFaceColor', col_mfc, 'MarkerEdgeColor', 'k', ...
    'LineWidth', 1.5, 'CapSize', 6, 'MarkerSize', 5);

hold on

errorbar(hours_nonmfc, nonmfc_avg, nonmfc_sd, '-o', 'Color', col_nonmfc, ...
    'MarkerFaceColor', col_nonmfc, 'MarkerEdgeColor', 'k', ...
    'LineWidth', 1.5, 'CapSize', 6, 'MarkerSize', 5);

hold off

% ---- Άξονες: Arial, χωρίς bold, edge μαύρο ----
set(gca, 'FontName', 'Arial', 'FontWeight', 'normal', 'FontSize', 12, ...
    'XColor', 'k', 'YColor', 'k', 'LineWidth', 1, 'Box', 'on');

xlabel('Time (h)', 'FontName', 'Arial', 'FontWeight', 'normal', 'FontSize', 13, 'Color', 'k');
ylabel('Optical density (600 nm)', 'FontName', 'Arial', 'FontWeight', 'normal', ...
    'FontSize', 13, 'Color', 'k');

xlim([0 130]);
ylim([0 80]);

% ---- Legend κάτω, χωρίς τίτλο ----
legend({'MFC', 'Non MFC'}, 'Location', 'southoutside', 'Orientation', 'horizontal', ...
    'Box', 'off', 'FontSize', 10, 'FontName', 'Arial');

% ---- Export full high resolution ----
set(gcf, 'PaperUnits', 'centimeters', 'PaperPosition', [0 0 18 12]);
set(gcf, 'Renderer', 'painters');
print(gcf, 'surfacetension', '-dtiff', '-r1200');
print(gcf, 'surfacetension', '-depsc', '-r1200');