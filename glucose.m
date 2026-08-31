%% GLUCOSE REMOVAL (%)
% MFC vs Non-MFC

% DATA
time_labels = {'24', '72', '120'};
groups = {'MFC', 'Non MFC'};

mean_val = [90.98, 98.89;
            96.37, 99.72;
            98.22, 99.91];

sd_val   = [0.96, 0.506;
            3.071, 0.132;
            2.468, 0.01];

% COLOURS (TEAL PALLETE)
cb_colors = [27  72  94;
             128 174 154]/255;

% Bar plot 
figure('Color', 'w');
b = bar(mean_val, 'grouped');

for i = 1:2
    b(i).FaceColor = cb_colors(i,:);
    b(i).EdgeColor = 'k';
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

% Axes
set(gca, 'XTickLabel', time_labels, 'FontName', 'Arial', 'FontWeight', 'normal', ...
    'FontSize', 12, 'XColor', 'k', 'YColor', 'k', 'LineWidth', 1, 'Box', 'on');

xlabel('Time (h)', 'FontName', 'Arial', 'FontWeight', 'normal', 'FontSize', 13, 'Color', 'k');
ylabel('Glucose Removal (%)', 'FontName', 'Arial', 'FontWeight', 'normal', ...
    'FontSize', 13, 'Color', 'k');

ylim([0 110]);
ytickformat('percentage');

% Legend
legend(groups, 'Location', 'southoutside', 'Orientation', 'horizontal', ...
    'Box', 'off', 'FontSize', 10, 'FontName', 'Arial');

% export
set(gcf, 'PaperUnits', 'centimeters', 'PaperPosition', [0 0 18 12]);
set(gcf, 'Renderer', 'painters');
print(gcf, 'Glucose_removal_plot', '-dtiff', '-r1200');
print(gcf, 'Glucose_removal_plot', '-depsc', '-r1200');

%% statistical analysis 
%% MFC vs Non-MFC: unpaired t-test 
fprintf('--- MFC vs Non-MFC, ανά time point (unpaired t-test) ---\n');
[~, p24]  = ttest2(mfc_24h,  nonmfc_24h);
[~, p72]  = ttest2(mfc_72h,  nonmfc_72h);
[~, p120] = ttest2(mfc_120h, nonmfc_120h);
fprintf('24h:  p = %.4f\n', p24);
fprintf('72h:  p = %.4f\n', p72);
fprintf('120h: p = %.4f\n\n', p120);

%%  One-way ANOVA between time points
mfc_all   = [mfc_24h, mfc_72h, mfc_120h];
mfc_group = [repmat({'24h'},1,4), repmat({'72h'},1,4), repmat({'120h'},1,4)];

fprintf('--- One-way ANOVA: MFC across time points ---\n');
[p_mfc_time, tbl_mfc, stats_mfc] = anova1(mfc_all, mfc_group, 'off');
fprintf('p = %.4f\n\n', p_mfc_time);

%% One-way ANOVA between time points only in NON MFC
nonmfc_all   = [nonmfc_24h, nonmfc_72h, nonmfc_120h];
nonmfc_group = [repmat({'24h'},1,2), repmat({'72h'},1,2), repmat({'120h'},1,2)];

fprintf('--- One-way ANOVA: Non-MFC across time points ---\n');
[p_nonmfc_time, tbl_nonmfc] = anova1(nonmfc_all, nonmfc_group, 'off');
fprintf('p = %.4f\n\n', p_nonmfc_time);

%% Two-way ANOVA: Group × Time
all_vals  = [mfc_24h, mfc_72h, mfc_120h, nonmfc_24h, nonmfc_72h, nonmfc_120h];
group_f   = [repmat({'MFC'},1,12), repmat({'NonMFC'},1,6)];
time_f    = [repmat({'24h'},1,4), repmat({'72h'},1,4), repmat({'120h'},1,4), ...
             repmat({'24h'},1,2), repmat({'72h'},1,2), repmat({'120h'},1,2)];

fprintf('--- Two-way ANOVA: Group x Time ---\n');
[p_2way, tbl_2way] = anovan(all_vals, {group_f, time_f}, ...
    'model', 'interaction', 'varnames', {'Group','Time'}, 'display', 'off');
fprintf('Group effect p = %.4f\n', p_2way(1));
fprintf('Time effect p = %.4f\n', p_2way(2));
fprintf('Interaction p = %.4f\n', p_2way(3));