clear all

% bezva super venku v�tr 
a = load('LOG-9764.TXT');

dt = 0.033;

from = round(20/dt);
to = round(75/dt);

mpcEnabled = a(from:to, end-1);

speedLimit = 0.35;
time = integrate(ones(1, length(from:to)).*dt);

to_plot = 74;

hFig = figure(1)
subplot(3, 1, 1);
hold off
plot(time, a(from:to, 2).*mpcEnabled, 'r', 'LineWidth', 1.5);
hold on
plot(time, a(from:to, 8).*mpcEnabled, 'b', 'LineWidth', 1.5);
axis([0 to_plot -1.9 0.4]);
title('Position');
xlabel('Time [s]');
ylabel('Position [m]');
legend('Setpoint', 'Estimated position');

subplot(3, 1, 2);
hold off
plot(time, a(from:to, 10).*mpcEnabled, 'r', 'LineWidth', 1.5);
hold on
plot(time, a(from:to, 4).*mpcEnabled, 'b', 'LineWidth', 1.5);
plot(time, ones(1, length(from:to)).*-speedLimit, 'k--', 'LineWidth', 1.5);
plot(time, ones(1, length(from:to)).*speedLimit, 'k--', 'LineWidth', 1.5);
axis([0 to_plot -0.6 0.6]);
title('Speed');
xlabel('Time [s]');
ylabel('Speed [m/s]');
legend('Measured speed', 'Estimated by KF', 'Speed limit');

subplot(3, 1, 3);
hold off
plot(time, a(from:to, 12).*mpcEnabled, 'b', 'LineWidth', 1.5);
axis([0 to_plot -250 250]);
title('Control action');
xlabel('Time [s]');
ylabel('Control action [-]');
legend('Control action');

set(hFig, 'Units', 'centimeters');
set(hFig, 'Position', [0 0 23 17])

drawnow;

pause(2);

tightfig(hFig);
