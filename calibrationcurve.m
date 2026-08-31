%%  Glucose Calibration Curve
% x = Absorbance 510nm, y = Concentration (g/L)

clear; clc; close all;

%% DATA
C_glucose   = [0     0.25    0.5     0.75    1];
ABS_average = [0     0.2663  0.4697  0.6494  0.9742];
ABS_stdev   = [0     0.008415 0.085348 0.016971 0.069226];

% EQUATION
slope     = 1.0621;
intercept = -0.0012;
R2        = 0.9905;

%% COLOURS
col_pts = [91 155 213]/255;

%% PLOT
figure('Color','w','Position',[100 100 750 500]);
hold on

% Trend line
x_fit = linspace(0, 1.2, 100);
y_fit = slope*x_fit + intercept;
plot(x_fit, y_fit, ':', 'Color', col_pts, 'LineWidth', 1.5);

%  Data points
for i = 1:numel(C_glucose)
    x = ABS_average(i);
    y = C_glucose(i);
    err = ABS_stdev(i);
        marker = 'o';  
   
    if err > 0
        errorbar(x, y, err, 'vertical', marker, ...
            'Color', col_pts, 'MarkerFaceColor', col_pts, 'MarkerEdgeColor','k', ...
            'MarkerSize', 7, 'LineWidth', 1.2, 'CapSize', 5);
    else
        plot(x, y, marker, 'Color', col_pts, 'MarkerFaceColor', col_pts, ...
            'MarkerEdgeColor','k', 'MarkerSize', 7, 'LineWidth', 1.2);
    end
end

hold off

%% R2EQUATION
text(0.65, 1.05, sprintf('y = %.2fx + %.4f\nR^2 = %.4f', slope, intercept, R2), ...
    'FontName','Arial', 'FontSize', 11, 'Color','k');

%% AXES
set(gca, 'FontName', 'Arial', 'FontSize', 12, 'XColor','k', 'YColor','k', ...
    'LineWidth', 1, 'Box','on', 'TickDir','in');
xlabel('Absorbance 510nm', 'FontName','Arial', 'FontSize', 13, 'Color','k');
ylabel('Concentration (g/L)', 'FontName','Arial', 'FontSize', 13, 'Color','k');


xlim([0 1.4]);
ylim([0 1.4]);
xticks(0:0.25:1.4);
yticks(0:0.2:1.4);

%% EXPORTGRAPHS
exportgraphics(gcf, 'calibration_curve.tif', 'Resolution', 1200);
exportgraphics(gcf, 'calibration_curve.eps', 'ContentType', 'vector');
exportgraphics(gcf, 'calibration_curve.png', 'Resolution', 1200);