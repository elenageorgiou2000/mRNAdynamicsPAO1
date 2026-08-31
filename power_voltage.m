%% Power & Voltage vs Time - Dual Y-Axis Plot
clear; clc; close all;

%% DATA
time_h = [0 6 12 18 24 30 36 42 48 54 60 66 72 78 84 90 96 102 108 114 120];

voltage_mV = [21.2425 96.3675 85.335 84.515 73.26 66.00333333 43.05 33.865 ...
              28.81666667 26.09333333 25.14333333 20.59666667 20.63333333 ...
              21.32666667 18.89666667 18.31666667 15.38 14.42 13.99333333 ...
              13.73333333 13.37333333];
voltage_err = [4.961978772 4.725022046 5.055465689 4.34564533 7.339511791 ...
               17.00017745 5.212497802 2.826075017 3.415206192 4.702520601 ...
               5.175570822 2.50501497 2.461510376 2.253086772 2.581556378 ...
               2.516962455 4.168644864 4.78510188 4.047670112 3.899440131 ...
               3.822333493];

power_mW = [0.0009 0.0182 0.0143 0.0140 0.0105 0.0085 0.003633926 ...
            0.002248702 0.001628236 0.001335024 0.001239583 0.000831809 ...
            0.000834773 0.000891817 0.000700165 0.000657844 0.000463813 ...
            0.000407718 0.000383948 0.000369813 0.000350679];
power_err = [0.0012 0.0011 0.0010 0.0010 0.0013 0.0017 0.0011 0.0010 ...
             0.0009 0.0010 0.0015 0.0005 0.0005 0.0004 0.0004 0.0004 ...
             0.0003 0.0003 0.0003 0.0003 0.0002];

%% COLOURS
col_power   = [27  72  94]/255;
col_voltage = [128 174 154]/255;

%% PLOT
figure('Color','w','Position',[100 100 800 500]);

yyaxis left
errorbar(time_h, power_mW, power_err, '-o', ...
    'Color', col_power, 'MarkerFaceColor', col_power, 'MarkerEdgeColor','k', ...
    'LineWidth', 1.5, 'MarkerSize', 5, 'CapSize', 6);
ylabel('Power (mW)', 'FontName','Arial', 'FontWeight','normal', 'FontSize', 13, 'Color','k');
ylim([0 0.025]);
ytickformat('%.4f');
ax = gca;
ax.YColor = 'k';

yyaxis right
errorbar(time_h, voltage_mV, voltage_err, '-o', ...
    'Color', col_voltage, 'MarkerFaceColor', col_voltage, 'MarkerEdgeColor','k', ...
    'LineWidth', 1.5, 'MarkerSize', 5, 'CapSize', 6);
ylabel('Voltage (mV)', 'FontName','Arial', 'FontWeight','normal', 'FontSize', 13, 'Color','k');
ylim([0 120]);
ytickformat('%.0f');
ax.YColor = 'k';

xlabel('Time (hours)', 'FontName','Arial', 'FontWeight','normal', 'FontSize', 13, 'Color','k');
xlim([-3 123]);
xticks(time_h);
xtickangle(0);

%% AXES
set(gca, 'FontName', 'Arial', 'FontWeight', 'normal', 'FontSize', 12, ...
    'XColor', 'k', 'Box', 'on', 'TickDir', 'in', ...
    'XGrid','off', 'YGrid','off', 'XMinorGrid','off', 'YMinorGrid','off');
grid off;

%% Legend
legend({'Power (mW)','Voltage (mV)'}, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'Box', 'off', 'FontSize', 10, 'FontName','Arial');


drawnow;
pos = ax.Position;
annotation('line', [pos(1) pos(1)+pos(3)], [pos(2)+pos(4) pos(2)+pos(4)], ...
    'Color', 'k', 'LineWidth', 0.8);

%% Export graph
set(gcf, 'PaperUnits', 'centimeters', 'PaperPosition', [0 0 18 12]);
set(gcf, 'Renderer', 'painters');
print(gcf, 'power_voltage_plot', '-dtiff', '-r1200');
print(gcf, 'power_voltage_plot', '-depsc', '-r1200');
exportgraphics(gcf, 'power_voltage_plot.png', 'Resolution', 600);