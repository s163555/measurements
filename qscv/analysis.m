clear; close all; clc;

hfcv = '12_10_2025 12_47_54 PM_CMUT-CV_(2).csv';
[hfcv_voltage, hfcv_capacitance] = analyze_mos_capacitor_data(hfcv,10);
hfcv_data = table(hfcv_voltage, hfcv_capacitance, 'VariableNames', {'Voltage', 'Capacitance'});

qscv = '12_10_2025 12_27_42 PM_QSCV[2]_(13).csv';
[qscv_voltage, qscv_capacitance] = analyze_mos_capacitor_data(qscv,13);
qscv_data = table(qscv_voltage, qscv_capacitance, 'VariableNames', {'Voltage', 'Capacitance'});

% Interpolate QSCV onto HFCV voltage grid
C_QS = interp1(qscv_data.Voltage, ...
               qscv_data.Capacitance, ...
               hfcv_data.Voltage, ...
               'linear', 'extrap');

V = hfcv_data.Voltage;
C_HF = hfcv_data.Capacitance;

% Identify accumulation region (adjust voltage threshold if needed)
accum_idx = V > max(V) - 0.5;

Cox = mean(C_HF(accum_idx));

q = 1.602e-19;   % elementary charge [C]

Dit = (Cox ./ q) .* ...
      (C_QS - C_HF) ./ ...
      (C_HF .* (Cox - C_QS));

valid = (V > -0.8) & (V < 0.2) & Dit > 0 & isfinite(Dit);

V_Dit   = V(valid);
Dit_val = Dit(valid);
Dit_avg = mean(Dit_val);
Dit_med = median(Dit_val);
fprintf('Dit ≈ %.2e cm^-2 eV^-1\n', Dit_avg)

figure(1); 
hold on;
plot(hfcv_data.Voltage, hfcv_data.Capacitance,'k',LineWidth=2);
plot(qscv_data.Voltage, qscv_data.Capacitance,'k:',LineWidth=2);
title('MOS Capacitor Capacitance vs Voltage @ 25 degC');
legend('HFCV @ 1 MHz', 'QSCV','Location','southeast');
xlabel('Voltage (V)');
ylabel('Capacitance (F)');
grid on;
ax = gca;
ax.XMinorGrid = 'on';
ax.YMinorGrid = 'on';
hold off;

figure(2);
hold on;
plot(hfcv_data.Voltage, hfcv_data.Capacitance);
hold off;

figure(3);
semilogy(V_Dit, Dit_val, 'k', 'LineWidth', 2);
grid on;
xlabel('Gate Voltage (V)');
ylabel('D_{it} (cm^{-2} eV^{-1})');
title('Interface Trap Density extracted via High–Low C–V');

function [voltage, capacitance] = analyze_mos_capacitor_data(filename,rowStart)
    % Read the CSV file, ignoring the first 10 rows
    data = readtable(filename, 'HeaderLines', rowStart);
    voltage = data{:, 1};
    capacitance = data{:, 2};
end

function plot_capacitance_vs_voltage(data)
    plot(data.Voltage, data.Capacitance, 'o-'); % Ensure only one plot is created
    
end