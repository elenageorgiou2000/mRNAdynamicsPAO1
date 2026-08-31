% ---- Δεδομένα ----
time_labels = {'24', '72', '120'};
groups = {'MFC', 'Non MFC', 'Coulombic Efficiency'};

mean_val = [68.01, 83.25, 3.22;
            78.55, 85.90, 2.37;
            83.01, 86.63, 12.68];

sd_val   = [4.11, 1.53, 2.10;
            1.46, 1.19, 1.29;
            5.82, 2.22, 1.92];

% ---- Χρώματα: Teal 5, Teal 2, Teal 1 ----
cb_colors = [27  72  94;
             128 174 154;
             181 209 174]/255;

% ---- Bar plot ----
figure('Color', 'w');
b = bar(mean_val, 'grouped');

for i = 1:3
    b(i).FaceColor = cb_colors(i,:);
    b(i).EdgeColor = 'k';       % edge outline μαύρο
    b(i).LineWidth = 0.8;
end

hold on

ngroups = size(mean_val, 1);
nbars   = size(mean_val, 2);
groupwidth = min(0.8, nbars/(nbars + 1.5));

for i = 1:nbars
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, mean_val(:,i), sd_val(:,i), 'k', 'linestyle', 'none', ...
             'LineWidth', 1, 'CapSize', 6);
end

hold off

% ---- Άξονες: Arial, χωρίς bold ----
set(gca, 'XTickLabel', time_labels, 'FontName', 'Arial', 'FontWeight', 'normal', ...
    'FontSize', 12, 'XColor', 'k', 'YColor', 'k', 'LineWidth', 1, 'Box', 'on');

xlabel('Time (h)', 'FontName', 'Arial', 'FontWeight', 'normal', 'FontSize', 13, 'Color', 'k');
ylabel('COD Removal / Coulombic Efficiency (%)', 'FontName', 'Arial', ...
    'FontWeight', 'normal', 'FontSize', 13, 'Color', 'k');

ylim([0 100]);
ytickformat('percentage');

% ---- Legend κάτω, χωρίς τίτλο ----
lgd = legend(groups, 'Location', 'southoutside', 'Orientation', 'horizontal', ...
    'Box', 'off', 'FontSize', 10, 'FontName', 'Arial');

% ---- Export full high resolution ----
set(gcf, 'PaperUnits', 'centimeters', 'PaperPosition', [0 0 18 12]);
set(gcf, 'Renderer', 'painters');   % vector-based rendering, καλύτερο για line art
print(gcf, 'COD_removal_plot_teal', '-dtiff', '-r1200');   % TIFF 1200dpi
print(gcf, 'COD_removal_plot_teal', '-depsc', '-r1200');   % + EPS vector, αν το ζητά το journal
%% ---- 1) MFC vs Non-MFC (ανά χρονικό σημείο, paired) ----
mfc_vals    = [68.01, 78.55, 83.01];
nonmfc_vals = [83.25, 85.90, 86.63];

[h1, p1, ci1, stats1] = ttest(mfc_vals, nonmfc_vals);   % paired t-test
fprintf('--- Paired t-test: MFC vs Non-MFC ---\n');
fprintf('t(%d) = %.3f, p = %.4f\n', stats1.df, stats1.tstat, p1);
fprintf('Mean difference: %.2f, 95%% CI [%.2f, %.2f]\n\n', ...
    mean(mfc_vals - nonmfc_vals), ci1(1), ci1(2));

%% ---- 2) One-way ANOVA: διαφορές ανάμεσα στα χρονικά σημεία (24 vs 72 vs 120) ----
% Για MFC:
mfc_matrix = [68.01; 78.55; 83.01];   % 1 τιμή ανά time point (μέσος όρος -- αν έχεις raw replicates, βάλε εκείνα)
time_group = {'24h'; '72h'; '120h'};

% Αν έχεις raw replicate values (π.χ. 3-4 ανά time point), δώσε μου τα και
% θα φτιάξω σωστό one-way ANOVA με πραγματικές επαναλήψεις αντί για μέσους όρους.

fprintf('--- One-way ANOVA between time points (MFC) ---\n');
fprintf('ΠΡΟΣΟΧΗ: χρειάζεσαι raw replicate data (όχι μόνο μέσους όρους) για σωστό ANOVA.\n');
fprintf('Στείλε μου τα raw δεδομένα (π.χ. n=3-4 replicates ανά time point) για να το τρέξω σωστά.\n\n');

%% ---- 3) Correlation: Coulombic Efficiency vs χρόνο ----
ce_vals  = [3.22, 2.37, 12.68];
time_num = [24, 72, 120];
[r, p_corr] = corr(time_num', ce_vals', 'Type', 'Pearson');
fprintf('--- Correlation: CE vs Time ---\n');
fprintf('r = %.3f, p = %.4f\n', r, p_corr);