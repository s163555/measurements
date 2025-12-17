clear; close all; clc;

qscv1 = '12_10_2025 12_02_55 PM_QSCV[2]_(7).csv';
[qscv_voltage, qscv_capacitance] = analyze_mos_capacitor_data(qscv1,13);
qscv1_data = table(qscv_voltage, qscv_capacitance, 'VariableNames', {'Voltage', 'Capacitance'});

qscv2 = '12_10_2025 12_04_44 PM_QSCV[2]_(8).csv';
[qscv_voltage, qscv_capacitance] = analyze_mos_capacitor_data(qscv2,13);
qscv2_data = table(qscv_voltage, qscv_capacitance, 'VariableNames', {'Voltage', 'Capacitance'});

qscv3 = '12_10_2025 12_06_54 PM_QSCV[2]_(9).csv';
[qscv_voltage, qscv_capacitance] = analyze_mos_capacitor_data(qscv3,13);
qscv3_data = table(qscv_voltage, qscv_capacitance, 'VariableNames', {'Voltage', 'Capacitance'});

qscv4 = '12_10_2025 12_09_49 PM_QSCV[2]_(10).csv';
[qscv_voltage, qscv_capacitance] = analyze_mos_capacitor_data(qscv4,13);
qscv4_data = table(qscv_voltage, qscv_capacitance, 'VariableNames', {'Voltage', 'Capacitance'});

qscv5 = '12_10_2025 12_15_34 PM_QSCV[2]_(11).csv';
[qscv_voltage, qscv_capacitance] = analyze_mos_capacitor_data(qscv5,13);
qscv5_data = table(qscv_voltage, qscv_capacitance, 'VariableNames', {'Voltage', 'Capacitance'});

qscv6 = '12_10_2025 12_27_42 PM_QSCV[2]_(13).csv';
[qscv_voltage, qscv_capacitance] = analyze_mos_capacitor_data(qscv6,13);
qscv6_data = table(qscv_voltage, qscv_capacitance, 'VariableNames', {'Voltage', 'Capacitance'});

figure;
hold on;
plot(qscv1_data.Voltage, qscv1_data.Capacitance, 'DisplayName', 'QSCV1');
plot(qscv2_data.Voltage, qscv2_data.Capacitance, 'DisplayName', 'QSCV2');
plot(qscv3_data.Voltage, qscv3_data.Capacitance, 'DisplayName', 'QSCV3');
plot(qscv4_data.Voltage, qscv4_data.Capacitance, 'DisplayName', 'QSCV4');
plot(qscv5_data.Voltage, qscv5_data.Capacitance, 'DisplayName', 'QSCV5');
plot(qscv6_data.Voltage, qscv6_data.Capacitance, 'DisplayName', 'QSCV6');
hold off;

xlabel('Voltage (V)');
ylabel('Capacitance (F)');
title('Capacitance vs Voltage for QSCV Data');
legend show;
grid on;

function [voltage, capacitance] = analyze_mos_capacitor_data(filename,rowStart)
    % Read the CSV file, ignoring the first 10 rows
    data = readtable(filename, 'HeaderLines', rowStart);
    voltage = data{:, 1};
    capacitance = data{:, 2};
end