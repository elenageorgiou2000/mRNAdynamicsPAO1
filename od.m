% ==========================================================
% 24h MICROBIAL GROWTH — MFC vs Non-MFC (OD 600nm)
% ==========================================================

% ---- Δεδομένα MFC (πρώτος πίνακας) ----
hours_mfc = [0, 1, 3, 6, 12, 20, 22, 24];
mfc_avg   = [0.2548, 0.4504, 0.4334, 0.4396, 0.4348, 0.4798, 0.5000, 0.5014];
mfc_sd    = [0.1262, 0.0400, 0.0513, 0.0513, 0.0573, 0.0675, 0.0309, 0.0873];

% ---- Δεδομένα Non-MFC / Glucose 2.5g/L (δεύτερος πίνακας) ----
hours_nonmfc = [0, 1, 3, 6, 12, 20, 22, 24];
nonmfc_avg   = [0.1000, 0.1124, 0.2660, 0.8933, 2.3036, 3.5576, 3.5048, 3.3956];
nonmfc_sd    = [0,      0.0215, 0.0413, 0.0511, 0.1697, 0.1143, 0.1137, 0.1211];

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

xlim([0 25]);
ylim([0 4]);

% ---- Legend κάτω, χωρίς τίτλο ----
legend({'MFC', 'Non MFC'}, 'Location', 'southoutside', 'Orientation', 'horizontal', ...
    'Box', 'off', 'FontSize', 10, 'FontName', 'Arial');

% ---- Export full high resolution ----
set(gcf, 'PaperUnits', 'centimeters', 'PaperPosition', [0 0 18 12]);
set(gcf, 'Renderer', 'painters');
print(gcf, 'Growth_curve_plot', '-dtiff', '-r1200');
print(gcf, 'Growth_curve_plot', '-depsc', '-r1200');